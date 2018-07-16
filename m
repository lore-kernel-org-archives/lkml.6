Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B820856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vf/57wc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724B820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeGPPTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:19:48 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39696 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeGPPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:19:48 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 117F724E23D4;
        Mon, 16 Jul 2018 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531752721; bh=ElYhwSZ6ZZjNb9gBxGqnV/QCeIRLJyFprwacurdmIek=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Vf/57wc8sZ6/tQYGIaBhW1bmWnPUx/9N3L0QanpDnByaQw1DqmLcDSgSM1bjf3TeP
         HOHTXXrV8YAUGcbjdeiwPZETYj8F6V3Kw6wsrDQYbPo9ABrW9ONe1cW9BkXT1DRy5C
         4YjtqgJ4ExbDcSGOT7u5/tP3jNBhvl3LPeD7xxQ/MbXj3BzceLyL40t6k5tOT77ov1
         yCfPRwpU/ow/IzDN70C73KWCk04j5ogPmZ/PwOe8RLg/ug/VdXMS/yNTIFF4U41wi7
         s7Aw4F8+OEkze77ckoiVdbTjInZ9YlfYAt1Qq5lBCKcW/LKuBpc8/32Qk20Un8VUp5
         pgd9S7xhc+/sQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7132F3C25;
        Mon, 16 Jul 2018 07:52:00 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 16 Jul 2018 07:52:00 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 16 Jul 2018 16:51:58 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 16 Jul 2018 16:51:57 +0200
Subject: Re: [PATCH v9 00/12] Add MSI-X support on pcitest tool
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <20180713132513.GD18515@red-moon>
 <aabf72f0-e325-b5d2-0d2e-048acb6c1721@synopsys.com>
 <cf97fd13-568b-cd45-fcfb-f91d52a907bf@ti.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <77bb1aa0-da1f-be70-b0fe-beeceb544e8e@synopsys.com>
Date:   Mon, 16 Jul 2018 15:49:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cf97fd13-568b-cd45-fcfb-f91d52a907bf@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 16/07/2018 05:07, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 13 July 2018 09:29 PM, Gustavo Pimentel wrote:
>> Hi Lorenzo,
>>
>> On 13/07/2018 14:25, Lorenzo Pieralisi wrote:
>>> On Mon, Jul 09, 2018 at 06:42:38PM +0100, Gustavo Pimentel wrote:
>>>> Patch series made against Lorenzo's master branch.
>>>>
>>>> Fix EP link notification implementation.
>>>>
>>>> Add MSI-X support on pcitest tool.
>>>>
>>>> Add new callbacks methods and handlers to trigger the MSI-X interrupts
>>>> on the EP DesignWare IP driver.
>>>>
>>>> Allow to set/get MSI-X EP maximum capability number.
>>>>
>>>> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
>>>>
>>>> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
>>>>
>>>> Update the pcitest.sh script to support MSI-X feature tests.
>>>>
>>>> Gustavo Pimentel (12):
>>>>   PCI: dwc: Fix EP link notification implementation
>>>>   PCI: endpoint: Add MSI-X interfaces
>>>>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>>>>   PCI: dwc: Add MSI-X callbacks handler
>>>>   PCI: dwc: Rework MSI callbacks handler
>>>>   PCI: dwc: Add legacy interrupt callback handler
>>>>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>>>>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>>>>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>>>>   pci_endpoint_test: Add 2 ioctl commands
>>>>   tools: PCI: Add MSI-X support
>>>>   PCI: endpoint: Add MSI set maximum restriction
>>>>
>>>>  Documentation/PCI/endpoint/pci-test-function.txt  |   8 +-
>>>>  Documentation/ioctl/ioctl-number.txt              |   1 +
>>>>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>>>>  drivers/misc/pci_endpoint_test.c                  | 260 ++++++++++++++++------
>>>>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>>>>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>>>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 217 ++++++++++++++++--
>>>>  drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +-
>>>>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>>>>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>>>>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>>>>  drivers/pci/endpoint/functions/pci-epf-test.c     |  86 +++++--
>>>>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>>>>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>>>>  include/linux/pci-epc.h                           |  16 +-
>>>>  include/linux/pci-epf.h                           |   1 +
>>>>  include/uapi/linux/pcitest.h                      |   3 +
>>>>  tools/pci/pcitest.c                               |  51 ++++-
>>>>  tools/pci/pcitest.sh                              |  15 ++
>>>>  19 files changed, 664 insertions(+), 143 deletions(-)
>>>
>>> Gustavo, Kishon,
>>>
>>> it seems like this series has been thoroughly reviewed and it is
>>> ready to go, please let me know if there is any pending change.
>>
>> I just sent the patch # 10 based on Kishon's latest review.
>> For me it's nearly perfect. :)
> 
> I got to test this series today and I found one issue.
> 
> use this sequence:
> 1) pcitest -i 2 /* change to MSIX irq type */
>    For platforms that doesn't support MSIX, get the following message
>    pci-endpoint-test 0000:01:00.0: Failed to get MSI-X interrupts
>    SET IRQ TYPE TO MSI-X:          NOT OKAY
> 
>    However after this, pci_endpoint_test_set_irq() will invoke
>    pci_endpoint_test_free_irq_vectors() and pci_endpoint_test_release_irq().
>    This will free previously allocated MSI irq vectors.
> 
> 2) pcitest -i 1 /* change to MSI irq type */
> 
>    This will not invoke pci_endpoint_test_alloc_irq_vectors() and
>    pci_endpoint_test_request_irq() since now "if (irq_type == req_irq_type)"
>    will return true.
> 
>    After this MSI tests will fail.
> 
> Other than this failing sequence, the series looks good to me.

It's fixed on the patch series v11 (see patch
#10-pci_endpoint_test-Add-2-ioctl-commands.patch file).
Thanks!

> 
> Thanks
> Kishon
> 

Regards,
Gustavo
