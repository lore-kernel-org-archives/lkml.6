Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA86C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5223208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rxqq/R/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5223208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeJEW54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:57:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46854 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:57:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95FwVxk023344;
        Fri, 5 Oct 2018 10:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538755111;
        bh=8xQ67cbmS5kFqrGYHc1GKQMrYMVvpYPqZp+rfTlWHAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rxqq/R/HnfsSZDzHGHBnzGQYue9axk11hq11ggtQ9bXWFDFUcFU0sMzrTdEO2MOZ/
         ofkhBYgfy4IvsoTBJf3r8OhDXP5fYtW1hs3UuH7pfESgGyRVQAwrmpzq/iSB8nKepm
         /n2TzqAeVoHyFvnICb7I6PrY02F5JQrgXwgxE8Iw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FwVg6008179;
        Fri, 5 Oct 2018 10:58:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 10:58:30 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 10:58:30 -0500
Received: from [172.22.128.128] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FwUQa026434;
        Fri, 5 Oct 2018 10:58:30 -0500
Subject: Re: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy
 bindings
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <catalin.marinas@arm.com>, <adrian.hunter@intel.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
 <20181004111451.9539-2-faiz_abbas@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <ad9945db-de08-36fc-47b8-499ce2079d92@ti.com>
Date:   Fri, 5 Oct 2018 10:58:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004111451.9539-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 06:14 AM, Faiz Abbas wrote:
> Add information to document bindings for the MMC PHY
> on TI's AM654 devices.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  .../devicetree/bindings/phy/am654-mmc-phy.txt | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
> new file mode 100644
> index 000000000000..766921612758
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt


Name ti,am654-mmc-phy.txt might be more consistent name.


> @@ -0,0 +1,42 @@
> +TI AM654 MMC PHY
> +-------------------
> +
> +Required properties:
> + - compatible: ti,am654-emmc-phy
> + - #phy-cells: must be 0
> + - reg: PHY registers address offset and size
> + - clocks: must be phandle of the clock provider which is the host
> +	   controller
> + - clock-names: must be "mmcclk"
> + - ti,otap-del-sel: Output Tap Delay select.
> + - ti,trm-icp: DLL trim select.
> + - ti,driver-strength-ohm: driver strength in ohms.
> +			   Valid values are 33, 40, 50, 66, and 100 ohms.
> +
> +Example:
> +			mmc_phy1: mmc_phy@10100 {
> +				compatible = "ti,am654-mmc-phy";
> +				reg = <0x10100 0x34>;
> +				clocks = <&sdhci1>;
> +				clock-names = "mmcclk";
> +				#phy-cells = <0>;
> +				ti,otap-del-sel = <0x2>;
> +				ti,trm-icp = <0x8>;
> +				status = "disabled";


No need for disabled in the example case. Also not sure the host
controller example below needs to be here, there are already examples
for that binding in mmc/arasan,sdhci.txt.

Andrew


> +			};
> +
> +Host controller node:
> +
> +			sdhci1: sdhci@0 {
> +				compatible = "ti,am654-sdhci-5.1";
> +				reg = <0x0 0x1000>;
> +				power-domains = <&k3_pds 48>;
> +				clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
> +				clock-names = "clk_ahb", "clk_xin";
> +				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-output-names = "mmc_cardclck";
> +				#clock-cells = <0>;
> +				phys=<&mmc_phy1>;
> +				phy-names = "phy_arasan";
> +				status = "disabled";
> +			};
> 
