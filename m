Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeDMRqx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:46:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36513 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeDMRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:46:51 -0400
X-Google-Smtp-Source: AIpwx4+PPPngFdtewfxVwQlrndjziA4WpQqqNMU1GsAS7h00SGK/nfVR6N2C6c5CZpPbgQGkpEhMDA==
Date: Fri, 13 Apr 2018 12:46:48 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: display: atmel: add optional
 output-mode property
Message-ID: <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409105918.20792-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105918.20792-3-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:59:15PM +0200, Peter Rosin wrote:
> Useful for beating cases where an output mode selection heuristic
> fails.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..dc478455b883 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -10,6 +10,10 @@ Required properties:
>   - #address-cells: should be set to 1.
>   - #size-cells: should be set to 0.
>  
> +Optional properties:
> + - output-mode: override any output mode selection hueristic and force a
> +   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
> +

This needs to be generic, not just added to some random display 
controller binding.

It also belongs in the port or endpoint node as is done for camera 
interfaces.

Rob
