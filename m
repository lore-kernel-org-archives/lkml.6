Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1547920879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWU9DPRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeLNHJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:09:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32935 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLNHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:09:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so4029813ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 23:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FS/IqNQl5h0fDnRQkZ5neXYZbjLANhSCRHdXKL9WMno=;
        b=OWU9DPRgFxjFj3lws0fiQI3VeUTPewNiv6mBoFj1X6D8gYDcDjWNVHMC78CJp3ZaVQ
         neDkpYmEC6pAtF76IyYihHT2PFtgzhcZ/bL+Vl8mIY0KEW/RaV3UHZ0ovkI6mdnkEqfo
         +3ZbO/xMzgPJ2BdKjwL6SNGZuqF2BqB2OQ8f1v3Ua/5Qnj94tz3xPw3C0g8trOZXnCVP
         z2OXxR6iCOqC1XhClyobTs+Rp4VLvqsTnl+174jXfv6M/JZLhyKW5ZFoJ3pZQ5Ruc05j
         mmFs3KlkPQZE4CwnDunCiWhvNXjCX0agmXBaEJ6pdRpvVmRwg7HOJLOWRxCEWv2ybKWD
         JWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FS/IqNQl5h0fDnRQkZ5neXYZbjLANhSCRHdXKL9WMno=;
        b=Y8bReZCauJuMbLTzvylMzMnZ1i0awX7UkcvTDy1pIWIlcLb/wKC/Tise4rD5qDDau4
         cw3VtyXMAySc0QT96+IjpV5rz2AgsdfkqQmQFOpouQpk+g49tjIfQjtVRLjPMLysjc6P
         RkqlZN8Ux5iKtmzHN9kOz06WtKmDBsFu4tOdupA3zmPkXXCi3iic6ptkDi9Q3UJPTiiG
         C6q0uu8GKWnMRDyxXH4pq7jv9HI+H2YOYPO8cdhab9FB/jx23UeCTumXdp8d3CnX9ljj
         33K1y7cNN3or918SW/hkfezbE8FXWi6jCujaMedobXyZfVAOkr43ogFQPBBcbW5sWUkf
         EWdw==
X-Gm-Message-State: AA+aEWaJnH0HUdnekD4iBwmYhlBwG135L4KzBlckTj2u7QEWnhzXPNzb
        pLOtFrh/NZvHv2wBcb1WxrA=
X-Google-Smtp-Source: AFSGD/UNMrq1EWr6VBUY1fa2JwwPSeAFCIar/Naf5pRKywpW/DQ6DbxFOCBWilp1qqwg/1uuDegSFg==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr1141936ljd.21.1544771388148;
        Thu, 13 Dec 2018 23:09:48 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id q67sm772381lfe.19.2018.12.13.23.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 23:09:46 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
 <20181213154845.GF21184@phenom.ffwll.local>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jgross@suse.com,
        boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <57b468f5-cf7a-0dcd-fef8-fd399025fb45@gmail.com>
Date:   Fri, 14 Dec 2018 09:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213154845.GF21184@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 5:48 PM, Daniel Vetter wrote:
> On Thu, Dec 13, 2018 at 12:17:54PM +0200, Oleksandr Andrushchenko wrote:
>> Daniel, could you please comment?
> Cross-revieweing someone else's stuff would scale better,
fair enough
>   I don't think
> I'll get around to anything before next year.

I put you on CC explicitly because you had comments on other patch [1]

and this one tries to solve the issue raised (I tried to figure out

at [2] if this is the way to go, but it seems I have no alternative here).

While at it [3] (I hope) addresses your comments and the series just

needs your single ack/nack to get in: all the rest ack/r-b are already

there. Do you mind looking at it?

> -Daniel

Thank you very much for your time,

Oleksandr

