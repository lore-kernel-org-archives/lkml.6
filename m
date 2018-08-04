Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68001C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6C217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7+LLrNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6C217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeHDRse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 13:48:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeHDRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 13:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TZpyQNjibjNOLUfnd0dfO5TMshSVem9za2WRk2ubBcY=; b=R7+LLrNJikVKSOBGHs1s34t9mm
        ReKgwPgVc+2FWlAoOR+FA03pa9sK9yCaTi3BQotgkT4CiA1cDO3ofwEOP5UJ+MKUmC8CV2FvlLoFh
        cLJ5IixNQ6Fm9/RjJIVTacdH/C8XpJA4k4vLMntGBjXRAEnDNGtqREavoEwfmU+AdJKNJNbgUfsLM
        R6GDaZyRJtVv1xHkYrIZIAqdLzP5K/DMhJf2npiXKSdPMCfwbvlruXeOR5y9LvwXMuoPdOSZjXi8o
        Bx8vjqwz3Lzrrl5lbdFThaYgeWS+E9Kc193PClwdFkWT991jF6sJ252fyBHpl/e6V/F2pcwmaHN/r
        l9i52ghA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flym4-000303-5R; Sat, 04 Aug 2018 15:47:24 +0000
Subject: Re: kbuild: ARCH=um archheaders failed
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
 <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
 <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29f9908d-06e5-8e88-4433-9bd7935a0d1f@infradead.org>
Date:   Sat, 4 Aug 2018 08:47:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 07:23 PM, Masahiro Yamada wrote:
> 2018-08-04 0:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> On 08/02/2018 05:13 PM, Randy Dunlap wrote:
>>> Hi Yamada-san,
>>>
>>> I see this every few weeks.  It's not reproducible (it depends
>>> on the moon, Mars, etc.).
>>>
>>> I'm using O=builddir.  The build log is short (below).
>>>
>>> Do you see a makefile problem here?  (nothing to do with mmotm;
>>> I see it more frequently with linux-next since I do many daily
>>> builds with it)
>>
>> BTW, this is just um defconfig with -j4.
>>
>> --
>> ~Randy
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> I will send a patch with commit description later
> after more testing,
> but the following patch should fix the issue.
> 
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index d3975e7..1cec053 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -120,7 +120,7 @@ archheaders:
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
>                     kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
>                     obj=$(HOST_DIR)/include/generated/uapi/asm
> -       $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
> +       $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
> 
> 
>  archprepare: include/generated/user_constants.h
> 
> 
> 

I tested this patch and it works.  :)
but then it's difficult to reproduce the problem.

Thanks!
-- 
~Randy
