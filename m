Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D5D41C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8878320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jnA6Xp/d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YCyATbGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8878320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933828AbeFLIbw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:31:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeFLIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:31:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E831602BD; Tue, 12 Jun 2018 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792309;
        bh=OKyWdj5ZUElVAlqma/conqyWv7riKtTD8VDX3wT63ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnA6Xp/dSk8WnX5fJF18vr4eSltt/q9HPmGfumDPDTPWAe4aRkXy1fkogfS6c0oED
         SwtAx4+eqBbFCqU2lJpG3C1nBppfpX+qxxGipkrdoJ3xk+EDmFf46/DaTqloXRit0s
         plmQTeagYdzd92z4bDFjawz/DtIqhpYMKLV/YzkQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9103F60116;
        Tue, 12 Jun 2018 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792308;
        bh=OKyWdj5ZUElVAlqma/conqyWv7riKtTD8VDX3wT63ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YCyATbGF3oaqkCJVfJsLvuODO3XtkqNKuuaN7CHf4mEfSnGJK9t61Usw064BCirOp
         RHQQQUp3oF/tybzReZ7SW1/bh+nMdpaNJN7JQAOnNCZyQQqa9tbTIuMWEh+CaHhaeB
         bppPG2Og5YpSO1+4FORImn2u/mu3TKTRUzd+wNCk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 14:01:48 +0530
From:   poza@codeaurora.org
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: iproc: Reduce inbound/outbound mapping print
 level
In-Reply-To: <1528762867-16823-6-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-6-git-send-email-ray.jui@broadcom.com>
Message-ID: <f38e325f6d2e280e0a5f63183042746a@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 05:51, Ray Jui wrote:
> Reduce inbound/outbound mapping print level from dev_info to
> dev_dbg. This reduces the console logs during Linux boot process
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c 
> b/drivers/pci/host/pcie-iproc.c
> index 59be1e0..3160e93 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -880,14 +880,14 @@ static inline int iproc_pcie_ob_write(struct
> iproc_pcie *pcie, int window_idx,
>  	writel(lower_32_bits(pci_addr), pcie->base + omap_offset);
>  	writel(upper_32_bits(pci_addr), pcie->base + omap_offset + 4);
> 
> -	dev_info(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
> -		 window_idx, oarr_offset, &axi_addr, &pci_addr);
> -	dev_info(dev, "oarr lo 0x%x oarr hi 0x%x\n",
> -		 readl(pcie->base + oarr_offset),
> -		 readl(pcie->base + oarr_offset + 4));
> -	dev_info(dev, "omap lo 0x%x omap hi 0x%x\n",
> -		 readl(pcie->base + omap_offset),
> -		 readl(pcie->base + omap_offset + 4));
> +	dev_dbg(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
> +		window_idx, oarr_offset, &axi_addr, &pci_addr);
> +	dev_dbg(dev, "oarr lo 0x%x oarr hi 0x%x\n",
> +		readl(pcie->base + oarr_offset),
> +		readl(pcie->base + oarr_offset + 4));
> +	dev_dbg(dev, "omap lo 0x%x omap hi 0x%x\n",
> +		readl(pcie->base + omap_offset),
> +		readl(pcie->base + omap_offset + 4));
> 
>  	return 0;
>  }
> @@ -1054,8 +1054,8 @@ static int iproc_pcie_ib_write(struct iproc_pcie
> *pcie, int region_idx,
>  	    iproc_pcie_reg_is_invalid(imap_offset))
>  		return -EINVAL;
> 
> -	dev_info(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
> -		 region_idx, iarr_offset, &axi_addr, &pci_addr);
> +	dev_dbg(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
> +		region_idx, iarr_offset, &axi_addr, &pci_addr);
> 
>  	/*
>  	 * Program the IARR registers.  The upper 32-bit IARR register is
> @@ -1065,9 +1065,9 @@ static int iproc_pcie_ib_write(struct iproc_pcie
> *pcie, int region_idx,
>  	       pcie->base + iarr_offset);
>  	writel(upper_32_bits(pci_addr), pcie->base + iarr_offset + 4);
> 
> -	dev_info(dev, "iarr lo 0x%x iarr hi 0x%x\n",
> -		 readl(pcie->base + iarr_offset),
> -		 readl(pcie->base + iarr_offset + 4));
> +	dev_dbg(dev, "iarr lo 0x%x iarr hi 0x%x\n",
> +		readl(pcie->base + iarr_offset),
> +		readl(pcie->base + iarr_offset + 4));
> 
>  	/*
>  	 * Now program the IMAP registers.  Each IARR region may have one or
> @@ -1081,10 +1081,10 @@ static int iproc_pcie_ib_write(struct
> iproc_pcie *pcie, int region_idx,
>  		writel(upper_32_bits(axi_addr),
>  		       pcie->base + imap_offset + ib_map->imap_addr_offset);
> 
> -		dev_info(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
> -			 window_idx, readl(pcie->base + imap_offset),
> -			 readl(pcie->base + imap_offset +
> -			       ib_map->imap_addr_offset));
> +		dev_dbg(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
> +			window_idx, readl(pcie->base + imap_offset),
> +			readl(pcie->base + imap_offset +
> +			      ib_map->imap_addr_offset));
> 
>  		imap_offset += ib_map->imap_window_offset;
>  		axi_addr += size;

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
