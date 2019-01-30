Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57735C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6F82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548878543;
	bh=1WIutgr7n8g9Msl4+K35pDZGk9VAaQjURwahEOABn2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zWfkOP/7c0PSO2/cfs0aiWphkSNVLN0JlTH2YVfoqVMZmtv16mtNdYQFkGKyrAUgr
	 47Oz/RfvCh7dYysYC6hPA8YKyqeZ3JcOyM4Mz6c0TFzIvEDwl7OQxMYXNJtGHmBzJb
	 HJlxj13dFM0UoRCmcZpDU+lfLN5qnJZHhVxP9mOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfA3UCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:02:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37991 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3UCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:02:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so724692oii.5;
        Wed, 30 Jan 2019 12:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7U4FwF4rwvNfXRrLtt0q+Bh7E9FjuCDZRhkCbsAnKo=;
        b=B4i9RIgYFfmvszyibkTZnv2+7kP0jI3lep3G7TF+E5tdaQN5r0AMh72dS5w733xeAd
         ymdpEifP5JtA/b7UPEN8sxtr0cCiZ7JBldywL7fHjCkvPlNeRgpebxsnov4GCCIIFNEn
         DpFxaQB5FQQXt6vB/VxfgKKBitccxr57HnoNb+MBCn3UbjfQM0dhNjUe/qH06CKxiMRR
         fezsBWXL3Il+3oIRfxyixveBc5evw3tAgMOmGghw0FC25GWsozjPk0DFHO/bcgTKrUbH
         n2hQTPgF9gBoXXMVXzlXLLhbTVI1qG4xSPBe80I62gC03q8ED0B5pNRf2VwvZHY5+AxE
         MS9w==
X-Gm-Message-State: AJcUukf5d1zummWQq3nHTsMbM2lCadZEEI8JK43rNto5l4MFbyJ8Jlt8
        JvgPkFzYeWdO1MN+kf7hzw==
X-Google-Smtp-Source: ALg8bN6UVC6iZTdLJlj4jcLfLc176T8NLD5kdGdWZIYeHNOXIPBLYnhsLAJr7zyLp9iqK1O/Pr1uUw==
X-Received: by 2002:aca:c413:: with SMTP id u19mr12736474oif.209.1548878539803;
        Wed, 30 Jan 2019 12:02:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u109sm925002otb.8.2019.01.30.12.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 12:02:18 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:02:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20190130200218.GB5908@bogus>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> new file mode 100644
> index 0000000..8ef6e39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> @@ -0,0 +1,73 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> +chipsets
> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-ssphy".

This is in no way specific enough.

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
> +
> +Optional child nodes:
> +
> +- vbus-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the VBUS supply node.

Does the phy actually get supplied by Vbus? If not, then Vbus supply 
should be defined in a USB connector node.

> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". PHY reset specifiers
> +		 for phy core and COR resets.

COR or COM?

Looks to me the order is reversed.

> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy".
> +
> +Example:
> +
> +usb3_phy: phy@78000 {

usb3-phy@...

> +	compatible = "qcom,usb-ssphy";
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
> +	vbus-supply = <&usb3_vbus_reg>;
> +};
> -- 
> 2.7.4
> 
