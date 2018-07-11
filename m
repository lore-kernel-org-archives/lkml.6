Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B57C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742520C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0742520C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbeGKTSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:18:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38329 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:18:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so51293289oie.5;
        Wed, 11 Jul 2018 12:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Av7JzrQgvGRWv7NkW+wupltSBoY4alLAH3kyeY4PdAc=;
        b=sBtPZMjtXBLVWrTgUR2xJdESJLbEX2cQ34jcipMV1hZGL62csCExakalpuo5o/X8N6
         5HO311OIy1AX3Z+3hqwbAQEYw5LOV4qhVfjMtTHdPK05qpbh1BnHyE9BRX0PyAfwVjeK
         igZoUwy83PeL3FOHLElSowtq60VJOViUj8mz7QKYkCJ3LRMaMrzcnAPUF0ouxF1LTQUT
         izQxAsmhgnhK7ektrW4R3iQ9alKzuT1NScWgRfLetxWUMzlnAB9z9DscHfCfX2WonsQ0
         VxKuGjXHTCr1SXH2Nu2C+oTDkw5T7TjB58s16GQTlfPECK0IPE1W6ztNQVjJ7NCtUV4i
         F4kw==
X-Gm-Message-State: AOUpUlHJN7iLcLBwB8f+kfMikI9IcnCrzHPI8qL7C+PTYHTbStJMaoKB
        rYH3ZLg4EPh2GFayKVaAukwZur4=
X-Google-Smtp-Source: AAOMgpc6XmnU6Q4Y44aBN87QSDxBhabTIfpUmpduR6mVWlcYiQhnIAZmSQIwpj/Ujiu4hYGRja5hCg==
X-Received: by 2002:aca:5249:: with SMTP id g70-v6mr605613oib.351.1531336374209;
        Wed, 11 Jul 2018 12:12:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m3-v6sm13724365oif.26.2018.07.11.12.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:12:53 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:12:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io
Subject: Re: [PATCH v2 1/4] dt-bindings: add binding for Allwinner R40 SATA
 AHCI controller
Message-ID: <20180711191252.GA2289@rob-hp-laptop>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <1531149658-27030-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531149658-27030-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:20:55PM +0000, Corentin Labbe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The Allwinner R40 SoC contains a SATA AHCI controller like the one in
> A10/A20 SoCs, however a reset control and two power supplies are added
> to it.
> 
> Add a binding document for it.
> 
> As a dedicated binding document is needed now for the A10/A20/R40 AHCI
> controller, drop the A10 compatible line from generic platform AHCI
> controller binding document.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
>  .../bindings/ata/allwinner,sun4i-a10-ahci.txt      | 40 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c760ecb81381..1bea4b5ef9fd 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -9,7 +9,6 @@ PHYs.
>  
>  Required properties:
>  - compatible        : compatible string, one of:
> -  - "allwinner,sun4i-a10-ahci"
>    - "brcm,iproc-ahci"
>    - "hisilicon,hisi-ahci"
>    - "cavium,octeon-7130-ahci"
> diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> new file mode 100644
> index 000000000000..0eea78c14ad3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
> @@ -0,0 +1,40 @@
> +Allwinner A10/A20/R40 SoC SATA AHCI Controller
> +
> +Required properties:
> +- compatible        : compatible string, one of:
> +  - "allwinner,sun4i-a10-ahci"
> +  - "allwinner,sun8i-r40-ahci"
> +- interrupts        : the SATA IRQ
> +- reg               : the register mapping
> +- clocks            : the clocks needed by SATA controller, usually contains
> +		      an AHB clock and a mod clock

usually?

Need to specify the order. The examples look reversed of what you have 
here.

> +
> +Optional properties:
> +- target-supply     : regulator for SATA target power
> +
> +Required properties for the following compatibles:
> +  - "allwinner,sun8i-r40-ahci"
> +- resets            : the reset control needed by SATA controller
> +- vdd1v2-supply     : regulator for SATA controller's 1.2V VDD
> +- vdd2v5-supply     : regulator for SATA controller's 2.5V VDD
> +
> +
> +Examples for A10:
> +	ahci: sata@1c18000 {
> +		compatible = "allwinner,sun4i-a10-ahci";
> +		reg = <0x01c18000 0x1000>;
> +		interrupts = <56>;
> +		clocks = <&pll6 0>, <&ahb_gates 25>;
> +		target-supply = <&reg_ahci_5v>;
> +	};
> +
> +Examples for R40:
> +	ahci: sata@1c18000 {
> +		compatible = "allwinner,sun8i-r40-ahci";
> +		reg = <0x01c18000 0x1000>;
> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&ccu CLK_SATA>, <&ccu CLK_BUS_SATA>;
> +		resets = <&ccu RST_BUS_SATA>;
> +		vdd1v2-supply = <&reg_eldo3>;
> +		vdd2v5-supply = <&reg_dldo4>;
> +	};
> -- 
> 2.16.4
> 
