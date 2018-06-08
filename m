Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4R/yDqNpGltHVQAAmS7hNA
	; Fri, 08 Jun 2018 11:33:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 023C4607DC; Fri,  8 Jun 2018 11:33:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbZqLQwI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E9E9D607A4;
	Fri,  8 Jun 2018 11:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9E9D607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeFHLdw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:33:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45536 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeFHLdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:33:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so19542789lfe.12;
        Fri, 08 Jun 2018 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JgZ/ul28uqQfT9tgD1LT5tQNwVBWuuUwaCej6LduFXQ=;
        b=QbZqLQwIFoYFBRoR1gB0aSmO0E8LZJU9GxUXq9l8ExF5Uw9bYUk5ILJjMtVlf/QJ7E
         yDO+1/oKfZT7N3+aGTxt3qX3FB61D6S/UbsQy62uOOZgOnRr5l1WSqZjYfjAz3wuhIIx
         B9j/X0bzLS/lZb/6P3QU7WWkdUkZdiOVgm9HxTJpK0n+sB0nWGA8Je0yGngrWRqfbq+E
         nxVF+Y7OUrhmCmY0x/XGKvo3LbItfPR56tN+/2LanZy19cWc+EMcHhUaWrSMuEVHTF2Y
         qUw3y7RvrLEZnb2NxKlypdZv3BzZDFfcaF5xRAnfpCU+qp+/KdLmKYlAc8MazYCCUi1Q
         clFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JgZ/ul28uqQfT9tgD1LT5tQNwVBWuuUwaCej6LduFXQ=;
        b=F8ATtns/3LK8Te5sTXRdZ4+umXfbbeRhZ/8a1Sh6MGRbAu7gdwYRtC73DnNCjV9BAf
         /nQWXQqoEU1GhB6tSFrcIbsaZVxzop5lLLzarcfnZuA2tRIkmar2Hjr6kcRK+//emfxe
         tJQ4m1p4p+LdBOLbtdEHyWBletMkZZDdr/mbWVEp31SjyHO2JLLRbcZilAdxmTly5G2C
         QlpSFeWIpqOneqVhXmXxg8taGcRttf+8HkHeKha3s6EJu1HeJ2QXVL2fADhOQqbYtxHP
         74+mMOI1H4BNw/tdKQukL8Bj87iwmEdN+4LYPVTJE1snRVoUnfqXI4wCuw/C0qh6Rj+s
         1iPg==
X-Gm-Message-State: APt69E2B1hQp/Vtv6U4e3N8uNs06Yoin1ovTDb1S+EeocGGNn+h+huK0
        YuvYjGR3BjGTiEdXtXPmOtI=
X-Google-Smtp-Source: ADUXVKJ1kBjz9x2YsAtFMwd+MyIbgHqTaBikT3vgIyz9iwndhQAbOahHOSJmJAPNsxsnzhm7mXx91A==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr4254470ljc.29.1528457628098;
        Fri, 08 Jun 2018 04:33:48 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id i21-v6sm3581697lfa.18.2018.06.08.04.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 04:33:47 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com,
        Stefano Stabellini <sstabellini@kernel.org>
Cc: daniel.vetter@intel.com, matthew.d.roper@intel.com,
        dongwon.kim@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-6-andr2000@gmail.com>
 <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com>
 <84217eac-b83b-710f-39ab-c93cad65bf9a@gmail.com>
 <a172746d-7a97-159f-71a7-511b2d239089@oracle.com>
 <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com>
 <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <4be24882-185d-01e3-6aa1-751e341433c7@gmail.com>
Date: Fri, 8 Jun 2018 14:33:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 12:46 AM, Boris Ostrovsky wrote:
> (Stefano, question for you at the end)
>
> On 06/07/2018 02:39 AM, Oleksandr Andrushchenko wrote:
>> On 06/07/2018 12:19 AM, Boris Ostrovsky wrote:
>>> On 06/06/2018 04:14 AM, Oleksandr Andrushchenko wrote:
>>>> On 06/04/2018 11:12 PM, Boris Ostrovsky wrote:
>>>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>>>> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map
>>>>> *map)
>>>>>         if (map == NULL)
>>>>>             return;
>>>>>     +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> *Option 1: kfree(map->frames);*
>>>>> +    if (map->dma_vaddr) {
>>>>> +        struct gnttab_dma_alloc_args args;
>>>>> +
>>>>> +        args.dev = map->dma_dev;
>>>>> +        args.coherent = map->dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>>>>> +        args.nr_pages = map->count;
>>>>> +        args.pages = map->pages;
>>>>> +        args.frames = map->frames;
>>>>> +        args.vaddr = map->dma_vaddr;
>>>>> +        args.dev_bus_addr = map->dma_bus_addr;
>>>>> +
>>>>> +        gnttab_dma_free_pages(&args);
>> *Option 2: kfree(map->frames);*
>>>>> +    } else
>>>>> +#endif
>>>>>         if (map->pages)
>>>>>             gnttab_free_pages(map->count, map->pages);
>>>>> +
>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>> +    kfree(map->frames);
>>>>> +#endif
>>>>>
>>>>> Can this be done under if (map->dma_vaddr) ?
>>>>>     In other words, is it
>>>>> possible for dma_vaddr to be NULL and still have unallocated frames
>>>>> pointer?
>>>> It is possible to have vaddr == NULL and frames != NULL as we
>>>> allocate frames outside of gnttab_dma_alloc_pages which
>>>> may fail. Calling kfree on NULL pointer is safe,
>>> I am not questioning safety of the code, I would like avoid another
>>> ifdef.
>> Ah, I now understand, so you are asking if we can have
>> that kfree(map->frames); in the place *Option 2* I marked above.
>> Unfortunately no: map->frames is allocated before we try to
>> allocate DMA memory, e.g. before dma_vaddr is set:
>> [...]
>>          add->frames = kcalloc(count, sizeof(add->frames[0]),
>>                        GFP_KERNEL);
>>          if (!add->frames)
>>              goto err;
>>
>> [...]
>>          if (gnttab_dma_alloc_pages(&args))
>>              goto err;
>>
>>          add->dma_vaddr = args.vaddr;
>> [...]
>> err:
>>      gntdev_free_map(add);
>>
>> So, it is possible to enter gntdev_free_map with
>> frames != NULL and dma_vaddr == NULL. Option 1 above cannot be used
>> as map->frames is needed for gnttab_dma_free_pages(&args);
>> and Option 2 cannot be used as frames != NULL and dma_vaddr == NULL.
>> Thus, I think that unfortunately we need that #ifdef.
>> Option 3 below can also be considered, but that seems to be not good
>> as we free resources in different places which looks inconsistent.
>
> I was only thinking of option 2. But if it is possible to have frames !=
> NULL and dma_vaddr == NULL then perhaps we indeed will have to live with
> the extra ifdef.
ok
>
>> Sorry if I'm still missing your point.
>>>> so
>>>> I see no reason to change this code.
>>>>>>         kfree(map->pages);
>>>>>>         kfree(map->grants);
>>>>>>         kfree(map->map_ops);
>>>>>> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map
>>>>>> *map)
>>>>>>         kfree(map);
>>>>>>     }
>>>>>>     -static struct grant_map *gntdev_alloc_map(struct gntdev_priv
>>>>>> *priv, int count)
>>>>>> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv,
>>>>>> int count,
>>>>>> +                      int dma_flags)
>>>>>>     {
>>>>>>         struct grant_map *add;
>>>>>>         int i;
>>>>>> @@ -155,6 +200,37 @@ static struct grant_map
>>>>>> *gntdev_alloc_map(struct gntdev_priv *priv, int count)
>>>>>>             NULL == add->pages)
>>>>>>             goto err;
>>>>>>     +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>> +    add->dma_flags = dma_flags;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Check if this mapping is requested to be backed
>>>>>> +     * by a DMA buffer.
>>>>>> +     */
>>>>>> +    if (dma_flags & (GNTDEV_DMA_FLAG_WC |
>>>>>> GNTDEV_DMA_FLAG_COHERENT)) {
>>>>>> +        struct gnttab_dma_alloc_args args;
>>>>>> +
>>>>>> +        add->frames = kcalloc(count, sizeof(add->frames[0]),
>>>>>> +                      GFP_KERNEL);
>>>>>> +        if (!add->frames)
>>>>>> +            goto err;
>>>>>> +
>>>>>> +        /* Remember the device, so we can free DMA memory. */
>>>>>> +        add->dma_dev = priv->dma_dev;
>>>>>> +
>>>>>> +        args.dev = priv->dma_dev;
>>>>>> +        args.coherent = dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>>>>>> +        args.nr_pages = count;
>>>>>> +        args.pages = add->pages;
>>>>>> +        args.frames = add->frames;
>>>>>> +
>>>>>> +        if (gnttab_dma_alloc_pages(&args))
>> *Option 3: kfree(map->frames);*
>>>>>> +            goto err;
>>>>>> +
>>>>>> +        add->dma_vaddr = args.vaddr;
>>>>>> +        add->dma_bus_addr = args.dev_bus_addr;
>>>>>> +    } else
>>>>>> +#endif
>>>>>>         if (gnttab_alloc_pages(count, add->pages))
>>>>>>             goto err;
>>>>>>     @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map
>>>>>> *map)
>>>>>>             map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>>>>             if (use_ptemod)
>>>>>>                 map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>> +        else if (map->dma_vaddr) {
>>>>>> +            unsigned long mfn;
>>>>>> +
>>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>> Not pfn_to_mfn()?
>>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM: [1]
>>>> and [2]
>>>> Thus,
>>>>
>>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of function
>>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>>       mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>
>>>> So, I'll keep __pfn_to_mfn
>>> How will this work on non-PV x86?
>> So, you mean I need:
>> #ifdef CONFIG_X86
>> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>> #else
>> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>> #endif
>>
> I'd rather fix it in ARM code. Stefano, why does ARM uses the
> underscored version?
Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
with static inline for ARM? e.g.
static inline ...pfn_to_mfn(...)
{
     __pfn_to_mfn();
}
>
> -boris
>
Thank you,
Oleksandr
