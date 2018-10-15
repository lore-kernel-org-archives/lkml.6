Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA432C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE7B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJPC4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:56:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46792 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:56:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so15965578oia.13;
        Mon, 15 Oct 2018 12:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHC02P3BP6ls8Xl9PRakYsZohXHoLy7Bk0iuyHlq65s=;
        b=EbndYtDUV/FAg6E0k+HP69mUK0Zk1Ytxy+e+wbm0p/oj7536W+ss5xLtQ+7Hsd67uS
         OHLRSUCzxez+abCQhn/DD9n1cc5bbT7eS8e0CndCRT7p3BxIhL1GTNCk9+oX7Owy/lDM
         gEMS7ovgETsOgpwHw2FXVXlN9Pur6CLuflsYc5wmmsc5TN53eje94r6o5CbLMGHQIvi+
         c+XDKjsgrjWbFLdiCKJ3c59NPO2M5kRk0F3dbwbmGz1fWKgZssHD3T/Mf4iwzMdUTKSC
         kHosmGcA7XItYBJ61guB3o4ta3K3Zisbqw7w/fUykwsxw9PvPkRA8CXSb3mdYPD+HWfx
         pj/w==
X-Gm-Message-State: ABuFfoiPMWzfz9POpOsv/gVIi+ZDVTWygpMCQ4rxb9eEBnDNZrOVC3qe
        S26pXMQ+RClAkg4c2fWgfw==
X-Google-Smtp-Source: ACcGV62CkuxWV6cuLfH08ihDLYTtRByd0wjOTyoZfXjTKLfOxKoa/q5X1UIHeNipZ3AQMNFFIayo0A==
X-Received: by 2002:aca:c7c9:: with SMTP id x192-v6mr9425353oif.43.1539630571235;
        Mon, 15 Oct 2018 12:09:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t53sm3869467otf.8.2018.10.15.12.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:09:30 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:09:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Message-ID: <20181015190929.GA22554@bogus>
References: <1538582545-22041-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538582545-22041-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:02:25PM +0100, Alan Douglas wrote:
> Add DT binding documentation for Sierra PHY.  The PHY supports
> a number of different protocols, including PCIe and USB.
> 
> The PHY lanes may be configured as single or multi-lane links.
> Each link is treated as a separate sub-node.  For example, if
> there are 4 lanes in total the first 2 might be configured as
> a multi-lane PCIe link while the other two are single lane
> USB links, and in this case there would be 3 sub-nodes.
> 
> There are two resets for the PHY block (one for APB register
> access, one for the PHY link) and separate resets for each
> link.  For multi-lane links, the reset corresponds to the
> reset line on the master lane, the resets on other lanes
> have no effect.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> new file mode 100644
> index 0000000..0e2f3e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> @@ -0,0 +1,68 @@
> +Cadence Sierra PHY
> +-----------------------
> +
> +Required properties:
> +- compatible:	cdns,sierra-phy-t0
> +- clocks:	Must contain an entry in clock-names.
> +		See ../clocks/clock-bindings.txt for details.
> +- clock-names:	Must be "phy_clk"
> +- resets:	Must contain an entry for each in reset-names.
> +		See ../reset/reset.txt for details.
> +- reset-names:	Must include "sierra_reset" and "sierra_apb" and one for each
> +		sub-node.
> +		"sierra_reset" must control the reset line to the PHY.
> +		"sierra_apb" must control the reset line to the APB PHY
> +		interface.
> +		The name of the reset for each sub-node should match the full
> +		name of the sub-node.  The sub-node resets must control the
> +		reset line for the master lane of the sub-node.

Add a resets property to the sub-nodes instead.

> +- reg:		register range for the PHY.
> +- #address-cells: Must be 1
> +- #size-cells:	Must be 0
> +
> +Optional properties:
> +- cdns,autoconf:	A boolean property whose presence indicates that the
> +			PHY registers will be configured by hardware. If not
> +			present, all sub-node optional properties must be
> +			provided.
> +
> +Sub-nodes:
> +  Each group of PHY lanes with a single master lane should be represented as
> +  a sub-node. Note that the actual configuration of each lane is determined by
> +  hardware strapping, and must match the configuration specified here.
> +
> +Sub-node required properties:
> +- #phy-cells:	Generic PHY binding; must be 0.
> +
> +Sub-node optional properties:
> +- reg:			The master lane number.  This is the lowest numbered
> +			lane in the lane group.

How do you name the nodes if this is optional?

> +- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.  The
> +			group is made up of consecutive lanes.
> +- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
> +			configuration of lanes.
> +
> +Example:
> +	pcie_phy4: pcie-phy@fd240000 {
> +		compatible = "cdns,sierra-phy-t0";
> +		reg = <0x0 0xfd240000 0x0 0x40000>;
> +		resets = <&phyrst 0>, <&phyrst 1>, <&phyrst 2>, <&phyrst 4>;
> +		reset-names = "sierra_reset", "sierra_apb",
> +				"pcie_phy@0", "pcie_phy@2";
> +		clocks = <&phyclock>;
> +		clock-names = "phy_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pcie0_phy0: pcie-phy@0 {
> +				reg = <0>;
> +				cdns,num-lanes = <2>;
> +				#phy-cells = <0>;
> +				cdns,phy-type = <PHY_TYPE_PCIE>;
> +		};
> +		pcie0_phy1: pcie-phy@2 {
> +				reg = <2>;
> +				cdns,num-lanes = <1>;
> +				#phy-cells = <0>;
> +				cdns,phy-type = <PHY_TYPE_PCIE>;
> +		};
> +
> -- 
> 1.9.0
> 
