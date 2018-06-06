Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6007160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeFFKhn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:37:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbeFFKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:37:38 -0400
Date: Wed, 6 Jun 2018 12:37:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Masatake YAMATO <yamato@redhat.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] x86/iommu: Fix a typo in a macro parameter
In-Reply-To: <20180606051026.29535-1-yamato@redhat.com>
Message-ID: <alpine.DEB.2.21.1806061235330.1579@nanos.tec.linutronix.de>
References: <20180606051026.29535-1-yamato@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Masatake YAMATO wrote:

Can you please explain why 0 is the wrong value. That's not a typo, that's
a functional change and both the subject line and the changelog itself
should be explanatory.

Thanks,

	tglx

> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  arch/x86/include/asm/iommu_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
> index 1fb3fd1a83c2..2a0d5f7d1ed1 100644
> --- a/arch/x86/include/asm/iommu_table.h
> +++ b/arch/x86/include/asm/iommu_table.h
> @@ -66,7 +66,7 @@ struct iommu_table_entry {
>  #define IOMMU_INIT_POST(_detect)					\
>  	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 0)
>  
> -#define IOMMU_INIT_POST_FINISH(detect)					\
> +#define IOMMU_INIT_POST_FINISH(_detect)					\
>  	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 1)
>  
>  /*
> -- 
> 2.17.0
> 
> 
