Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0196C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45E20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJe9CTzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfAVXu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:50:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:50:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so179602pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg2FrSNYL5mUAqLEkhsXCahwMmPNuVyImKcCd137yqM=;
        b=UJe9CTzCSptgIyMFGLe6xVXTT98jzAXyHYiDEv+IG0hX8o+AYuxRyUqW7dTd7NkEB9
         S1e9N8ey2Hjqpdv2Rf4p7csCZAHvQvgMjRRH1ZxfSZIxn1b/OHrY9aflWrwJ/gvu1GGq
         4rLvXrDKdk5zLYl6zMAyp0mqpRP1DOMxPaI4jvLMqYMj6qB0oAfZsu5v2DIoPMHNslSi
         nnXM2azX41MXEsqbgrNEVXzV35Nyo96f2U991oNAAR69sRXQKyHZWhXqCT6A84J4MHJb
         jQY+o3pfsyqOqGY35pP8P5CuT8PzbR3JtrtITI/C6dolzwshAPPaLT8151c/ytz3lM9p
         tw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg2FrSNYL5mUAqLEkhsXCahwMmPNuVyImKcCd137yqM=;
        b=I5cEPIq9ErEKA5DLi77uyJ0nScjiHsrT9fmzMVgLoMkFb24LORKyXMTgFITBElHxY/
         HVjYVtX/fF4ywDxd2t+fFTOL4ap8u9jQ50t0uWWj1oNfeZAkPj27tLT08Cp35lXjprXQ
         1qWwkpwcEE+ie4cFqXnn9I8Isi+qG732E+EHeBI1rTcs+yAJX/nQ1yS/tQR4aqY5m3BF
         l5DzQZ54V5Ps5TPG5ByAO6L+SwgY28blpJogsZ14ksd8wJbesQpreDILW/axIbpRTobX
         wHXPeEIR9TVAVKMRyCBggIozInLf3XFfzUGOLV9VMa2fEg/ye5BcP1q6YxvIOktoRJL8
         niMg==
X-Gm-Message-State: AJcUukfjgMtMaDG90Dza4u46U8TIZYTm9hf8qT0+2DMU6K9fzvhMl4JK
        DSZukE/QZvEfFG9zo9WekmwzviEadXYc46YxSphylQ==
X-Google-Smtp-Source: ALg8bN4/m1RpY9sTYjZaUT2/A0wEqclaPgKw7MRtgdmiceR18YTotMTYx+hsIwA1HTQE4N/ttDOmiMiny5aClavit8Y=
X-Received: by 2002:a63:a064:: with SMTP id u36mr34153634pgn.145.1548201027235;
 Tue, 22 Jan 2019 15:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20190122233749.42220-1-trong@android.com> <20190122233749.42220-4-trong@android.com>
In-Reply-To: <20190122233749.42220-4-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Jan 2019 15:50:16 -0800
Message-ID: <CAKwvOdkACNJhHtPWG5VXR3o7S9RfHiBqkb4x=RnjF2y3ixnQGg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gcov: docs: add a note on GCC vs Clang differences
To:     Tri Vo <trong@android.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:39 PM Tri Vo <trong@android.com> wrote:
>
> Document some things of note to gcov users:
> 1. GCC gcov and Clang llvm-cov tools are not compatible.
> 2. The use of GCC vs Clang is transparent at build-time.
>
> Signed-off-by: Tri Vo <trong@android.com>

Thanks for adding this note (I made the mistake myself when testing
out these patches that the coverage format is slightly different).
And good find removing the documentation on the now obsolete config.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/dev-tools/gcov.rst | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
> index 69a7d90c320a..46aae52a41d0 100644
> --- a/Documentation/dev-tools/gcov.rst
> +++ b/Documentation/dev-tools/gcov.rst
> @@ -34,10 +34,6 @@ Configure the kernel with::
>          CONFIG_DEBUG_FS=y
>          CONFIG_GCOV_KERNEL=y
>
> -select the gcc's gcov format, default is autodetect based on gcc version::
> -
> -        CONFIG_GCOV_FORMAT_AUTODETECT=y
> -
>  and to get coverage data for the entire kernel::
>
>          CONFIG_GCOV_PROFILE_ALL=y
> @@ -169,6 +165,20 @@ b) gcov is run on the BUILD machine
>        [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
>
>
> +Note on compilers
> +-----------------
> +
> +GCC and LLVM gcov tools are not necessarily compatible. Use gcov_ to work with
> +GCC-generated .gcno and .gcda files, and use llvm-cov_ for Clang.
> +
> +.. _gcov: http://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> +.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html
> +
> +Build differences between GCC and Clang gcov are handled by Kconfig. It
> +automatically selects the appropriate gcov format depending on the detected
> +toolchain.
> +
> +
>  Troubleshooting
>  ---------------
>
> --
> 2.20.1.321.g9e740568ce-goog
>


-- 
Thanks,
~Nick Desaulniers
