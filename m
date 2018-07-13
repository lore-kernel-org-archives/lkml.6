Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDACECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9711B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9711B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:28:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbeGMO2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:28:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6887ED1;
        Fri, 13 Jul 2018 07:13:17 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56443F5B1;
        Fri, 13 Jul 2018 07:13:16 -0700 (PDT)
Date:   Fri, 13 Jul 2018 15:15:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-candence-ep: remove redundant variable mmc
Message-ID: <20180713141511.GA18555@red-moon>
References: <20180711080103.4581-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711080103.4581-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:01:03AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable mmc is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'mmc' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/pcie-cadence-ep.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to pci/cadence for v4.19, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index e3fe4124e3af..63549e03eae8 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -238,7 +238,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> -	u16 flags, mmc, mme;
> +	u16 flags, mme;
>  
>  	/* Validate that the MSI feature is actually enabled. */
>  	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> @@ -249,7 +249,6 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>  	 * Get the Multiple Message Enable bitfield from the Message Control
>  	 * register.
>  	 */
> -	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
>  	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
>  
>  	return mme;
> -- 
> 2.17.1
> 
