Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3788C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9C323FAF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XJzV0t3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9C323FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeGFJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:32:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeGFJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:32:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w669WTKn119725;
        Fri, 6 Jul 2018 04:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530869549;
        bh=raLBUv7vYW8Dg0sYSCkpm+RAK1ktfcCsSKMI6dj8DYQ=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=XJzV0t3jSJ1Usc9KWtx+OXTpj71B1hSxjRBtMnZKdFLMRyjZT0Tg5SLPU96QUGm63
         huzgSEGfRBq/Osi4XU/AxYfh+JKMMTp7pwRRYcziSkAn/vKeHbjh2Kv3ROkdWcGlFf
         wYrieHeWM/Oib0yrmEZXEF0JmB9QZ59AB3GF5BAw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669WTa8028637;
        Fri, 6 Jul 2018 04:32:29 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 04:32:29 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 04:32:29 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669WPXN010842;
        Fri, 6 Jul 2018 04:32:26 -0500
Subject: Re: [PATCH v6 00/11] Add MSI-X support on pcitest tool
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <77139978-65cc-b954-bc61-bebf3bcc67ac@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <284a6871-4687-e437-6876-3cd1e0329cbb@ti.com>
Date:   Fri, 6 Jul 2018 15:02:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <77139978-65cc-b954-bc61-bebf3bcc67ac@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 06 July 2018 02:24 PM, Gustavo Pimentel wrote:
> Hi,
> 
> Just a gentle reminder.

sorry for the delay. I've now reviewed the pending patches.

Thanks
Kishon

> 
> Thanks.
> 
> On 21/06/2018 17:01, Gustavo Pimentel wrote:
>> Patch series made against Lorenzo's master branch.
>>
>> Add MSI-X support on pcitest tool.
>>
>> Add new callbacks methods and handlers to trigger the MSI-X interrupts
>> on the EP DesignWare IP driver.
>>
>> Allow to set/get MSI-X EP maximum capability number.
>>
>> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
>>
>> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
>>
>> Update the pcitest.sh script to support MSI-X feature tests.
>>
>> Gustavo Pimentel (11):
>>   PCI: endpoint: Add MSI-X interfaces
>>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>>   PCI: dwc: Add MSI-X callbacks handler
>>   PCI: dwc: Rework MSI callbacks handler
>>   PCI: dwc: Add legacy interrupt callback handler
>>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>>   pci_endpoint_test: Add 2 ioctl commands
>>   tools: PCI: Add MSI-X support
>>   PCI: endpoint: Add MSI set maximum restriction.
>>
>>  Documentation/ioctl/ioctl-number.txt              |   1 +
>>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>>  drivers/misc/pci_endpoint_test.c                  | 259 ++++++++++++++++------
>>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++--
>>  drivers/pci/controller/dwc/pcie-designware-plat.c |   7 +-
>>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>>  drivers/pci/endpoint/functions/pci-epf-test.c     |  81 +++++--
>>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>>  include/linux/pci-epc.h                           |  15 +-
>>  include/linux/pci-epf.h                           |   1 +
>>  include/uapi/linux/pcitest.h                      |   3 +
>>  tools/pci/pcitest.c                               |  51 ++++-
>>  tools/pci/pcitest.sh                              |  15 ++
>>  18 files changed, 644 insertions(+), 132 deletions(-)
>>
> 
