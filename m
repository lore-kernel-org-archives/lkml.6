Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFFAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D14520866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPwycXtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfAOO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:27:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39214 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:27:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FERiYP106652;
        Tue, 15 Jan 2019 08:27:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547562464;
        bh=lQFnyE46FaVj/+e+vZyU1ndUXVskqbFRRs/4Q8JdMeY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EPwycXtYi+eP4DiQ0T1JwDWxPG8oSdfANmEM69RPMojkDbFA4IK7b6SCYxgxtenn2
         rTZ6qqkUzjA6rypx/TndvNVU34U5+MX0AeZ+R+V1Dn0uRCtLzQqHQuIgbN01HUaH/R
         NcVkT4mOkmiCCiGI1+DAw5BYsOtpTSwZeXn5kXXk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FERiG0022899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:27:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:27:43 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:27:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FERhrT028678;
        Tue, 15 Jan 2019 08:27:43 -0600
Date:   Tue, 15 Jan 2019 08:27:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Message-ID: <20190115142711.iwsx4p3gfa63dutc@kahuna>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
 <20190110073355.3382-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110073355.3382-2-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject claims MMC/SD, while the patch is specific for emmc and HS200?

could you fix that up please?

On 13:03-20190110, Faiz Abbas wrote:
> Add support for the Secure Digital Host Controller Interface (SDHCI)
> present on TI's AM654 SOCs. It is compatible with eMMC5.1 Host
> Specifications and SDHC Standard Specification 4.10.
> 
> Enable only upto HS200 speed mode.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 272cf8fc8d30..78e1bb56adee 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -191,4 +191,17 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  	};
> +
> +	sdhci0: sdhci@4f80000 {
> +		compatible = "ti,am654-sdhci-5.1";
> +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
> +		power-domains = <&k3_pds 47>;
> +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		ti,otap-del-sel = <0x2>;
> +		ti,trm-icp = <0x8>;
> +	};
>  };
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon
