Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE97C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3F23EF1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RmFzY+kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF3F23EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeGFI5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:57:00 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:58836 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:56:56 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8237C24E21CD;
        Fri,  6 Jul 2018 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530867416; bh=rKWMu6AeIYfwXpM8nAPrQFEOX/tzPQngQBIqlro33Bs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=RmFzY+kvCVRUeuXBTYHOa7ZbFayPy+bFf9rVQ4Ogv6TzspZk9SvIhY0GFNOzLo4sg
         336Sawm+q7r8H1BtV+MtDRbFuIwyWq+QBoCTBslbVafFzI0Mym3J15AQVOEqvm8O16
         qxVQDglf/NtDVu3sxnmjU/4TxpoxRjSu8M2LCBYQVBgeycR+Ki6yN5Rlb9OTWo5XI1
         WPwZza0JGYbpWfVc7r/Im3VqwQLeZk9TzO06r+BBIUOEMuXl8imDntrRxg9frK0eTN
         5ekT5Mb9ABt/nvad13gqAH03KToQ9RlfuBGve6E//h/79NEMRw6KrV44pENi59VSP9
         Q+4hfRSSL4T5g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id A85523C47;
        Fri,  6 Jul 2018 01:56:54 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 01:56:54 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 10:56:52 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 10:56:51 +0200
Subject: Re: [PATCH v6 00/11] Add MSI-X support on pcitest tool
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <77139978-65cc-b954-bc61-bebf3bcc67ac@synopsys.com>
Date:   Fri, 6 Jul 2018 09:54:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a gentle reminder.

Thanks.

On 21/06/2018 17:01, Gustavo Pimentel wrote:
> Patch series made against Lorenzo's master branch.
> 
> Add MSI-X support on pcitest tool.
> 
> Add new callbacks methods and handlers to trigger the MSI-X interrupts
> on the EP DesignWare IP driver.
> 
> Allow to set/get MSI-X EP maximum capability number.
> 
> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
> 
> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
> 
> Update the pcitest.sh script to support MSI-X feature tests.
> 
> Gustavo Pimentel (11):
>   PCI: endpoint: Add MSI-X interfaces
>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>   PCI: dwc: Add MSI-X callbacks handler
>   PCI: dwc: Rework MSI callbacks handler
>   PCI: dwc: Add legacy interrupt callback handler
>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>   pci_endpoint_test: Add 2 ioctl commands
>   tools: PCI: Add MSI-X support
>   PCI: endpoint: Add MSI set maximum restriction.
> 
>  Documentation/ioctl/ioctl-number.txt              |   1 +
>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>  drivers/misc/pci_endpoint_test.c                  | 259 ++++++++++++++++------
>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware-plat.c |   7 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  81 +++++--
>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>  include/linux/pci-epc.h                           |  15 +-
>  include/linux/pci-epf.h                           |   1 +
>  include/uapi/linux/pcitest.h                      |   3 +
>  tools/pci/pcitest.c                               |  51 ++++-
>  tools/pci/pcitest.sh                              |  15 ++
>  18 files changed, 644 insertions(+), 132 deletions(-)
> 

