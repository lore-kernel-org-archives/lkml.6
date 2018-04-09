Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeDIVTy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:19:54 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43652 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDIVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:19:50 -0400
X-Google-Smtp-Source: AIpwx49p2Gk+byHNqFyUkK3503TShJOBDxQyCmJPL5ZAM3u8NM+0MQMhqaIokBwL7+vz3fifNir1JQ==
Date: Mon, 9 Apr 2018 16:19:49 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] display: panel: Add AUO g070vvn01 display support
 (800x480)
Message-ID: <20180409211949.cp4jqmtlaswi5jyz@rob-hp-laptop>
References: <20180403101525.22369-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403101525.22369-1-lukma@denx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:15:25PM +0200, Lukasz Majewski wrote:
> This commit adds support for AUO's 7.0" display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../bindings/display/panel/auo,g070vvn01           | 30 +++++++++++++++++++++

.txt

>  drivers/gpu/drm/panel/panel-simple.c               | 31 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g070vvn01
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/auo,g070vvn01 b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01
> new file mode 100644
> index 000000000000..bd4017362094
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/auo,g070vvn01
> @@ -0,0 +1,30 @@
> +AU Optronics Corporation 7.0" FHD (800 x 480) TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "auo,g070vvn01"
> +- backlight: phandle of the backlight device attached to the panel
> +- power-supply: single regulator to provide the supply voltage
> +
> +Required nodes:
> +- port: Parallel port mapping to connect this display
> +
> +This panel needs single power supply voltage. Its backlight is conntrolled
> +via PWM signal.
> +
> +Example:
> +--------
> +
> +Example device-tree definition when connected to iMX6Q based board
> +
> +	lcd_panel: lcd-panel {
> +		compatible = "auo,g070vvn01";
> +		backlight = <&backlight_lcd>;
> +		bus-format-override = "rgb565";

This is not documented though it appears in a few i.MX dts files.

> +		power-supply = <&reg_display>;
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint = <&lcd_display_out>;
> +			};
> +		};
> +	};
