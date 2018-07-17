Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02355ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F6920864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RN8rXK4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F6920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeGQHN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:13:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQHN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TwCarA2wHUqxHtg5ZBcyM9Yk1ft/0X3/PdSJ9I7/K8c=; b=RN8rXK4FH0jnyxiAZWTzPIRYj
        Z4ETESmSXpnZSPw2pafWGHJPjgaEvjBhVtflrAv3BWTXJtv+uPc/EkcY29shVy2MiFv1af+fgB+6y
        tJnaP476FzciTK6qzQjUnGODyqJ6FrudzvEHr1ZQmBmpieV7AlnfebXMjby8RKx7AxR/K11jv3pJR
        YRZNYNFoQ4pDSdY5yW59mvwH1zz7NwgDYQpGeMh1lKATJgKs4OsYAKB8XaSeQDMkJi63tyHGsoK1B
        VX74TxP0v73DDperMolCGnEt9Y1SCyTZZLpW4453s8P8TTznDl0XdB5Vr849kOCJr46+jzH86KBuz
        GOtbIH3+A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffJhH-00023g-8J; Tue, 17 Jul 2018 06:42:55 +0000
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level
 Kconfig
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-5-hch@lst.de>
 <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
 <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
Message-ID: <7d4e0925-3d6b-7698-1ef3-4c66500d8507@infradead.org>
Date:   Mon, 16 Jul 2018 23:42:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 11:33 PM, Randy Dunlap wrote:
> On 07/11/2018 05:21 AM, Masahiro Yamada wrote:
>> 2018-07-09 0:19 GMT+09:00 Christoph Hellwig <hch@lst.de>:
>>> Instead of duplicating the source statements in every architecture just
>>> do it once in the toplevel Kconfig file.
>>>
>>> Note that with this the inclusion of arch/$(SRCARCH/Kconfig moves out of
>>> the top-level Kconfig into arch/Kconfig so that don't violate ordering
>>> constraits while keeping a sensible menu structure.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>>
>>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>>> index dd4f3d3e644f..7ab7b148181b 100644
>>> --- a/arch/sh/Kconfig
>>> +++ b/arch/sh/Kconfig
>>> @@ -168,10 +168,6 @@ config PGTABLE_LEVELS
>>>         default 3 if X2TLB
>>>         default 2
>>>
>>> -source "init/Kconfig"
>>> -
>>> -source "kernel/Kconfig.freezer"
>>> -
>>>  menu "System type"
>>>
>>>  #
>>> @@ -553,8 +549,6 @@ endchoice
>>>
>>>  endif
>>>
>>> -source "arch/sh/mm/Kconfig"
>>
>>
>> I noticed at least sh is broken
>> because "arch/sh/mm/Kconfig" is no longer included by anyone.
>>
>> I am not doing further tests.
>>
> 
> Hi,
> 
> Thanks for noticing that.
> 
> I have tested all $ARCH (except um) with "allmodconfig" and so far, arch/sh/
> is the only one that has a problem.
> 

Well, there are 3 $ARCH-es that have an arch/$ARCH/mm/Kconfig file:
arm, sh, and unicore32.

We can either merge those into arch/$ARCH/Kconfig or we can source
arch/$ARCH/mm/Kconfig for all $ARCH (where most of these files will be
empty).

Christoph, thoughts/ideas?


> 
>>
>> Please test *ALL* architectures.
>>
>> If possible, matrix tests (arch, config-target), where
>> arch = arm, arm64, ...
>> config-target = allyesconfig, allnoconfig, alldefconfig, ...
>>
>>
>> Note:
>> scripts/diffconf is helpful.
>>
> 
> 


-- 
~Randy
