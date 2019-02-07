Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5D021902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C8MpDbTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBGL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:26:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:26:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BQVaq084095;
        Thu, 7 Feb 2019 05:26:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549538791;
        bh=8AIG5Drdjq4ss0gYs4JH8xtC9u7x4mZrBSQ6CqW1Mxg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=C8MpDbTrDl4iOPdwsJtUU+BuRISpU2yIRSfDJyB2KREewDRdl5CILqVraA/io0p0D
         TZ8LjY+7jWLrUFs+83yBdgY2RGnOy7T5DEzGxqZgPsmWuT+OXXbU8hphAneKZbLQqr
         LuVxwP7G6qFKloE1JkE65AGKykxt2lqxPBpVdu38=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BQVih066725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:26:31 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:26:30 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:26:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BQS4i013028;
        Thu, 7 Feb 2019 05:26:29 -0600
Subject: Re: [PATCH v2 3/4] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190206110753.28738-1-kishon@ti.com>
 <20190206110753.28738-4-kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5C15E4.8010601@ti.com>
Date:   Thu, 7 Feb 2019 13:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190206110753.28738-4-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/19 13:07, Kishon Vijay Abraham I wrote:
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

Instead of these magic numbers and expecting a human to decipher this
which is prone to error, is it better to create the following defines and
check for valid configuration in the driver?

AM654_SERDES_LANE_USB3,
AM654_SERDES_LANE_PCIE_LANE0,
AM654_SERDES_LANE_PCIE_LANE1,
AM654_SERDES_LANE_SGMII,

So if you pass AM654_SERDES_LANE_PCIE_LANE0 to SERDES1, driver can easily
figure out that it should be 1 if it is serdes0 and 0 if serdes1.

Which means the DT must contain something so that you can identify
if it is serdes0 or serdes1.

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
> +};

You should also show a user that selects the lane function.

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
