Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0879D2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5T1SF6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBGNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:34:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50616 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBGNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:34:40 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so14824934iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JkB7tkcxbbK3agVR2jQok9w+5Zbzlx0aaFAqKfM03I=;
        b=W5T1SF6jdEsuUqv6d17UoJrsZBcCP0NikNoDcomPUq+0g2v8gYD+WR2E2p5k7t/ZDJ
         CYi5No/1yi0U3rFYYPsHvpQgf70Jy46Vd+5Ch3aTMkYfAB1K5jiENFCxsnvJSpWacZQj
         Yr9IczkN2j3SBWR8yAsGR/t+M9amEZ8mSs0INwnEw6ePPRb+a96kMWQ1bkdqkFUQEygw
         Ii+yeVQnY/eBLRp09Tq2xyt/I+/Wua3XFXlP8TYCXqgyTlTMfNC4n+sFfelTU/nATPC8
         sZLPqW6jAmbT9Z2njrUU4BUUgdOwhfcR3E1wtJtxzs/mUAzAl6SfKRLfdR1mgcM6/qJq
         TfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JkB7tkcxbbK3agVR2jQok9w+5Zbzlx0aaFAqKfM03I=;
        b=Cgj6nfmXRpPlfmS0BEQPAIBACVojr8r2KQOmYwld36cfjc7eLDPnnUxmVSHmn6edU1
         4usQeWl406/WB7g4MM8FGhmGYOhJTZl8t0fO00Jp2gA47WXbXdRtqbcz5LwPoB+cuAPv
         8a9MABGRaBCz6xEUh+w/1UGjiWcpmLEdXA9mlszCkpdZZ6VKqgGU2aY+I6u8QRfoP0jc
         RLobGafAO0SqJCCNRrasLnujtr2rIfkcfZpGIf3lyTeBvTEO1dkc50031LJfvmEzigQ2
         FEXkxCyDoQFY8yEOHLMrBnVwmyI4kwLqLv0bZA+212465Vt1XY4Q8pMMsErDGD+6I/1d
         Oxdg==
X-Gm-Message-State: AHQUAuZKz/bA4l59jGnBD8JIUABqlGdIB8SjZVKXKxEsO/PcQocwW7M+
        k3KHnMpgk7Y79TY25L1eMkxb7H94R5bMJ7c8Ws8G+Q==
X-Google-Smtp-Source: AHgI3IaX/dgjnukzwfvJI2QNvYhoF+7bgFwR9XZoKMgId8AENtAa3WHxYus9EjG2ibv9rCbrMmLwmcxAlvu6fJEdnOA=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr1512278ioj.60.1549546479240;
 Thu, 07 Feb 2019 05:34:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch> <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
In-Reply-To: <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Feb 2019 14:34:27 +0100
Message-ID: <CAKv+Gu97N_DFpaYGq60i0Fvn3XS=1k7Zihh2Zz9Cs+uua1EuLw@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: use unified assembler in macros
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, 7 Feb 2019 at 10:46, Stefan Agner <stefan@agner.ch> wrote:
>
> Use unified assembler syntax (UAL) in macros. Divided syntax is
> considered depricated.

'deprecated'

> This will also allow to build the kernel
> using LLVM's integrated assembler.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  arch/arm/lib/copy_to_user.S   | 2 +-
>  arch/arm/lib/memcpy.S         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 0d4c189c7f4f..712ca399f559 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -91,7 +91,7 @@
>         .endm
>
>         .macro str1b ptr reg cond=al abort
> -       str\cond\()b \reg, [\ptr], #1
> +       strb\cond\() \reg, [\ptr], #1

You can drop the null token here, you only need that in the middle of
a word. Same below.


>         .endm
>
>         .macro enter reg1 reg2
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index 97a6ff4b7e3c..2e402b815e13 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -49,7 +49,7 @@
>         .endm
>
>         .macro ldr1b ptr reg cond=al abort
> -       ldr\cond\()b \reg, [\ptr], #1
> +       ldrb\cond\() \reg, [\ptr], #1
>         .endm
>
>  #ifdef CONFIG_CPU_USE_DOMAINS
> diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
> index 64111bd4440b..1c9e625148ca 100644
> --- a/arch/arm/lib/memcpy.S
> +++ b/arch/arm/lib/memcpy.S
> @@ -30,7 +30,7 @@
>         .endm
>
>         .macro ldr1b ptr reg cond=al abort
> -       ldr\cond\()b \reg, [\ptr], #1
> +       ldrb\cond\() \reg, [\ptr], #1
>         .endm
>
>         .macro str1w ptr reg abort
> @@ -42,7 +42,7 @@
>         .endm
>
>         .macro str1b ptr reg cond=al abort
> -       str\cond\()b \reg, [\ptr], #1
> +       strb\cond\() \reg, [\ptr], #1
>         .endm
>
>         .macro enter reg1 reg2
> --
> 2.20.1
>
