Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC154C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D5A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NE6OlyNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D5A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJPGWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:22:55 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43087 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeJPGWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:22:55 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so8131503ybe.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ViqYesi82YeN4bvELvabGAC7pDtrrjvsmRUXryKv5I=;
        b=NE6OlyNdpEAgyHF+JVWV+GIukTAyidnU74cU9zUj02njSyrSnB0rFBG8XP+Rm7kTaV
         +f0jJT8a39+Jstdxtwa2pmQS2M3zTKXnWWJA10gY7jbf69n5LcY+mHvFiT+C3djKWcSc
         PFtMs60uFezETStBSL16wvcxNpqW5yqIu5MXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ViqYesi82YeN4bvELvabGAC7pDtrrjvsmRUXryKv5I=;
        b=d+jnQ3JshVSNfPklHS4TY5BpXaYjuFZGYS0ZcSj8PV1a2NzMoDfAurJXnlCavO4Nl6
         kmyb/txgTT1VGCB2PlSVg3BQzcUbu2LHMOtr5hmw1w6uA3ILY7xx3KwGpEH5nVKpq5Ai
         UQQaUasjOzSH+a8quXFR76Imn2H/noG0r1mfblbnGlcv2hrU/kltQIFQR/NR17OdZeky
         SrblZO+1KtlIZV/KOhFCF2w+EoeDYATD1rOSnLRKBA56DC0DVJ5GrlGZ8YSG9XfaFT4j
         zK05nuFJOXOboGEVt0XtPe5jmBG80q/GbRJogY70Y72rHVh6DyDiUbxxZh/lsUiLgfms
         lvSw==
X-Gm-Message-State: ABuFfojrJgsoQVjnzOkp7FU5n0IKczK2p5MZnMykF4G9glgOYD9uMK9p
        IZu3+/IZLs3nJFmevF172kJgnVQG+lE=
X-Google-Smtp-Source: ACcGV61NnDHOwt0OpCaIIqNBwmP2JpNAUrYYUW5er1Oil2IDGOgoAduVGcEubaJnXfbxQ0nZd50DvQ==
X-Received: by 2002:a25:7c03:: with SMTP id x3-v6mr9790541ybc.275.1539642939746;
        Mon, 15 Oct 2018 15:35:39 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id j81-v6sm2960092ywc.93.2018.10.15.15.35.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:35:36 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p74-v6so8131214ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:35:36 -0700 (PDT)
X-Received: by 2002:a25:640a:: with SMTP id y10-v6mr10401026ybb.421.1539642935679;
 Mon, 15 Oct 2018 15:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 15:35:34
 -0700 (PDT)
In-Reply-To: <20181005084754.20950-12-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com> <20181005084754.20950-12-kristina.martsenko@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 15:35:34 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
Message-ID: <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> From: Mark Rutland <mark.rutland@arm.com>
>
> Now that we've added code to support pointer authentication, add some
> documentation so that people can figure out if/how to use it.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [kristina: update cpu-feature-registers.txt]
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/arm64/booting.txt                |  8 +++
>  Documentation/arm64/cpu-feature-registers.txt  |  4 ++
>  Documentation/arm64/elf_hwcaps.txt             |  5 ++
>  Documentation/arm64/pointer-authentication.txt | 84 ++++++++++++++++++++++++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 Documentation/arm64/pointer-authentication.txt
>
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 8d0df62c3fe0..8df9f4658d6f 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -205,6 +205,14 @@ Before jumping into the kernel, the following conditions must be met:
>      ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
>    - The DT or ACPI tables must describe a GICv2 interrupt controller.
>
> +  For CPUs with pointer authentication functionality:
> +  - If EL3 is present:
> +    SCR_EL3.APK (bit 16) must be initialised to 0b1
> +    SCR_EL3.API (bit 17) must be initialised to 0b1
> +  - If the kernel is entered at EL1:
> +    HCR_EL2.APK (bit 40) must be initialised to 0b1
> +    HCR_EL2.API (bit 41) must be initialised to 0b1
> +
>  The requirements described above for CPU mode, caches, MMUs, architected
>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>  enter the kernel in the same exception level.
> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
> index 7964f03846b1..b165677ffab9 100644
> --- a/Documentation/arm64/cpu-feature-registers.txt
> +++ b/Documentation/arm64/cpu-feature-registers.txt
> @@ -190,6 +190,10 @@ infrastructure:
>       |--------------------------------------------------|
>       | JSCVT                        | [15-12] |    y    |
>       |--------------------------------------------------|
> +     | API                          | [11-8]  |    y    |
> +     |--------------------------------------------------|
> +     | APA                          | [7-4]   |    y    |
> +     |--------------------------------------------------|
>       | DPB                          | [3-0]   |    y    |
>       x--------------------------------------------------x
>
> diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
> index d6aff2c5e9e2..95509a7b0ffe 100644
> --- a/Documentation/arm64/elf_hwcaps.txt
> +++ b/Documentation/arm64/elf_hwcaps.txt
> @@ -178,3 +178,8 @@ HWCAP_ILRCPC
>  HWCAP_FLAGM
>
>      Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0001.
> +
> +HWCAP_APIA
> +
> +    EL0 AddPac and Auth functionality using APIAKey_EL1 is enabled, as
> +    described by Documentation/arm64/pointer-authentication.txt.
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> new file mode 100644
> index 000000000000..8a9cb5713770
> --- /dev/null
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -0,0 +1,84 @@
> +Pointer authentication in AArch64 Linux
> +=======================================
> +
> +Author: Mark Rutland <mark.rutland@arm.com>
> +Date: 2017-07-19
> +
> +This document briefly describes the provision of pointer authentication
> +functionality in AArch64 Linux.
> +
> +
> +Architecture overview
> +---------------------
> +
> +The ARMv8.3 Pointer Authentication extension adds primitives that can be
> +used to mitigate certain classes of attack where an attacker can corrupt
> +the contents of some memory (e.g. the stack).
> +
> +The extension uses a Pointer Authentication Code (PAC) to determine
> +whether pointers have been modified unexpectedly. A PAC is derived from
> +a pointer, another value (such as the stack pointer), and a secret key
> +held in system registers.
> +
> +The extension adds instructions to insert a valid PAC into a pointer,
> +and to verify/remove the PAC from a pointer. The PAC occupies a number
> +of high-order bits of the pointer, which varies dependent on the
> +configured virtual address size and whether pointer tagging is in use.
> +
> +A subset of these instructions have been allocated from the HINT
> +encoding space. In the absence of the extension (or when disabled),
> +these instructions behave as NOPs. Applications and libraries using
> +these instructions operate correctly regardless of the presence of the
> +extension.
> +
> +
> +Basic support
> +-------------
> +
> +When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
> +present, the kernel will assign a random APIAKey value to each process
> +at exec*() time. This key is shared by all threads within the process,
> +and the key is preserved across fork(). Presence of functionality using
> +APIAKey is advertised via HWCAP_APIA.

It might be useful to include documentation here on how many bits of
the address are being used for the PAC bits (I'm assuming it's 7?)

-Kees

-- 
Kees Cook
Pixel Security
