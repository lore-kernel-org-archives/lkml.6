Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC92C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC35627B51
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NtwdPgA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC35627B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeF2GhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:37:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeF2GhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:37:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5T6b2QL012173;
        Fri, 29 Jun 2018 01:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530254222;
        bh=Lx5kMToTv3aKHbCBePuPH0/zG8gXaCYKl+e9NRGmS5Y=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=NtwdPgA5hpoPvslQjaLD5hXgBZY76gR4XHW10TXqGFDR5LGyg4TDqR8l0CcSzkY8I
         39En4/kvu0Io7NuIDxX5tY60749qQy3QhJBIEpRj/J1bBRQFOrEfkveO5qFu8Q2CCW
         I//fwT4ze9/wNX/IBISONqy9kgJKSV4eYo4pazA0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5T6b2vY005486;
        Fri, 29 Jun 2018 01:37:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 01:37:02 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 01:37:02 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5T6b0Nx026998;
        Fri, 29 Jun 2018 01:37:00 -0500
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add binding doc for Stingray
 PCIe PHY
To:     Ray Jui <ray.jui@broadcom.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
References: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
 <1529540316-21706-2-git-send-email-ray.jui@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <424c21ea-e751-16e8-71b0-d05537b9e0b3@ti.com>
Date:   Fri, 29 Jun 2018 12:06:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1529540316-21706-2-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob and device tree list

On Thursday 21 June 2018 05:48 AM, Ray Jui wrote:
> Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
> root complex
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> new file mode 100644
> index 0000000..c2eede6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> @@ -0,0 +1,39 @@
> +Broadcom Stingray PCIe PHY
> +
> +Required properties:
> +- compatible: must be "brcm,sr-pcie-phy"
> +- brcm,sr-cdru: phandle to the CDRU syscon node
> +- brcm,sr-mhb: phandle to the MHB syscon node
> +- #phy-cells: Must be 1, denotes the PHY index
> +
> +For PAXB based root complex, one can have a configuration of up to 8 PHYs
> +PHY index goes from 0 to 7
> +
> +For the internal PAXC based root complex, PHY index is always 8
> +
> +Example:
> +	mhb: syscon@60401000 {
> +		compatible = "brcm,sr-mhb", "syscon";
> +		reg = <0 0x60401000 0 0x38c>;
> +	};
> +
> +	cdru: syscon@6641d000 {
> +		compatible = "brcm,sr-cdru", "syscon";
> +		reg = <0 0x6641d000 0 0x400>;
> +	};
> +
> +	pcie_phy: phy {
> +		compatible = "brcm,sr-pcie-phy";
> +		brcm,sr-cdru = <&cdru>;
> +		brcm,sr-mhb = <&mhb>;
> +		#phy-cells = <1>;
> +	};
> +
> +	/* users of the PCIe PHY */
> +
> +	pcie0: pcie@48000000 {
> +		...
> +		...
> +		phys = <&pcie_phy 0>;
> +		phy-names = "pcie-phy";
> +	};
> 
