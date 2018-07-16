Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2C20839
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E2C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGPVT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:19:59 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42137 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:19:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so77412936oib.9;
        Mon, 16 Jul 2018 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyVKScfPZkzfWNuJiyzOHkMGcMBQBCaAZpQoYhQQRAs=;
        b=C5+dCuOWqUj+6xsjCdC7DeiWYx7Vxg9QwRDwF/CQJEpLXGYh2jDP4c0oK1gx1G0Dwz
         MdTV1BjhZyUK8tl4Uz39JJdiS5hOlgp0Eex8Nsn3sH1rs7xE87YgVHkANfnyCyE+JrY3
         exwxvlrRfVZ1vyIbxyOQkf8xwRnMEdFzDCu0bGAH9rOKDcr7cT0zwlVJC7zaDAOPR6Yc
         KZ0hZCytDwOxvgYrOo+N4hhSoNpyhi4y8+XcOUUJhskJUauUf2e7sWclmZ9yp4OaVHjz
         SoH3/soqjaTdoRp5SlTA4B1XDuXJJsON4T8EcygV7GtoxQpFbM0QJnCYKYJtSnrEUvkf
         IGXA==
X-Gm-Message-State: AOUpUlFl/NFhkkeq3D/bYqUiV6vqopcz4gRsuIHm3wFeWNkYsJ2DVp6F
        PBYmaFdQFXknb5usnvvO7g==
X-Google-Smtp-Source: AAOMgpfMqWQgpLCWOilPfG3lO5i8qM50KNS98oxIajbTAI5UKI3Z+eSyXk2JOoJpD1s6WkitFsVfoQ==
X-Received: by 2002:aca:2ec9:: with SMTP id u192-v6mr918345oiu.17.1531774251576;
        Mon, 16 Jul 2018 13:50:51 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i204-v6sm25355266oia.41.2018.07.16.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:50:50 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:50:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3
 PHY driver
Message-ID: <20180716205049.GA3663@rob-hp-laptop>
References: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PHY interface built into USB3 controller
> implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> new file mode 100644
> index 0000000..3df4a486
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> @@ -0,0 +1,118 @@
> +Socionext UniPhier USB3 PHY
> +
> +This describes the devicetree bindings for PHY interfaces built into
> +USB3 controller implemented on Socionext UniPhier SoCs.
> +The controller includes High-Speed PHY and Super-Speed PHY.
> +
> +USB3 High-Speed (HS) PHY
> +------------------------
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
> +    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
> +    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
> +    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
> +- reg: Specifies offset and length of the register set for the device.
> +- #phy-cells: Should be 0.
> +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> +	According to the clock-names, appropriate clocks are required.
> +- clock-names: Should contain the following:
> +    "gio", "link" - for Pro4 SoC
> +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> +    "link", "phy" - for others

Can't you make 'link' always first.

> +- resets: A list of phandles to the reset control for USB3 glue layer.
> +	According to the reset-names, appropriate resets are required.
> +- reset-names: Should contain the following:
> +    "gio", "link" - for Pro4 SoC
> +    "link", "phy" - for others
> +
> +Optional properties:
> +- phy-supply: A phandle to the regulator for USB VBUS.

The phy actually needs Vbus or you just want to control Vbus from the 
phy driver?

> +- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
> +	Available only for HS-PHY implemented on LD20 and PXs3, and
> +	if unspecified, default value is used.
> +- nvmem-cell-names: Should be the following names, which correspond to
> +	each nvmem-cells.
> +	All of the 3 parameters associated with the following names are
> +	required for each port, if any one is omitted, the trimming data
> +	of the port will not be set at all.
> +    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
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
> +		usb_hsphy0: hs-phy@200 {
> +			compatible = "socionext,uniphier-ld20-usb3-hsphy";
> +			reg = <0x200 0x10>;
> +			#phy-cells = <0>;
> +			clock-names = "link", "phy";
> +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> +			reset-names = "link", "phy";
> +			resets = <&sys_rst 14>, <&sys_rst 16>;
> +			phy-supply = <&usb_vbus0>;
> +			nvmem-cell-names = "rterm", "sel_t", "hs_i";
> +			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
> +				      <&usb_hs_i0>;
> +		};
> +	};
> +
> +
> +USB3 Super-Speed (SS) PHY
> +-------------------------

Nothing seems to be shared here. Make this 2 docs.

> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
> +    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
> +    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
> +    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
> +- reg: Specifies offset and length of the register set for the device.
> +- #phy-cells: Should be 0.
> +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> +	According to the clock-names, appropriate clocks are required.
> +- clock-names:
> +    "gio", "link" - for Pro4 SoC
> +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> +    "link", "phy" - for others

Can't you make 'link' always first.

> +- resets: A list of phandles to the reset control for USB3 glue layer.
> +	According to the reset-names, appropriate resets are required.
> +- reset-names:
> +    "gio", "link" - for Pro4 SoC
> +    "link", "phy" - for others

And here.

> +
> +Optional properties:
> +- phy-supply: A phandle to the regulator for USB VBUS.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
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
> +		usb_ssphy0: ss-phy@300 {
> +			compatible = "socionext,uniphier-ld20-usb3-ssphy";
> +			reg = <0x300 0x10>;
> +			#phy-cells = <0>;
> +			clock-names = "link", "phy";
> +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> +			reset-names = "link", "phy";
> +			resets = <&sys_rst 14>, <&sys_rst 16>;
> +			phy-supply = <&usb_vbus0>;
> +		};
> +
> +		other nodes ...
> +	};
> -- 
> 2.7.4
> 
