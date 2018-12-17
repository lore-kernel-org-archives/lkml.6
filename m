Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C77C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E182086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT9P6RZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeLQIDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:03:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34188 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:03:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so10141285ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=iWZiaQjHlcpYJuXIXUs36VispKxL4rc6ScfVKXrVAyU=;
        b=iT9P6RZnkc8Ux19Htmw4JbGHCq10z2flHuNF0TFgc6VvG/q4lRWS/WXIz24wQqycJc
         QaFNRGO+9UeMssC9toj69sM6WKkz1VnSJfCqORJygiTiuyk4/w06oGU+jUaPq7Dgl2LP
         mbWGiKYAFgoPkclKG6zhVlwv8dSp91QC2DjskkvMBQ+iTsM9Tt+W6SKzQYtHBzaHEyI+
         SZ+9nwsp0PUZwwYnG78nMiDBHuooH0eDflfcn2aENH3DHATvqc49Y5StI3UFsg5w9R+k
         J8oU4Xfdkq4BG0iXa5ejepLj01+3hw+LrQA/j4TZMAnYz2G5YzlmFainREZOITBVSDiv
         1K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iWZiaQjHlcpYJuXIXUs36VispKxL4rc6ScfVKXrVAyU=;
        b=WS9uhTzCkmhNBZq8DcmLZxjm4twVrCtjQMkeNNRV8ZJVuMrjilMR+FqmNtCTa3cBod
         XqYDOg99x2iKqptKAwBvjZF0/2x/cGpEtEdGnB3RA6N0rifM4HN0h0/SsgQg2LAXRRvn
         bHccKAR1+buqjVuRLxvmJ9g3l6x5yJK5DYqvbJbB3OKJmpp76BI2qNalQ7R3Nv4/CVV3
         miMUA5lBuXH/r5GEdqNzH/5VIwNKe6DBHek3+QQtCguirte+Lo+NqbtJNG6jzxgNFlO8
         GS9xbv1M7RORZUC6h098MAk7yfAiD+O+TTFvIekU2sjdScG4Ff/bAV5SJ91KNOclBkuZ
         X3Rw==
X-Gm-Message-State: AA+aEWbkT4PBQNPfzapo8medObygLFB4QS7txn+6F+++q04TtnfmEi4q
        EIlOklEQG7z/yxTEXmWY/vE=
X-Google-Smtp-Source: AFSGD/UafZLo7Rqajb0J1mrKubAa6TUUBPBAcYt4Rgz/4Jt58KnVddLqRfUmCSQrN18Jwj63L54P1Q==
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr5701381ljg.138.1545033810667;
        Mon, 17 Dec 2018 00:03:30 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id z9sm2444463lfj.79.2018.12.17.00.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 00:03:29 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jgross@suse.com,
        boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
 <20181213154845.GF21184@phenom.ffwll.local>
 <57b468f5-cf7a-0dcd-fef8-fd399025fb45@gmail.com>
 <20181214083519.GI21184@phenom.ffwll.local>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <bcbefc77-82a6-ef7a-e47f-2725332ea0d5@gmail.com>
Date:   Mon, 17 Dec 2018 10:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214083519.GI21184@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 10:35 AM, Daniel Vetter wrote:
> On Fri, Dec 14, 2018 at 09:09:45AM +0200, Oleksandr Andrushchenko wrote:
>> On 12/13/18 5:48 PM, Daniel Vetter wrote:
>>> On Thu, Dec 13, 2018 at 12:17:54PM +0200, Oleksandr Andrushchenko wrote:
>>>> Daniel, could you please comment?
>>> Cross-revieweing someone else's stuff would scale better,
>> fair enough
>>>    I don't think
>>> I'll get around to anything before next year.
>> I put you on CC explicitly because you had comments on other patch [1]
>>
>> and this one tries to solve the issue raised (I tried to figure out
>>
>> at [2] if this is the way to go, but it seems I have no alternative here).
>>
>> While at it [3] (I hope) addresses your comments and the series just
>>
>> needs your single ack/nack to get in: all the rest ack/r-b are already
>>
>> there. Do you mind looking at it?
> As mentioned, much better if you aim for more per review with others, not
> just me. And all that dma coherency stuff isn't something a really
> understand all that well (I just know we have lots of pain). For options
> maybe work together with Gerd Hoffman or Noralf Tronnes, I think either
> has some patches pending that also need some review.

Fair enough,

thank you

