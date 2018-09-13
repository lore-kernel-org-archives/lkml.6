Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE92133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECDJCXVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CE92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIMJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:10:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37164 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:10:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so4175267qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1uxQgYYR4yWpo1Urd72WH8XQcH+dHq+7GUlHe/gmg4c=;
        b=ECDJCXVAnydnhwWpU/OJNaj3h8a0fQbsWLdANjcsHtwIddDJ7q48s31GJRElIeNunP
         U1V6SINbe2br/43+pC1ynKuTZC1UWzXo31gKtxQJu3EeD+kFh1uFD2Xqh4Kao0UZWnJb
         8xlliEtRyVB/qraz2q6yLh75Vkwf5OA26DR2brb45UUCGh8owudVs7Xzat9U3iIp2gWI
         oLd5PxK/vrIDv/1f9aD9OjAzDMZIdOEI76cliEBKRFsKx6NMevVihyYoq24IlRmePuiB
         iuLO04WXrsmlhBf3W53jbocf+uf1SFN9BiAccMA4A48/eGsG4Z7MCr/QfolfdYzdKfBj
         v3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1uxQgYYR4yWpo1Urd72WH8XQcH+dHq+7GUlHe/gmg4c=;
        b=JbwfkqUndHn2mXduKcHgt6sI4+V5sHMptLsh+K1XBjuoiLP/K9x7fCsgP+i1lb6GLH
         kMXz+5qACbT3x3O04ciuV60Bvg9rmRwmCveXCoDL/V9mfsO6OuaBW/f/Cdw+pPq47hR3
         IKxLJyle/dSqMIyurEGgyUdaC6X5Zha8vvJfokLgorp0dqqqYB3GDphT10n6VHxirhzT
         bUuhw7vLdj6Umhlb5UPP/Ih9e1WNYb4WY1aOHg7TcNzimk/7VAzwcDDbVW1O5oYVHtu1
         E78vZseJ3c11JCyXAxCw0XlaKHlJTZoReUVsvG6AxqfqJwEYwf8qBvVrXxfZzf/3Si/p
         sdhg==
X-Gm-Message-State: APzg51DRva0NaQBzcE7IjzhyRzX9dEdwYjsHWPu5P33zW+VEZwZBYMlw
        n0OhiNio6lZKXPWwB32+wxcoOvKuOEyBwziyLeA=
X-Google-Smtp-Source: ANB0VdZqp++KB5nIVuG4IvmhKkAA4LPwelOg83uMxbPX1XsTkc+MCLQ8dhwPPBJsiuALkfNH+DyO5g24rPU85/T7zHY=
X-Received: by 2002:ac8:304a:: with SMTP id g10-v6mr3947036qte.136.1536811395314;
 Wed, 12 Sep 2018 21:03:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 21:02:54
 -0700 (PDT)
In-Reply-To: <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
References: <20180910060455.20409-1-stefan@agner.ch> <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
 <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 13 Sep 2018 06:02:54 +0200
Message-ID: <CANiq72=BE8ygC6r4cJ2TshwOKCEv0C8F2xmpLRhSVMfqq16xUQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler-clang.h: define __naked
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Agner <stefan@agner.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paul Lawrence <paullawrence@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Wed, Sep 12, 2018 at 6:19 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I will do a bigger one tomorrow or so and see if there are any
> important differences. Regardless of what we do, I will send the
> __naked patches separately as well (requested by Nick on GitHub).

So I did a comparison with a full allyesconfig between -rc2 and -rc2 +
v4. I find quite a lot binary differences, but not a single objdump -d
difference (object file by object file) just by fixing UTS_RELEASE to
the same value, so I guess that is a very good sign in case someone
wants to pick the entire series sooner than expected. Regardless, I
will send the separate __naked patches.

I should note that, at some point in one of my allyesconfig builds I got this:

  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
ld: drivers/edac/amd64_edac.o(.text+0x200031d2): reloc against
`__asan_load4_noabort': error 4
ld: final link failed: Nonrepresentable section on output
Makefile:1035: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Running make (without cleaning) didn't reproduce it, and the other
allyesconfig builds didn't suffer any problem either. Maybe my
hardware is failing, but I wanted to let you know nevertheless.

Cheers,
Miguel
