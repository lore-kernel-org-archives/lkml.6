Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121ED20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XpmGjPbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121ED20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLHPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:45:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54226 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLHPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:45:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB8FjRJY086823;
        Sat, 8 Dec 2018 09:45:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544283927;
        bh=sNubEZmLX9GLtz40Y78ZtKImyP0i/MBR2DeoShL3eQI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XpmGjPbnldQtVCaHJnt8JiSoEo6YW/Rnf8WFNwO3kDdyOpICEJehHZapj1UUOs6j8
         mYzqj+VB4FT4WFV9I3kkQtXPgg10dYgOx9S0cV/BMpwe/OxCrEa6fjiXxxw5JllLt5
         6/V+ZvF0Uj2EwDrNJ3b5gwAOv7DkahtfHLa4lgh0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB8FjRi8001191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 09:45:27 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 8
 Dec 2018 09:45:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 8 Dec 2018 09:45:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB8FjQRZ011911;
        Sat, 8 Dec 2018 09:45:26 -0600
Date:   Sat, 8 Dec 2018 09:45:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mark.rutland@arm.com>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Message-ID: <20181208154526.ivbvwvcx6otg7lvh@akan>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-2-faiz_abbas@ti.com>
 <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:56-20181208, Vignesh R wrote:
> 
> 
> On 07/12/18 2:12 PM, Faiz Abbas wrote:
> > There are two MMC host controller instances present on the TI's
> > Am654 SOCs. Add device tree nodes for the same.
> > 
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index 916434839603..d07212f16a81 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -129,4 +129,32 @@
> >  		clocks = <&k3_clks 113 1>;
> >  		power-domains = <&k3_pds 113>;
> >  	};
> > +
> > +	sdhci0: sdhci@4f80000 {
> > +		compatible = "ti,am654-sdhci-5.1";
> > +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
> > +		power-domains = <&k3_pds 47>;
> > +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
> > +		clock-names = "clk_ahb", "clk_xin";
> > +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> > +		sdhci-caps-mask = <0x80000007 0x0>;
> > +		mmc-ddr-1_8v;
> > +		ti,otap-del-sel = <0x2>;
> > +		ti,trm-icp = <0x8>;
> > +		status = "disabled";
> > +	};
> 
> Please drop "status=disabled" from dtsi. Can be disabled as required in
> the board dts.


yes - the standard in k3 is to disable the nodes that are'nt needed in
board.dtsi.

This is different from "disabled by default" approach in DRA7 or OMAP4
for example.

-- 
Regards,
Nishanth Menon
