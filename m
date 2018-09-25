Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EAF206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EAF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeIZDLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:11:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41035 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIZDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:11:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so25917696oti.8;
        Tue, 25 Sep 2018 14:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSaGeVXdRFDswyvVrSFbR6RakD+RcYmJYiprcDxeeIo=;
        b=SEw3ClsOxexoihDYSqYDs8KA+7u0viaT3Kh39XNzn3AWfHJ3bb144Pck/J5/6iZPIp
         d4UEBhVmDLZcqb2KuChqiykTqxmkCYcWv6lTJ8zBzKl8iUSApTBtKjRrAZqIhA12mdWm
         NzJocD8z3BqWRTw8+XSY1hyu/AO1Y8UsEniAxwN88MgrH8c+L9moE9RpE0r8ZqPL0TmQ
         cQgDijjaFCzwqxTzy1Czm+L5EbI8amVq7xE2nZ+Y7J3wNpDY1C5MNwWxnmrRyRNiGdJP
         Bd/V1nUoTARBsmVIJhMXTqATaLZEPkG9njug46sEYhMJ4m3Lq8N7F/JYM65ckNjDbogM
         6bFw==
X-Gm-Message-State: ABuFfogfvZp6agbsQruItNxddC89QgWNyoVMPk9fntxeZzOkjScB+GQL
        bGmkpFWN5ppinrbUsBz46Q==
X-Google-Smtp-Source: ACcGV63hE8Ys57wY0qwSXWqiOrg1mkAX9v9rSCTE4hhd3jD9N7Oqv4gwQsfK8jiRpF9TiEHwzcU2AA==
X-Received: by 2002:a9d:2d56:: with SMTP id v80-v6mr2127268ota.146.1537909315529;
        Tue, 25 Sep 2018 14:01:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1134116otb.74.2018.09.25.14.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:01:54 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:01:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Message-ID: <20180925210154.GA21444@bogus>
References: <1536244949-25892-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536244949-25892-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:42:29PM +0100, Alan Douglas wrote:
> Add DT binding documentation for Sierra PHY.  The PHY supports
> a number of different protocols, including PCIe and USB.
> 
> The PHY lanes may be configured as single or multi-lane links.
> Each link is treated as a separate subnode.  For example, if
> there are 4 lanes in total the first 2 may be configured as
> a multi-lane PCIe link while the other two are single lane
> USB links, and in this case there would be 3 subnodes.
> 
> There are two resets for the PHY block, and additional resets,
> one for each lane.  For multi-lane links, only the reset for
> the master lane is required, the resets on other lanes have no
> effect.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> new file mode 100644
> index 0000000..94a8a7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> @@ -0,0 +1,65 @@
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
> +		Resets for each subnode must control the master lane for the
> +		subnode lane group.

What are the names?

> +- reg:		register range for the PHY.
> +- reg-names:	Must be "reg".

Kind of pointless with only 1.

> +- #address-cells: Should be 1
> +- #size-cells:	Should be 0
> +
> +Optional properties:
> +- cdns,autoconf:	If present, indicates that the PHY registers will
> +			be configured by hardware.  If not present, all
> +			sub-node optional properties must be provided.

boolean?

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
> +- reg:			The master lane number.
> +- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.
> +- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
> +			configuration of lanes.
> +
> +Example:
> +	pcie_phy4: pcie-phy4@fd240000 {

pcie-phy@fd240000

> +		compatible = "cdns,sierra-phy-t0";
> +		reg = <0x0 0xfd240000 0x0 0x40000>;
> +		reg-names = "reg";
> +		resets = <&phyrst 0>, <&phyrst 1>,<&phyrst 2>,<&phyrst 4>;
> +		reset-names = "sierra_reset","sierra_apb","pcie_phy0",pcie_phy1;

spaces and quotes missing.

> +		clocks = <&phyclock>;
> +		clock-names = "phy_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pcie0_phy0: pcie-phy0@0 {

pcie-phy@0

> +				reg = <0>;
> +				cdns,num-lanes = <2>;
> +				#phy-cells = <0>;
> +				cdns,phy-type = <PHY_TYPE_PCIE>;
> +		};
> +		pcie0_phy1: pcie-phy1@0 {

pcie-phy@2

Or reg should be 1?

> +				reg = <2>;
> +				cdns,num-lanes = <1>;
> +				#phy-cells = <0>;
> +				cdns,phy-type = <PHY_TYPE_PCIE>;
> +		};
> +
> -- 
> 1.9.0
> 
