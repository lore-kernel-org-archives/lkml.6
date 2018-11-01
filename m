Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03940C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD51205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8oV6rOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD51205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeKBEIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:08:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52189 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeKBEIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:08:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so2273247wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=csBfI1CYjSX9tZQgJRJEFBHcbmd20fyGTnJaBhYvo9o=;
        b=s8oV6rOzE1Qti03eT1v6TIDRcnrIRFmo3Loar/koIl1V8nLREq/Ar3ysjrXgZeTUV8
         UjA6brzjg2E8Uy0xiL+MULxcPFaB3VbJ9bxm1heRXdRVcjhX4eszfxnSzzl1eBYmQhT0
         PFYBcceteQKDjfizaK3Kaafb6WXMm/arwfG2KdhEqFLC2UeOhMR66TLG1yKOivYu/VJe
         m8gw6Ds7bGNCyYOKX5e2hF6NXGHlhRvDAhXU/8b+olCXs44bwRH3dprPApr+8u1VEK0M
         ZbEdX/g90JjfHQ7Q05ocEC4KXXbiVNW6cmoaZnn1MEZ/WZ8XumtcqI9Yj8xPOLSICLMr
         ajiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=csBfI1CYjSX9tZQgJRJEFBHcbmd20fyGTnJaBhYvo9o=;
        b=W0bDmLrg245cVV/9lHH/epYEXjzH21h1DWV8WcvItOQoWaz5rX+z6EHe5Dg41i+f+M
         LKztzLAPNKtNKwnyTNGq7of4jZk83IJIWzKdaUocDV7lBw7DH11K6KgzHILYO7oAudcU
         SOkNJpWNdvAFF9TtT+pRANvFkqojmsYEskRqNyI8hMrtRRjTdhsP0sUX5wAuFq8XO70l
         FgOBxh40wFJgAkKIRgJP87jbxQ6KRIiBCLxDFBtjAiKYkTLczSSK24tE9GlQWG9AczRo
         yjjUGUvf8VXbIeuZee5Crz5HGLF6Uf3h4AlaCG1AifYwtFzKtQz/EMDAOlgefG4V+UDT
         cz8g==
X-Gm-Message-State: AGRZ1gL850Cgf7u24zKjwupWqkuDfsNEcKoWunXiuQT29kPxfKcsPoOf
        RRKSr9bhwrD51G69IK8X0Du2Qalv
X-Google-Smtp-Source: AJdET5derjSoPFM7dE/Wq23mlsCcAA53JMQbKROWYTMntQM0v7V9TkTLUf/AnGrBov6TllgkyOR0dA==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr6711161wmb.72.1541099033617;
        Thu, 01 Nov 2018 12:03:53 -0700 (PDT)
Received: from [10.67.50.106] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id p19-v6sm14537256wmc.46.2018.11.01.12.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:03:52 -0700 (PDT)
Subject: Re: [PATCH] ARM64: dma: move swiotlb helpers under CONFIG_IOMMU_DMA
To:     Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181101185340.32664-1-olof@lixom.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <5b524dcf-f78c-25af-6a70-9c85aa8e4a42@gmail.com>
Date:   Thu, 1 Nov 2018 12:03:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101185340.32664-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 11:53 AM, Olof Johansson wrote:
> Fixes the following tinyconfig warnings:
> arch/arm64/mm/dma-mapping.c:174:12: warning: '__swiotlb_mmap_pfn' defined but not used [-Wunused-function]
> arch/arm64/mm/dma-mapping.c:163:12: warning: '__swiotlb_get_sgtable_page' defined but not used [-Wunused-function]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Christoph sent an alternative solution here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-October/609480.html

> ---
>  arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3a703e5d4e32..62356c64e180 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>  	__dma_unmap_area(phys_to_virt(paddr), size, dir);
>  }
>  
> -static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> -				      struct page *page, size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -
> -	return ret;
> -}
> -
> -static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = vma_pages(vma);
> -	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -
> -	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> -				      vma->vm_end - vma->vm_start,
> -				      vma->vm_page_prot);
> -	}
> -
> -	return ret;
> -}
> -
>  static int __init atomic_pool_init(void)
>  {
>  	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> @@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
>  #include <linux/platform_device.h>
>  #include <linux/amba/bus.h>
>  
> +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> +				      struct page *page, size_t size)
> +{
> +	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +
> +	return ret;
> +}
> +
> +static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> +			      unsigned long pfn, size_t size)
> +{
> +	int ret = -ENXIO;
> +	unsigned long nr_vma_pages = vma_pages(vma);
> +	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
> +
> +	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> +		ret = remap_pfn_range(vma, vma->vm_start,
> +				      pfn + off,
> +				      vma->vm_end - vma->vm_start,
> +				      vma->vm_page_prot);
> +	}
> +
> +	return ret;
> +}
> +
>  /* Thankfully, all cache ops are by VA so we can ignore phys here */
>  static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
>  {
> 


-- 
Florian
