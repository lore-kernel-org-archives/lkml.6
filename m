Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5573CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D4420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U3f9+gUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D4420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeFTOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:30:42 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:52008 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:30:40 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5F52D1E04FD;
        Wed, 20 Jun 2018 16:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529505038; bh=B1zDmxHdlXsJVu+bI5ibijsP6NaXydHeyNmgJP5MhiQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=U3f9+gUwUhskeeA0PDH/dD8y7FF7uVeSnvTmnL7oHaeZPX4W/siizywfsewe1I3Z0
         c0N50mdcBs/5tMbNqrxUY59YZSCBQYwgC8fNwp8hnmVBahBdKv9XR5CUM8YCvfmWvD
         8uy+6h7C4h54urLChW+JLfRGjQ0FMB3rVBB8K7ByxxrqyZ0tf12mVF30BHVwFaHZxQ
         dChIww+1Hmyh7+wS0yrvTYD5Yzub19dTXgK27wjYJ6ea+95dtfpx7ZA+Z6DPbNswbp
         UCiWNK9ewJ3FLezzdxuLUe0Uemc4Z2JLl6+jmwGcyN8foWqYhsfg+8Kv/YzuId4v+X
         aTq8Ywg98v3Rg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 700FB5F42;
        Wed, 20 Jun 2018 07:30:37 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 07:30:37 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 16:30:35 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 16:30:34 +0200
Subject: Re: [PATCH v4 09/10] pci_endpoint_test: Add 2 ioctl commands
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
 <b10530671bdcda8b9d2bb25048ad9048f814c608.1529329262.git.gustavo.pimentel@synopsys.com>
 <327bcbd0-b2a0-d1eb-5471-e6e63169fc8d@ti.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <f6335b77-186e-9df9-bcc6-bbc9a31c87b9@synopsys.com>
Date:   Wed, 20 Jun 2018 15:28:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <327bcbd0-b2a0-d1eb-5471-e6e63169fc8d@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/06/2018 08:58, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:
>>  - New patch file created base on the previous patch
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following
>> Kishon's suggestion.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>>
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
>>  2 files changed, 132 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>> index fdfa0f6..58ccca4 100644
>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>> @@ -28,6 +28,9 @@ ioctl
>>  	      to be tested should be passed as argument.
>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>  	      to be tested should be passed as argument.
>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>  		as argument.
>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 8d15dbe..df2017f 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	for (i = 0; i < test->num_irqs; i++)
>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
>> +
>> +	test->num_irqs = 0;
>> +}
>> +
>> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int irq = -1;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +	bool res = true;
>> +
>> +	switch (irq_type) {
>> +	case IRQ_TYPE_LEGACY:
>> +		irq = 0;
>> +		break;
>> +	case IRQ_TYPE_MSI:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI interrupts\n");
>> +		break;
>> +	case IRQ_TYPE_MSIX:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid IRQ type selected\n");
>> +	}
>> +
>> +	if (irq < 0) {
>> +		irq = 0;
>> +		res = false;
>> +	}
>> +	test->num_irqs = irq;
>> +
>> +	return res;
>> +}
>> +
>> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +
>> +	pci_disable_msi(pdev);
>> +	pci_disable_msix(pdev);
>> +}
>> +
>> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	int err;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
>> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +	if (err) {
>> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
>> +		return false;
>> +	}
>> +
>> +	for (i = 1; i < test->num_irqs; i++) {
>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>> +				       pci_endpoint_test_irqhandler,
>> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +		if (err)
>> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
>> +				pci_irq_vector(pdev, i),
>> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>  				  enum pci_barno barno)
>>  {
>> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>  	return ret;
>>  }
>>  
>> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>> +				      int req_irq_type)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
>> +		dev_err(dev, "Invalid IRQ type option\n");
>> +		return false;
>> +	}
>> +
>> +	if (irq_type == req_irq_type)
>> +		return true;
>> +
>> +	irq_type = req_irq_type;
>> +
>> +	pci_endpoint_test_free_irq_vectors(test);
>> +	pci_endpoint_test_release_irq(test);
>> +
>> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
>> +
>> +	if (!pci_endpoint_test_request_irq(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>  				    unsigned long arg)
>>  {
>> @@ -471,6 +584,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>  	case PCITEST_COPY:
>>  		ret = pci_endpoint_test_copy(test, arg);
>>  		break;
>> +	case PCITEST_SET_IRQTYPE:
>> +		ret = pci_endpoint_test_set_irq(test, arg);
>> +		break;
>> +	case PCITEST_GET_IRQTYPE:
>> +		ret = irq_type;
> 
> Can't the set_irq be done as part of raise irq itself?

That could work for the legacy/MSI/MSI-X tests, but not for the Write/Read/Copy
tests... From what I saw, it was possible to perform Write/Read/Copy tests with
either legacy or MSI on the previous version. I'm assuming that you don't wanna
to lose that functionalities, right?

Regards,
Gustavo

> 
> Thanks
> Kishon
> 