> -Daniel
>
>>> -Daniel
>> Thank you very much for your time,
>>
>> Oleksandr
>>
>>>> Thank you
>>>>
>>>> On 11/27/18 12:32 PM, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> When GEM backing storage is allocated with drm_gem_get_pages
>>>>> the backing pages may be cached, thus making it possible that
>>>>> the backend sees only partial content of the buffer which may
>>>>> lead to screen artifacts. Make sure that the frontend's
>>>>> memory is coherent and the backend always sees correct display
>>>>> buffer content.
>>>>>
>>>>> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>>>>>
>>>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>> ---
>>>>>     drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
>>>>>     1 file changed, 48 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>>> index 47ff019d3aef..c592735e49d2 100644
>>>>> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>>> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>>> @@ -33,8 +33,11 @@ struct xen_gem_object {
>>>>>     	/* set for buffers allocated by the backend */
>>>>>     	bool be_alloc;
>>>>> -	/* this is for imported PRIME buffer */
>>>>> -	struct sg_table *sgt_imported;
>>>>> +	/*
>>>>> +	 * this is for imported PRIME buffer or the one allocated via
>>>>> +	 * drm_gem_get_pages.
>>>>> +	 */
>>>>> +	struct sg_table *sgt;
>>>>>     };
>>>>>     static inline struct xen_gem_object *
>>>>> @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
>>>>>     	return xen_obj;
>>>>>     }
>>>>> +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>>>>> +{
>>>>> +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>>> +
>>>>> +	if (!xen_obj->pages)
>>>>> +		return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>>>> +}
>>>>> +
>>>>>     static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>>>     {
>>>>>     	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>>>     	struct xen_gem_object *xen_obj;
>>>>> +	struct address_space *mapping;
>>>>>     	int ret;
>>>>>     	size = round_up(size, PAGE_SIZE);
>>>>> @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>>>     		xen_obj->be_alloc = true;
>>>>>     		return xen_obj;
>>>>>     	}
>>>>> +
>>>>>     	/*
>>>>>     	 * need to allocate backing pages now, so we can share those
>>>>>     	 * with the backend
>>>>>     	 */
>>>>> +	mapping = xen_obj->base.filp->f_mapping;
>>>>> +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
>>>>> +
>>>>>     	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>>>     	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>>>>>     	if (IS_ERR_OR_NULL(xen_obj->pages)) {
>>>>> @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>>>>>     		goto fail;
>>>>>     	}
>>>>> +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
>>>>> +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
>>>>> +		ret = PTR_ERR(xen_obj->sgt);
>>>>> +		xen_obj->sgt = NULL;
>>>>> +		goto fail_put_pages;
>>>>> +	}
>>>>> +
>>>>> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>>>> +			DMA_BIDIRECTIONAL)) {
>>>>> +		ret = -EFAULT;
>>>>> +		goto fail_free_sgt;
>>>>> +	}
>>>>> +
>>>>>     	return xen_obj;
>>>>> +fail_free_sgt:
>>>>> +	sg_free_table(xen_obj->sgt);
>>>>> +	xen_obj->sgt = NULL;
>>>>> +fail_put_pages:
>>>>> +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
>>>>> +	xen_obj->pages = NULL;
>>>>>     fail:
>>>>>     	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>>>>>     	return ERR_PTR(ret);
>>>>> @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>>>     	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>>>     	if (xen_obj->base.import_attach) {
>>>>> -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
>>>>> +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
>>>>>     		gem_free_pages_array(xen_obj);
>>>>>     	} else {
>>>>>     		if (xen_obj->pages) {
>>>>> @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>>>     							xen_obj->pages);
>>>>>     				gem_free_pages_array(xen_obj);
>>>>>     			} else {
>>>>> +				if (xen_obj->sgt) {
>>>>> +					dma_unmap_sg(xen_obj->base.dev->dev,
>>>>> +						     xen_obj->sgt->sgl,
>>>>> +						     xen_obj->sgt->nents,
>>>>> +						     DMA_BIDIRECTIONAL);
>>>>> +					sg_free_table(xen_obj->sgt);
>>>>> +				}
>>>>>     				drm_gem_put_pages(&xen_obj->base,
>>>>>     						  xen_obj->pages, true, false);
>>>>>     			}
>>>>> @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
>>>>>     	return xen_obj->pages;
>>>>>     }
>>>>> -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>>>>> -{
>>>>> -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>>> -
>>>>> -	if (!xen_obj->pages)
>>>>> -		return ERR_PTR(-ENOMEM);
>>>>> -
>>>>> -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>>>> -}
>>>>> -
>>>>>     struct drm_gem_object *
>>>>>     xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>>>>>     				  struct dma_buf_attachment *attach,
>>>>> @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>>>>>     	if (ret < 0)
>>>>>     		return ERR_PTR(ret);
>>>>> -	xen_obj->sgt_imported = sgt;
>>>>> +	xen_obj->sgt = sgt;
>>>>>     	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
>>>>>     					       NULL, xen_obj->num_pages);
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> [1] https://patchwork.kernel.org/patch/10693787/
>>
>> [2] https://lists.xen.org/archives/html/xen-devel/2018-11/msg02882.html
>>
>> [3] https://patchwork.kernel.org/patch/10705853/
>>
>>
