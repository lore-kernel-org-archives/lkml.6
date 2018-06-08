Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6ov3GoSqGlvGTgAAmS7hNA
	; Fri, 08 Jun 2018 16:10:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F809607DC; Fri,  8 Jun 2018 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528474244;
	bh=sfu+Yx/2pXQkzZRmia9D5zoeuv/OOxoIDYzRsx7mP0Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jCHyjkk3a+ehIQxOXVt+XZ/aoO/hpapfzeCC2JQRKy13bksnsnUZUuf/veHTk0abG
	 +xmlFeHTYe13gKhOW7UdQMLqOnzbE5runEtNp0HavJKyTmSHX3WkVioJRWOvEB1Gmy
	 POaOz7Q7tOzd3dpWBsJ/zwTvMuG4ZZUhAKbQumg4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A5483606FA;
	Fri,  8 Jun 2018 16:10:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SDAYJC8u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Npt8vMru"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5483606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeFHQKk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:10:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeFHQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:10:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6A3B608C9; Fri,  8 Jun 2018 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528474238;
        bh=sfu+Yx/2pXQkzZRmia9D5zoeuv/OOxoIDYzRsx7mP0Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SDAYJC8ufKghUctIvNH35srb7nZ5aFJpZYE5QSEPo7fJFExYQ4REqfRclk/U1D77A
         j1SLwHegik700lw+3ZPFUIzVmPf/wLt3xzF4lgXALQrZohtOvl1szDkzZJyZu8fcJA
         oqolVdLB159h98VxVkMHb6h6NSO6n8DCJLMy8Jss=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F894606FA;
        Fri,  8 Jun 2018 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528474237;
        bh=sfu+Yx/2pXQkzZRmia9D5zoeuv/OOxoIDYzRsx7mP0Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Npt8vMru8N9BrOOWjDiPmd5wM9OkRlkL1QGUVzXT3RLs6Gc94P7Rh8gYSELGGgjXS
         db3CdLl56lV2MnuYGj8eDG8gEcIxw294sQhVuzFVi1uUcxicFy/wr4NMrSEIa1+4YM
         RzpkrOI1MvnS7RQIdTG7DeCiWQYK2StVBlFrRcc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F894606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180608144617.2900894-1-arnd@arndb.de>
 <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
 <CAK8P3a2=uMFOcw=gZGuwsH+V=1DMXGgxf_hZHw3tMJD1nDdG2Q@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <830c2468-293c-385c-0b91-c96bedae4d4a@codeaurora.org>
Date: Fri, 8 Jun 2018 12:10:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2=uMFOcw=gZGuwsH+V=1DMXGgxf_hZHw3tMJD1nDdG2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2018 11:47 AM, Arnd Bergmann wrote:
> On Fri, Jun 8, 2018 at 5:27 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> +Will,
>>

[snip]

>> So, it is difficult to judge how this barrier has been used without an
>> expert opinion.
>>
>> Changing
>>
>> wmb() + writel()
>>
>> to
>>
>> wmb() + writel_relaxed()
>>
>> is safer than dropping the wmb() altogether.
> 
> If the wmb() was not just about the writeq() then I would argue your patch
> description was misleading. We certainly shouldn't replace random writeq()
> calls with writeq_relaxed() just because we can show that the driver has
> a barrier in front of it.
> 
> In particular, the ipr_mask_and_clear_interrupts() function has multiple
> writeq() or writel() calls, and even a readl() and your patch only changes
> one of them, which seems like a rather pointless exercise as the function
> still fully synchronizes the I/O multiple times.

You are right, I only searched wmb() + writel() combinations. Changed only
the places where I found issues. 

We were given a direction to go to eliminating barriers direction as you already
noted. 

I just wanted to highlight the difficulty of wholesale dropping of wmb() without
careful inspection. [1] [2]

We certainly need a better patch that covers all use cases. Your patch is
a step in the good direction. We just need some attention from the maintainer
that we are not actually breaking something.

> 
>> Will Deacon should probably look at why writeq_relaxed is missing on some ARM
>> arches too.
>>
>> Drivers shouldn't worry about write derivatives.
> 
> This driver defines writeq() itself for architectures that don't have it, but
> it doesn't define writeq_relaxed() and doesn't include
> linux/io-64-nonatomic-lo-hi.h
> or linux/io-64-nonatomic-hi-lo.h. It seems that it needs a different behavior
> from all other drivers here, storing the upper 32 bits into the lower
> address and
> the lower 32 bits into the upper address.

I don't think there is a consensus about using these includes in the community.
I bumped into this issue before and came up with an include you pointed.
I didn't get too much enthusiasm from the maintainer.

Why are we pushing the responsibility into the drivers? I'd think that architecture
should take care of this. Is there a portability issue that I'm missing from some
architecture I never heart of? (I work on Little-Endian machines most of the time)

[1] https://patchwork.kernel.org/patch/10301861/
[2] https://www.mail-archive.com/netdev@vger.kernel.org/msg227443.html

> 
>          Arnd
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
