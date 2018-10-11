Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D147C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCC204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRD3F7D5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCCC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJKQBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:01:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36465 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeJKQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:01:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id e201-v6so3273091ywa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIzNl5MyXyPdBtW1D+ZzfZvtak4OL15GXB5RKgoC9hA=;
        b=eRD3F7D5NF4eYzZrB7L3NqGeZcJMpjlrhz9OlRTPFuEM1pAMd7Ckpp+hfV88SvycVl
         2Hdg5I/dW69mLw7QF+1iRWOlju9ips0H463oS+NyO0eVsQ5pQy83OzeCGUw0eOs+Wx1H
         fNIwOGmoCDf0LIedx90+KKCISba1FwpauiB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIzNl5MyXyPdBtW1D+ZzfZvtak4OL15GXB5RKgoC9hA=;
        b=HTnOiAsfrCHntzyNPJICFU5/2NBBXvbp3Q7HnWe/R2DDqcXEkaz6RoxArKUUEvT1HU
         FsMoHlmzyIfyqbxmkM6JMVrH1968T2aCudCCRD8kFK+on7bv/7JyN407JSnxHvus19iZ
         gxTS+eHTGx4ueWnOo7HDWUobzHHrmN/VC2e3PWDV3VJGm9ZdJS/sQ5BTOMp0zIGBoEdx
         ORt7kaFykKH8TciOPJFKgxDuG0mz+MU+zxn56h3ef1/eo9UxxPRmyto2y/m1ibk7UZYS
         Ku5YtOmFeqjzoG5YhZ8nEycjX7nDUJ73dlvSdVJMq+OIV4gvp4bEp1Ycfsj1BIwKHyt6
         7xRg==
X-Gm-Message-State: ABuFfoh40whsPbT0E+ZWUqg1GSuIOB716ATJLLLJO/Cfoq6eaZ+Uzb8X
        hn/7JDQBE4SnrQsN4yCsWTm0KVfoRuNFOluLLRiYUw==
X-Google-Smtp-Source: ACcGV61tGBv5SG+NHiRshslYKsbOxET3wOImY0Zqfo0Pz2/CAVGH4tcEDLjRq3PHC1M3CzvdZcc3mp3CC9xxrjDS8HA=
X-Received: by 2002:a81:3bc4:: with SMTP id i187-v6mr266432ywa.82.1539246915007;
 Thu, 11 Oct 2018 01:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <1539231895-4118-8-git-send-email-firoz.khan@linaro.org> <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 11 Oct 2018 14:05:03 +0530
Message-ID: <CALxhOnjtT28W3V6wMjhXYqHo0uDgmUDgMLp8TyT2nxu=n0iL+Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ia64: wire up system calls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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

On Thu, 11 Oct 2018 at 12:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 11, 2018 at 6:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > wire up perf_event_open, seccomp, pkey_mprotect, pkey_alloc,
> > pkey_free, statx, io_pgetevents and rseq system calls
> >
> > This require an architecture specific implementation as it not
> > present now.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/ia64/kernel/syscalls/syscall.tbl | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> > index 6b64f60..1f42b60 100644
> > --- a/arch/ia64/kernel/syscalls/syscall.tbl
> > +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> > @@ -335,3 +335,19 @@
> >  323     common  copy_file_range                 sys_copy_file_range
> >  324     common  preadv2                         sys_preadv2
> >  325     common  pwritev2                        sys_pwritev2
> > +# perf_event_open requires an architecture specific implementation
> > +326    common  perf_event_open                 sys_perf_event_open
> > +# seccomp requires an architecture specific implementation
> > +327    common  seccomp                         sys_seccomp
>
> I don't think that's correct for these two. perf_event_open() of
> course requires 'perf' support that ia64 does not have, but
> at least seccomp should just work.
>
> > +# pkey_mprotect requires an architecture specific implementation
> > +328    common  pkey_mprotect                   sys_pkey_mprotect
> > +# pkey_alloc requires an architecture specific implementation
> > +329    common  pkey_alloc                      sys_pkey_alloc
> > +# pkey_free requires an architecture specific implementation
> > +330    common  pkey_free                       sys_pkey_free
>
> One comment for all pkey calls would be sufficient. More importantly
> it requires hardware support that ia64 does not have AFAICT.
>
> > +# statx requires an architecture specific implementation
> > +331    common  statx                           sys_statx
> > +# io_pgetevents requires an architecture specific implementation
> > +332    common  io_pgetevents                   sys_io_pgetevents
>
> It certainly does not require any support from the architecture for these.
>
> > +# rseq requires an architecture specific implementation
> > +333    common  rseq                            sys_rseq
>
> Maybe leave rseq and pkey_* commented out so we reserve
> the number but don't add it for real? Maybe the ia64 maintainers
> have a preference.
>
> As asm-generic maintainer, I'd like to have the various asm/unistd.h
> headers be as similar as possible and at least reserve all the
> numbers even if we don't need the calls on a given architecture.
>

Thanks for your review.

Firoz

>        Arnd
