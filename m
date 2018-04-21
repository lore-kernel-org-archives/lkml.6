Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDURaR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:30:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46355 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDURaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:30:15 -0400
X-Google-Smtp-Source: AIpwx492GnNkf0XXb/BELVkjlOE3Z/FSVqSN2CLrNuNE2O9/gslDPKc9jDOs8QQVrzGmJsfC9ZjGkg==
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        Seung Woo Kim <sw0312.kim@samsung.com>, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/2] drm/exynos: fimd: Add support for S5PV210 FIMD variant
Date: Sat, 21 Apr 2018 19:30:12 +0200
Message-ID: <4230005.Q0ymWkG0nD@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-38-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAJKOXPcv2A8po8-8ZVic8KX2xURPZsRBkS6My3qMhefRQk-fRQ@mail.gmail.com>
References: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1524241936-10295-2-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPcv2A8po8-8ZVic8KX2xURPZsRBkS6My3qMhefRQk-fRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3LHUMt4010367

On Saturday, April 21, 2018 6:55:17 PM CEST Krzysztof Kozlowski wrote:
> On Fri, Apr 20, 2018 at 6:32 PM, Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> > From: Tomasz Figa <tomasz.figa@gmail.com>
> >
> > This patch adds support for FIMD variant found on S5PV210 SoC.
> > Except CLKSEL bit availability, it is identical to Exynos4210.
> >
> > Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> You need to add your Signed-off-by here as well. It is necessary every
> time you touch a patch (and sending it is also a "touch" action).
Hi

Thanks for feedback, i've send a v2 version of this patchset with this issue fixed.

> 
> Best regards,
> Krzysztof
> 
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > index d42ae2bc3e56..01b1570d0c3a 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > @@ -121,6 +121,12 @@ static struct fimd_driver_data s3c64xx_fimd_driver_data = {
> >         .has_limited_fmt = 1,
> >  };
> >
> > +static struct fimd_driver_data s5pv210_fimd_driver_data = {
> > +       .timing_base = 0x0,
> > +       .has_shadowcon = 1,
> > +       .has_clksel = 1,
> > +};
> > +
> >  static struct fimd_driver_data exynos3_fimd_driver_data = {
> >         .timing_base = 0x20000,
> >         .lcdblk_offset = 0x210,
> > @@ -193,6 +199,8 @@ struct fimd_context {
> >  static const struct of_device_id fimd_driver_dt_match[] = {
> >         { .compatible = "samsung,s3c6400-fimd",
> >           .data = &s3c64xx_fimd_driver_data },
> > +       { .compatible = "samsung,s5pv210-fimd",
> > +         .data = &s5pv210_fimd_driver_data },
> >         { .compatible = "samsung,exynos3250-fimd",
> >           .data = &exynos3_fimd_driver_data },
> >         { .compatible = "samsung,exynos4210-fimd",
> > --
> > 2.7.4
> >
> 
