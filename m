Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC05ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436012148E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R32XDzNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436012148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbeGMANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:13:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53411 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387719AbeGMANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:13:14 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so9276570itd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=floiBXgg12C4kqU5VTrJdbAukqagbECpPMk7AGzr8YI=;
        b=R32XDzNs0gxEj/n+dRwJjUr1NutBy6Ihxn3V7WXAB9o7cp2dYtrCWD3GBR24rUlIfq
         yLqg7VLeHgyGdc2FFyd8LHQt248NLGYGnif9c6rMB8452MLMLv01Qawvi+PKna9nhY/8
         XCiUssIQZJl6AW0hZs82TThTPHz//WObZpt+UK9clgck9ilSnlokjtyozdL31LTQDf/h
         vAu2psHRXNz54SIVTEK0NUeLhb41yHHsjmuIP36DpGjWRqwmBjs62rPWCSPekKvmJdRf
         YvwNlUCa48CoqwPVeubkSrQSQjovTHPobMQhfbPgHDC3miDZJTFcTg8+p4Z2MaznTu9s
         ZudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=floiBXgg12C4kqU5VTrJdbAukqagbECpPMk7AGzr8YI=;
        b=Fj2T8Z3YgY3b3Nhle7abPbe9W77e2b9NfpRk7XB+Lnp+4m3hEOE8iEJTt5MPSRZ0XT
         +jt8OyD66tBM88isuF4rQXpAv+sfHlcfO1nIq2TFAJaEeO5GJPj2LA6WMYlhifkxXykp
         c/YyTV10qoVjNv1a1tSInY9GJwfIOZ+h0E8j3FZty/0REcW9ONAtltCpE31J0Fo19lFB
         m2AzTk2m0UD+sx3wnpz4579/irtT1v7zTX9LPzDJgppokjvZK9TKgVV+aOjer83TDteG
         rMOeO0cUznQld5/le5oK9/aZKhhc5JAwCJVgEmA4Ze3HLWlLawNUOkyFcYveSfCLgz8L
         qyjQ==
X-Gm-Message-State: AOUpUlEYS7t2i6JdUiEeyRtKJBmT87lh64sd55T4FaR4T1bXJ4C66E+1
        9AXD4FkTtxuVuQvJ7B77YShbuR9c15aYhS7/gPnEv4C4
X-Google-Smtp-Source: AAOMgpcUFuB/fqSvAgt1iE6fyiJQLhZ5g4dGFcl/8v0HQfaXMWZwq6nThMH77cj/KMsXmGvnT76khKlysWJceKnyuDA=
X-Received: by 2002:a24:7a84:: with SMTP id a126-v6mr3021211itc.111.1531440078163;
 Thu, 12 Jul 2018 17:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180712201032.156997-1-astrachan@google.com> <47d4b24e-8c60-fb3b-3377-62d20c5f3dd1@zytor.com>
 <CANDihLEz3_fZ4r4g=VcxWps5DWSjMJdbJZKZWsLFKVp_c7FscA@mail.gmail.com>
 <1432bfde-41b4-e8aa-037b-fca41a149cb8@zytor.com> <5AB78E47-BC62-4DA5-920B-00E9731AAE04@amacapital.net>
In-Reply-To: <5AB78E47-BC62-4DA5-920B-00E9731AAE04@amacapital.net>
From:   Alistair Strachan <astrachan@google.com>
Date:   Thu, 12 Jul 2018 17:01:06 -0700
Message-ID: <CANDihLFWXKd1ijdTFCdZSa4yiQLMP=PhUpws41DYfOP-zLOpng@mail.gmail.com>
Subject: Re: [PATCH] x86: vdso: Fix leaky vdso link with CC=clang
To:     luto@amacapital.net
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 4:20 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> > On Jul 12, 2018, at 3:06 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> >> On 07/12/18 13:37, Alistair Strachan wrote:
> >>> On Thu, Jul 12, 2018 at 1:25 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >>>> On 07/12/18 13:10, Alistair Strachan wrote:
> >>>> The vdso{32,64}.so can fail to link with CC=clang when clang tries to
> >>>> find a suitable GCC toolchain to link these libraries with.
> >>>>
> >>>> /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
> >>>>  access beyond end of merged section (782)
> >>>>
> >>>> This happens because the host environment leaked into the cross
> >>>> compiler environment due to the way clang searches for suitable GCC
> >>>> toolchains.
> >>>>
> >>>
> >>> Is this another clang bug that you want a workaround for in the kernel?
> >>
> >> Clang is a retargetable compiler (specified with --target=<something>)
> >> and so it has a mechanism for searching for suitable binutils (from
> >> another "GCC toolchain") to perform assembly and linkage. This
> >> mechanism relies on both --target and --gcc-toolchain when
> >> cross-compiling, otherwise it will fall back to searching /usr.
> >>
> >> The --target and --gcc-toolchain flags are already specified correctly
> >> in the top level Makefile, but the vdso Makefile rolls its own linker
> >> flags and doesn't use KBUILD_CFLAGS. Therefore, these flags get
> >> incorrectly dropped from the vdso $CC link command line, and an
> >> inconsistency is created between the "GCC toolchain" used to generate
> >> the objects for the vdso, and the linker used to link them.
> >>
> >
> > It sounds like there needs to be a more fundamental symbol than
> > KBUILD_CFLAGS to contain these kinds of things.
>
> How about $(CC)?

I'm guessing, but I think this wasn't done originally because CC is
something the user might reasonably specify on the command line (the
other bit comes from CROSS_COMPILE), so doing this via CC would
require us to override the CC passed in on the command line. Not sure
how to do that, since the vdso makefile is executed with a submake, so
the usual "override CC := $(CC) something else" followed by "export
CC" doesn't work.
