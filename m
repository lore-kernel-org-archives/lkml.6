Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE2C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6696421906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAZUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:55:10 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:45934 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:55:09 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EEF27803ED;
        Sat, 26 Jan 2019 21:55:02 +0100 (CET)
Date:   Sat, 26 Jan 2019 21:55:01 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/2] drm: panel: Add Samsung s6e63m0 panel documentation
Message-ID: <20190126205501.GA31182@ravnborg.org>
References: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=BNFw7j2wAAAA:8 a=pGLkceISAAAA:8
        a=Gk5Lg1JDi_lk8uzEZa4A:9 a=QEXdDO2ut3YA:10 a=1SBQqThTLjUA:10
        a=uesgAwXLq_X2AS_V3feQ:22 a=hxIpvf-Zr7OmKYnbfISL:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel.

Thanks for the patch, some comments follows.
Please judge what comments you chose to follow, see this as suggestions.

According to Documentation/devicetree/bindings/submitting-patches.rst:

	The preferred subject prefix for binding patches is:
	"dt-bindings: <binding dir>: ..."

It would be a good idea to follow this practice in next revision.

On Fri, Jan 25, 2019 at 05:46:44PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
> driver.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../display/panel/samsung,s6e63m0.txt         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> new file mode 100644
> index 000000000000..4979200e2dd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> @@ -0,0 +1,60 @@
> +Samsung s6e63m0 AMOLED LCD panel
> +
> +Required properties:
> +  - compatible: "samsung,s6e63m0"
> +  - reset-gpio: GPIO spec for reset pin
The preferred name is reset-gpios (added 's')

> +  - vdd3-supply: VDD regulator
> +  - vci-supply: VCI regulator
> +  - display-timings: timings for the connected panel as described by [1]
Today, as is my best understanding, it is encouraged to specify the timing
in the actual driver and not in DT,

The example include a spi-max-frequency which is not mentioned?

> +
> +Optional properties:
> +  - reset-delay: Delay in ms after adjusting reset-gpio, default 120ms
> +  - power-on-delay: Delay in ms after powering on, default 25ms
> +  - power-off-delay: Delay in ms before powering off, default 200ms
> +  - panel-width-mm: physical panel width in mm
> +  - panel-height-mm: physical panel height in mm
Likewise these delays are also properties that today are included in the driver.

I cannot explain the background for this, this is just how things are done.

> +
> +The device node can contain one 'port' child node with one child
> +'endpoint' node, according to the bindings defined in [2]. This
> +node should describe panel's video bus.
> +
> +[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
> +[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +		s6e63m0: display@0 {
> +			compatible = "samsung,s6e63m0";
> +			reg = <0>;
> +			reset-gpio = <&mp05 5 1>;
> +			vdd3-supply = <&ldo12_reg>;
> +			vci-supply = <&ldo11_reg>;
> +			spi-max-frequency = <1000000>;
> +
> +			power-on-delay = <0>;
> +			power-off-delay = <0>;
> +			reset-delay = <10>;
> +			panel-width-mm = <53>;
> +			panel-height-mm = <89>;
> +
> +			display-timings {
> +				timing-0 {
> +					/* 480x800@60Hz */
> +					clock-frequency = <25628040>;
> +					hactive = <480>;
> +					vactive = <800>;
> +					hfront-porch = <16>;
> +					hback-porch = <16>;
> +					hsync-len = <2>;
> +					vfront-porch = <28>;
> +					vback-porch = <1>;
> +					vsync-len = <2>;
> +				};
> +			};
> +
> +			port {
> +				lcd_ep: endpoint {
> +					remote-endpoint = <&fimd_ep>;
> +				};
> +			};
> +		};

	Sam
