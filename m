Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD9C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D823F73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vLftu1/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940D823F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeGFJWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:22:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47400 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeGFJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:22:18 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w669M2jM012122;
        Fri, 6 Jul 2018 04:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530868922;
        bh=reOWVxdk32ZEXuGxlcxv3UJnLVk8y2qi58MMVeXEpXc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=vLftu1/kY7aKAPibu81DbxhpnxMgNsflQONf17BsDs8NQ8vlW1XgTAtl38yGqrH+8
         b6dJBgocucRPItSuI50Q+ChLUAzvKGsyWfhw/103tuqoDySE8SGUs7JxHU3WIKUH0r
         2e0OANSuNpCqWTbreDempVQJZSrKbe//bAE5JDk4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669M2c5010975;
        Fri, 6 Jul 2018 04:22:02 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 04:22:01 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 04:22:01 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669Lw9f000391;
        Fri, 6 Jul 2018 04:21:58 -0500
Subject: Re: [PATCH v6 08/11] pci-epf-test/pci_endpoint_test: Add MSI-X
 support
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <72576b96a48c6d50d69ed6b0621a508f620de2a7.1529595907.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <33247760-36f6-d30f-6108-73bd768633ed@ti.com>
Date:   Fri, 6 Jul 2018 14:51:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <72576b96a48c6d50d69ed6b0621a508f620de2a7.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
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
>  - Moved PCITEST_MSIX ioctl entry from patch #10 to here.
>  - Documented ioctl parameter type associated to
> drivers/misc/pci_endpoint_test.c driver.
> 
>  Documentation/ioctl/ioctl-number.txt             |  1 +
>  Documentation/misc-devices/pci-endpoint-test.txt |  3 +++
>  drivers/misc/pci_endpoint_test.c                 | 29 +++++++++++++++++-------
>  drivers/pci/endpoint/functions/pci-epf-test.c    | 24 ++++++++++++++++++--
>  include/uapi/linux/pcitest.h                     |  1 +
>  5 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 480c860..65259d4 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -166,6 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>  'P'	all	linux/soundcard.h	conflict!
>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
> +'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
>  'Q'	all	linux/soundcard.h
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
> index 4ebc359..fdfa0f6 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -10,6 +10,7 @@ The PCI driver for the test device performs the following tests
>  	*) verifying addresses programmed in BAR
>  	*) raise legacy IRQ
>  	*) raise MSI IRQ
> +	*) raise MSI-X IRQ
>  	*) read data
>  	*) write data
>  	*) copy data
> @@ -25,6 +26,8 @@ ioctl
>   PCITEST_LEGACY_IRQ: Tests legacy IRQ
>   PCITEST_MSI: Tests message signalled interrupts. The MSI number
>  	      to be tested should be passed as argument.
> + PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
> +	      to be tested should be passed as argument.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 4d2c9cb..2b58887 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -39,13 +39,14 @@
>  
>  #define IRQ_TYPE_LEGACY				0
>  #define IRQ_TYPE_MSI				1
> +#define IRQ_TYPE_MSIX				2
>  
>  #define PCI_ENDPOINT_TEST_MAGIC			0x0
>  
>  #define PCI_ENDPOINT_TEST_COMMAND		0x4
>  #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ			BIT(1)
> -/* BIT(2) is reserved for raising MSI-X IRQ command */
> +#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
>  #define COMMAND_READ				BIT(3)
>  #define COMMAND_WRITE				BIT(4)
>  #define COMMAND_COPY				BIT(5)
> @@ -84,7 +85,7 @@ MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>  
>  static int irq_type = IRQ_TYPE_MSI;
>  module_param(irq_type, int, 0444);
> -MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
>  
>  enum pci_barno {
>  	BAR_0,
> @@ -202,16 +203,18 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  }
>  
>  static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> -				      u8 msi_num)
> +				       u16 msi_num, bool msix)
>  {
>  	u32 val;
>  	struct pci_dev *pdev = test->pdev;
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 IRQ_TYPE_MSI);
> +				 msix == false ? IRQ_TYPE_MSI :
> +				 IRQ_TYPE_MSIX);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_RAISE_MSI_IRQ);
> +				 msix == false ? COMMAND_RAISE_MSI_IRQ :
> +				 COMMAND_RAISE_MSIX_IRQ);
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -456,7 +459,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  		ret = pci_endpoint_test_legacy_irq(test);
>  		break;
>  	case PCITEST_MSI:
> -		ret = pci_endpoint_test_msi_irq(test, arg);
> +	case PCITEST_MSIX:
> +		ret = pci_endpoint_test_msi_irq(test, arg, cmd == PCITEST_MSIX);
>  		break;
>  	case PCITEST_WRITE:
>  		ret = pci_endpoint_test_write(test, arg);
> @@ -543,6 +547,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  		test->num_irqs = irq;
>  		break;
> +	case IRQ_TYPE_MSIX:
> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +		test->num_irqs = irq;
> +		break;
>  	default:
>  		dev_err(dev, "Invalid IRQ type selected\n");
>  	}
> @@ -560,8 +570,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				       pci_endpoint_test_irqhandler,
>  				       IRQF_SHARED, DRV_MODULE_NAME, test);
>  		if (err)
> -			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
> -				pci_irq_vector(pdev, i), i + 1);
> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
> +				pci_irq_vector(pdev, i),
> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> @@ -627,6 +638,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  err_disable_msi:
>  	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
>  	pci_release_regions(pdev);
>  
>  err_disable_pdev:
> @@ -658,6 +670,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  	for (i = 0; i < test->num_irqs; i++)
>  		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>  	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
>  }
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index eb9cd00..bfef6d1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -20,10 +20,11 @@
>  
>  #define IRQ_TYPE_LEGACY			0
>  #define IRQ_TYPE_MSI			1
> +#define IRQ_TYPE_MSIX			2
>  
>  #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
> -/* BIT(2) is reserved for raising MSI-X IRQ command */
> +#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
>  #define COMMAND_READ			BIT(3)
>  #define COMMAND_WRITE			BIT(4)
>  #define COMMAND_COPY			BIT(5)
> @@ -266,6 +267,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
>  	case IRQ_TYPE_MSI:
>  		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
>  		break;
> +	case IRQ_TYPE_MSIX:
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX, irq);
> +		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
>  		break;
> @@ -292,7 +296,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	reg->command = 0;
>  	reg->status = 0;
>  
> -	if (reg->irq_type > IRQ_TYPE_MSI) {
> +	if (reg->irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;
>  	}
> @@ -346,6 +350,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		goto reset_handler;
>  	}
>  
> +	if (command & COMMAND_RAISE_MSIX_IRQ) {
> +		count = pci_epc_get_msix(epc, epf->func_no);
> +		if (reg->irq_number > count || count <= 0)
> +			goto reset_handler;
> +		reg->status = STATUS_IRQ_RAISED;
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX,
> +				  reg->irq_number);
> +		goto reset_handler;
> +	}
> +
>  reset_handler:
>  	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>  			   msecs_to_jiffies(1));
> @@ -481,6 +495,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  		return ret;
>  	}
>  
> +	ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
> +	if (ret) {
> +		dev_err(dev, "MSI-X configuration failed\n");
> +		return ret;
> +	}

This will break existing platforms using designware IP but doesn't support
MSIX. Either we should use epc->features or return 0 in set_msix callback if
msix capability is not present.

Thanks
Kishon
