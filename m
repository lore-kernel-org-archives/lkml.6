Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984B120871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WXxV4yJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984B120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeFTJ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:27:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43192 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754529AbeFTJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:26:57 -0400
X-Greylist: delayed 9552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 05:26:57 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5K7w7Ax114547;
        Wed, 20 Jun 2018 02:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529481487;
        bh=Sj9Zron9LpmFSVfEQJp650LzpG1ppzimjHmYGN6MqNw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=WXxV4yJhs/28Xyub+BIsQtcFiOsc+tPbNI+My5UVrI566z44zlW0cAPAP8iq6akV1
         I1c2+7sYM8r1TafpytF6p1sArHvYlpqBaPN5AceQeoAU/znMCkN5pAN5pVfHYYzbIO
         z0TBU/f+zLXrLmVy1n5SpBNX10LrZVmgnzSW86Gc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K7w7Zb024265;
        Wed, 20 Jun 2018 02:58:07 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 02:58:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 20 Jun 2018 02:58:06 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K7w3QO011791;
        Wed, 20 Jun 2018 02:58:04 -0500
Subject: Re: [PATCH v4 09/10] pci_endpoint_test: Add 2 ioctl commands
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
 <b10530671bdcda8b9d2bb25048ad9048f814c608.1529329262.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <327bcbd0-b2a0-d1eb-5471-e6e63169fc8d@ti.com>
Date:   Wed, 20 Jun 2018 13:28:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <b10530671bdcda8b9d2bb25048ad9048f814c608.1529329262.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
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
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
>  2 files changed, 132 insertions(+), 48 deletions(-)
> 
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
> index 8d15dbe..df2017f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
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
> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
> +{
> +	int irq = -1;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	bool res = true;
> +
> +	switch (irq_type) {
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
> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
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
> +	irq_type = req_irq_type;
> +
> +	pci_endpoint_test_free_irq_vectors(test);
> +	pci_endpoint_test_release_irq(test);
> +
> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}
> +
> +	if (!pci_endpoint_test_request_irq(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
>  {
> @@ -471,6 +584,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	case PCITEST_COPY:
>  		ret = pci_endpoint_test_copy(test, arg);
>  		break;
> +	case PCITEST_SET_IRQTYPE:
> +		ret = pci_endpoint_test_set_irq(test, arg);
> +		break;
> +	case PCITEST_GET_IRQTYPE:
> +		ret = irq_type;

Can't the set_irq be done as part of raise irq itself?

Thanks
Kishon
