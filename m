Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DAAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417CC21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAMCQDx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbeLTLYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:24:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34008 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:24:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so1218201lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CHWwXCP2hZJFuW/LTGJZeYjfTw7LLfqQvfy5uQk+IlA=;
        b=eAMCQDx7xo8ZFqZ7PzgVtT3x6jAJOoPrs1JcjuyV5PkSg2imfd83ZMQ3KqQCDJ0s7X
         FELEwdCEgtIKrYEHH4i+JeJWJp0BazaDXt33amY/Fy61xEPZ0LtiTz2E+9bMN4xJYACC
         w/YdWUW/NFiAEqfVZrhUUXry3XSGINtx1pVptiHRfokgyo6MJaWzSSdrJRGNuNuZjRKx
         0MdvAge3kLLHr8eKxkCwTRgCTw4R08idQwc95HzG44wafDmptXjaM0uZ0fY8kHQE8OHB
         z0Um5twQti4jhBcubXa0Uae6x3BxZd7/nvw6BXC5/S77nBxs3J5M+eaSRb8IDqtMuUUd
         enXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CHWwXCP2hZJFuW/LTGJZeYjfTw7LLfqQvfy5uQk+IlA=;
        b=gRs5zfMJSgik3FCGoZwo2NQa3Cl07TV86x8Jf7yzhFtHzD6yfaT51899yNuChobxTV
         AxSjp8mX7cH38SZvwqbA51vSo09GwdD2RL9RPtPerXPQRLlnTrpY/3ZE0oWWnULeK8Iu
         UVvs+pNTzxtXuDveGWcGT4slBkKq4I34K3scZbrb57yibxSNAuTFcJKqB7dgQXZodSL8
         F/KbdHWolXbiMkJX3KkvCMuYTv8FIBSDUHWtbegfdf08FEVP7jZoGl3U4xZ7FeokZkQ8
         46zceHlqdI7yJ79UWKyMfB2Ji5hjerExv2nzaOOz866Aq2WRDKkazd4YoAs8OxwFVPiN
         GBFg==
X-Gm-Message-State: AA+aEWYMhCUhEzwTgIiQk3cJKPB/33HO2INvbm17avZqT/JycPGS+bJd
        xQlavXcFRJEdCSTHfM4WwN4=
X-Google-Smtp-Source: AFSGD/XfeiEmvPsgWW7UTFlbpCDr47FkQLt4WqpMvmaiUKIBnTHwkaJTTNaWwfwkh6yuNK4/eRQbTw==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr6697983ljg.160.1545305076585;
        Thu, 20 Dec 2018 03:24:36 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id v11-v6sm4037058ljc.57.2018.12.20.03.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 03:24:36 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Gerd Hoffmann <kraxel@redhat.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
 <96086dbe-8065-2d0d-e5f6-4932ffbf956e@tronnes.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <18fb3bb8-5682-b156-8299-7ac03463ce23@gmail.com>
