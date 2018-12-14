Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87E8206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muoHOG/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeLNS0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:26:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeLNS0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:26:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3050120pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ysbk4lJpjpjDvpHiS69bpbmB1bYhnbHIBXRDTU7EEM=;
        b=muoHOG/fck/IFSLh2uu/32ZTMREdMjIY6O1mezDzlIeIa2H7OGvu7Q6LsroLMTTzi1
         XQasXyvpCFyDg6HuBcb/Gy8fuNwDMnpmVyLY/q1bRkTcNkA3IhfEErW0GGSzM2WLqL8q
         OgvbTIplrF5cM6mK8+uLk7dhC84XE3bbDB5856Oc9DO8xcij1cv0PrkydwCBvsLLjEc5
         7QmRwvFQTdXk5QvDOgfvNbt1S1mNfYjpZbTskdJ1hmXl7YvvWnW59nZzlW4xx0IRk10e
         UCtoS5pWI2cyTJ3AfkLbTzKk3gyFd64FH/vLtsP9QNbPbRDjVMP4svv8L+28UFGKRI0n
         RSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ysbk4lJpjpjDvpHiS69bpbmB1bYhnbHIBXRDTU7EEM=;
        b=ToSLKh88ZW59ScSGawz4lGfLgsV51m6/dEo6k4O55tXbCdHdRfieuNnfEY6EflE/kS
         wsv+u7xNs2hFGsGGHJgmBhxQkT3S6k/v0LPUSYXZPWOW1899/2Jo9l7YFRQx01vQchxC
         04EVEr0baYu76qsKHom9776xRPTqLvNWaNdSH0pl4+FQ3jtYjwPwC7LG+UiwDob9hcEt
         1C7wZWZMAmU6B/2ltRxbTh1NGcKcId0mezCsTRYK2Ny/zcHNnGq5AktdWIosNm+P+P7Q
         HIZM9HG5nIOdATTJMtltpgcEExDHOBViYxZHwyYyR2qs3PkXbgPFQBLBHHbNxd4I8zkU
         6CgA==
X-Gm-Message-State: AA+aEWZ94TLcAMfnS67aO/EMkdJaTSH5T5Ar6GnJVIevOdlGJ36InTgq
        7c1aRJKu6K73GbhuO8/dIygh76g6HPUf2Q8mczbRRphXTYo=
X-Google-Smtp-Source: AFSGD/WyWwdvBBXewuPNeXW6Cc0ZyXTU+kd+dMSvo3MYsT1r/6IObeFy3tohR+3BDoXT8K0dLUG7ugwa+Dn8PapDx1s=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr3624631pga.202.1544811982266;
 Fri, 14 Dec 2018 10:26:22 -0800 (PST)
MIME-Version: 1.0
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com> <1544774739-13471-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544774739-13471-3-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Dec 2018 10:26:10 -0800
Message-ID: <CAKwvOd=YVMgaURxYb2J0aWN-5i_i6uRU-ot7JgO5GBPXvqakrw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: add -Werror=implicit-int flag unconditionally
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
> This flag is documented in the GCC 4.6 manual, and recognized by
> Clang as well. Let's rip off the cc-option switch.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

LGTM: https://godbolt.org/z/1Z3aG2
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bcb943e..b63699b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -425,7 +425,7 @@ LINUXINCLUDE    := \
>  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
>  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
> -                  -Werror-implicit-function-declaration \
> +                  -Werror-implicit-function-declaration -Werror=implicit-int \
>                    -Wno-format-security \
>                    -std=gnu89
>  KBUILD_CPPFLAGS := -D__KERNEL__
> @@ -825,9 +825,6 @@ KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
>  # conserve stack if available
>  KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
>
> -# disallow errors like 'EXPORT_GPL(foo);' with missing header
> -KBUILD_CFLAGS   += $(call cc-option,-Werror=implicit-int)
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
