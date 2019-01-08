Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50ED20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMCw8XFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfAHSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:01:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36263 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAHSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:01:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so4196460ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/JHyziTXYBZgKuarJJ+NDCvRCIPz6dL/9BbolzPVrs=;
        b=EMCw8XFewXGueYaj9qtzkX6ek0b6RZUBiLrNSBGscpVfgjmfHO8I0Zcp+9zFdvmmEe
         c2xh/HQ+On3H3TSOak2Mc+gZcDMR4Hmt5lDt+QRQDFkVzro/3z4pV9ut8gQTJyKdBI45
         HYmYlhjsAI9dA98iwTXqP68zDqDrakq5cQvas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/JHyziTXYBZgKuarJJ+NDCvRCIPz6dL/9BbolzPVrs=;
        b=H7FYHSudjuLSVWHsaU51CmcnrNmFHcp4fJ3A80GY7Lj5KFi2F7QqwNJfJo/38p+pvx
         DG2uGcmPYH+6j1NM69oEy0rYMbpEKBiFZMdHT5vOQ0whFwDEmomwV2lQTjnU9YMA5h4c
         NwDvVO59+3Fr45z5K1mtA5LplNtMFkD53YN+dEo2ksZDU0WM0ldwx+2Z2I0tJUBEh+yr
         Z5IfaXk/F4IZ/S95cPFRSNdq76KgRV3izcuW8SB0Y0KFcFlhl7sFsM19r35oww8zCsS2
         XnGZUfJsLajzjlPxdG144HLpt1cqjhnpYo01daKJfmu+FB6YshnmntKFDSWtyvblkd9H
         SPCQ==
X-Gm-Message-State: AJcUukc68X8OcffuM8rnD2pS+2hbYOFRoFeRDUOyGdBNYDPNJ2jgXdcH
        LSx3RnF/lWzsUDtZnktZT1AzhVkLDwHMzQ==
X-Google-Smtp-Source: ALg8bN6hN28RjBzhnd1aB+KeRx7UpDUIZDPotkidd2YWhubjXgvd0nWCh4uj6GgT6na+pfiQZKDF+w==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr1819219ljj.61.1546970493206;
        Tue, 08 Jan 2019 10:01:33 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g17sm13381311lfg.78.2019.01.08.10.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:01:32 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id k15-v6so4169855ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:01:31 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1600815ljh.59.1546970491265;
 Tue, 08 Jan 2019 10:01:31 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
 <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com> <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
 <dbb32dfaebee4bcb8ec3372bc7a27032@AcuMS.aculab.com> <CAHk-=wg02_--Xbf9HQw0g5-0k_uY+ksbxfBHK45BKDnPjz9OXw@mail.gmail.com>
 <9e479981e09b4bebaaf6bc7f81c7bb59@AcuMS.aculab.com>
In-Reply-To: <9e479981e09b4bebaaf6bc7f81c7bb59@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 10:01:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFoLfXct8RdMQRGn_B7RFfpZib403CLORZrex1KbAAqg@mail.gmail.com>
Message-ID: <CAHk-=wjFoLfXct8RdMQRGn_B7RFfpZib403CLORZrex1KbAAqg@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:10 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > It will never work for memcpy_fromio(). Any driver that thinks it will
> > copy from io space to user space absolutely *has* to do it by hand. No
> > questions, and no exceptions. Some loop like
> >
> >    for (..)
> >       put_user(readl(iomem++), uaddr++);
> >
> > because neither copy_to_user() nor memcpy_fromio() will *ever* handle
> > that correctly.
> >
> > They might randomly happen to work on x86, but absolutely nowhere else.
>
> Actually they tend to handle it on a lot of systems.

Not with memcpy_fromio(), at least.

That doesn't work even on x86. Try it. If the user space page is
swapped out (or not mapped), you'd get a kernel page fault.

And if you do "copy_to_user()" from a mmio region, you get what you
get. If somebody complains about it doing a byte-at-a-time copy, I'll
laugh in their face and tell them to fix their broken driver. It might
work on about half the architectures out there, but it's still
complete garbage, and it's not a bug in copy_to_user().

               Linus
