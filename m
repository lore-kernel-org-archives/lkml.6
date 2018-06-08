Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DO8zDwmlGluZAgAAmS7hNA
	; Fri, 08 Jun 2018 15:47:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9DF49607DC; Fri,  8 Jun 2018 15:47:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIvh/EhW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DAB8602FC;
	Fri,  8 Jun 2018 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DAB8602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeFHPrV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:47:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33556 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:47:20 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so5380490ita.0;
        Fri, 08 Jun 2018 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2BIEOZ0MbFMZyTmkftMOWA2usEwmvl6V+4H4DW7It5E=;
        b=vIvh/EhWJ90FIH52nELON+yxUat9nwQb0h28Bz7bZo9ty1ppQG8HrwFYN73y/1wvUt
         16xWl5HYssl8Skl8QhwkIepOqo8DUNicvyhucYI/zOIp7n0ujiKJUbn4gx2u5Sk/bxm2
         fPuyU0EaR3S/5uZxa5dWFLN+BrvzK8UzfehATyfjRFuuzl0ln4rPDm63IeeY6LByT0CS
         nHwHeFtII2AkzeJHw/+0bY6A0djFcdtbY8trmKsMk5/dzDOPaUsAnl9W109DuGzUjO23
         NKk/huxW1h674X94eEqv7eK/7vUUqn/yUIVrFNmNwJmh+PP+hzHAxUye1wKd2VnOl2Ri
         Ko6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2BIEOZ0MbFMZyTmkftMOWA2usEwmvl6V+4H4DW7It5E=;
        b=Z/S7+PFiMj3Ts38WoZAZSKNElAHh2i7GgEjEITNQL6e2Jjt7rRYQhvEeH3NYR6CcCx
         NvL1JvwuL+MRk9YilWLD+itdz2/TR6adj2/5GBRKbnsnKE4uXrYx1qzQP8WMmzuhMZgz
         Idx3w0zKYnw2Jn7uJ6m5bKKv6kzYnEKVZVEE74fgHbhDUZdnB/8vJf+Qr8qGHtHJGCzI
         iuAUPndsFg5uWGka1yO1NKA5wRWqoCkHycQOfWv31ao50EWAaKjsezKpuRktTOkSyyaq
         hwn9sPEZKfXN0PEPsa7Nbo8Jef2xFzN4lEEnyA5xKNcCvF63nmsNItFhPqBsz+qLs01U
         cpmQ==
X-Gm-Message-State: APt69E0ShaQcy8tQfIGO/EXoDZloLu+3ZHzpAkaVzEhe6j0EF/G8QCLN
        TijWw2jQTBVmZF2Hu2IswFdjwXsk0+eOCKXEgr0=
X-Google-Smtp-Source: ADUXVKLDhULxv5rXE/Q19Vja4u2vj1xyNcVG4hJLrP5OwlEqdrIFUOPaNsalrd0pv128Ba5h3e+5qyq485SA/YFUqko=
X-Received: by 2002:a24:43cf:: with SMTP id s198-v6mr2094554itb.28.1528472839186;
 Fri, 08 Jun 2018 08:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7515:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 08:47:18 -0700 (PDT)
In-Reply-To: <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
References: <20180608144617.2900894-1-arnd@arndb.de> <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 Jun 2018 17:47:18 +0200
X-Google-Sender-Auth: 1ZLOPNdjKtFtJOwOkMLMOIzzci0
Message-ID: <CAK8P3a2=uMFOcw=gZGuwsH+V=1DMXGgxf_hZHw3tMJD1nDdG2Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
To: Sinan Kaya <okaya@codeaurora.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 5:27 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> +Will,
>
> On 6/8/2018 10:46 AM, Arnd Bergmann wrote:
>> Replacing writeq() with writeq_relaxed() doesn't work on many architectures,
>> as that variant is not available in general:
>>
>> net/Makefile:24: CC cannot link executables. Skipping bpfilter.
>> drivers/scsi/ipr.c: In function 'ipr_mask_and_clear_interrupts':
>> drivers/scsi/ipr.c:767:3: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writew_relaxed'? [-Werror=implicit-function-declaration]
>>    writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
>>    ^~~~~~~~~~~~~~
>>    writew_relaxed
>>
>> The other issue here is that the patch eliminated the wrong barrier.
>> As per a long discussion that followed Sinan's original patch submission,
>> the conclusion was that drivers should generally assume that the barrier
>> implied by writel() is sufficient for ordering DMA, so this reverts his
>> change and instead removes the extraneous wmb() before it, which is no
>> longer needed on any architecture now.
>>
>> Fixes: 0109a4f2e02d ("scsi: ipr: Eliminate duplicate barriers on weakly-ordered archs")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This looks good on paper however we need an input from the driver maintainer
> because some drivers like Intel NIC are using write barriers in place of
> a SMP barrier + write barrier combination as an optimizatin.
>
> Removing the barrier itself can actually break the driver if SMP barrier is
> actually needed instead.
>
> So, it is difficult to judge how this barrier has been used without an
> expert opinion.
>
> Changing
>
> wmb() + writel()
>
> to
>
> wmb() + writel_relaxed()
>
> is safer than dropping the wmb() altogether.

If the wmb() was not just about the writeq() then I would argue your patch
description was misleading. We certainly shouldn't replace random writeq()
calls with writeq_relaxed() just because we can show that the driver has
a barrier in front of it.

In particular, the ipr_mask_and_clear_interrupts() function has multiple
writeq() or writel() calls, and even a readl() and your patch only changes
one of them, which seems like a rather pointless exercise as the function
still fully synchronizes the I/O multiple times.

> Will Deacon should probably look at why writeq_relaxed is missing on some ARM
> arches too.
>
> Drivers shouldn't worry about write derivatives.

This driver defines writeq() itself for architectures that don't have it, but
it doesn't define writeq_relaxed() and doesn't include
linux/io-64-nonatomic-lo-hi.h
or linux/io-64-nonatomic-hi-lo.h. It seems that it needs a different behavior
from all other drivers here, storing the upper 32 bits into the lower
address and
the lower 32 bits into the upper address.

         Arnd
