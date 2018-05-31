Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755120AbeEaL2B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:28:01 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:47570 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754779AbeEaL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:27:56 -0400
Subject: Re: [PATCH v2 6/7] misc: pci_endpoint_test: Add MSI-X support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <30034b904a27c405b894a34922e59315dcae68ab.1526576613.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2f56cd19-f7a5-c99f-e74f-83a4dbeb0248@ti.com>
Date: Thu, 31 May 2018 16:57:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <30034b904a27c405b894a34922e59315dcae68ab.1526576613.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Add new driver parameter to allow interruption type selection.
> 
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
> 
> Change Legacy/MSI/MSI-X test process, by having in a BAR:
>  - Interrupt type triggered (added).
>  - Interrupt ID number (moved from the command section).
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

It's better to change the subject to pci-epf-test/pci_endpoint_test: Add MSI-X
support

IMO this patch should be split into multiple patches

*) Cleanup PCI_ENDPOINT_TEST memspace (by moving the interrupt number away from
command section)
*) Using irq_type module param
*) Adding MSI-X support
*) adding 2 ioctl commands (I'm not convinced on adding new ioctls though)

Thanks
Kishon
