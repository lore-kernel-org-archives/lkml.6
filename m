Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64ECC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0022B52
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE0022B52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeFVAUW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:20:22 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:59663
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933729AbeFVAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:20:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CkAABbQCxb/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFPxODeZYmIpZ5hHcCgxw4FAECAQEBAQEBAoY+AQEBAyMPAQVBEAs?=
 =?us-ascii?q?NCwICJgICVwYNBgIBAYMhgXOqYm2CHBqEQYNogQWBC4lcgTYMgi4uh3uCVQKZJ?=
 =?us-ascii?q?ggBjwqIH4UokziBczMaCCgIgyKCIReOKV2QLAEB?=
X-IPAS-Result: =?us-ascii?q?A2CkAABbQCxb/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGFPxO?=
 =?us-ascii?q?DeZYmIpZ5hHcCgxw4FAECAQEBAQEBAoY+AQEBAyMPAQVBEAsNCwICJgICVwYNB?=
 =?us-ascii?q?gIBAYMhgXOqYm2CHBqEQYNogQWBC4lcgTYMgi4uh3uCVQKZJggBjwqIH4Uokzi?=
 =?us-ascii?q?BczMaCCgIgyKCIReOKV2QLAEB?=
X-IronPort-AV: E=Sophos;i="5.51,253,1526313600"; 
   d="scan'208";a="142791210"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 22 Jun 2018 08:19:55 +0800
Subject: Re: [PATCH v2] m68knommu: Fix typos in Coldfire 5272 DMA debug code
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20180621203053.32047-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <ecdf3bdf-6453-0c5f-1a72-b4df7148c867@linux-m68k.org>
Date:   Fri, 22 Jun 2018 10:19:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621203053.32047-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 22/06/18 06:30, Geert Uytterhoeven wrote:
> If DEBUG_DMA is defined:
> 
>      include/asm/dma.h: In function ‘set_dma_mode’:
>      include/asm/dma.h:393: error: ‘dmabp’ undeclared (first use in this function)
>      include/asm/dma.h:393: error: (Each undeclared identifier is reported only once
>      include/asm/dma.h:393: error: for each function it appears in.)
>      include/asm/dma.h: In function ‘set_dma_addr’:
>      include/asm/dma.h:424: error: ‘dmawp’ undeclared (first use in this function)
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Do you want me to take this via the m68knommu git tree?

Regards
Greg


> ---
> v2:
>    - Add Acked-by.
> ---
>   arch/m68k/include/asm/dma.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/dma.h b/arch/m68k/include/asm/dma.h
> index b0978a23bad1d7ee..ae2021964e32d36f 100644
> --- a/arch/m68k/include/asm/dma.h
> +++ b/arch/m68k/include/asm/dma.h
> @@ -390,7 +390,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
>   
>   #ifdef DEBUG_DMA
>     printk("%s(%d): dmanr=%d DMR[%x]=%x DIR[%x]=%x\n", __FILE__, __LINE__,
> -         dmanr, (int) &dmalp[MCFDMA_DMR], dmabp[MCFDMA_DMR],
> +	 dmanr, (int) &dmalp[MCFDMA_DMR], dmalp[MCFDMA_DMR],
>   	 (int) &dmawp[MCFDMA_DIR], dmawp[MCFDMA_DIR]);
>   #endif
>   }
> @@ -421,7 +421,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
>   
>   #ifdef DEBUG_DMA
>     printk("%s(%d): dmanr=%d DMR[%x]=%x SAR[%x]=%08x DAR[%x]=%08x\n",
> -	__FILE__, __LINE__, dmanr, (int) &dmawp[MCFDMA_DMR], dmawp[MCFDMA_DMR],
> +	__FILE__, __LINE__, dmanr, (int) &dmalp[MCFDMA_DMR], dmalp[MCFDMA_DMR],
>   	(int) &dmalp[MCFDMA_DSAR], dmalp[MCFDMA_DSAR],
>   	(int) &dmalp[MCFDMA_DDAR], dmalp[MCFDMA_DDAR]);
>   #endif
> 
