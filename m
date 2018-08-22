Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C5CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC10208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYCB7Fmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC10208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeHVWfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:35:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeHVWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:35:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so2499040wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hEoSw1QzYWzj86YS1vACPT9CSMn5dtE9BIFeI0QDP4w=;
        b=WYCB7FmxEBwyKbSupFOZtiJHLx5JvrkVKZ9hnPtIQgBin8HBUaiXUH6RZPHeh2h8WH
         yE0MxbrXfbxBJC4CzSITlOnu2G0ZQkiNE/hDb5TzDhHV32YjuEcLoSWwrKWHuwYqMNku
         /LZ3LPPnWFx8xfR3lQsJduzsbeqfbtDqr81QkSyy8naVdlPk9PAaPPCrhPah8u1JKk4Z
         di0edELJfRDkut+UOH91dJDl+Hc1ewZaRADrq8J7amplhlIVuwQvqdpjp8PxHoHrajy5
         VQwGqCyD4lvsEHns4cPgpA3s58DeUL6F3af5UbDHuY0ZA+IcRRdhOSq9jrHJiE6sBXAO
         uGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=hEoSw1QzYWzj86YS1vACPT9CSMn5dtE9BIFeI0QDP4w=;
        b=V+iaZSxxpqq7YlyFcFpGws9OJuDfw427+bCNQPFQZbKfZ2m8UtxmjTr1SZJ1jKrw0s
         JWwlLr25JMIAI93Upma9ync5KwwKTzA1P6X0HSWdzoavpp+ml09l77ekEnCae758w/t6
         1iL6PaMv8sM1ZghGLTYPvMzoLr8P8fZ6TOLYdiExaKh+X/sHr6m+DVDU8ZHB4ZwrRR0Y
         BdQUFW0Vi+clMUcph0KI8K9QKoNp6MWV6r5gTWrMOZNXeXGLbKwjjdkGVEXiVOlcGntn
         7tDS02Fjjh/W87Sv44L8kGfEj+Q2YD9lUMa8A35rd61X7RzSd5lCo7AFqTMaA/b1qVWs
         m8Aw==
X-Gm-Message-State: APzg51BrZuh9gPJRQTBq2pM19OtsTKUXexNtpqqrfgyy0EaGtEY23WYn
        bpHV1r5MHhbjeYeD5Onj/Cs=
X-Google-Smtp-Source: ANB0VdaRpT5qmgZVZHj1wZuu/K/t4cGn6oRgDovKnViBJsNH+2u3UQpNUDVZWAUhXCthGfAwmQKpkA==
X-Received: by 2002:adf:9a21:: with SMTP id z30-v6mr9282942wrb.47.1534964977975;
        Wed, 22 Aug 2018 12:09:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id o3-v6sm2089857wrn.58.2018.08.22.12.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 12:09:37 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
To:     Jiandi An <jiandi.an@amd.com>, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org, ray.huang@amd.com,
        Jerry.Zhang@amd.com, christian.koenig@amd.com
References: <20180822185754.104729-1-jiandi.an@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
Date:   Wed, 22 Aug 2018 21:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822185754.104729-1-jiandi.an@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.08.2018 um 20:57 schrieb Jiandi An:
> Framebuffer memory needs to be accessed decrypted.  Ensure the
> memory encryption mask is not set for the ttm framebuffer mappings.

NAK, the memory not only needs to be decrypted while CPU accessed but 
all the time.

ttm_page_alloc.c and ttm_page_alloc_dma.c should already take care of 
that while mapping the pages.

Regards,
Christian.

>
> Signed-off-by: Jiandi An <jiandi.an@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
>   drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 046a6dda690a..b3f5d26f571e 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -29,6 +29,7 @@
>    * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>    */
>   
> +#include <asm/set_memory.h>
>   #include <drm/ttm/ttm_bo_driver.h>
>   #include <drm/ttm/ttm_placement.h>
>   #include <drm/drm_vma_manager.h>
> @@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
>   	if (ret)
>   		return ret;
>   	if (!bo->mem.bus.is_iomem) {
> -		return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
> +		ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
> +		if (!ret && sev_active())
> +			set_memory_decrypted((unsigned long) map->virtual,
> +					     num_pages);
> +		return ret;
>   	} else {
>   		offset = start_page << PAGE_SHIFT;
>   		size = num_pages << PAGE_SHIFT;
> @@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
>   		iounmap(map->virtual);
>   		break;
>   	case ttm_bo_map_vmap:
> +		if (sev_active())
> +			set_memory_encrypted((unsigned long) map->virtual,
> +					     bo->num_pages);
>   		vunmap(map->virtual);
>   		break;
>   	case ttm_bo_map_kmap:
> +		if (sev_active())
> +			set_memory_encrypted((unsigned long) map->virtual, 1);
>   		kunmap(map->page);
>   		break;
>   	case ttm_bo_map_premapped:
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 6fe91c1b692d..211d3549fd9f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   	 * Speculatively prefault a number of pages. Only error on
>   	 * first page.
>   	 */
> +
> +	/* Mark framebuffer pages decrypted */
> +	cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
> +
>   	for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
>   		if (bo->mem.bus.is_iomem) {
> -			/* Iomem should not be marked encrypted */
> -			cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>   			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>   		} else {
>   			page = ttm->pages[page_offset];

