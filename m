Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD50ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFEE2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CiVwHamj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFEE2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbeGMIOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:14:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbeGMIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:14:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6D80PKp042429;
        Fri, 13 Jul 2018 03:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531468825;
        bh=uxoeO0vZGY/8iyLscYAVjKyNfAu0053q2caeIbeZzHM=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=CiVwHamjDOAxw58tEuidAVXpoZkdGZ3nbNYHTUGPwDfpFlp0JlANvBa0T5VP+4idR
         4kexVwQnf+4GefsP3+aNZ3lts816LRpMwW2w519e+11Qy+2v0jmiX/9AXFUXzQATsu
         qSWMXliS+QcEE9IH78lM06T6xpdy67NIHwqVkJy0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D80PCs004210;
        Fri, 13 Jul 2018 03:00:25 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 13
 Jul 2018 03:00:25 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 13 Jul 2018 03:00:25 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D80LDV032044;
        Fri, 13 Jul 2018 03:00:22 -0500
Subject: Re: [PATCH v9 08/12] pci-epf-test/pci_endpoint_test: Use irq_type
 module parameter
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <1390280769246adf7bd7339d210cf8541b74b9ef.1531155252.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ec3a8dd2-77d4-9c02-7fd5-60ae045dbdc7@ti.com>
Date:   Fri, 13 Jul 2018 13:30:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1390280769246adf7bd7339d210cf8541b74b9ef.1531155252.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 09 July 2018 11:12 PM, Gustavo Pimentel wrote:
> Add new driver parameter to allow interruption type selection.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v2->v3:
>  - New patch file created base on the previous patch
> "misc: pci_endpoint_test: Add MSI-X support" patch file following
> Kishon's suggestion.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Nothing changed, just to follow the patch set version.
> Change v6->v7:
>  - Removed unnecessary set to zero variable.
>  - Removed empty line.
> Change v7->v8:
>  - Re-sending the patch series.
> Change v8->v9:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/misc/pci_endpoint_test.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 35fbfbd..349794c 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -82,6 +82,10 @@ static bool no_msi;
>  module_param(no_msi, bool, 0444);
>  MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>  
> +static int irq_type = IRQ_TYPE_MSI;
> +module_param(irq_type, int, 0444);
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
> +
>  enum pci_barno {
>  	BAR_0,
>  	BAR_1,
> @@ -108,7 +112,7 @@ struct pci_endpoint_test {
>  struct pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	bool no_msi;
> +	int irq_type;
>  };
>  
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -291,8 +295,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
>  				 size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_COPY);
> @@ -361,8 +364,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_READ);
> @@ -419,8 +421,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_WRITE);
> @@ -505,11 +506,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	test->alignment = 0;
>  	test->pdev = pdev;
>  
> +	if (no_msi)
> +		irq_type = IRQ_TYPE_LEGACY;
> +
>  	data = (struct pci_endpoint_test_data *)ent->driver_data;
>  	if (data) {
>  		test_reg_bar = data->test_reg_bar;
>  		test->alignment = data->alignment;
> -		no_msi = data->no_msi;
> +		irq_type = data->irq_type;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -529,11 +533,17 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	if (!no_msi) {
> +	switch (irq_type) {
> +	case IRQ_TYPE_LEGACY:
> +		break;
> +	case IRQ_TYPE_MSI:
>  		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>  		if (irq < 0)
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  		test->num_irqs = irq;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid IRQ type selected\n");
>  	}
>  
>  	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
> 
