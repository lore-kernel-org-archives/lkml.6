Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA3120661
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN7YGBZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBUVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:13:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34166 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:13:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so7525906wmd.1;
        Thu, 21 Feb 2019 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PramYZvIyZ1cJpZWKaIMwNL+tlzfLoaSYlmfFhVMK4Y=;
        b=HN7YGBZrx+jA7ANnB1ZG1wIfR+GMX8iiAvwmid9sADKVyc0hldLOHuL54ebcZ/BGF4
         n/I9wnd5mNoGDAyE7+LEBYh7UtyNzNdcmVWcA2EcsX5fMZJ3syzy4pL6NQCIYpvlEahj
         VCfei7NlTNujNvDK3faBPDLGCyXqMYA/BKGxRqyFg1n/o3OshZbZ0KS5x8WSp4UmRZSJ
         Nqdr7ihf0WhSGKNKwbzs/UAHk7l6h3OiQimKasALCIokDCxiI4uNZuO2KbqsGCOepNqh
         dodqLAxNqtLDtcySm8VvzWkbmBLtO3E9ZYs4utGiGvvWH+9ziHZ3pY3XM8rQF05HHfZJ
         OrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PramYZvIyZ1cJpZWKaIMwNL+tlzfLoaSYlmfFhVMK4Y=;
        b=fIsE5sUBQpM5HgKhRxuxTsVxawQ8Y9tXmbKaZUPlDFZ/Iq6/hUyqrFFUb4Qjy6EMuG
         6PVLjqFE8eWrgEO4LqqykTjBsyLD0tDqyiBnHMPfy8DJgvdcNm7zAKeyiY0NflyoQvI+
         +2bk8KYVzczezIqRp9AL9Jp3UI91ePcy/kmO+TZ5XmMtzt6q6FuqmrOI0/SOJvHPDjyF
         FJy15TIAQa8YDyy5FTkp9hqYbKyPfhF6i7DUokZdwzQiocuY7icUBiSHmdKTGp71lh4c
         3G2ZBGDwC3hfVryyRzsPNHWAsqN5+EpNCxpymKiYEdciyzWg9ZkUgjbwMcmO9A1fqh7W
         KECg==
X-Gm-Message-State: AHQUAua5Mkh77d0ugnqkleio4rUNPWbCpKRCcvqsXXPxCvMNq1l1TemK
        BbZ1J018tNAW4e8xdUrk/5Inrgvy+mX4NZc1XKvhABdk
X-Google-Smtp-Source: AHgI3IZU7e45DSBi2NwGSfG+CvPCVIANsIQb36uIQZRKLrmL6GBWxcJ6+CeSKYmKHkl750yZhRK72XcKIwK1G2vNEts=
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr286932wmg.124.1550783635899;
 Thu, 21 Feb 2019 13:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20190221203820.7044-1-paul@crapouillou.net>
In-Reply-To: <20190221203820.7044-1-paul@crapouillou.net>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 21 Feb 2019 22:13:55 +0100
Message-ID: <CAOiHx=k--4gOnERK4qJ6QfMyqqeAn4CQfYFeBZYRieWAa19cDw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ingenic: Add support for appended devicetree
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 21:39, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add support for booting the kernel from an externally-appended
> devicetree, if no devicetree was built-in.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/Kconfig        |  2 +-
>  arch/mips/jz4740/setup.c | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a84c24d894aa..8b7ea9062198 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -391,7 +391,7 @@ config MACH_INGENIC
>         select GPIOLIB
>         select COMMON_CLK
>         select GENERIC_IRQ_CHIP
> -       select BUILTIN_DTB
> +       select BUILTIN_DTB if MIPS_NO_APPENDED_DTB
>         select USE_OF
>         select LIBFDT
>
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index afb40f8bce96..5c00064937c4 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -31,6 +31,7 @@
>
>  #define JZ4740_EMC_SDRAM_CTRL 0x80
>
> +extern const char __appended_dtb;

Does this build/link with MIPS_NO_APPENDED_DTB? I would assume it
won't be able to resolve the symbol in that case.

You can also just use fw_passed_dtb from asm/bootinfo.h, which will be
populated automatically from fw_args (if UHI) or __appended_dtb (if
present and valid)[1], without having to care where it came from.

Regards
Jonas

[1] https://elixir.bootlin.com/linux/latest/source/arch/mips/kernel/head.S#L96
