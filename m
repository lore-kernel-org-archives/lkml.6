Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ECE2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2LYV6ybb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ECE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeJLXlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:41:03 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33248 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeJLXlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:41:02 -0400
Received: by mail-wr1-f50.google.com with SMTP id e4-v6so14027430wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hxVCU92OitQCJUgR7B289FyKRi8LK32Fk8IRZIRsdhk=;
        b=2LYV6ybbHGeDf85x1+ZqEg9lgGQP450EAbbtT+EPR+JtREaFtxlEL9FMbeV3kBltPr
         54N1yUer7PgplVHBkWEQHJlK7+BgAraj5lVHdOct0V/LSIDzP0aRi4pIH1DO5OxNKCZ/
         RjTMerON8x9vG3o6QBfThfos/Kt67fD39j2O0nybAKBVmp4VXLaO7Nf7va8XgJSHBmUl
         L4kTcL0eyBrh4452E77lPEX214bIj47K8P1ldCkgdY4NU2mojWNbDj6qHSWrtFfPstSV
         7tcU6jQb29Vo7vsnBVe7q6QzjMUPvMxDsqX7da4M+3VNsz9SWaxvweoKMjSXm10TxNbS
         j34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hxVCU92OitQCJUgR7B289FyKRi8LK32Fk8IRZIRsdhk=;
        b=BDwV1VpKHkKPQHTYiO5+KpgNCtRrujf/lH9UFw9Tw3X1lRBNWMLLHGZrkv5CDMWoax
         OheoVOlGhU3MtNz+vWkK0/lXUDAbS8ONPVd5N0obFwAsI8E8KcwVYnCBJr10AN4W+5P+
         neok8eXLAPUhd8i9sayjkFur948hb3RHRafDgDeyynA7johp1brP5Jz+NCliSnJ7CHTn
         3s4HJvMSF6XaUq2wdDddjOIlvtU9UepTbndH0es7micYkWmy07XHTKreSiH7vslTfOsW
         fCVTIwpHUjN9wDPphml5T2hNYUoiFJyVfzetEzu2uRiLWTtgAr4ix193An1EjCIpQY9i
         keNg==
X-Gm-Message-State: ABuFfoiYTUz2XRJ3GgnZ6DkK0c8+T/YVPlb1unvoBbJdyi/oF2d7b6M5
        PCjysOXyo0gQ13zsreKx2jZ83o6lxBRdP2ekDEeCFA==
X-Google-Smtp-Source: ACcGV61X/wYlgE0DsNytyCooVv/6IhfNuiwCeqlRgMc1bSCzBGlLNY1KGq0pqCPwwnjgrrYVDsXc41821k0+VnVy5MM=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr5572787wrc.131.1539360470691;
 Fri, 12 Oct 2018 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
 <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
 <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
 <20181012152515.1d816906@alans-desktop> <77F59E25-5244-4CBC-A3CB-DCF863803CD2@amacapital.net>
 <20181012160219.7d16ef59@alans-desktop>
In-Reply-To: <20181012160219.7d16ef59@alans-desktop>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 12 Oct 2018 09:07:39 -0700
Message-ID: <CALCETrWTHtqdQNQmk9taMRxOOEE8XanibEbP73AQNvNKJZjrEg@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 8:02 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote=
:
>
> > My understanding is that the standard =E2=80=9Cbreadcrumb=E2=80=9D is t=
hat a cache line is fetched into L1D, and that the cacheline in question wi=
ll go into L1D even if it was previously not cached at all. So flushing L1D=
 will cause the timing from a probe to be different, but the breadcrumb is =
still there, and the attack will still work.
>
> Flush not write back. The L1D is empty (or full of other stuff the way
> the prototype I tested did it as x86 lacked a true L1 flushing primitive)

I'm not sure I follow what you're saying.  If an attacker is learning
some information based on whether a given cacheline is in L1D, I'm
asking why the attacker can't learn exactly the same information based
on whether the cache line is in L2.  Or using any of the other
variants that Jann is talking about.

Adding ~1600 cycles plus the slowdown due to the fact that the cache
got flushed to a code path that we hope isn't hot to mitigate one
particular means of exploiting potential bugs seems a bit dubious to
me.
