Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1377CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h0FQgo3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC9721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJRQxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:53:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55672 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeJRQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:53:06 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB986113F;
        Thu, 18 Oct 2018 10:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539852786;
        bh=PQCJCjxtj/zNFsYFvD46UmeAzQTvNSUW3+CgT3XXA5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0FQgo3DNjpDww5rrKePmw5W0FfZZY8rD/FjszR6us+uXkJjEmzl15U9R1FmxOzMJ
         UHx3gjkJ7WNVAfMrYMT2W6k4aFcmqNB8hVrpCnhXyGMJrVgalU/VCiGLp6Kr0huIm4
         qoGfvcFzjpsHCk6cSSAJpha2yKWBfbPWJJlLMQUc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Date:   Thu, 18 Oct 2018 11:53:16 +0300
Message-ID: <1886367.eljNk7jKYl@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181018073327.64942-5-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io> <20181018073327.64942-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

Thank you for the patch.

On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> The ANX6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
> 
> Add a binding document for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/display/bridge/anx6345.txt       | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/anx6345.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> b/Documentation/devicetree/bindings/display/bridge/anx6345.txt new file
> mode 100644
> index 000000000000..0689d4eb5f65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> @@ -0,0 +1,39 @@
> +Analogix ANX6345 eDP Transmitter
> +--------------------------------
> +
> +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
> +portable devices.
> +
> +Required properties:
> +
> + - compatible		: "analogix,anx6345"
> + - reg			: I2C address of the device
> + - reset-gpios		: Which GPIO to use for reset
> +
> +Optional properties:
> +
> + - dvdd12-supply	: Regulator for 1.2V digital core power.
> + - dvdd25-supply	: Regulator for 2.5V digital core power.

Shouldn't these to supplies be mandatory ?

> + - panel-supply		: Regulator for the power of the panel.

Shouldn't the panel supply for specified in the DT node of the panel ?

> + - edid			: verbatim EDID data block describing attached
> +			  panel, only used when the panel has no EDID info.

This should also be specified in the panel DT node.

> + - Video port for RGB input, using the DT bindings defined in [1].

I think you should also add a port for the output.

> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +anx6345: anx6345@38 {
> +	compatible = "analogix,anx6345";
> +	reg = <0x38>;
> +	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +	panel-supply = <&reg_dc1sw>;
> +	dvdd25-supply = <&reg_dldo2>;
> +	dvdd12-supply = <&reg_fldo1>;
> +
> +	port {
> +		anx6345_in: endpoint {
> +			remote-endpoint = <&tcon0_out_anx6345>;
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart



