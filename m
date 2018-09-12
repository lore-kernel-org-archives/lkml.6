Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtWkZigt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeILUFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:05:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54466 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeILUFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:05:12 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so3432372ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+jNtaMDgvCXvxa+vyBkrOOnXlX5oEL2FiZf6uC2YQWs=;
        b=jtWkZigtUooLqmJR8WGs6wrgOzL1HxpXTYmMc+SV9xtq1Hey6ftU6iyasTK72ZyO/x
         JbdBJXeUIHG3R8cMTj0PGr0/YdUtmtQ8eLhe9P+YFmd7ibmWZ/GWNx1ogX82Ob+YY2Ro
         JPcstKH6L8CAAuoZ2GaJhVp14Rd2K8RWpQbUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+jNtaMDgvCXvxa+vyBkrOOnXlX5oEL2FiZf6uC2YQWs=;
        b=RAGU+CeCdukuGCR/NEkBJqNM0pMEatPtdnmeINk/hIPjwrk1RVtkyoXIGcF0LTdYXr
         XUXJdTJGTWWmALvPuI2BabiDicochW1pKZM0p1rhrHGFR3UR3mIVEAbT3QAXJBQCalel
         zwM1KtdRn4l9VKJRs2Gy9B/Votxtj1IpIYokWUEqd2i/dKmxY+9/E4tNOaBJJnKy2r8U
         vBIjgpQkPLaw1HQpF8TVgl6PaGGB27D/wyGrcMnc9r93LmI2l9CbRRXNk45xqEER5OTe
         YteAp6cS8Ibcp6ooirQFsJModwtV4fGM/BQfviNRC9COiwjpN9ViTiAtm2DQ8GYRPgnu
         CQHQ==
X-Gm-Message-State: APzg51DmDNObPSJzxIXldk64wRH/ReS59solJtKyFtebhyACVrP8ePf8
        L1pHUs8dGOhKHcQiSHj+1qb5rGd+XUY1kALx06o5Fw==
X-Google-Smtp-Source: ANB0Vda/ucNFipjshZw0LGPoGhE8mg3R2JZ0nFy7/QVXPXAEaSEsNKq3OlgKIINxNxqhng9FHMmI/d7j+Svn+OHYKvU=
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr2181403jad.2.1536764417145;
 Wed, 12 Sep 2018 08:00:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 08:00:16
 -0700 (PDT)
In-Reply-To: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
References: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 17:00:16 +0200
Message-ID: <CAKv+Gu_dfQUXDdvk99fe6-qW3wj8e=8wR2aqCtJj1GfkXirzRg@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: earlyprintk - Add 64bit efi fb address support
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 September 2018 at 18:23, Aaron Ma <aaron.ma@canonical.com> wrote:
> EFI GOP uses 64-bit frame buffer address in some BIOS.
> Add 64bit address support in efi earlyprintk.
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  arch/x86/platform/efi/early_printk.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
> index 5fdacb322ceb..c0ae25f59acd 100644
> --- a/arch/x86/platform/efi/early_printk.c
> +++ b/arch/x86/platform/efi/early_printk.c
> @@ -32,6 +32,8 @@ static __init int early_efi_map_fb(void)
>                 return 0;
>
>         base = boot_params.screen_info.lfb_base;
> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>         size = boot_params.screen_info.lfb_size;
>         efi_fb = ioremap(base, size);
>
> @@ -49,6 +51,8 @@ static __ref void *early_efi_map(unsigned long start, unsigned long len)
>         unsigned long base;
>
>         base = boot_params.screen_info.lfb_base;
> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>
>         if (efi_fb)
>                 return (efi_fb + start);

Please fix this in a way that works on 32-bit x86/PAE as well (i.e.,
use a suitable type for base)
