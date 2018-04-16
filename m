Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109416-1523911124-2-15185182894368201576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523911123; b=kXrXs2qLriTb27IW/mLa7p5vYgJARc5wVEYpp/fLnDgBCbI3sU
    jotnh/Bx+2b0W4McXmRTgSfWw/6WfkZJSUDrPHDn47JkLwONGPo0/phon3wPFSQp
    AspJ/1Kf81xdRP92Scc94gA+kXoFypbH+jYCqE/nYxaPiyS/3MqG3kt9Opv6/hRa
    ZwdPydyPXPd4d2degWjYSFJ2PgYnBhKCfSi9fMI31S4qzAd/ymPMp2v6/ZSX4veX
    R+yjUzvjmgawW56fdIj/0Wp9kl2wFedQwDsA+xJL6Ed5uOfWsdwTBYbXy3IP6iLH
    jyM+cMXPVeL3FnH37wxV67zrRJr7t9s+Lshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523911123; bh=/4DpFifB9EZ93dq3Q/P2OYLM1PRxws
    IGvLYaYR64HYQ=; b=I35idrPjDiVt/8FfQ2E0ifHP0anBnlw9aTJtjp0ph0CYHS
    GIW+oLgGje7M9pC8Em01gR/m9Okq7F75r+oYxkxLRDzKECzdzHRXbmvltWlJYWsO
    8k7b2JHwqHGj/SQY3amrpVcJiPeN+q0CvV7Vw/Qwv/qMry9iDpmHxR3QdxfYzDsf
    tIHKjk+pgm5hor7yKTX5zjHjx4vczvC9XZky505TvRvny3oHiFh1Q83alWG2ZKhc
    11w+7UBd9ZO08GHsAe3uyaxvn9AljjpLoiqpOEfElyRotFUis8EmXTLxo0zaY5ke
    zG38VHu7oJQzqgYA/2ADpPcW6On62ZVkVLxmTs/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tqFDrUMs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tqFDrUMs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDZhAMhAweAjuOHNtfxmwaOg15DpkYpIBBkLTnoRf3dVmsXdSlnHRkhbnTF3tqrSf9ko4xb+VEHqTf2pjxO4V9BPbrMdk8nuCGrtRL+g/EnOtAJU7u/M
    V4Awb55JOGIw9GxiAVdk7dh0g+4CMLArFeGRf+IYedIMBQpHJEotXlw7fZCp8sPrTerd64vc4JOWrrdofDApXvSX4LoJEMc/O3LmZf7xd8K/rcr64G4QOph3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=g5nnLByuPCsGi69Xe0AA:9
    a=PRimCYh_hpsUl2Xs:21 a=odo9FaBM_WpD8Fh3:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDPUib (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:38:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35503 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeDPUi3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 16:38:29 -0400
X-Google-Smtp-Source: AIpwx4/MRPe5A5nx0DNJ+mM4ZYSDt+CrUX25bcJR/sSjNS9LqWctLzSk9srHHF+5brSmeA9TT04HgQ==
Date: Mon, 16 Apr 2018 15:38:27 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: balbi@kernel.org, andy.gross@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Update documentation for
 Qualcomm DWC3 driver
Message-ID: <20180416203827.4jgevj4dgce6r3cq@rob-hp-laptop>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
 <1523638285-5742-2-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523638285-5742-2-git-send-email-mgautam@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 10:21:22PM +0530, Manu Gautam wrote:
> Existing documentation has lot of incorrect information as it
> was originally added for a driver that no longer exists.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.txt          | 78 ++++++++++++++++------
>  1 file changed, 57 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> index bc8a2fa..fdc574a 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> @@ -1,54 +1,90 @@
>  Qualcomm SuperSpeed DWC3 USB SoC controller
>  
>  Required properties:
> -- compatible:	should contain "qcom,dwc3"
> +- compatible:		should contain "qcom,dwc3"

Needs an SoC specific compatible string.

> +- reg:			offset and length of register set for QSCRATCH wrapper
> +- power-domains:	specifies a phandle to PM domain provider node
>  - clocks:		A list of phandle + clock-specifier pairs for the
>  				clocks listed in clock-names
> -- clock-names:	Should contain the following:
> +- clock-names:		Should contain the following:
>    "core"		Master/Core clock, have to be >= 125 MHz for SS
>  				operation and >= 60MHz for HS operation
> +  "mock_utmi"		Mock utmi clock needed for ITP/SOF generation in
> +				host mode. Its frequency should be 19.2MHz.
> +  "sleep"		Sleep clock, used for wakeup when USB3 core goes
> +				into low power mode (U3).
>  
>  Optional clocks:
>    "iface"		System bus AXI clock.  Not present on all platforms
> -  "sleep"		Sleep clock, used when USB3 core goes into low
> -				power mode (U3).
> +  "cfg_noc"		System Config NOC clock. Not present on all platforms

These need to be specific as to which compatible properties have or 
don't have these clocks.

> +- assigned-clocks:	should be:
> +				MOCK_UTMI_CLK
> +				MASTER_CLK
> +- assigned-clock-rates: should be:
> +                                19.2Mhz (192000000) for MOCK_UTMI_CLK
> +                                >=125Mhz (125000000) for MASTER_CLK in SS mode
> +                                >=60Mhz (60000000) for MASTER_CLK in HS mode
> +
> +Optional properties:
> +- resets:		list of phandle and reset specifier pairs

How many? 

> +- interrupts:		specifies interrupts from controller wrapper used
> +			to wakeup from low power/susepnd state.	Must contain
> +			one or more entry for interrupt-names property
> +- interrupt-names:	Must include the following entries:
> +			- "hs_phy_irq": The interrupt that is asserted when a
> +			   wakeup event is received on USB2 bus
> +			- "ss_phy_irq": The interrupt that is asserted when a
> +			   wakeup event is received on USB3 bus
> +			- "dm_hs_phy_irq" and "dp_hs_phy_irq": Separate
> +			   interrupts for any wakeup event on DM and DP lines

Sounds like the irqs are actually part of the PHYs? If so, then that's 
where they should be in the DT.

> +- qcom,select-utmi-as-pipe-clk: if present, disable USB3 pipe_clk requirement.
> +				Used when dwc3 operates without SSPHY and only
> +				HS/FS/LS modes are supported.
>  
>  Required child node:
>  A child node must exist to represent the core DWC3 IP block. The name of
>  the node is not important. The content of the node is defined in dwc3.txt.
>  
>  Phy documentation is provided in the following places:
> -Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
> +Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
> +Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY
>  
>  Example device nodes:
>  
>  		hs_phy: phy@100f8800 {
> -			compatible = "qcom,dwc3-hs-usb-phy";
> -			reg = <0x100f8800 0x30>;
> -			clocks = <&gcc USB30_0_UTMI_CLK>;
> -			clock-names = "ref";
> -			#phy-cells = <0>;
> -
> +			compatible = "qcom,qusb2-v2-phy";
> +			...
>  		};
>  
>  		ss_phy: phy@100f8830 {
> -			compatible = "qcom,dwc3-ss-usb-phy";
> -			reg = <0x100f8830 0x30>;
> -			clocks = <&gcc USB30_0_MASTER_CLK>;
> -			clock-names = "ref";
> -			#phy-cells = <0>;
> -
> +			compatible = "qcom,qmp-v3-usb3-phy";
> +			...
>  		};
>  
> -		usb3_0: usb30@0 {
> +		usb3_0: usb30@a6f8800 {
>  			compatible = "qcom,dwc3";
> +			reg = <0xa6f8800 0x400>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			clocks = <&gcc USB30_0_MASTER_CLK>;
> -			clock-names = "core";
> -
>  			ranges;
>  
> +			interrupts = <0 131 0>, <0 486 0>, <0 488 0>, <0 489 0>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> +				  "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +			clocks = <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				<&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				<&gcc GCC_USB30_PRIM_SLEEP_CLK>;
> +			clock-names = "core", "mock_utmi", "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <133000000>;
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +			reset-names = "core_reset";
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
> +			qcom,select-utmi-as-pipe-clk;
>  
>  			dwc3@10000000 {
>  				compatible = "snps,dwc3";
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
