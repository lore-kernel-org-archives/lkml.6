Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14959C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BF620871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CpBNYFFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BF620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeFTKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:07:55 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:51056 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFTKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:07:52 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id ED20D1E04A8;
        Wed, 20 Jun 2018 12:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529489271; bh=HEPC60kX0ujYIEx9DO21GKBaI95Dp3Az4QiinETJh+M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=CpBNYFFMZujkuudhBR7KjqDz2UoPkMkO2dgWs7/eKWFMZBj2vDjAb50+IewPaKKVW
         DGouYR/aSNVgC/bcvmO4rAdUsjis8FHNfiLa/f/C3OxReDoEcAOxYTOQk0gqe8FWVH
         boWzi3TaCCczw3BDM1onp3PBUursNMr2rgXq2jRWZwEhfiIpKvFHuL3meLXzAqeEak
         xJb+12eWjjGUVFTz9BKSRbrIznIxB1/4aDj1r6EAO3Zd5wem8ktaknkQw1rPMVO62L
         0KeTwPzUTpPuFL54vQprgTOxhpBwmmrDRGriOl3eZ2qhu77/rAYGtz4y0DP642sk6a
         6dTkq1BsdBWNw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 093153AC1;
        Wed, 20 Jun 2018 03:07:50 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 03:07:18 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 12:07:11 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 12:07:11 +0200
Subject: Re: [PATCH v4 03/10] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
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
 <5bfa0cf053878e0e859a8b97227ca03ea4d50e92.1529329262.git.gustavo.pimentel@synopsys.com>
 <355c0797-1e86-fc0e-ca61-b5eb00835d36@ti.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <3359884c-d937-ad66-6fdd-72072c43c696@synopsys.com>
Date:   Wed, 20 Jun 2018 11:05:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <355c0797-1e86-fc0e-ca61-b5eb00835d36@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/06/2018 07:47, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
>> Change {cdns, dra7xx, artpec6}_pcie_ep_raise_irq() and pci_epc_raise_irq()
>> signature, namely the interrupt_num variable type from u8 to u16 to
>> accommodate 2048 maximum MSI-X interrupts.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Acked-by: Alan Douglas <adouglas@cadence.com>
> 
> This patch should precede patch #2 and the following hunk from patch #2 should
> be added here.
> 
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -191,7 +191,7 @@ enum dw_pcie_as_type {
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> -			     enum pci_epc_irq_type type, u8 interrupt_num);
> +			     enum pci_epc_irq_type type, u16 interrupt_num);
>  };

Yes, it it makes a lot more sense in the other patch file.

Thanks.
Gustavo

> 
> Thanks
> Kishon
> 
>> ---
>> Change v1->v2:
>>  - Nothing changed, just to follow the patch set version.
>> Change v2->v3:
>>  - Move into here the pci_epc_raise_irq() signature change from patch
>> file #1.
>>  - Move into here the {dra7xx, artpec6}_pcie_ep_raise_irq() signature
>> changes from patch file #2.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>>
>>  drivers/pci/controller/dwc/pci-dra7xx.c   | 2 +-
>>  drivers/pci/controller/dwc/pcie-artpec6.c | 2 +-
>>  drivers/pci/controller/pcie-cadence-ep.c  | 3 ++-
>>  drivers/pci/endpoint/pci-epc-core.c       | 8 ++++----
>>  include/linux/pci-epc.h                   | 6 +++---
>>  5 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 345aab5..ce9224a 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
>>  }
>>  
>>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				 enum pci_epc_irq_type type, u8 interrupt_num)
>> +				 enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
>> index 321b56c..9a2474b 100644
>> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
>> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
>> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>>  }
>>  
>>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				  enum pci_epc_irq_type type, u8 interrupt_num)
>> +				  enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  
>> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
>> index e3fe412..208d11f 100644
>> --- a/drivers/pci/controller/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/pcie-cadence-ep.c
>> @@ -363,7 +363,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>>  }
>>  
>>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
>> -				  enum pci_epc_irq_type type, u8 interrupt_num)
>> +				  enum pci_epc_irq_type type,
>> +				  u16 interrupt_num)
>>  {
>>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>  
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 7d77bd0..c72e656 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -131,13 +131,13 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>>   * pci_epc_raise_irq() - interrupt the host system
>>   * @epc: the EPC device which has to interrupt the host
>>   * @func_no: the endpoint function number in the EPC device
>> - * @type: specify the type of interrupt; legacy or MSI
>> - * @interrupt_num: the MSI interrupt number
>> + * @type: specify the type of interrupt; legacy, MSI or MSI-X
>> + * @interrupt_num: the MSI or MSI-X interrupt number
>>   *
>> - * Invoke to raise an MSI or legacy interrupt
>> + * Invoke to raise an legacy, MSI or MSI-X interrupt
>>   */
>>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
>> -		      enum pci_epc_irq_type type, u8 interrupt_num)
>> +		      enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	int ret;
>>  	unsigned long flags;
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 89f079f..bb2395b 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -35,7 +35,7 @@ enum pci_epc_irq_type {
>>   *	     MSI-X capability register
>>   * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
>>   *	     from the MSI-X capability register
>> - * @raise_irq: ops to raise a legacy or MSI interrupt
>> + * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
>>   * @start: ops to start the PCI link
>>   * @stop: ops to stop the PCI link
>>   * @owner: the module owner containing the ops
>> @@ -56,7 +56,7 @@ struct pci_epc_ops {
>>  	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
>>  	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
>>  	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
>> -			     enum pci_epc_irq_type type, u8 interrupt_num);
>> +			     enum pci_epc_irq_type type, u16 interrupt_num);
>>  	int	(*start)(struct pci_epc *epc);
>>  	void	(*stop)(struct pci_epc *epc);
>>  	struct module *owner;
>> @@ -154,7 +154,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
>>  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
>>  int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
>>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
>> -		      enum pci_epc_irq_type type, u8 interrupt_num);
>> +		      enum pci_epc_irq_type type, u16 interrupt_num);
>>  int pci_epc_start(struct pci_epc *epc);
>>  void pci_epc_stop(struct pci_epc *epc);
>>  struct pci_epc *pci_epc_get(const char *epc_name);
>>

