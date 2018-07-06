Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8252C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E0524018
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tn4pC4jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E0524018
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753732AbeGFKuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:50:16 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60795 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeGFKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:50:13 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 29E7C24E2376;
        Fri,  6 Jul 2018 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530874212; bh=EI60GWRV3FGgqZoRk6pQsrNSo7L6f4GFSodeaYg5vGE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Tn4pC4jFVj6UBO3OpAp072iVfOJeHq95mA7tRgpF2EU7CSVvMTT7VN2tKKnNnJUBn
         X9MY4NmBBgCpUmFIgoPZUc2Fpd9xtaqt5Lo9Kmn5y78tO+uRenOfWY9Nrc742X2wa6
         w2JbQKq4D4jNvyxUZVtycnue+dgqZxlgVe5tCqj/BbGaH3BS3AXaV3b19bkyW54spl
         P9ThFqbDPmbpeJwJeeMbiFPg7MYyUIExVdQCOVXe9ernY0/vYtoFNwVqmTa+TpwZDI
         luVqM3RFzfHqju1F/S+k85qs0SylMVMoqDTP5h5DygjpDNnfIjYuiwWYZqCg0dSRNe
         7LDCckIItbjeQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9849B5C4A;
        Fri,  6 Jul 2018 03:50:09 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 03:50:09 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 12:50:07 +0200
Received: from [10.107.19.85] (10.107.19.85) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 12:50:06 +0200
Subject: Re: [PATCH v6 02/11] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>, <kishon@ti.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <90e6f3255f468103d41ab7f6b438ea3a78186e00.1529595907.git.gustavo.pimentel@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <d716c8a6-2a5b-99b1-f71d-6c4d71514a2e@synopsys.com>
Date:   Fri, 6 Jul 2018 11:50:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <90e6f3255f468103d41ab7f6b438ea3a78186e00.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: pt-PT
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.85]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gustavo,

Às 5:01 PM de 6/21/2018, Gustavo Pimentel escreveu:
> Change {cdns, dra7xx, artpec6, dw, rockchip}_pcie_ep_raise_irq() and
> pci_epc_raise_irq() signature, namely the interrupt_num variable type
> from u8 to u16 to accommodate 2048 maximum MSI-X interrupts.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Alan Douglas <adouglas@cadence.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Good work on this!

Acked-By: Joao Pinto <jpinto@synopsys.com>

> ---
> Change v1->v2:
>  - Nothing changed, just to follow the patch set version.
> Change v2->v3:
>  - Move into here the pci_epc_raise_irq() signature change from patch
> file #1.
>  - Move into here the {dra7xx, artpec6}_pcie_ep_raise_irq() signature
> changes from patch file #2.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Swap patch files position (#3 -> #2).
>  - Moved dw_pcie_ep_raise_irq and dw_plat_pcie_ep_raise_irq functions
> signatures changes from patch file #3.
>  - Changed rockchip_pcie_ep_raise_irq function signature.
> Change v5->v6:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  drivers/pci/controller/pcie-cadence-ep.c          | 3 ++-
>  drivers/pci/controller/pcie-rockchip-ep.c         | 2 +-
>  drivers/pci/endpoint/pci-epc-core.c               | 8 ++++----
>  include/linux/pci-epc.h                           | 6 +++---
>  9 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 345aab5..ce9224a 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
>  }
>  
>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				 enum pci_epc_irq_type type, u8 interrupt_num)
> +				 enum pci_epc_irq_type type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 321b56c..9a2474b 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u8 interrupt_num)
> +				  enum pci_epc_irq_type type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 8650416..b86cb99 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -242,7 +242,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
>  }
>  
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
> -				enum pci_epc_irq_type type, u8 interrupt_num)
> +				enum pci_epc_irq_type type, u16 interrupt_num)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 5937fed..14b6b4b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -78,7 +78,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  				     enum pci_epc_irq_type type,
> -				     u8 interrupt_num)
> +				     u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index bee4e25..9d581c0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -191,7 +191,7 @@ enum dw_pcie_as_type {
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> -			     enum pci_epc_irq_type type, u8 interrupt_num);
> +			     enum pci_epc_irq_type type, u16 interrupt_num);
>  };
>  
>  struct dw_pcie_ep {
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index e3fe412..208d11f 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -363,7 +363,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>  }
>  
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> -				  enum pci_epc_irq_type type, u8 interrupt_num)
> +				  enum pci_epc_irq_type type,
> +				  u16 interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 6beba8e..b8163c5 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -472,7 +472,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  
>  static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
>  				      enum pci_epc_irq_type type,
> -				      u8 interrupt_num)
> +				      u16 interrupt_num)
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 7d77bd0..c72e656 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -131,13 +131,13 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>   * pci_epc_raise_irq() - interrupt the host system
>   * @epc: the EPC device which has to interrupt the host
>   * @func_no: the endpoint function number in the EPC device
> - * @type: specify the type of interrupt; legacy or MSI
> - * @interrupt_num: the MSI interrupt number
> + * @type: specify the type of interrupt; legacy, MSI or MSI-X
> + * @interrupt_num: the MSI or MSI-X interrupt number
>   *
> - * Invoke to raise an MSI or legacy interrupt
> + * Invoke to raise an legacy, MSI or MSI-X interrupt
>   */
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
> -		      enum pci_epc_irq_type type, u8 interrupt_num)
> +		      enum pci_epc_irq_type type, u16 interrupt_num)
>  {
>  	int ret;
>  	unsigned long flags;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 89f079f..bb2395b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -35,7 +35,7 @@ enum pci_epc_irq_type {
>   *	     MSI-X capability register
>   * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
>   *	     from the MSI-X capability register
> - * @raise_irq: ops to raise a legacy or MSI interrupt
> + * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @owner: the module owner containing the ops
> @@ -56,7 +56,7 @@ struct pci_epc_ops {
>  	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
>  	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
>  	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
> -			     enum pci_epc_irq_type type, u8 interrupt_num);
> +			     enum pci_epc_irq_type type, u16 interrupt_num);
>  	int	(*start)(struct pci_epc *epc);
>  	void	(*stop)(struct pci_epc *epc);
>  	struct module *owner;
> @@ -154,7 +154,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
>  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
>  int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
> -		      enum pci_epc_irq_type type, u8 interrupt_num);
> +		      enum pci_epc_irq_type type, u16 interrupt_num);
>  int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  struct pci_epc *pci_epc_get(const char *epc_name);
> 

