Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E506208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pf5yexvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E506208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJPD12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:27:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34998 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPD12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:27:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so9809715plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEthvG9hbLFisXKYvA1uvR5sptAXPWPC66vp5D7EQCU=;
        b=Pf5yexvKuvxQud93ll/wVaG0SCYSKtW0NCVXCpvlB7yqr6fyTBvZHr/jC9kpyp08OM
         UTt2HX24ka4+O7c4Z7D+BMna5II85R7u8k28DzVPqhVbJDgx6qut3Q1jQ8Db1o9A4GRt
         b+dAqk5++He/LcP/Os/CgYU0JkR4+7iLah5828LDpEYgwLNr5aqsKEoRq38fh2VMiraB
         qryZ3jud+mtd+HYcUY7tCtUuGjDcAMJJ2VFloy6jEVn341ONvdydwFJ+5nXIfcFf4gxs
         X1E1rFQ5x+m8BbmqwZfLFRkvFc+porAQrtLlefbHC05QNAph+R1X70KgM/Zvhl46OBaX
         x/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEthvG9hbLFisXKYvA1uvR5sptAXPWPC66vp5D7EQCU=;
        b=rkgD7WGBWTgoFzK7BZMq2N0TEVjNpO+N90hV4oBfm+xVWrr/fQP7IJlFfQ1fzRzvzQ
         UiAON+5RvmA2bjcaZ9dNNjU3551Me5yepK+rKMsKlMv4W5s2J6gSj7fMEA02O1/mltLT
         M8PWi/1AYjubWIfNbt9gV675EKHnkcY1G3zr5sGcT64jnRuBbZLUkz0AfnIqxGtz8A1J
         gNmwbDluQrKspRHeCUMftGLfVzlnsY+uAFlrOdxYTR9RfywL7/aNtr6y219IyAXmuZOV
         dat3b3atkOvoe9pjdznGnV0abEgnEnAHzGGJhFrQ0sjo1+R3xv/ZYoMz9pN4t3B6wa0k
         bk6Q==
X-Gm-Message-State: ABuFfojKbG17COtX/mtsn9GiRJNnIB5f0rTJ1MiWPar9HGZFbWeABlcN
        C/khnTJJO4XB8aHItyVOrnZx8ih3VLK+rpo54szoIw==
X-Google-Smtp-Source: ACcGV62fOI+sbx0H68jB9ClaIGrW+z59whuNrxFbPFwMK8zkquO/JAO70+bWPOkv09KCRTT3tQGUtBsGw7BmV6hoDZ8=
X-Received: by 2002:a17:902:b40d:: with SMTP id x13-v6mr18616989plr.13.1539632448058;
 Mon, 15 Oct 2018 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181013010348.6740-1-natechancellor@gmail.com>
In-Reply-To: <20181013010348.6740-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Oct 2018 12:40:36 -0700
Message-ID: <CAKwvOdk8HGTtQ=qb2THgRb3B6O=iErXFyrbKVoGDkMeFAdD3kA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 6:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building the kernel with Clang, some disabled warnings appear
> because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
> this list so that the build is clean again.
>
> -Wpointer-sign was disabled for the whole kernel before the beginning
> of git history.
>
> -Waddress-of-packed-member was disabled for the whole kernel in
> commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
> warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
> Disable the address-of-packed-member compiler warning").
>
> -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
> LLVMLinux: Add Kbuild support for building kernel with Clang") and for
> x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
> warnings about GNU extensions").
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/112
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
> and suggested potentially rewriting the x86 portion of this Makefile to
> behave like the arm/arm64 one where problematic flags are filtered out.
> While that comes to fruition, it would be nice for this folder to behave
> like the rest of the kernel when it comes to this warnings so that the
> build is cleaner, thus this patch.
>
>  drivers/firmware/efi/libstub/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c51627660dbb..d9845099635e 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)                := -march=i386
>  cflags-$(CONFIG_X86_64)                := -mcmodel=small
>  cflags-$(CONFIG_X86)           += -m$(BITS) -D__KERNEL__ -O2 \
>                                    -fPIC -fno-strict-aliasing -mno-red-zone \
> -                                  -mno-mmx -mno-sse -fshort-wchar
> +                                  -mno-mmx -mno-sse -fshort-wchar \
> +                                  -Wno-pointer-sign \

Hi Nathan, thanks for this patch.

Should this be:
$(call cc-disable-warning, pointer-sign)
as well?

> +                                  $(call cc-disable-warning, address-of-packed-member) \
> +                                  $(call cc-disable-warning, gnu)
>
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
