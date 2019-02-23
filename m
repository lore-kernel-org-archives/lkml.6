Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE30206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5f7XR4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfBWQwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:52:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBWQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:52:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so2534823pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0DH+kKdMY/jBvSjyJM20HnxSYxPjDjvJIinZlIj5RE=;
        b=V5f7XR4rOI+xembxAZuBPCHlH2ER01mkrB+6gKw/Uga6/Uug2Ptb+x0l4syTQOEgYx
         1kCU6z1eoXAyPa2nE/4bZ5H7AXa7drP+43JBr7FF8ku9aY/ccj6fBPRJSucHzB8XaSNS
         2Og/0g3QCWJ9t+iEbnRkp3ji7lHGJAbgCeDGYsbxB0s43kSFr16aKqOyq3NHKcEwbd4Q
         FVGqa8fIKdsXkOiXrqcqb9CZdS1/NTN4wa/d+gyvB4835DuTQIBFnbtq4FBe5XqX7wNZ
         3KrDcFfCrF7ltnb8Z1qlZDNoRxydf1PIpIPraOKArO/YtGnN+bp54DvJA5IBuzA2+j8I
         SUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0DH+kKdMY/jBvSjyJM20HnxSYxPjDjvJIinZlIj5RE=;
        b=tCYJNwKZ1kibsES/45c+dBHXdW1LnyI/mRb+11x3m0L7mSzAU8J7sHlsau15DKv8N3
         i6vucenDib5yTByPbus+ZXpheujjIO40GxnPTsTyfZswMdc9vFBq5w4REzO89Pvee7zf
         dNM3tsdKTZzR2fxp0rUCoy0yo+j5TFHcYWM4I3XhRU6gtVC/DMCUCOUqMZN23nc+wqac
         9Ufl8iWl4J2eLb0VEbNA2KTzgDPigBi1BHAIngHErzNlsG59qejkus/7Pw7eKekP8i0k
         obkKnJZxyra25oVk7drITKYbxJqiLpzktzid9Khrhksd4b82qGCz4GPuRTmsG7r9czJn
         K68w==
X-Gm-Message-State: AHQUAubYrfu2Yt1uBxtuqggUl4ADnn8Rxm0itTGjh0XURNU2ZW05C+kZ
        cpRaggK+3glHUArbiaHiyTV35w==
X-Google-Smtp-Source: AHgI3IaIpPf//h05h5cdWYjjNh9Q+tPsHwvywUpel3im8EMhCf9XCATsUASuittHYY9pVFl079cb6A==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr5297567pgr.404.1550940742497;
        Sat, 23 Feb 2019 08:52:22 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t24sm6394715pfh.21.2019.02.23.08.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 08:52:21 -0800 (PST)
Date:   Sat, 23 Feb 2019 08:52:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh@kernel.org, swboyd@chromium.org, andy.gross@linaro.org,
        shawn.guo@linaro.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
Message-ID: <20190223165218.GB572@tuxbook-pro>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Feb 03:17 PST 2019, Jorge Ramirez-Ortiz wrote:

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

Per Rob's request make this:

Should contain "qcom,qcs404-snps-usb-ssphy" and "qcom,snps-usb-ssphy"

You can then leave the driver matching on qcom,snps-usb-ssphy for now
and if we ever find this to be incompatible with other platforms we can
make the driver match on the platform-specific compatible.

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

The USB-C connector is attached both to the HS and SS PHYs, so I think
you should represent this external to this node and use of_graph to
query it.

So the connector should look similar to example 2 in
connector/usb-connector.txt.

Regards,
Bjorn

> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		type = "micro";
> +		vbus-supply = <&usb3_vbus_reg>;
> +	};
> +};
> -- 
> 2.20.1
> 
