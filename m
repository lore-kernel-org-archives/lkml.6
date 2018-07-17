Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E304ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C6320BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D6ekDXua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C6320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQDOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:14:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60234 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbeGQDO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:14:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6H2hvjm126570;
        Mon, 16 Jul 2018 21:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531795437;
        bh=IYtIsvV749u9E5GpTQr3LWk0+9eUaA6E7GtYMxW0iTo=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=D6ekDXuaV4sQZzBkSjfpD31j1h1FrdhUMpsMv2ZRvlsFc2cn0jhX544e3Fw02CYLv
         ajjtAjtTeoM0GycrbZwi5jn2mVRJeozScV3JSxYmtuMBd3BsLMUjFse8rMd2mX4D/S
         y6D4IVwJ7Wua1z9sba8Bh6iEFKJglPFnirNKzwaI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H2hvOv008139;
        Mon, 16 Jul 2018 21:43:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 21:43:56 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 21:43:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6H2hrlE024063;
        Mon, 16 Jul 2018 21:43:54 -0500
Subject: Re: [PATCH v11 10/12] pci_endpoint_test: Add 2 ioctl commands
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <joao.pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
 <0dc487515e28a6cd790888cb98f84fb7ea3a412e.1531751641.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fe9da184-e085-05d2-2c12-4dc50633736f@ti.com>
Date:   Tue, 17 Jul 2018 08:13:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0dc487515e28a6cd790888cb98f84fb7ea3a412e.1531751641.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Monday 16 July 2018 08:22 PM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
> 
> Add IRQ type validation before executing the READ/WRITE/COPY tests.
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
>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
> from patch #10 to here.
>  - Increased ioctl parameters range associated to
> drivers/misc/pci_endpoint_test.c driver.
> Change v6->v7:
>  - irq_type variable update just before returning the function.
> Change v7->v8:
>  - Re-sending the patch series.
> Change v8->v9:
>  - Added a extra parameter to pci_endpoint_test_alloc_irq_vectors,
> that specifies which irq type should be allocated.
> Change v9->v10:
>  - Fixed bug, report available: https://lkml.org/lkml/2018/7/16/11
>  - Added IRQ type validation before executing the READ/WRITE/COPY
> tests.
> 
>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 192 +++++++++++++++++------
>  include/uapi/linux/pcitest.h                     |   2 +
>  4 files changed, 152 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 65259d4..c15c4f3 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>  'P'	all	linux/soundcard.h	conflict!
>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>  'Q'	all	linux/soundcard.h
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
> index fdfa0f6..58ccca4 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -28,6 +28,9 @@ ioctl
>  	      to be tested should be passed as argument.
>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>  	      to be tested should be passed as argument.
> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f4fef10..d909ca5 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -37,6 +37,7 @@
>  
>  #define DRV_MODULE_NAME				"pci-endpoint-test"
>  
> +#define IRQ_TYPE_UNDEFINED			-1
>  #define IRQ_TYPE_LEGACY				0
>  #define IRQ_TYPE_MSI				1
>  #define IRQ_TYPE_MSIX				2
> @@ -157,6 +158,88 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
> +{
> +	int i;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	for (i = 0; i < test->num_irqs; i++)
> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
> +
> +	test->num_irqs = 0;
> +}
> +
> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> +						int type)
> +{
> +	int irq = -1;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	bool res = true;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEGACY:
> +		irq = 0;
> +		break;
> +	case IRQ_TYPE_MSI:
> +		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI interrupts\n");
> +		break;
> +	case IRQ_TYPE_MSIX:
> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +		break;
> +	default:
> +		dev_err(dev, "Invalid IRQ type selected\n");
> +	}
> +
> +	if (irq < 0) {
> +		irq = 0;
> +		res = false;
> +	}
> +	test->num_irqs = irq;
> +
> +	return res;
> +}
> +
> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +
> +	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
> +}
> +
> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> +{
> +	int i;
> +	int err;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
> +	if (err) {
> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
> +		return false;
> +	}
> +
> +	for (i = 1; i < test->num_irqs; i++) {
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> +				       pci_endpoint_test_irqhandler,
> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
> +		if (err)
> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
> +				pci_irq_vector(pdev, i),
> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
> +	}
> +
> +	return true;
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> @@ -247,6 +330,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>  	if (size > SIZE_MAX - alignment)
>  		goto err;
>  
> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		goto err;
> +	}
> +
>  	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
>  					   &orig_src_phys_addr, GFP_KERNEL);
>  	if (!orig_src_addr) {
> @@ -337,6 +425,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>  	if (size > SIZE_MAX - alignment)
>  		goto err;
>  
> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		goto err;
> +	}
> +
>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>  				       GFP_KERNEL);
>  	if (!orig_addr) {
> @@ -400,6 +493,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>  	if (size > SIZE_MAX - alignment)
>  		goto err;
>  
> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		goto err;
> +	}
> +
>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>  				       GFP_KERNEL);
>  	if (!orig_addr) {
> @@ -440,6 +538,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>  	return ret;
>  }
>  
> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> +				      int req_irq_type)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		return false;
> +	}
> +
> +	if (irq_type == req_irq_type)
> +		return true;
> +
> +	pci_endpoint_test_free_irq_vectors(test);
> +	pci_endpoint_test_release_irq(test);
> +
> +	if (!pci_endpoint_test_alloc_irq_vectors(test, req_irq_type))
> +		goto err;
> +
> +	if (!pci_endpoint_test_request_irq(test))
> +		goto err;
> +
> +	irq_type = req_irq_type;
> +	return true;
> +
> +err:
> +	pci_endpoint_test_release_irq(test);

sorry for not noticing this earlier..

pci_endpoint_test_alloc_irq_vectors enables MSI.. I'd have expected
pci_endpoint_test_free_irq_vectors to disable MSI. Similarly
pci_endpoint_test_request_irq requests irq. Ideally
pci_endpoint_test_release_irq should have freed irq. I feel the contents of
pci_endpoint_test_release_irq() and pci_endpoint_test_free_irq_vectors are swapped.

For the patch itself, I have tested it now and the issue I reported earlier is
not seen in this series.

Thanks
Kishon
