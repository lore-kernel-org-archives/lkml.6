Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F1AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446A20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e1+pZD6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1446A20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeFTKiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:38:24 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54912 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbeFTKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:38:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5K7s4ZQ014509;
        Wed, 20 Jun 2018 02:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529481244;
        bh=cuV0VxwoPm/YYzCp9V9lz0HOxMnHjizrx1IWDtvSZsM=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=e1+pZD6dUM4N8Ql6NoFpkwKxGK1ycCpUxzlFqHUuazKrBpH/AECegUT1Edjv4931t
         M5v2uYxL22qGEcekZYZzpvVdiR2Ys18UUf9CJmHP22HJt66VeLnyjbmr519d82goSL
         VFtXVX0nQyXWoeCrk1Hue7twbrseN5YekI+FdLms=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K7s30I022804;
        Wed, 20 Jun 2018 02:54:03 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 02:54:03 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 20 Jun 2018 02:54:03 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K7rxi9007994;
        Wed, 20 Jun 2018 02:54:00 -0500
Subject: Re: [PATCH v4 06/10] pci-epf-test/pci_endpoint_test: Cleanup
 PCI_ENDPOINT_TEST memspace
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
 <13077810f3630c01835041e41b338dd85fa91953.1529329262.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <eea616bd-a5dd-f8bb-22b3-319401c70cc6@ti.com>
Date:   Wed, 20 Jun 2018 13:23:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <13077810f3630c01835041e41b338dd85fa91953.1529329262.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
> Cleanup PCI_ENDPOINT_TEST memspace (by moving the interrupt number away
> from command section).
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v2->v3:
>  - New patch file created base on the previous patch
> "misc: pci_endpoint_test: Add MSI-X support" patch file following
> Kishon's suggestion.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> 
>  drivers/misc/pci_endpoint_test.c              | 84 ++++++++++++++++-----------
>  drivers/pci/endpoint/functions/pci-epf-test.c | 60 ++++++++++++-------
>  2 files changed, 91 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 7b37046..56be808 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -35,38 +35,42 @@
>  
>  #include <uapi/linux/pcitest.h>
>  
> -#define DRV_MODULE_NAME			"pci-endpoint-test"
> -
> -#define PCI_ENDPOINT_TEST_MAGIC		0x0
> -
> -#define PCI_ENDPOINT_TEST_COMMAND	0x4
> -#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
> -#define COMMAND_RAISE_MSI_IRQ		BIT(1)
> -#define MSI_NUMBER_SHIFT		2
> -/* 6 bits for MSI number */
> -#define COMMAND_READ                    BIT(8)
> -#define COMMAND_WRITE                   BIT(9)
> -#define COMMAND_COPY                    BIT(10)
> -
> -#define PCI_ENDPOINT_TEST_STATUS	0x8
> -#define STATUS_READ_SUCCESS             BIT(0)
> -#define STATUS_READ_FAIL                BIT(1)
> -#define STATUS_WRITE_SUCCESS            BIT(2)
> -#define STATUS_WRITE_FAIL               BIT(3)
> -#define STATUS_COPY_SUCCESS             BIT(4)
> -#define STATUS_COPY_FAIL                BIT(5)
> -#define STATUS_IRQ_RAISED               BIT(6)
> -#define STATUS_SRC_ADDR_INVALID         BIT(7)
> -#define STATUS_DST_ADDR_INVALID         BIT(8)
> -
> -#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
> +#define DRV_MODULE_NAME				"pci-endpoint-test"
> +
> +#define IRQ_TYPE_LEGACY				0
> +#define IRQ_TYPE_MSI				1
> +
> +#define PCI_ENDPOINT_TEST_MAGIC			0x0
> +
> +#define PCI_ENDPOINT_TEST_COMMAND		0x4
> +#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
> +#define COMMAND_RAISE_MSI_IRQ			BIT(1)

Maybe you can add a comment here that BIT(2) is reserved for MSIX support
> +#define COMMAND_READ				BIT(3)
> +#define COMMAND_WRITE				BIT(4)
> +#define COMMAND_COPY				BIT(5)
> +
> +#define PCI_ENDPOINT_TEST_STATUS		0x8
> +#define STATUS_READ_SUCCESS			BIT(0)
> +#define STATUS_READ_FAIL			BIT(1)
> +#define STATUS_WRITE_SUCCESS			BIT(2)
> +#define STATUS_WRITE_FAIL			BIT(3)
> +#define STATUS_COPY_SUCCESS			BIT(4)
> +#define STATUS_COPY_FAIL			BIT(5)
> +#define STATUS_IRQ_RAISED			BIT(6)
> +#define STATUS_SRC_ADDR_INVALID			BIT(7)
> +#define STATUS_DST_ADDR_INVALID			BIT(8)
> +
> +#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>  
>  #define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
>  #define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
>  
> -#define PCI_ENDPOINT_TEST_SIZE		0x1c
> -#define PCI_ENDPOINT_TEST_CHECKSUM	0x20
> +#define PCI_ENDPOINT_TEST_SIZE			0x1c
> +#define PCI_ENDPOINT_TEST_CHECKSUM		0x20
> +
> +#define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24

Is this not redundant? COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ already
indicates the irq type to be used.
> +#define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
> @@ -179,6 +183,9 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  {
>  	u32 val;
>  
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> +				 IRQ_TYPE_LEGACY);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);

Not sure if the above writes are really required.
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_RAISE_LEGACY_IRQ);
>  	val = wait_for_completion_timeout(&test->irq_raised,
> @@ -190,20 +197,22 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  }
>  
>  static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> -				      u8 msi_num)
> +				      u8 irq_num)

why do you want to rename this?

Thanks
Kishon
