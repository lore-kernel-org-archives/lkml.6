Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938386AbeBUPgh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:36:37 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39929 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933105AbeBUPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:36:35 -0500
X-Google-Smtp-Source: AH8x225HvSQrulsoir+mbFrL61nEXoSddUNGsetXnb5Yswqs8Dm1zjr+Ie3pXBkeBCS7d8IcO8Xx4Q==
MIME-Version: 1.0
In-Reply-To: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 21 Feb 2018 23:36:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v66c-KntNqkb0=qyP2JCafUOcPuh1o_VqeGencMXEuEfMA@mail.gmail.com>
Message-ID: <CAGb2v66c-KntNqkb0=qyP2JCafUOcPuh1o_VqeGencMXEuEfMA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drm/panel: Add Huarui LHR050H41 panel driver
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 21, 2018 at 5:20 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic. Add a
> driver for it.

So I distinctly remember questioning the vendor name the first time.
I would just use Bananapi as the vendor name instead.

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                  |   9 +-
>  drivers/gpu/drm/panel/Makefile                 |   1 +-
>  drivers/gpu/drm/panel/panel-huarui-lhr050h41.c | 506 ++++++++++++++++++-
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 6ba4031f3919..965310fd129a 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -28,6 +28,15 @@ config DRM_PANEL_SIMPLE
>           that it can be automatically turned off when the panel goes into a
>           low power state.
>
> +config DRM_PANEL_HUARUI_LHR050H41
> +       tristate "Huarui LHR050H41 panel"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y if you want to enable support for the Huarui Lighting
> +         LHR05041 DSI panel. The panel has a 1280x720 resolution.
> +

And it seems this panel is driven by an ILI9881C from Ilitek. So
maybe you could make the panel driver more like the IL9322, as in
having common code for the driver IC, then a data structure tied
to actual panel compatible strings to handle any quirks.

The datasheet can be found simply by googling the part ID, or here:

   http://en.startek-lcd.com/res/starteklcden/pdres/201706/20170617115241070.pdf

This should help with the init command sequence.

I also found this:

http://www.ampdisplay.com/documents/pdf/AM-7201280ETZQW-00H.pdf

which might or might not be the same panel.

Now the IL9332 driver simply uses the device model (Dlink DIR-685)
as part of the compatible string.

Regards
ChenYu

>  config DRM_PANEL_ILITEK_IL9322
>         tristate "Ilitek ILI9322 320x240 QVGA panels"
>         depends on OF && SPI
