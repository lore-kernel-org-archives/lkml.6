Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090BF20989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxDjUS5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090BF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeLMKR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:17:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45099 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeLMKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:17:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so1248775ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y7KqheVdOoqtKq4Z2DHP8sIv6gqCQpGjz0Av0MyXMfA=;
        b=cxDjUS5F8Ha4ZlU8w/Pc4gFB69Esb8I2BpZTAuzRoOMk2C1YAH4loQfKemK9e2+Xrt
         Q5knQK1e+giQN5pQlaki4i6oiyGHbTfhIgZcxC6M2VhdyElamq7Va0E6dRKDo9yU6HjT
         RHY6EtEmElGcUh0qBpG9rb5c2W9qMO8C3hke/UzBkViPuUULChtWTbLvwTIssKjX7R0F
         WCX6JTz9yTft/qY9WJ0iUJNva/JAPxgSFAFvziPQ7Jwoq6x9YFvb0XS8uVO2sBl8tBT+
         aRBRXhFdCH4y/ZgOTNuCNhzgRFr83OX+cgclLYR2fw8X6CoMnmW2sQ2YBkV3FHtGBAT5
         4emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y7KqheVdOoqtKq4Z2DHP8sIv6gqCQpGjz0Av0MyXMfA=;
        b=cxnraOlBz9Tw/9MNtRgTYzt+t6h3cbUWIzFuvpDVXpygJf3stmMBoAaV+fv9c4cyDb
         jG315rtW9bmyg+cDHk+Gws/0MtDYCKJWxV4FPn+c3pxqAlqOlNoxLi8TpX1JIOPkT/Qi
         GSNFen3XONLSc7udhqL9aCXJ2tohJGm0qQScq1ZU5hSeAsesYi9Be2dNcvYV9d3q/TW+
         EvQP/HWvA/5zkM+vmc3//VV+tJ7URuYg+M7MpUbv7V5ycB13DERV6rj/Dug6WDA+1acJ
         QoAWB0sgkn5JqTHjk4z1ROlJr9J/vH5g2wmv/X+55A+6HkUPd209/M0jweSaEZ3QtNyL
         KH5g==
X-Gm-Message-State: AA+aEWYMerh0TISit2ljB+HElL60UE1rcEvYbWY6pTSgKWWys0YPZa+3
        ny/+YmyVK2/lkuSR5GkhUCc=
X-Google-Smtp-Source: AFSGD/ViDxIzI97U4iGlz6RyaQTIznhV19M81NPdogSA5uHddsGRwi2U+w2GwS1vVxlMqbEvaLf7nQ==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr14190511lju.116.1544696276529;
        Thu, 13 Dec 2018 02:17:56 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id e94sm269095lfi.23.2018.12.13.02.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:17:55 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
Date:   Thu, 13 Dec 2018 12:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127103252.20994-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, could you please comment?

Thank you

On 11/27/18 12:32 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> When GEM backing storage is allocated with drm_gem_get_pages
> the backing pages may be cached, thus making it possible that
> the backend sees only partial content of the buffer which may
> lead to screen artifacts. Make sure that the frontend's
> memory is coherent and the backend always sees correct display
> buffer content.
>
> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
>   1 file changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index 47ff019d3aef..c592735e49d2 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -33,8 +33,11 @@ struct xen_gem_object {
>   	/* set for buffers allocated by the backend */
>   	bool be_alloc;
>   
> -	/* this is for imported PRIME buffer */
> -	struct sg_table *sgt_imported;
> +	/*
> +	 * this is for imported PRIME buffer or the one allocated via
> +	 * drm_gem_get_pages.
> +	 */
> +	struct sg_table *sgt;
>   };
>   
>   static inline struct xen_gem_object *
> @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
>   	return xen_obj;
>   }
>   
> +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> +{
> +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> +
> +	if (!xen_obj->pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> +}
> +
>   static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   {
>   	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>   	struct xen_gem_object *xen_obj;
> +	struct address_space *mapping;
>   	int ret;
>   
>   	size = round_up(size, PAGE_SIZE);
> @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   		xen_obj->be_alloc = true;
>   		return xen_obj;
>   	}
> +
>   	/*
>   	 * need to allocate backing pages now, so we can share those
>   	 * with the backend
>   	 */
> +	mapping = xen_obj->base.filp->f_mapping;
> +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
> +
>   	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>   	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>   	if (IS_ERR_OR_NULL(xen_obj->pages)) {
> @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   		goto fail;
>   	}
>   
> +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
> +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
> +		ret = PTR_ERR(xen_obj->sgt);
> +		xen_obj->sgt = NULL;
> +		goto fail_put_pages;
> +	}
> +
> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> +			DMA_BIDIRECTIONAL)) {
> +		ret = -EFAULT;
> +		goto fail_free_sgt;
> +	}
> +
>   	return xen_obj;
>   
> +fail_free_sgt:
> +	sg_free_table(xen_obj->sgt);
> +	xen_obj->sgt = NULL;
> +fail_put_pages:
> +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
> +	xen_obj->pages = NULL;
>   fail:
>   	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>   	return ERR_PTR(ret);
> @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>   	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>   
>   	if (xen_obj->base.import_attach) {
> -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
> +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
>   		gem_free_pages_array(xen_obj);
>   	} else {
>   		if (xen_obj->pages) {
> @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>   							xen_obj->pages);
>   				gem_free_pages_array(xen_obj);
>   			} else {
> +				if (xen_obj->sgt) {
> +					dma_unmap_sg(xen_obj->base.dev->dev,
> +						     xen_obj->sgt->sgl,
> +						     xen_obj->sgt->nents,
> +						     DMA_BIDIRECTIONAL);
> +					sg_free_table(xen_obj->sgt);
> +				}
>   				drm_gem_put_pages(&xen_obj->base,
>   						  xen_obj->pages, true, false);
>   			}
> @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
>   	return xen_obj->pages;
>   }
>   
> -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> -{
> -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> -
> -	if (!xen_obj->pages)
> -		return ERR_PTR(-ENOMEM);
> -
> -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> -}
> -
>   struct drm_gem_object *
>   xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>   				  struct dma_buf_attachment *attach,
> @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>   
> -	xen_obj->sgt_imported = sgt;
> +	xen_obj->sgt = sgt;
>   
>   	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
>   					       NULL, xen_obj->num_pages);
