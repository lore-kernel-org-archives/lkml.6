Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beIgIaBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfABMOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:14:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfABMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:14:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so26507033wml.2;
        Wed, 02 Jan 2019 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=tuOeiypRUnZ+vONbIlfvSMz1B6QmcFHUX6zM6XouHKw=;
        b=beIgIaBwoGs1oVP4kVoCdEoOgYkRQcaIk0bR3Q2xIS2FszfzqPCLXyLGYS74X7bD0w
         jrWOYxayiEXKXmp5xyJhszLjNZS8sVE8hysSeKZJnf2VuOEe4UADKZCdG9Om4r85EIWH
         Rrg7r7P/mV09o65vPH0lVcUDmlmZFkgXnOs4YDMm+0+EVvMxr/ai5Ifpgh/Bn3dKVuTz
         cFo/VcLImQR3jNo4aj/1PKadMZtSRpPsjOm5P55xpZ9755igmPjUPNuA3dLqc0R26L02
         aDAz1WOC8JqqWJA1DzDGpIhYaya2rCtkSoAgUiIORS6ow4Li1wtrPa+wlRTvkZ15Cp6X
         K42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tuOeiypRUnZ+vONbIlfvSMz1B6QmcFHUX6zM6XouHKw=;
        b=Rez8pS1ZQDMjM6cSmSC1n6HKZj982PhHTQI1Bmc92OAZZjAHotENeq/Uhpgc6m3g6t
         0G6Ipdh4tXQZLkpIQFVZdp9hbN8QzzwpFG7sgr1RubJee2r5FpEyelwwUxhVGN01LO0M
         lPsxB08fGvrx+nDS4f8AHuNrBW4+WUA0onYDiKQB284BhftPjquqzoQeIUR9XLsAtx5M
         JrW/HMITA1fo5Lw56hurSoT/B2g1ZU/YPJcEa6NFPmle4fotTm43PvYKCIRJlPHCU6m+
         0n/1eD9X+cUgpgGIUyIIBcFfuJzUg/BbZy8R/OAMrbU8yENGSxG0IDasIHkaBN9Vj2c1
         8i7w==
X-Gm-Message-State: AA+aEWYbjmC55ZLLWInnDPgaHTIw1ulF3NpVzta81CnwtQbA+b9gJRkh
        L7taFL3FwqOsQDYuvotT8yJA4HJSlLh477z6/YM=
X-Google-Smtp-Source: AFSGD/Wrp+2wG3UodzdTtFKXJ1N1+jmmQr9HUM6U4bEiUWyE7kCh4UEN6Qwi3BN1wf/RkHNC8Lh+0w7pDhELJg7mkKQ=
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr36004298wme.73.1546431270297;
 Wed, 02 Jan 2019 04:14:30 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 2 Jan 2019 13:14:18 +0100
Message-ID: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
support of asm-goto.

Currently, I am doing experiments with clang-7 and a snapshot of
clang-8 on Linux/x86.
These compilers have no asm-goto support.

What is your recommendation for Linux >= v4.20?
I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
compiling with clang - which has no effect.
This is confusing.

Thanks, this patch makes things clearer and protects users from
setting "wrong" in the sense of non-functional settings.

I have tested this against recent Linus tree where kbuild/kconfig Git
pulls were latest commits.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
v7 and v8 (snapshot) ]

Thanks.

Regards,
- Sedat -
