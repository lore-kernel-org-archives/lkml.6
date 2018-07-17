Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D26EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069D820C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fPa6l9bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069D820C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeGQK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:26:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeGQK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:26:32 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6H9scce058478;
        Tue, 17 Jul 2018 04:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531821278;
        bh=RkMQK0O7XLzsYW/VLGrATuJqGShfGYkb5EAwNQVDzFU=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=fPa6l9bgcu9NC4GDTz21wMIsynwaqC+CJPr4THeLuaiAR/JkkaZDtLwPp+0zP7EcW
         F+tX2yhkFhvBf9qz9iGsPYd+s1q0Yu+rC/A59cY8LZmQNvK/9nDU7lii39D2zXxko3
         sE00knQKeRgmuE98L+xq++b4ypLJQK/1+CTbH/NA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H9scJn021570;
        Tue, 17 Jul 2018 04:54:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 17
 Jul 2018 04:54:38 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 17 Jul 2018 04:54:38 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H9sZ2Z020634;
        Tue, 17 Jul 2018 04:54:36 -0500
Subject: Re: [PATCH v2 2/4] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To:     Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-3-vigneshr@ti.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2096bbca-6ee9-784d-5a1e-6109472fc841@ti.com>
Date:   Tue, 17 Jul 2018 15:24:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180627122919.23926-3-vigneshr@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 June 2018 05:59 PM, Vignesh R wrote:
> Errata i870 is applicable in both EP and RC mode. Therefore rename
> function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
> workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
> common place. So, that errata workaround is applied for both modes of
> operation.
> 
> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 345aab56ce8b..95d9076e3fde 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -542,7 +542,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>  };
>  
>  /*
> - * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
> + * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>   * @dra7xx: the dra7xx device where the workaround should be applied
>   *
>   * Access to the PCIe slave port that are not 32-bit aligned will result
> @@ -552,7 +552,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>   *
>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>   */
> -static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
> +static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
>  {
>  	int ret;
>  	struct device_node *np = dev->of_node;
> @@ -695,6 +695,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
>  		dra7xx->link_gen = 2;
>  
> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
> +	if (ret)
> +		dev_err(dev, "WA for Errata i870 not appplied. Update DT\n");
> +
>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_EP);
>  
> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
> -		if (ret)
> -			goto err_gpio;
> -
>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>  		if (ret < 0)
>  			goto err_gpio;
> 
