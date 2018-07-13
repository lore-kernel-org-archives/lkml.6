Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4056ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDB6208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aIiVB+cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDB6208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:17:41 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35193 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbeGMQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:17:41 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1784010C1A38;
        Fri, 13 Jul 2018 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531497747; bh=/RJyx4VYfKq3BLS6JJuv53CwHgmQ1oEygzz2/MySoTk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=aIiVB+cQPfwYOQ8QRn/nTBSjLJofiJIBE+HNcI0ymlUT4lSPwUPrU/Uy6LKSmFt91
         rZWiVdzd0dKWTCzIE7sNFFA0uyoxaD5DueeueHu5G5ecnL/rmOPhkSK3xd0c34uDV4
         NGKBTV5kPZGd983vAPdCj+5wFimmCrLczJmfs3eGU2NFqo07gljX9ac7T7L+mnZjbg
         7n+J9ofa7u8sdcRMF3paga8wczLfof/RetWYMSp+Y7tkx2vlCPI06uam2l3QK48yO3
         nsNOOYTI6BSyl0GVLW6GQWMHDbAX3TOEvxjuewHHFCLLSDygzaSIVGDKQnONKk6qUk
         QKwSH+RCaOe7A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BF56E3D25;
        Fri, 13 Jul 2018 09:02:14 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 09:02:13 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 18:02:11 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 18:02:10 +0200
Subject: Re: [PATCH v9 00/12] Add MSI-X support on pcitest tool
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "kishon@ti.com" <kishon@ti.com>
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
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <aabf72f0-e325-b5d2-0d2e-048acb6c1721@synopsys.com>
Date:   Fri, 13 Jul 2018 16:59:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180713132513.GD18515@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 13/07/2018 14:25, Lorenzo Pieralisi wrote:
> On Mon, Jul 09, 2018 at 06:42:38PM +0100, Gustavo Pimentel wrote:
>> Patch series made against Lorenzo's master branch.
>>
>> Fix EP link notification implementation.
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
>> Gustavo Pimentel (12):
>>   PCI: dwc: Fix EP link notification implementation
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
>>   PCI: endpoint: Add MSI set maximum restriction
>>
>>  Documentation/PCI/endpoint/pci-test-function.txt  |   8 +-
>>  Documentation/ioctl/ioctl-number.txt              |   1 +
>>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>>  drivers/misc/pci_endpoint_test.c                  | 260 ++++++++++++++++------
>>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 217 ++++++++++++++++--
>>  drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +-
>>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>>  drivers/pci/endpoint/functions/pci-epf-test.c     |  86 +++++--
>>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>>  include/linux/pci-epc.h                           |  16 +-
>>  include/linux/pci-epf.h                           |   1 +
>>  include/uapi/linux/pcitest.h                      |   3 +
>>  tools/pci/pcitest.c                               |  51 ++++-
>>  tools/pci/pcitest.sh                              |  15 ++
>>  19 files changed, 664 insertions(+), 143 deletions(-)
> 
> Gustavo, Kishon,
> 
> it seems like this series has been thoroughly reviewed and it is
> ready to go, please let me know if there is any pending change.

I just sent the patch # 10 based on Kishon's latest review.
For me it's nearly perfect. :)

Gustavo

> 
> Lorenzo
> 

