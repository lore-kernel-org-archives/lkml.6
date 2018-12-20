Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29D320815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545325535;
	bh=aJ+4TKS+x3dRkTysFHV5KTneB4dLErCh+3HYLLQtFn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yUOAdRwJ0tTItB1tNmjOagAqVPJHih8MM1K1OEu23QlIsMrqokit8grS6TB1HbEP8
	 O7VSeC1cca/v8tdxxrJpOagqo33z3/aglTYcxMybOzF3Erd96+2lbKAg6wZty86D/A
	 jFLGKEN5pRo8hSbF6tBiTaN13zggqTM0nPgVwSWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeLTRFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:05:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39354 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLTRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:05:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so2443163oia.6;
        Thu, 20 Dec 2018 09:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQCI79tZBuKidiDBBrEbESEjWUWQYAcupup/hzJNOJo=;
        b=aNiZ2AF14CTcV+6zeD+tRORpyhKKeXK+/yXBzsDnHCeOVC22Z+3mAaVd6PqioTknCR
         Y4CKrgAiERHLE/z4A7ZX/IJEMalXmdTz/FrrCMDvimpT7BI6Uq2jHl888KQaGKA+Kj2K
         fFvFhAtwqQOtE/uDH6puR3S6H1u7WTeDyQgK0K8tTHnwutuMDt1nzHYIRfKsYXzg5qXp
         yLEer/irTYO9hUWAoBxDdo5JaptL6qbaQnNYkYUHXlSFYY8TR1RMFNT/8BLBXiCl+MjV
         uZ8Jzw97+IyD9xGer+gZSxXNeTcxdkDoFLrbJsc6xrBwzGcJmi++CA8UjxWWvuoHeTu5
         7RLA==
X-Gm-Message-State: AA+aEWYy0y2gXXjyP4gmmVQ8vxzA3UiUjgq8mm5p2DEP2XFqrJc7UkT/
        5D7t4xXWYfWN7295653R+We6DaM=
X-Google-Smtp-Source: AFSGD/U0P1OFrFK0eshs4I7yjf+IgK/t3C6JiTWlluKaZ5B1IRCmblA/lZFK9qitIOag2ry8qWVIJQ==
X-Received: by 2002:aca:ef87:: with SMTP id n129mr2742007oih.118.1545325532665;
        Thu, 20 Dec 2018 09:05:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r203sm10393228oih.11.2018.12.20.09.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:05:32 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:05:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20181220170531.GA19862@bogus>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 10:55:57AM +0100, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> new file mode 100644
> index 0000000..fcf4e01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> @@ -0,0 +1,78 @@
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

What is "qcom,dwc3-ss-usb-phy" which already exists then?

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
> +- qcom,vdd-voltage-level:
> +    Value type: <prop-array>
> +    Definition: This is a list of three integer values <no min max> where
> +		 each value corresponding to voltage corner in uV.
> +
> +Optional child nodes:
> +
> +- vbus-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the VBUS supply node.
> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". PHY reset specifiers
> +		 for phy core and COR resets.
> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy".
> +
> +Example:
> +
> +usb3_phy: phy@78000 {
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
> +	qcom,vdd-voltage-level = <0 1050000 1050000>;
> +};
> -- 
> 2.7.4
> 