>> Thank you
>>
>> On 11/27/18 12:32 PM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> When GEM backing storage is allocated with drm_gem_get_pages
>>> the backing pages may be cached, thus making it possible that
>>> the backend sees only partial content of the buffer which may
>>> lead to screen artifacts. Make sure that the frontend's
>>> memory is coherent and the backend always sees correct display
>>> buffer content.
>>>
>>> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>> ---
>>>    drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
>>>    1 file changed, 48 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> index 47ff019d3aef..c592735e49d2 100644
>>> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> @@ -33,8 +33,11 @@ struct xen_gem_object {
>>>    	/* set for buffers allocated by the backend */
>>>    	bool be_alloc;
>>> -	/* this is for imported PRIME buffer */
>>> -	struct sg_table *sgt_imported;
>>> +	/*
>>> +	 * this is for imported PRIME buffer or the one allocated via
>>> +	 * drm_gem_get_pages.
>>> +	 */
>>> +	struct sg_table *sgt;
>>>    };
>>>    static inline struct xen_gem_object *
>>> @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
>>>    	return xen_obj;
>>>    }
>>> +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>>> +{
>>> +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>> +
>>> +	if (!xen_obj->pages)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>> +}
>>> +
>>>    static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>    {
>>>    	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>    	struct xen_gem_object *xen_obj;
>>> +	struct address_space *mapping;
>>>    	int ret;
>>>    	size = round_up(size, PAGE_SIZE);
>>> @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>    		xen_obj->be_alloc = true;
>>>    		return xen_obj;
>>>    	}
>>> +
>>>    	/*
>>>    	 * need to allocate backing pages now, so we can share those
>>>    	 * with the backend
>>>    	 */
>>> +	mapping = xen_obj->base.filp->f_mapping;
>>> +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
>>> +
>>>    	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>    	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>>>    	if (IS_ERR_OR_NULL(xen_obj->pages)) {
>>> @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>    		goto fail;
>>>    	}
>>> +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
>>> +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
>>> +		ret = PTR_ERR(xen_obj->sgt);
>>> +		xen_obj->sgt = NULL;
>>> +		goto fail_put_pages;
>>> +	}
>>> +
>>> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>> +			DMA_BIDIRECTIONAL)) {
>>> +		ret = -EFAULT;
>>> +		goto fail_free_sgt;
>>> +	}
>>> +
>>>    	return xen_obj;
>>> +fail_free_sgt:
>>> +	sg_free_table(xen_obj->sgt);
>>> +	xen_obj->sgt = NULL;
>>> +fail_put_pages:
>>> +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
>>> +	xen_obj->pages = NULL;
>>>    fail:
>>>    	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>>>    	return ERR_PTR(ret);
>>> @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>    	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>    	if (xen_obj->base.import_attach) {
>>> -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
>>> +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
>>>    		gem_free_pages_array(xen_obj);
>>>    	} else {
>>>    		if (xen_obj->pages) {
>>> @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>    							xen_obj->pages);
>>>    				gem_free_pages_array(xen_obj);
>>>    			} else {
>>> +				if (xen_obj->sgt) {
>>> +					dma_unmap_sg(xen_obj->base.dev->dev,
>>> +						     xen_obj->sgt->sgl,
>>> +						     xen_obj->sgt->nents,
>>> +						     DMA_BIDIRECTIONAL);
>>> +					sg_free_table(xen_obj->sgt);
>>> +				}
>>>    				drm_gem_put_pages(&xen_obj->base,
>>>    						  xen_obj->pages, true, false);
>>>    			}
>>> @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
>>>    	return xen_obj->pages;
>>>    }
>>> -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>>> -{
>>> -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>> -
>>> -	if (!xen_obj->pages)
>>> -		return ERR_PTR(-ENOMEM);
>>> -
>>> -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>> -}
>>> -
>>>    struct drm_gem_object *
>>>    xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>>>    				  struct dma_buf_attachment *attach,
>>> @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>>>    	if (ret < 0)
>>>    		return ERR_PTR(ret);
>>> -	xen_obj->sgt_imported = sgt;
>>> +	xen_obj->sgt = sgt;
>>>    	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
>>>    					       NULL, xen_obj->num_pages);
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

[1] https://patchwork.kernel.org/patch/10693787/

[2] https://lists.xen.org/archives/html/xen-devel/2018-11/msg02882.html

[3] https://patchwork.kernel.org/patch/10705853/


