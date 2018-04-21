Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeDUQzV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753092AbeDUQzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 12:55:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3218F217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx49xL5ufWRevjMzJjkOjV+ikQhr0Aofeb9whvLio80LGcyDsi2LglOJq1I3aH/gv48CI6woYY+IFfurx6gCpzBE=
MIME-Version: 1.0
In-Reply-To: <1524241936-10295-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1524241936-10295-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 21 Apr 2018 18:55:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcv2A8po8-8ZVic8KX2xURPZsRBkS6My3qMhefRQk-fRQ@mail.gmail.com>
Message-ID: <CAJKOXPcv2A8po8-8ZVic8KX2xURPZsRBkS6My3qMhefRQk-fRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/exynos: fimd: Add support for S5PV210 FIMD variant
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        Seung Woo Kim <sw0312.kim@samsung.com>, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 6:32 PM, Paweł Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
>
> This patch adds support for FIMD variant found on S5PV210 SoC.
> Except CLKSEL bit availability, it is identical to Exynos4210.
>
> Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

You need to add your Signed-off-by here as well. It is necessary every
time you touch a patch (and sending it is also a "touch" action).

Best regards,
Krzysztof

> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index d42ae2bc3e56..01b1570d0c3a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -121,6 +121,12 @@ static struct fimd_driver_data s3c64xx_fimd_driver_data = {
>         .has_limited_fmt = 1,
>  };
>
> +static struct fimd_driver_data s5pv210_fimd_driver_data = {
> +       .timing_base = 0x0,
> +       .has_shadowcon = 1,
> +       .has_clksel = 1,
> +};
> +
>  static struct fimd_driver_data exynos3_fimd_driver_data = {
>         .timing_base = 0x20000,
>         .lcdblk_offset = 0x210,
> @@ -193,6 +199,8 @@ struct fimd_context {
>  static const struct of_device_id fimd_driver_dt_match[] = {
>         { .compatible = "samsung,s3c6400-fimd",
>           .data = &s3c64xx_fimd_driver_data },
> +       { .compatible = "samsung,s5pv210-fimd",
> +         .data = &s5pv210_fimd_driver_data },
>         { .compatible = "samsung,exynos3250-fimd",
>           .data = &exynos3_fimd_driver_data },
>         { .compatible = "samsung,exynos4210-fimd",
> --
> 2.7.4
>
