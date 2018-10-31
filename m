Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA87C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12272064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQKSCL+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12272064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeKAGpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:45:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeKAGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ELV29d31PEveM+CAN/jNfVieGcZHU9H4sAN/toVBi/g=; b=mQKSCL+eyN2txLC0AKxesPfIe
        uZjvFVLqJEcNghreVvmo8dUN2KnxXWrTOWYZ2lzBpLl6G/1ynLUD6xSTj5e/pD1jxTWp9kQqf63DO
        gQtor+orWpRwstiae3sbWzsS1A8ibPyWkSqcMDdN78xxS7kM/jURnA41gNKos2dtDEvNrT7qQG7Yl
        GbL9XO3W+RvK9nbEeSn5w4USmfFH7fE4L1/QegUBxp0d6KON/2W1kRtm0l5Li6qMA7vNkMfLu3aGb
        9LxE7X99VUPpni2WvjKTkzmNQEWagQW4QHdQ14f5AOX2GQ1qWdMuaiZfXJXIkEeDh8Mib2nZEXZFh
        oMHH900fg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHyIp-0000jP-1p; Wed, 31 Oct 2018 21:45:27 +0000
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Changbin Du <changbin.du@gmail.com>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <209b9bce-b6fc-8387-89fe-f810cbd0a41a@infradead.org>
Date:   Wed, 31 Oct 2018 14:45:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 2:41 PM, Arnd Bergmann wrote:
> On 10/31/18, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 10/30/18 8:59 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do not add any v4.21/v5.1 code to your linux-next included trees
>>> until after the merge window closes.
>>>
>>> Changes since 20181030:
>>>
>>
>>
>> on i386:
>>
>> ld: drivers/virt/vboxguest/vboxguest_core.o: in function
>> `vbg_ioctl_hgcm_call':
>> vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'
>>
>>
>> Full randconfig file is attached.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I ran into the same thing, and lots of others like it; they all go back to
> the -Og compiler option introduced in commit 94c7dfd01652 ("kernel
> hacking: support building kernel with -Og optimization level").
> 
> 
> I have patches for most of these, but I'd prefer if we could leave
> that patch out of 4.20 for now, and have it in linux-next for merging
> into the next merge window, to give us more time to fix up all the
> regressions. This particular instance is fixed by the patch below.
> 
> Other symptoms caused by the change are tons of 'section mismatch'
> warnings for functions that are no longer automatically inlined, and
> sprintf format string overflow warnings when gcc fails to propagate
> an upper bound on an integer argument that is printed into a fixed
> length string.

Yeah, I saw lots of those but haven't tried to diagnose them yet,
so thanks for the info.

> 
>      Arnd
> ---
> From 8172e650c6797b9cc64c6f7b1c9e5433156290cc Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 31 Oct 2018 16:24:35 +0100
> Subject: [PATCH] vbox: fix link error with 'gcc -Og'
> 
> With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
> error in the vboxguest driver, when that fails to optimize out the
> call to the compat handler:
> 
> drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
> vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'
> 
> Another compile-time check documents better what we want and avoids
> the error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c
> b/drivers/virt/vboxguest/vboxguest_core.c
> index 3093655c7b92..1475ed5ffcde 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
>  		return -EINVAL;
>  	}
> 
> -	if (f32bit)
> +	if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
>  		ret = vbg_hgcm_call32(gdev, client_id,
>  				      call->function, call->timeout_ms,
>  				      VBG_IOCTL_HGCM_CALL_PARMS32(call),
> 

I have that same patch on my machine.  :)
You can added my Acked-by or Tested-by if you want to.

thanks,
-- 
~Randy
