Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7169C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A5C214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SeIwdbHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A5C214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIZQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:31:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47568 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:31:38 -0400
Received: from avalon.localnet (nat-242.udc.es [193.144.61.242])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52883506;
        Wed, 26 Sep 2018 12:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537957161;
        bh=k5E+cV8204uiIEFCYOzjnGcTC485ZICWfY/2D0hoj2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeIwdbHzks0njkhD/e+Nri654s/p48BjFx8dgFWveGbhUJzMFMDyT37CaXf+eX7ZN
         N09X3+TH246cY3aScrlT93FvCiLT4gjRjt8+LNFH24r+2cOvWRLAo+tpGlGmod/3Gw
         WFqbIOe2aXGwYbHXbIH4VYZhR4baIhTFq/BQSZds=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yong Deng <yong.deng@magewell.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "\"David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v11 1/2] dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
Date:   Wed, 26 Sep 2018 13:19:34 +0300
Message-ID: <7197338.mhOH8fQaEM@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
References: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

Thank you for the patch.

On Wednesday, 26 September 2018 11:40:04 EEST Yong Deng wrote:
> Add binding documentation for Allwinner V3s CSI.
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt
> b/Documentation/devicetree/bindings/media/sun6i-csi.txt new file mode
> 100644
> index 000000000000..2ff47a9507a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,59 @@
> +Allwinner V3s Camera Sensor Interface
> +-------------------------------------
> +
> +Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> +interface and CSI1 is used for parallel interface.
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * bus: the CSI interface clock
> +    * mod: the CSI module clock
> +    * ram: the CSI DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset line driving the CSI
> +
> +Each CSI node should contain one 'port' child node with one child
> 'endpoint' +node, according to the bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt. As mentioned
> +above, the endpoint's bus type should be MIPI CSI-2 for CSI0 and parallel
> or
> +Bt656 for CSI1.

Nitpicking, BT.656 is parallel as well. We should use BT.601 instead of 
parallel, to differentiate between embedded sync and external sync. This is a 
problem in Documentation/devicetree/bindings/media/video-interfaces.txt in the 
first place, so I won't ask you to modify these bindings. I'll try to submit a 
patch for video-interfaces.txt.

> +Endpoint node properties for CSI1
> +---------------------------------

Should you list the CSI0 properties as well ? As the driver in patch 2/2 
doesn't support the CSI-2 interface I assume you have left out CSI0 for now, 
but it should still be listed in the bindings. I'm fine with fixing this as a 
follow-up patch to avoid missing the v4.20 merge window, but if you end up 
resubmitting the series, could you please address the problem ?

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
> +			   node
> +- bus-width:		: (required) must be 8, 10, 12 or 16
> +- pclk-sample		: (optional) (default: sample on falling edge)
> +- hsync-active		: (only required for parallel)
> +- vsync-active		: (only required for parallel)
>
> +Example:
> +
> +csi1: csi@1cb4000 {
> +	compatible = "allwinner,sun8i-v3s-csi";
> +	reg = <0x01cb4000 0x1000>;
> +	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_CSI>,
> +		 <&ccu CLK_CSI1_SCLK>,
> +		 <&ccu CLK_DRAM_CSI>;
> +	clock-names = "bus", "mod", "ram";
> +	resets = <&ccu RST_BUS_CSI>;
> +
> +	port {
> +		/* Parallel bus endpoint */
> +		csi1_ep: endpoint {
> +			remote-endpoint = <&adv7611_ep>;
> +			bus-width = <16>;
> +
> +			/* If hsync-active/vsync-active are missing,
> +			   embedded BT.656 sync is used */
> +			hsync-active = <0>; /* Active low */
> +			vsync-active = <0>; /* Active low */
> +			pclk-sample = <1>;  /* Rising */
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart



