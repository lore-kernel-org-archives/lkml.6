Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD741C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817AA23E6D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817AA23E6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935165AbeF2NjF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:39:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34448 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeF2Niy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:38:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF871529;
        Fri, 29 Jun 2018 06:38:54 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E973F73D;
        Fri, 29 Jun 2018 06:38:53 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:40:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST
 default to yes
Message-ID: <20180629134041.GC9643@red-moon>
References: <20180619171917.19932-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619171917.19932-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 07:19:17PM +0200, Geert Uytterhoeven wrote:
> PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
> not default to yes.
> 
> Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Rebased on top of the big PCI controller move.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 16f52c626b4bd510..91b0194240a57e8f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
>  	depends on PCI && PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCIE_DW_PLAT
> -	default y
>  	help
>  	  Enables support for the PCIe controller in the Designware IP to
>  	  work in host mode. There are two instances of PCIe controller in
> -- 
> 2.17.1
> 
