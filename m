Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E3208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J7amiCh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829E3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeGMIDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:03:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45206 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeGMIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:03:12 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6D7nXXL070646;
        Fri, 13 Jul 2018 02:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531468173;
        bh=QuCT4igisjadnh+l1JwB9JxufsPgwcHU1PNk1sOxCHw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=J7amiCh5jEAyPWJJBrdxqOJV0pWQDFD/xvTEPkPP+lGA87L5WPBpfWREw82pjb2/G
         7d/c3ChJCMOAGhIVUD/WiGKb9YpG3xuM0x6uC0jTHlt8WvKvXmKIquySsVPiVT+PeD
         QrTReLldTTOa0SmJFcSsg7TSPRfihgSBzsrT+zSs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D7nXLU017900;
        Fri, 13 Jul 2018 02:49:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 13
 Jul 2018 02:49:32 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 13 Jul 2018 02:49:32 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D7nTas027678;
        Fri, 13 Jul 2018 02:49:29 -0500
Subject: Re: [PATCH v9 03/12] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <4e5e896ab6e1015340d8dba6b797d9070defbb73.1531155252.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3647c24e-02ec-9e75-2cd5-7a77107711bd@ti.com>
Date:   Fri, 13 Jul 2018 13:19:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4e5e896ab6e1015340d8dba6b797d9070defbb73.1531155252.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 09 July 2018 11:12 PM, Gustavo Pimentel wrote:
> Change {cdns, dra7xx, artpec6, dw, rockchip}_pcie_ep_raise_irq() and
> pci_epc_raise_irq() signature, namely the interrupt_num variable type
> from u8 to u16 to accommodate 2048 maximum MSI-X interrupts.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Alan Douglas <adouglas@cadence.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
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
> Change v6->v7:
>  - Nothing changed, just to follow the patch set version.
> Change v7->v8:
>  - Re-sending the patch series.
> Change v8->v9:
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
> index 04092a7..69d039d 100644
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
> index 0ce3440..0efb318 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -81,7 +81,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
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
