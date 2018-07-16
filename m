Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA8F208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vmCtlqhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA8F208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeGPEdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:33:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37892 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeGPEdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:33:19 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6G47dCf001096;
        Sun, 15 Jul 2018 23:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531714059;
        bh=8ECphnHKzNmGtvMBcvVsbUpeSR2t31xtgl7GgHnpMuc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=vmCtlqhV9KIzwoNxuXrZYO1gwDMKAzGg/A7oRs7wdJZ/mtEnTMaB3kcdLc6iMTwPk
         tmjyRJrUnVK0hOavWhae6D5DvtJ3MPLzbNWZrIUwsC00FMOmnMeOu4UU4dwJ83HdKW
         ZaA4dz/MyeIm0yLc6tfchcWaeWnBdamlU/6vK0Bs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6G47dRP031661;
        Sun, 15 Jul 2018 23:07:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 15
 Jul 2018 23:07:38 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 15 Jul 2018 23:07:38 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6G47YlG006835;
        Sun, 15 Jul 2018 23:07:35 -0500
Subject: Re: [PATCH v9 00/12] Add MSI-X support on pcitest tool
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <20180713132513.GD18515@red-moon>
 <aabf72f0-e325-b5d2-0d2e-048acb6c1721@synopsys.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cf97fd13-568b-cd45-fcfb-f91d52a907bf@ti.com>
Date:   Mon, 16 Jul 2018 09:37:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <aabf72f0-e325-b5d2-0d2e-048acb6c1721@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 13 July 2018 09:29 PM, Gustavo Pimentel wrote:
> Hi Lorenzo,
> 
> On 13/07/2018 14:25, Lorenzo Pieralisi wrote:
>> On Mon, Jul 09, 2018 at 06:42:38PM +0100, Gustavo Pimentel wrote:
>>> Patch series made against Lorenzo's master branch.
>>>
>>> Fix EP link notification implementation.
>>>
>>> Add MSI-X support on pcitest tool.
>>>
>>> Add new callbacks methods and handlers to trigger the MSI-X interrupts
>>> on the EP DesignWare IP driver.
>>>
>>> Allow to set/get MSI-X EP maximum capability number.
>>>
>>> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
>>>
>>> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
>>>
>>> Update the pcitest.sh script to support MSI-X feature tests.
>>>
>>> Gustavo Pimentel (12):
>>>   PCI: dwc: Fix EP link notification implementation
>>>   PCI: endpoint: Add MSI-X interfaces
>>>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>>>   PCI: dwc: Add MSI-X callbacks handler
>>>   PCI: dwc: Rework MSI callbacks handler
>>>   PCI: dwc: Add legacy interrupt callback handler
>>>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>>>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>>>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>>>   pci_endpoint_test: Add 2 ioctl commands
>>>   tools: PCI: Add MSI-X support
>>>   PCI: endpoint: Add MSI set maximum restriction
>>>
>>>  Documentation/PCI/endpoint/pci-test-function.txt  |   8 +-
>>>  Documentation/ioctl/ioctl-number.txt              |   1 +
>>>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>>>  drivers/misc/pci_endpoint_test.c                  | 260 ++++++++++++++++------
>>>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>>>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 217 ++++++++++++++++--
>>>  drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +-
>>>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>>>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>>>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>>>  drivers/pci/endpoint/functions/pci-epf-test.c     |  86 +++++--
>>>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>>>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>>>  include/linux/pci-epc.h                           |  16 +-
>>>  include/linux/pci-epf.h                           |   1 +
>>>  include/uapi/linux/pcitest.h                      |   3 +
>>>  tools/pci/pcitest.c                               |  51 ++++-
>>>  tools/pci/pcitest.sh                              |  15 ++
>>>  19 files changed, 664 insertions(+), 143 deletions(-)
>>
>> Gustavo, Kishon,
>>
>> it seems like this series has been thoroughly reviewed and it is
>> ready to go, please let me know if there is any pending change.
> 
> I just sent the patch # 10 based on Kishon's latest review.
> For me it's nearly perfect. :)

I got to test this series today and I found one issue.

use this sequence:
1) pcitest -i 2 /* change to MSIX irq type */
   For platforms that doesn't support MSIX, get the following message
   pci-endpoint-test 0000:01:00.0: Failed to get MSI-X interrupts
   SET IRQ TYPE TO MSI-X:          NOT OKAY

   However after this, pci_endpoint_test_set_irq() will invoke
   pci_endpoint_test_free_irq_vectors() and pci_endpoint_test_release_irq().
   This will free previously allocated MSI irq vectors.

2) pcitest -i 1 /* change to MSI irq type */

   This will not invoke pci_endpoint_test_alloc_irq_vectors() and
   pci_endpoint_test_request_irq() since now "if (irq_type == req_irq_type)"
   will return true.

   After this MSI tests will fail.

Other than this failing sequence, the series looks good to me.

Thanks
Kishon