Date:   Thu, 20 Dec 2018 13:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <96086dbe-8065-2d0d-e5f6-4932ffbf956e@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 6:14 PM, Noralf Trønnes wrote:
>
> Den 19.12.2018 09.18, skrev Oleksandr Andrushchenko:
>> On 12/18/18 9:20 PM, Noralf Trønnes wrote:
>>>
>>> Den 27.11.2018 11.32, skrev Oleksandr Andrushchenko:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> When GEM backing storage is allocated with drm_gem_get_pages
>>>> the backing pages may be cached, thus making it possible that
>>>> the backend sees only partial content of the buffer which may
>>>> lead to screen artifacts. Make sure that the frontend's
>>>> memory is coherent and the backend always sees correct display
>>>> buffer content.
>>>>
>>>> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display 
>>>> frontend")
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko 
>>>> <oleksandr_andrushchenko@epam.com>
>>>> ---
>>>>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 
>>>> +++++++++++++++++++------
>>>>   1 file changed, 48 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c 
>>>> b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>> index 47ff019d3aef..c592735e49d2 100644
>>>> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>> @@ -33,8 +33,11 @@ struct xen_gem_object {
>>>>       /* set for buffers allocated by the backend */
>>>>       bool be_alloc;
>>>>   -    /* this is for imported PRIME buffer */
>>>> -    struct sg_table *sgt_imported;
>>>> +    /*
>>>> +     * this is for imported PRIME buffer or the one allocated via
>>>> +     * drm_gem_get_pages.
>>>> +     */
>>>> +    struct sg_table *sgt;
>>>>   };
>>>>     static inline struct xen_gem_object *
>>>> @@ -77,10 +80,21 @@ static struct xen_gem_object 
>>>> *gem_create_obj(struct drm_device *dev,
>>>>       return xen_obj;
>>>>   }
>>>>   +struct sg_table *xen_drm_front_gem_get_sg_table(struct 
>>>> drm_gem_object *gem_obj)
>>>> +{
>>>> +    struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>> +
>>>> +    if (!xen_obj->pages)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>>> +}
>>>> +
>>>>   static struct xen_gem_object *gem_create(struct drm_device *dev, 
>>>> size_t size)
>>>>   {
>>>>       struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>>       struct xen_gem_object *xen_obj;
>>>> +    struct address_space *mapping;
>>>>       int ret;
>>>>         size = round_up(size, PAGE_SIZE);
>>>> @@ -113,10 +127,14 @@ static struct xen_gem_object 
>>>> *gem_create(struct drm_device *dev, size_t size)
>>>>           xen_obj->be_alloc = true;
>>>>           return xen_obj;
>>>>       }
>>>> +
>>>>       /*
>>>>        * need to allocate backing pages now, so we can share those
>>>>        * with the backend
>>>>        */
>>>
>>>
>>> Let's see if I understand what you're doing:
>>>
>>> Here you say that the pages should be DMA accessible for devices 
>>> that can
>>> only see 4GB.
>>
>> Yes, your understanding is correct. As we are a para-virtualized 
>> device we
>>
>> do not have strict requirements for 32-bit DMA. But, via dma-buf export,
>>
>> the buffer we create can be used by real HW, e.g. one can pass-through
>>
>> real HW devices into a guest domain and they can import our buffer (yes,
>>
>> they can be IOMMU backed and other conditions may apply).
>>
>> So, this is why we are limiting to DMA32 here, just to allow more 
>> possible
>>
>> use-cases
>>
>>>
>>>> +    mapping = xen_obj->base.filp->f_mapping;
>>>> +    mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
>>>> +
>>>>       xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>>       xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>>>>       if (IS_ERR_OR_NULL(xen_obj->pages)) {
>>>> @@ -125,8 +143,27 @@ static struct xen_gem_object 
>>>> *gem_create(struct drm_device *dev, size_t size)
>>>>           goto fail;
>>>>       }
>>>>   +    xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
>>>> +    if (IS_ERR_OR_NULL(xen_obj->sgt)){
>>>> +        ret = PTR_ERR(xen_obj->sgt);
>>>> +        xen_obj->sgt = NULL;
>>>> +        goto fail_put_pages;
>>>> +    }
>>>> +
>>>> +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>>> +            DMA_BIDIRECTIONAL)) {
>>>
>>>
>>> Are you using the DMA streaming API as a way to flush the caches?
>> Yes
>>> Does this mean that GFP_USER isn't making the buffer coherent?
>>
>> No, it didn't help. I had a question [1] if there are any other 
>> better way
>>
>> to achieve the same, but didn't have any response yet. So, I implemented
>>
>> it via DMA API which helped.
>
> As Gerd says asking on the arm list is probably the best way of finding a
> future proof solution and understanding what's going on.
Yes, it seems so
>
> But if you don't get any help there and you end up with the present
> solution I suggest you add a comment that this is for flushing the caches
> on arm. With the current code one can be led to believe that the driver
> uses the dma address somewhere.
Makes sense
>
> What about x86, does the problem exist there?
>
Yes, but there I could do drm_clflush_pages which is not implemented for ARM
> I wonder if you can call dma_unmap_sg() right away since the flushing has
> already happened. That would contain this flushing "hack" inside the
> gem_create function.
Yes, I was thinking about this "solution" as well
>
> I also suggest calling drm_prime_pages_to_sg() directly to increase
> readability, since the check in xen_drm_front_gem_get_sg_table() isn't
> necessary for this use case.
This can be done
>
>
> Noralf.
>
>
>>
>>>
>>> Noralf.
>>>
>>>> +        ret = -EFAULT;
>>>> +        goto fail_free_sgt;
>>>> +    }
>>>> +
>>>>       return xen_obj;
>>>>   +fail_free_sgt:
>>>> +    sg_free_table(xen_obj->sgt);
>>>> +    xen_obj->sgt = NULL;
>>>> +fail_put_pages:
>>>> +    drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
>>>> +    xen_obj->pages = NULL;
>>>>   fail:
>>>>       DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>>>>       return ERR_PTR(ret);
>>>> @@ -149,7 +186,7 @@ void 
>>>> xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>>       struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>>         if (xen_obj->base.import_attach) {
>>>> -        drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
>>>> +        drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
>>>>           gem_free_pages_array(xen_obj);
>>>>       } else {
>>>>           if (xen_obj->pages) {
>>>> @@ -158,6 +195,13 @@ void 
>>>> xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>>>>                               xen_obj->pages);
>>>>                   gem_free_pages_array(xen_obj);
>>>>               } else {
>>>> +                if (xen_obj->sgt) {
>>>> + dma_unmap_sg(xen_obj->base.dev->dev,
>>>> +                             xen_obj->sgt->sgl,
>>>> +                             xen_obj->sgt->nents,
>>>> +                             DMA_BIDIRECTIONAL);
>>>> +                    sg_free_table(xen_obj->sgt);
>>>> +                }
>>>>                   drm_gem_put_pages(&xen_obj->base,
>>>>                             xen_obj->pages, true, false);
>>>>               }
>>>> @@ -174,16 +218,6 @@ struct page 
>>>> **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
>>>>       return xen_obj->pages;
>>>>   }
>>>>   -struct sg_table *xen_drm_front_gem_get_sg_table(struct 
>>>> drm_gem_object *gem_obj)
>>>> -{
>>>> -    struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>>>> -
>>>> -    if (!xen_obj->pages)
>>>> -        return ERR_PTR(-ENOMEM);
>>>> -
>>>> -    return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>>>> -}
>>>> -
>>>>   struct drm_gem_object *
>>>>   xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>>>>                     struct dma_buf_attachment *attach,
>>>> @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct 
>>>> drm_device *dev,
>>>>       if (ret < 0)
>>>>           return ERR_PTR(ret);
>>>>   -    xen_obj->sgt_imported = sgt;
>>>> +    xen_obj->sgt = sgt;
>>>>         ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
>>>>                              NULL, xen_obj->num_pages);
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> Thank you,
>>
>> Oleksandr
>>
>> [1] 
>> https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg31745.html
>>
Thank you,
Oleksandr
