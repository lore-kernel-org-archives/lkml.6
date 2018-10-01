Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6578C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD85213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNxkeHhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD85213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeJAUoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:44:54 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46499 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbeJAUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:44:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so1020858ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFo3jQyTe0CnWSxQPVPa2xuL0CCmpc4r12t2l+3+l5M=;
        b=VNxkeHhNXgPG+cvmldvhpo8SqsJra8c21FhLztD+IExr3oTx7LBxwvmZ1afiARqX1W
         YIVpfUyAKqkHMjmAq9lu+BE9cJgxi274jp7ZAqXJZTYYdZG3Utuk8DC+k982EvSz1JpT
         mpbDU+Yr/CUcWu2SrArtGFDrKmEfYC3o+foH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFo3jQyTe0CnWSxQPVPa2xuL0CCmpc4r12t2l+3+l5M=;
        b=CCE1K1+ohCXtVgoTdBmntNrxMPk0HCmBWriQ8d29UAHf/vQ6m4kI/H5SdQtky06/NT
         0SRFR0p0TYRdeCFevtXdKcxZPQE/MTYRfIwzYcgnfnu4d6ZDE+vnwPQLS9V5+b7uQgao
         Bo6YaiKkebzSqHunFyjUqvD6En+LKP3/hU9pAniVeYLnmcsIFBReUEx7iCOmuCoxgj1b
         2FbvqOJuKbzMEm/sEjxLMM00ycK0pD2jVhqQes1VS0+I+wl3noCQajX62uE4uekokzVz
         CEfjGS3eH8bJN0tyAkGCxyNLKDbYyaKxpRBPswQ1sALtfNRuFQGOmlauTykztgfe15oc
         S85g==
X-Gm-Message-State: ABuFfojEp6pYCPC1jdSIYc7Ej/EvCLLdYAevqsFjXMcLdH3epoRD1Ubr
        p1OHIJQE0XNEZTJR5A79Nqyq3Eua+O9+SYX1655fZg==
X-Google-Smtp-Source: ACcGV63/lgKVx1PTeWhekneadllTKeOe8FVfYL6Zpghd1wiGqsVZMM9+P/55EaQM1VP9xh54mTtm64ZTwXMHs0IVZvw=
X-Received: by 2002:a81:25c4:: with SMTP id l187-v6mr5986479ywl.236.1538402815429;
 Mon, 01 Oct 2018 07:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
 <1538058267-3765-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a3ZOC-V0uOD6uD=Hg-AoN8mkJynD6ubpaTppevUvQ54qw@mail.gmail.com>
In-Reply-To: <CAK8P3a3ZOC-V0uOD6uD=Hg-AoN8mkJynD6ubpaTppevUvQ54qw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 1 Oct 2018 19:36:44 +0530
Message-ID: <CALxhOnjrmfiPbSXf_ba3+5OyqZA6xuZue8PV4Pu7f3z+h-kUZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] parisc: add __NR_Linux_syscalls macro with __NR_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 28 Sep 2018 at 17:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > 1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
> >    by counting the no.of system calls. No need to update
> >    __NR_Linux_syscalls until we either add a new system call
> >    or delete an existing system call.
> >
> > 2. We can keep this feature it above mentioned script, that
> >    will count the number of syscalls and keep it in a gener-
> >    ated file. In this case we don't need to explicitly update
> >    __NR_Linux_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I moved
> > the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
> > unistd.h. The macro __NR_syscalls also added for making the
> > name convention same across all architecture. While __NR_sys-
> > calls isn't strictly part of the uapi, having it as part of
> > the generated header to simplifies the implementation. We also
> > need to enclose this macro with #ifdef __KERNEL__ to avoid side
> > effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/parisc/include/uapi/asm/unistd.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> > index bb52e12..255c62a 100644
> > --- a/arch/parisc/include/uapi/asm/unistd.h
> > +++ b/arch/parisc/include/uapi/asm/unistd.h
> > @@ -366,7 +366,11 @@
> >  #define __NR_statx             (__NR_Linux + 349)
> >  #define __NR_io_pgetevents     (__NR_Linux + 350)
> >
> > -#define __NR_Linux_syscalls    (__NR_io_pgetevents + 1)
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls           351
> > +#endif
> > +
> > +#define __NR_Linux_syscalls     __NR_syscalls
> >
>
> Hmm, now you have a __NR_Linux_syscalls macro that is defined in user
> space to a another macro that is not visible there. How about moving
> __NR_Linux_syscalls into arch/parisc/include/asm/unistd.h or
> replacing its users with __NR_syscalls instead?

Something went wrong when I created this patch series. Yes, this must be
reside in asm/unistd.h instead of uapi/asm/unistd.h. I would update this
change asap.

I would appreciate if some can perform boot test on actual platform.
Hopefully the above change doesn't make any problem.

Thanks
Firoz

>
>        Arnd
