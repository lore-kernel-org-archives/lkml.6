Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeDSQXC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbeDSQXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:23:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09E92183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZqch4Y/aHQtQo1E7fYOzZ51rZLFVXXA624amUciKYozR58hC1S4DLDotaD4ggz5a70LPIJXrwLuIQSnDg7ePqs=
MIME-Version: 1.0
In-Reply-To: <20180417131052.16336-4-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se> <20180417131052.16336-4-peda@axentia.se>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 19 Apr 2018 11:22:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
Message-ID: <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm: of: introduce drm_of_media_bus_fmt
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 8:10 AM, Peter Rosin <peda@axentia.se> wrote:
> Add a central function to parse a node according to the video
> interface binding and get a media bus format.
>
> Start with only supporting a very limited set of a few basic media
> bus formats.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_of.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_of.h     |  7 +++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 4c191c050e7d..f9473edb60a7 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -212,6 +212,44 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
>  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
>
>  /*
> + * drm_of_media_bus_fmt - return the media bus format described in the node
> + * @node: device tree node containing the media bus format
> + *
> + * @node is presumably an of-graph endpoint node.
> + *
> + * Return the media bus format, or zero if none is described. Or one of the
> + * standard error codes.
> + */
> +int drm_of_media_bus_fmt(struct device_node *node)

Should use endpoint or ep here instead of node to be clear what node
this function operates on.

Rob
