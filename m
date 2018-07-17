Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CABECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20DD20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xKWafQz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20DD20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeGQK1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:27:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55812 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeGQK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:27:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6H9tsHt083977;
        Tue, 17 Jul 2018 04:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531821354;
        bh=SOx94hjLIuwq+7BkNC4RFQzJDf1hSRxpBxkmS/dcMn4=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=xKWafQz4XWa6wv9LmK85RvrLTN+qohczkf1RkjdywZPmJHJdPyLEIgq6/3OcEyOOO
         UBK4/nOTDSJdXVT1JO8AR95IL1NdnTyhGzV4Y75LOqqR/OMEsOXnefP1fdg5Hpp6wa
         lPjTsmlFZ0VMPJnaOXDTOjIhJr4pdIdOFyXz9dPU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H9tsR4023297;
        Tue, 17 Jul 2018 04:55:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 17
 Jul 2018 04:55:54 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 17 Jul 2018 04:55:54 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H9tpvQ028612;
        Tue, 17 Jul 2018 04:55:51 -0500
Subject: Re: [PATCH v2 4/4] ARM: dts: dra7: Fix up unaligned access setting
 for PCIe EP
To:     Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-5-vigneshr@ti.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <92691b59-1952-b00f-da5b-f308f94aa2b7@ti.com>
Date:   Tue, 17 Jul 2018 15:25:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180627122919.23926-5-vigneshr@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 June 2018 05:59 PM, Vignesh R wrote:
> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
> incorrectly documented in the TRM. In fact, the bit positions are
> swapped. Update the DT bindings for PCIe EP to reflect the same.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Shouldn't this be sent to stable fixes?

Thanks
Kishon
> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 7bfe7f28e3bd..27ad193e1a87 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -355,7 +355,7 @@
>  				ti,hwmods = "pcie1";
>  				phys = <&pcie1_phy>;
>  				phy-names = "pcie-phy0";
> -				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
> +				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
>  				status = "disabled";
>  			};
>  		};
> 
