Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E0C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wL5m/Oyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAUJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:55:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51472 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfAUJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:55:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L9t668020126;
        Mon, 21 Jan 2019 03:55:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548064506;
        bh=V22rgboLW80Cn2cGzd7ZKw3/rGoAEGZdc3f2GUjIuhw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=wL5m/Oyg61nIT34Dm+DaFaSMBlprW37JlW6NoliMrh2FZxCkN7HugEjxvH8w+7nOh
         LgSaIvfC1lX4Z2PpjyHE92qdLIQhO2rpiVIbDIpKEscA5JtfDIwfTpnWzFQVJMvKk8
         EQxvdWXozyUlgOS6jpWb5RatZY2Cle08J55jeCGU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L9t6Dj028182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 03:55:06 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 03:55:06 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 03:55:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L9t4KH000777;
        Mon, 21 Jan 2019 03:55:05 -0600
Subject: Re: [PATCH 2/3] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190121064813.18444-1-kishon@ti.com>
 <20190121064813.18444-3-kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C4596F8.7030009@ti.com>
Date:   Mon, 21 Jan 2019 11:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190121064813.18444-3-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 21/01/19 08:48, Kishon Vijay Abraham I wrote:
> AM654x has two SERDES instances. Each instance has three input clocks
> (left input, externel reference clock and right input) and two output
> clocks (left output and right output) in addition to a PLL mux clock
> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
> The PLL mux clock can select from one of the three input clocks.
> The right output can select between left input and external reference
> clock while the left output can select between the right input and
> external reference clock.
> 
> The left and right input reference clock of SERDES0 and SERDES1
> respectively are connected to the SoC clock. In the case of two lane
> SERDES personality card, the left input of SERDES1 is connected to
> the right output of SERDES0 in a chained fashion.
> 
> See section "Reference Clock Distribution" of AM65x Sitara Processors
> TRM (SPRUID7 – April 2018) for more details.
> 
> Add dt-binding documentation in order to represent all these different
> configurations in device tree.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/ti-phy.txt        | 77 +++++++++++++++++++
>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 ++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 57dfda8a7a1d..fc2fff6b2c37 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -132,3 +132,80 @@ sata_phy: phy@4a096000 {
>  	syscon-pllreset = <&scm_conf 0x3fc>;
>  	#phy-cells = <0>;
>  };
> +
> +
> +TI AM654 SERDES
> +
> +Required properties:
> + - compatible: Should be "ti,phy-am654-serdes"
> + - reg : Address and length of the register set for the device.
> + - reg-names: Should be "serdes" which corresponds to the register space
> +	populated in "reg".
> + - #phy-cells: determine the number of cells that should be given in the
> +	phandle while referencing this phy. Should be "2". The 1st cell
> +	corresponds to the phy type (should be one of the types specified in
> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
> +	lane function.
> +	If SERDES0 is referenced 2nd cell should be:
> +		0 - USB3
> +		1 - PCIe0 Lane0
> +		2 - ICSS2 SGMII Lane0
> +	If SERDES1 is referenced 2nd cell should be:
> +		0 - PCIe1 Lane0
> +		1 - PCIe0 Lane1
> +		2 - ICSS2 SGMII Lane1

Can we have a way to change default lane at probe time without having any user dependencies.

e.g. To work in USB2.0 mode I don't want SERDES0 to be in lane 0 (which is SoC default).
But at the same time the application might not be using PCIe or SGMII, so there is no
PHY user to change the lane to 1 or 2.

A DT property to allow selection of a default lane at probe time would help.


> + - clocks: List of clock-specifiers representing the input to the SERDES.
> +	Should have 3 items representing the left input clock, external
> +	reference clock and right input clock in that order.
> + - clock-output-names: List of clock names for each of the clock outputs of
> +	SERDES. Should have 3 items for CMU reference clock,
> +	left output clock and right output clock in that order.
> + - assigned-clocks: As defined in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - assigned-clock-parents: As defined in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - #clock-cells: Should be <1> to choose between the 3 output clocks.
> +	Defined in Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +   The following macros are defined in dt-bindings/phy/phy-am654-serdes.h
> +   for selecting the correct reference clock. This can be used while
> +   specifying the clocks created by SERDES.
> +	=> AM654_SERDES_CMU_REFCLK
> +	=> AM654_SERDES_LO_REFCLK
> +	=> AM654_SERDES_RO_REFCLK
> +
> + - mux-controls: phandle to the multiplexer
> +
> +Example:
> +
> +Example for SERDES0 is given below. It has 3 clock inputs;
> +left input reference clock as indicated by <&k3_clks 153 4>, external
> +reference clock as indicated by <&k3_clks 153 1> and right input
> +reference clock as indicated by <&serdes1 AM654_SERDES_LO_REFCLK>. (The
> +right input of SERDES0 is connected to the left output of SERDES1).
> +
> +SERDES0 registers 3 clock outputs as indicated in clock-output-names. The
> +first refers to the CMU reference clock, second refers to the left output
> +reference clock and the third refers to the right output reference clock.
> +
> +The assigned-clocks and assigned-clock-parents is used here to set the
> +parent of left input reference clock to MAINHSDIV_CLKOUT4 and parent of
> +CMU reference clock to left input reference clock.
> +
> +serdes0: serdes@900000 {
> +	compatible = "ti,phy-am654-serdes";
> +	reg = <0x0 0x900000 0x0 0x2000>;
> +	reg-names = "serdes";
> +	#phy-cells = <2>;
> +	power-domains = <&k3_pds 153>;
> +	clocks = <&k3_clks 153 4>, <&k3_clks 153 1>,
> +			<&serdes1 AM654_SERDES_LO_REFCLK>;
> +	clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk",
> +				"serdes0_ro_refclk";
> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
> +	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
> +	ti,serdes-clk = <&serdes0_clk>;
> +	mux-controls = <&serdes_mux 0>;
> +	#clock-cells = <1>;
> +	status = "disabled";

We don't keep status "disabled" for AM6. All nodes are enabled by default.

> +};
> diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
> new file mode 100644
> index 000000000000..e8d901729ed9
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-am654-serdes.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for AM654 SERDES.
> + */
> +
> +#ifndef _DT_BINDINGS_AM654_SERDES
> +#define _DT_BINDINGS_AM654_SERDES
> +
> +#define AM654_SERDES_CMU_REFCLK	0
> +#define AM654_SERDES_LO_REFCLK	1
> +#define AM654_SERDES_RO_REFCLK	2
> +
> +#endif /* _DT_BINDINGS_AM654_SERDES */
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
