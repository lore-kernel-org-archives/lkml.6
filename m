Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD909204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sejyckTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbeLNSeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:34:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42420 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeLNSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:34:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3096010plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1DScp5e1ny3IHyqzNjg2uiEo55U/m1Q/4EwEotSILw=;
        b=sejyckTuSEm8xg1m7GQJ7yfkmyEB1h8XJeUhvApNUbcd/uL58WKBmQ+RpF8+QW6B+D
         tSPCmizKpV/gurtIz4Q0H1O2s+a2OYvlnvAx49DuTv3RCzF5mrvjDexb0ejCUYvIWMmy
         DbXFV03lDKGOrGYgboc6UcfO9ExH7e3d76vLo6+lrrZdFp/qVgqQpABnZtnkPItirBRf
         jAvf5lnLyHi+tPu1YU+58gv8eaYPUpueZKun7fZ4cB10k0F/SxL5UhACITeYNgtxTKW4
         VGU2E3yl7e5snd5bhrOh3DVWI6vLkB4f3h3cewOkj8lt7sezKJD3eOCiTVrHKjy/r0N+
         1aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1DScp5e1ny3IHyqzNjg2uiEo55U/m1Q/4EwEotSILw=;
        b=noDP5uI/IMsPnf8/9TqoikfocuoZvtClMYCtZt1s3HsgrzKf5WnUoGMDRgyKIk9bLm
         rG1YMUye+x6JbXcEkLC7P4TvGAFK8MYKhA9taSk3ESZMoTH+KiHI0SS6AdtTJXDuQgBO
         Qn5eAf4KyhUExQ+xhXBSqSGqD6P9FFv1dmS//B3PBRD4i7r4QGpYGeeHqcKSmfFe3Jey
         uzjMRbd0/GO6fNa1/Uz+nQstnFjkl5nJz6ELcl8OsWZ3HBU5bTwSUUzc51DbQ/odEl/L
         jEtQ8tE4Ddn/ZokwNnC0YjyNLD6dpZDCrUekWFtNjPfxv7WrpfVadFqGbUOQ5Qv3Gymt
         uC3g==
X-Gm-Message-State: AA+aEWZU9yPUGls4trck+fOQjEENb6grKTtaBjH0JMiCJdk3Si+4qb/w
        eE/Wdux0UNMuFasMHSQH0jAmQJIc2DR3U3YKBZch5A==
X-Google-Smtp-Source: AFSGD/V5EHoRH4vEwejAL6IAheddbUxjitCzYYI8HBhkVAMdBdBi4/s6PNKKdLcw+cWqf8LNJN4qSit3DHp4WJLZ0YQ=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr3951502pln.229.1544812442549;
 Fri, 14 Dec 2018 10:34:02 -0800 (PST)
MIME-Version: 1.0
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com> <1544774739-13471-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544774739-13471-2-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Dec 2018 10:33:51 -0800
Message-ID: <CAKwvOdkSSb-EECgCmYnW40Mbd4ibSf22wqUBqaT_X7g7Sn_9UQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: add -Werror=strict-prototype flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:06 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> -Wstrict-prototype is added to KBUILD_CFLAGS first, then overridden

-Wstrict-prototypes (plural)

> by -Werror=strict-prototype later.

-Werror=strict-prototypes (plural)

LGTM: https://godbolt.org/z/DyEpmU

If you would mind updating the commit message (and subject), then:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Let's add -Werror=strict-prototypes unconditionally because it is
> supported by GCC 4.6, and also by Clang.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3bbc16a..bcb943e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -423,7 +423,7 @@ LINUXINCLUDE    := \
>                 $(USERINCLUDE)
>
>  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
> -KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> +KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
>                    -Werror-implicit-function-declaration \
>                    -Wno-format-security \
> @@ -828,9 +828,6 @@ KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
>  # disallow errors like 'EXPORT_GPL(foo);' with missing header
>  KBUILD_CFLAGS   += $(call cc-option,-Werror=implicit-int)
>
> -# require functions to have arguments in prototypes, not empty 'int foo()'
> -KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)
> -
>  # Prohibit date/time macros, which would make the build non-deterministic
>  KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
>
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
