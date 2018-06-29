Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269E227D09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269E227D09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeF2J5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:57:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54949 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbeF2J5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:57:52 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fYq9y-0003QP-MK; Fri, 29 Jun 2018 11:57:46 +0200
Message-ID: <1530266266.5549.5.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: reset: uniphier: add USB3 controller
 reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 29 Jun 2018 11:57:46 +0200
In-Reply-To: <1530259891-18822-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530259891-18822-1-git-send-email-hayashi.kunihiko@socionext.com>
         <1530259891-18822-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 17:11 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for reset control of USB3 controller implemented in
> UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index 93efed6..f21d81c 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -118,3 +118,48 @@ Example:
>  
>  		other nodes ...
>  	};
> +
> +
> +USB3 controller reset
> +---------------------
> +
> +Required properties:
> +- compatible: Should be
> +    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC
> +    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC
> +    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC
> +    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC
> +- #reset-cells: Should be 1.
> +- reg: Specifies offset and length of the register set for the device.
> +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> +	According to the clock-names, appropriate clocks are required.
> +- clock-names: Should contain
> +    "gio", "link" - for Pro4 SoC
> +    "link"        - for others
> +- resets: A list of phandles to the reset control for USB3 glue layer.
> +	According to the reset-names, appropriate resets are required.
> +- reset-names: Should contain
> +    "gio", "link" - for Pro4 SoC
> +    "link"        - for others
> +
> +Example:
> +
> +	usb-glue@65b00000 {
> +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> +			     "simple-mfd";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x65b00000 0x400>;
> +
> +		usb_rst: reset@0 {
> +			compatible = "socionext,uniphier-ld20-usb3-reset";
> +			reg = <0x0 0x4>;
> +			#reset-cells = <1>;
> +			clock-names = "link";
> +			clocks = <&sys_clk 14>;
> +			clock-names = "link";

s/clock/reset/

> +			resets = <&sys_rst 14>;
> +		};
> +
> +		other nodes ...
> +	};

regards
Philipp
