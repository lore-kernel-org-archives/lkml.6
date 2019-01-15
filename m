Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA8CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A2320675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XWWreA+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbfAORwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:52:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46229 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfAORwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:52:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so2770965oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ze61RiBsdBzmtk92EzmbIeS1jQrq7l8HYGYF7t7VyY=;
        b=XWWreA+oVlQr9sjkK+Bu3hQBULVUOS+lHQ5hZNCCBppEiei9EmygnmGhtKiOLInyQI
         gsf+yQsqf58SzLWagpzdsV6UYtFLKkWvb+JJX3ZooeWYTbuKXKdh+MHtReGHZ2DeS2cH
         SN5OjBDPToWY5sEHocdab+PwwGma4kPw95ICgQyLgypjnYfSkjsrpvxbMXUDfatVmur0
         Je/m7hY5XErEF86CX8JMNqbVbmzTnCs7Ruz393Mjj1Mizj2zvJN4Md176Ro1y/NHnVs3
         dpfLBMOo+MbBdCysDrnUqiT1eR2IlvQMz9T7gjOF9H0t7g2q2nLH5/tgoHgd1emUKykH
         EWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ze61RiBsdBzmtk92EzmbIeS1jQrq7l8HYGYF7t7VyY=;
        b=BxxCXW69P4UoIJW8QpWjoNatKZEoTJb5mtWrlfKmkyeuF/eDtyj75iNY4CgZ2n4KNO
         EWKsa6yJJKuhhLkeL1xefE1453GCt2fHSMNhKM78ZuzlaeGQ4kFypX82gnFMtASYLEbf
         7bfApavL7yvXJMcu411HjkmKOEZBEngh9B3QXWiP2+BVlZN1HwwCr2vxDqb2q96jBm+m
         7VhHvDZkFsF582nohY4Vqbk/B/945qQKXwm+FlvmJBT/NHl/Nl+fKgvznodeKnqeRwOz
         QezCw/LP6kcWRiU/TqVjXcn+nf9acZuCcTDzmZqx7JW1laZfjrp5+22cYB+qFCK0ngsV
         U0MA==
X-Gm-Message-State: AJcUuke9wdwG1hMZIW8gt+DLwlyjdORhIFd8fvPDxA2YpRMUFFtjDCMC
        kKNOJs6V2y02t8o7DygrRb09N6rLNp3BFjATMUlc4A==
X-Google-Smtp-Source: ALg8bN4FOpeOOkbUFPCd0WnId3JzAVPol+ghvhaKrqDoU00ACKgfZ38T49jrmwHS/Oqxzc1Wwbb0OLzhJzoYUltRBGk=
X-Received: by 2002:aca:f044:: with SMTP id o65mr940657oih.145.1547574741306;
 Tue, 15 Jan 2019 09:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20190114210426.177543-1-trong@android.com> <20190114210426.177543-5-trong@android.com>
 <CAK7LNAQe5CUhvvyMDfS2t+Y+t9B5SwUOah6V==9Ds+HR2SL5nQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQe5CUhvvyMDfS2t+Y+t9B5SwUOah6V==9Ds+HR2SL5nQ@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 15 Jan 2019 09:52:10 -0800
Message-ID: <CANA+-vBi9nQ6tH=fY0xqrY4i6pFsXikrnaaBZ6BdEv7q92tT2Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oberpar@linux.ibm.com, Greg Hackmann <ghackmann@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 5:25 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Jan 15, 2019 at 6:07 AM Tri Vo <trong@android.com> wrote:
> >
> > Clang gcov format is only supported by Clang compiler, and Clang
> > compiler only supports Clang format.
>
>
> If so, what is the point of putting GCOV_FORMAT_CLANG into the
> choice menu?
>
>
> You can choose the format only when you are using GCC.
>
> I think the following is more sensible:
>
>
> if GCOV_KERNEL
>
> config GCOV_PROFILE_ALL
>          ....
>
>
> choice
>         prompt "Specify GCOV format for GCC"
>         depends on CC_IS_GCC
>         ...
>
> config GCOV_FORMAT_3_4
>         bool "GCC 3.4 format"
>         depends on GCC_VERSION < 40700
>         ...
>
> config GCOV_FORMAT_4_7
>         bool "GCC 4.7 format"
>         ...
>
> endchoice
>
>
> config GCOV_FORMAT_CLANG
>          def_bool CC_IS_CLANG
>
> endif
>
>
>
>
>
> Or, you can delete GCOV_FORMAT_CLANG
> if you write the Makefile like follows:
>
>
>
> obj-y := base.o fs.o
> obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
> obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
> obj-$(CONFIG_CC_IS_CLANG)     += clang.o

Thanks for the suggestion! It is more sensible than the current
approach. I'll send an update.
