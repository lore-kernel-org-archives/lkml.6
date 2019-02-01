Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADADC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE79F21479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDmEWQCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBBAEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:04:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56285 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBBAD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:03:59 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so12110922ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VV4f2PCyGwW/crTEb5s0n6CHHCI9fSydRbghYb9rKSc=;
        b=NDmEWQCXb9uyA6KnzxjAn2r1ogUz//7P4HKFVVeOeBPpVcPfMEqMnqLAUSsiA/Dsa0
         rZ7Bvqe+7XsnjVnr7AUhKwnCFCG/+eMjqR7vQUf4Ypn0+wcRWe6ZZo5ApbdNPWGDjAnA
         eg7NYMI/ermzNth9hrJASTHntqJFljEaSyU0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV4f2PCyGwW/crTEb5s0n6CHHCI9fSydRbghYb9rKSc=;
        b=D14j3KTJ05m/89NGsdRf5CEceEuTOA7bKZEk04ngBrKe4yMLbX9BiDR8u/gXBKa4Z4
         u/dL3GdiS3n5tOwss0hctQ9bn/q5f65GzpVRD122Fbgy2Hl7pQB35+M4MclAJH8DaOLu
         bYItMCtDxJjc4U1MYa2KaJcZoUXk+hLZZHiqZqavHQbSsSNIAQIdIkwsHc1kM+tWHYGj
         4b5EE5ozYChnzL21zYx7QLQMbm9KzykGY9EtbUPlwYIo5NgZuVJnb4jJ/4230tNaktcY
         6hg93QkSknxfZSCIb4KHxpGsxqzCXOnBUQBaJ79ErarqVSErAqbcb3Qt4eRzB/MCSObq
         ixTg==
X-Gm-Message-State: AHQUAua6ROXGt5OJiHDsBiQoVOGC906BJAVu4WIDPMWpROhGaViNWU63
        78ozgGyta27q4QOfradK61ukIk6tNcs=
X-Google-Smtp-Source: AHgI3IarqbmPQ3Qlt7/QMrvGOdjGJs1IkuhGUdUlHJabje9sZOOn2GKcqJv1iFCeu+us6mRrtXs9qQ==
X-Received: by 2002:a24:54d0:: with SMTP id t199mr3185977ita.57.1549065838411;
        Fri, 01 Feb 2019 16:03:58 -0800 (PST)
Received: from mail-it1-f176.google.com (mail-it1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id c75sm1997316itd.1.2019.02.01.16.03.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 16:03:58 -0800 (PST)
Received: by mail-it1-f176.google.com with SMTP id d11so12148894itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:03:58 -0800 (PST)
X-Received: by 2002:a24:3987:: with SMTP id l129mr2952723ita.45.1549065379165;
 Fri, 01 Feb 2019 15:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-21-thgarnie@chromium.org>
 <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com>
 <CAJcbSZH3-TVxDsoRLKSuFLU2bHVV9FgDXtUaZFMim3k+4QU8Cg@mail.gmail.com> <777DD215-A4F5-454F-856F-FFE870F15CDD@amacapital.net>
In-Reply-To: <777DD215-A4F5-454F-856F-FFE870F15CDD@amacapital.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 1 Feb 2019 15:56:07 -0800
X-Gmail-Original-Message-ID: <CAJcbSZGRFhQL56VnLwJn=r6MVjk9miYVeKgwdP+P45JT2q7QdA@mail.gmail.com>
Message-ID: <CAJcbSZGRFhQL56VnLwJn=r6MVjk9miYVeKgwdP+P45JT2q7QdA@mail.gmail.com>
Subject: Re: [PATCH v6 20/27] x86: Support global stack cookie
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 2:36 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Feb 1, 2019, at 12:21 PM, Thomas Garnier <thgarnie@chromium.org> wrote:
> >
> >> On Fri, Feb 1, 2019 at 11:27 AM Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >>> On Thu, Jan 31, 2019 at 11:29 AM Thomas Garnier <thgarnie@chromium.org> wrote:
> >>>
> >>> Add an off-by-default configuration option to use a global stack cookie
> >>> instead of the default TLS. This configuration option will only be used
> >>> with PIE binaries.
> >>>
> >>> For kernel stack cookie, the compiler uses the mcmodel=kernel to switch
> >>> between the fs segment to gs segment. A PIE binary does not use
> >>> mcmodel=kernel because it can be relocated anywhere, therefore the
> >>> compiler will default to the fs segment register. This is fixed on the
> >>> latest version of gcc.
> >>
> >> I hate all these gcc-sucks-so-we-hack-it-and-change-nasty-semantics
> >> options.  How about just preventing use of both stack protector and
> >> PIE unless the version of gcc in use is new enough.
> >
> > So fail the build in this scenario?
>
> Fail the build or use some Kconfig magic to prevent this from being configured in the first place.

Ok, I can do that in next iteration.

>
> >
> >>
> >> Also, does -mstack-protector-guard-reg not solve this?  See
> >> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708.  Or is there
> >> another bug?  Or are you worried about gcc versions that don't have
> >> that feature yet?
> >
> > I am worried about gcc versions that don't have this feature, yes.
