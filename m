Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A425C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF37D2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37D2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJQOfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:35:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39640 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeJQOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:35:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D9A3208C7; Wed, 17 Oct 2018 08:41:30 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B69E1208B5;
        Wed, 17 Oct 2018 08:41:19 +0200 (CEST)
Date:   Wed, 17 Oct 2018 08:41:17 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt-binding: spi: Document Macronix controller
 bindings
Message-ID: <20181017084117.26e25005@bbrezillon>
In-Reply-To: <1539742092-7049-3-git-send-email-masonccyang@mxic.com.tw>
References: <1539742092-7049-1-git-send-email-masonccyang@mxic.com.tw>
        <1539742092-7049-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob and the DT ML

Hi Mason,

Remember to Cc the DT mailing list and maintainers when you add/update a
binding.

On Wed, 17 Oct 2018 10:08:12 +0800
masonccyang@mxic.com.tw wrote:

> From: Mason Yang <masonccyang@mxic.com.tw>
> 
> Document the bindings used by the Macronix controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  Documentation/devicetree/bindings/spi/spi-mxic.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mxic.txt b/Documentation/devicetree/bindings/spi/spi-mxic.txt
> new file mode 100644
> index 0000000..529f2da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mxic.txt
> @@ -0,0 +1,34 @@
> +Macronix SPI controller Device Tree Bindings
> +--------------------------------------------
> +
> +Required properties:
> +- compatible: should be "mxicy,mx25f0a-spi"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "regs" and "dirmap"
> +- interrupts: interrupt line connected to the SPI controller
> +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"

The _clk suffix is unnecessary in my opinion. How about:

- clock-names: should contain "ps", "send" and "send_dly"

Other than that,

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
> +	  "send_dly_clk" clocks
> +
> +Example:
> +
> +	spi@43c30000 {
> +		compatible = "mxicy,mx25f0a-spi";
> +		reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
> +		reg-names = "regs", "dirmap";
> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <25000000>;
> +			spi-tx-bus-width = <4>;
> +			spi-rx-bus-width = <4>;
> +		};
> +	};

