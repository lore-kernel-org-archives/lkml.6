Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF98C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7671523F3E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Eq3YxajK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7671523F3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGFJEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:04:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57810 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeGFJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:04:40 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6694Tnf056692;
        Fri, 6 Jul 2018 04:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530867869;
        bh=m1K5e7UKXS5eIblLZ7zE+1Tcz8m/JotG/SFsdjbTQFA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Eq3YxajKTF4jU0mnIYXP7iVyMB9J4y3/zsVhvdCDMyvtLzinaLiO1LgagmHOILvrd
         2WKDLOL430jPbDoqpWUiDcnkCT0KsUZha/4R3IaCoDz8b0ujJb6o+crnjNW0bxxJ8e
         lHSmVdrOC+If7BxA8/vucE+yE5q0klUpJzFYfyP0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6694TIF012465;
        Fri, 6 Jul 2018 04:04:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 04:04:29 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 04:04:29 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6694PTw004546;
        Fri, 6 Jul 2018 04:04:26 -0500
Subject: Re: [PATCH v6 07/11] pci-epf-test/pci_endpoint_test: Use irq_type
 module parameter
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <98be2b2cfd6dfb9cdfed95da5fe8cde0a96ce37e.1529595907.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7257e7a6-50be-ee72-776d-41af141739a7@ti.com>
Date:   Fri, 6 Jul 2018 14:34:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <98be2b2cfd6dfb9cdfed95da5fe8cde0a96ce37e.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add new driver parameter to allow interruption type selection.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
> 
>  drivers/misc/pci_endpoint_test.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 35fbfbd..4d2c9cb 100644
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
> @@ -529,13 +533,21 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	if (!no_msi) {
> +	switch (irq_type) {
> +	case IRQ_TYPE_LEGACY:
> +		irq = 0;

Looks like this is not required. irq variable is used only for MSI irq.

Thanks
Kishon
