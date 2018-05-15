Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeEOO2t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:28:49 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbeEOO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:28:46 -0400
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <73eb2628-0d45-f23b-72c2-e463aef71f3f@synopsys.com>
Date: Tue, 15 May 2018 15:28:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: pt-PT
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.88]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jan,

Às 10:07 AM de 5/15/2018, Jan Kiszka escreveu:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/host/pci-aardvark.c        |  2 +-
>  drivers/pci/host/pci-ftpci100.c        |  2 +-
>  drivers/pci/host/pci-v3-semi.c         |  2 +-
>  drivers/pci/host/pci-versatile.c       |  2 +-
>  drivers/pci/host/pci-xgene.c           |  2 +-
>  drivers/pci/host/pcie-altera.c         |  2 +-
>  drivers/pci/host/pcie-iproc-platform.c |  2 +-
>  drivers/pci/host/pcie-rcar.c           |  2 +-
>  drivers/pci/host/pcie-rockchip.c       |  2 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
>  drivers/pci/host/pcie-xilinx.c         |  2 +-
>  drivers/pci/of.c                       | 30 ++++++++++++------------------
>  include/linux/of_pci.h                 |  4 ++--
>  14 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 5a535690b7b5..a8f6ab54b4c0 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -342,7 +342,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>  					&bridge->windows, &pp->io_base);
>  	if (ret)
>  		return ret;

(snip...)

Thanks for this patch!

Acked-by: Joao Pinto <jpinto@synopsys.com>
