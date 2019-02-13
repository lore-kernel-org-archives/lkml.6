Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542B222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094218;
	bh=4MolkE+gEZntM8K2sR4FNq6I6eB478FcjQqeBoN2qdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tNC0qLwbytSL6+C90bbH4/DZ5X7cAqEN3mmC8J8mdi3X8dlEBIJe7xgKBl6m5OGd5
	 plkyX7pr7VfvpD66Uxit1fn0y1CjRjkZQ/Ve1q3a3bMFAYrwuScsf0hUij+XN15HoN
	 F05QiXcttD0zJhhkaKCFThDcOnYaDeP0Ox+v9QQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbfBMVng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:43:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33985 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391795AbfBMVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:43:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so7034684oty.1;
        Wed, 13 Feb 2019 13:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HuZsMpTtMDs5/dtC99dFz32xoIqYbKwcEhqrvVdX3yw=;
        b=bHpeNj3iG62pPeP31awF33hlK2DlNahsv6p6paA6nMeLSqezXVwO8HKVkAP4H5Njdh
         dHukxA6d1bmD8XOyoSl5AN4GB4ORRUJwcMk6n8JmBUGHx9Zhd0nlURs4C+3+Yvq7BLsL
         zJE0qHCRK02T/tGKZGLibKxOhBte2bTuMph4pN0b/537oa6UxdpdR0YEz6lw7hawUH0G
         f5POfR+MtMWEW4hFyHvJ3Ko5W90joFe1G2LEe6bDWQCGSwVeFpQ4cY48BJ3qrnRSqOIy
         mH4FxLj1Q1uuuoPLXDyjea5sJU6/7GH1qklEDFUg/bXRSK8cR6TjHdHihMcLuYzwBhWy
         tYyw==
X-Gm-Message-State: AHQUAuaKqLNlM5FrKw8UbtBDVW96zVd2X0rQFv/EYGyPpMkuIi3SXBFw
        5RDWMulCxypo8UNSJ6mM7A==
X-Google-Smtp-Source: AHgI3IY1gnyiSbbR3AaPe11jtAKhirkxlwLrVEZ3EuRGOZo4XfiZyn97nEy28KRSY0D0iIkmKozeKg==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr192060oif.159.1550094214852;
        Wed, 13 Feb 2019 13:43:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm208758oih.18.2019.02.13.13.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:43:34 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:43:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     bjorn.andersson@linaro.org, swboyd@chromium.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
Message-ID: <20190213214333.GA8220@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 12:17:33PM +0100, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 SuperSpeed phy
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-usb-ssphy.txt      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> new file mode 100644
> index 000000000000..354e6f9cef62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> @@ -0,0 +1,79 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Qualcomm 1.0.0 SS phy controller supports SuperSpeed USB connectivity on
> +some Qualcomm platforms.
> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,snps-usb-ssphy".

Still not specific. Put the SoC name(s) in it.

> +
> +- reg:
> +    Value type: <prop-encoded-array>
> +    Definition: USB PHY base address and length of the register map.
> +
> +- #phy-cells:
> +    Value type: <u32>
> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
> +
> +- clocks:
> +    Value type: <prop-encoded-array>
> +    Definition: See clock-bindings.txt section "consumers". List of
> +		 three clock specifiers for reference, phy core and
> +		 pipe clocks.
> +
> +- clock-names:
> +    Value type: <string>
> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> +		 property. Must contain "ref", "phy" and "pipe".
> +
> +- vdd-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator VDD supply node.
> +
> +- vdda1p8-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator 1.8V supply node.
> +
> +Optional properties:
> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". Specifiers for COM and
> +		 PHY resets.
> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy" if the property is
> +		 specified.
> +
> +Required child nodes:
> +
> +- usb connector node as defined in bindings/connector/usb-connector.txt
> +  containing the property vbus-supply.
> +
> +Example:
> +
> +usb3_phy: usb3-phy@78000 {
> +	compatible = "qcom,snps-usb-ssphy";
> +	reg = <0x78000 0x400>;
> +	#phy-cells = <0>;
> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +	clock-names = "ref", "phy", "pipe";
> +	resets = <&gcc GCC_USB3_PHY_BCR>,
> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
> +	reset-names = "com", "phy";
> +	vdd-supply = <&vreg_l3_1p05>;
> +	vdda1p8-supply = <&vreg_l5_1p8>;
> +	usb3_c_connector: usb3-c-connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		type = "micro";

'micro' is certainly not right for USB-C. Probably should be omitted?

> +		vbus-supply = <&usb3_vbus_reg>;
> +	};
> +};
> -- 
> 2.20.1
> 
