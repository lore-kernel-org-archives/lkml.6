Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDIShR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:37:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46072 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeDIShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:37:16 -0400
X-Google-Smtp-Source: AIpwx4+cgCFJXFvB/K0DPblk4rGIFu4CqWXP422S5fhcxq23F4bihs2ZiSh1hVW6WDvbc/bYYZ+Azg==
Date: Mon, 9 Apr 2018 13:37:13 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the
 input bus format
Message-ID: <20180409183713.xk7qt4mukb24vr64@rob-hp-laptop>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-5-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326212447.7380-5-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:24:46PM +0200, Peter Rosin wrote:
> If the bridge changes the bus format, allow this to be described in
> the bridge, instead of providing false information about the bus
> format of the connector or panel.

I guess this is dead, but I'll comment here anyway because this issue 
has come up several times and I think something is needed.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
>  drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index 50220190c203..8d40a2069252 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -30,6 +30,12 @@ Required properties:
>    device-specific version corresponding to the device first
>    followed by the generic version.
>  
> +Optional properties:
> +
> +- interface-pix-fmt:
> +  List of valid input bus formats of the encoder. Recognized bus formats
> +  are listed in ../bus-format.txt

We already have bus interface properties defined in 
media/video-interfaces.txt. It's the same problem though the bus/pixel 
formats are somewhat different. "bus-width" is probably enough to handle 
your particular case, but I'd imagine that could easily not be the case. 
If so, we should extend the existing binding rather than diverge with 
something new.

Rob
