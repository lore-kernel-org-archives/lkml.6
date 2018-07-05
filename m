Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63960C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128A24139
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mFpTvi/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1128A24139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeGECWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:22:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeGECWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FOaLsF2IQPIqPzxLQ0W8e4InX8GmfNuy6/+BhVVnBUc=; b=mFpTvi/37+DY5TR6jg0Cs/BWR
        l3LodjL+lObNJrR1IFWvtLemizv6d4PUFjkyIqXrRn5b2d+52vQw4hQoz5cMzNqw5pkJm7Z2uTjMq
        rtxuD6uqOoojvf8P4YZp0PeAracJYHzZYr/1gWBRkLy1ZjkagLB7aae+5SSXCme29l8gkvYrelirv
        iKWoW0cYc8hXA0d+9FC6+sQbe/yKrETmgETBYyTb8VVj8qwvodgsUR9ZNbA4JpfwDrpHRACFfui4i
        uz9XHX2Lp43/FJMWihOfnGuRtgDkMKOrmJx0sgOIcc41nL0ec5h0e+dJ+DhoEuP2U1UuvRazghY/v
        nFoMxC4yA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fatux-0004FQ-Kt; Thu, 05 Jul 2018 02:22:47 +0000
Subject: Re: [PATCH] kbuild: delete INSTALL_FW_PATH from kbuild documentation
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6477e1be-6686-582b-35b5-72e9f677619f@infradead.org>
 <CAK7LNATj1ibX=GMJ92fpX45Ba2WJKKb=h7_ZR9DeZcyBGcMHbQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43f37d95-89cc-fd42-46c3-533f85f014e8@infradead.org>
Date:   Wed, 4 Jul 2018 19:22:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATj1ibX=GMJ92fpX45Ba2WJKKb=h7_ZR9DeZcyBGcMHbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/18 18:49, Masahiro Yamada wrote:
> 2018-07-05 4:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Removed Kbuild documentation for INSTALL_FW_PATH.
>>
>> The kbuild symbol INSTALL_FW_PATH was removed from Kbuild tools in
>> September 2014 (for 4.14) but the symbol was not deleted from
> 
> I think 'September 2017'
> although I can fix up the log locally.

Right you are.  and thanks.

> 
> 
> 
>> the kbuild documentation, so do that now.
>>
>> Fixes: 5620a0d1aac ("firmware: delete in-kernel firmware")
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: stable@vger.kernel.org # 4.14 and later
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  Documentation/kbuild/kbuild.txt |    9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> --- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
>> +++ linux-next-20180704/Documentation/kbuild/kbuild.txt
>> @@ -149,15 +149,6 @@ stripped after they are installed.  If I
>>  the default option --strip-debug will be used.  Otherwise,
>>  INSTALL_MOD_STRIP value will be used as the options to the strip command.
>>
>> -INSTALL_FW_PATH
>> ---------------------------------------------------
>> -INSTALL_FW_PATH specifies where to install the firmware blobs.
>> -The default value is:
>> -
>> -    $(INSTALL_MOD_PATH)/lib/firmware
>> -
>> -The value can be overridden in which case the default value is ignored.
>> -
>>  INSTALL_HDR_PATH
>>  --------------------------------------------------
>>  INSTALL_HDR_PATH specifies where to install user space headers when
>>
>>
>> --


-- 
~Randy
