Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D36C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94325208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94325208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeGaLNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:13:48 -0400
Received: from ozlabs.org ([203.11.71.1]:49887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbeGaLNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:13:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41frqb0Q0Qz9rxx;
        Tue, 31 Jul 2018 19:34:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
In-Reply-To: <20180730073842.16092-1-hch@lst.de>
References: <20180730073842.16092-1-hch@lst.de>
Date:   Tue, 31 Jul 2018 19:34:18 +1000
Message-ID: <87sh3zhhph.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kernel/dma.c | 3 ---
>  arch/sh/drivers/pci/pci.c | 2 --
>  arch/x86/kernel/pci-dma.c | 3 ---
>  drivers/pci/pci-driver.c  | 2 +-
>  4 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 155170d70324..dbfc7056d7df 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -357,9 +357,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>  
>  static int __init dma_init(void)
>  {
> -#ifdef CONFIG_PCI
> -	dma_debug_add_bus(&pci_bus_type);
> -#endif
>  #ifdef CONFIG_IBMVIO
>  	dma_debug_add_bus(&vio_bus_type);
>  #endif

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
