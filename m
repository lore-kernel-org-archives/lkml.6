Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k8OcNfymGVseCwAAmS7hNA
	; Thu, 07 Jun 2018 21:43:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BBDA8606FA; Thu,  7 Jun 2018 21:43:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m/zZLD5q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D77D1601B4;
	Thu,  7 Jun 2018 21:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D77D1601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeFGVnV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:43:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeFGVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:43:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57LfYJN018374;
        Thu, 7 Jun 2018 21:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=q2Fg2n/ZiSsqgu6n2tvxmhD6vK3OFQHJrc7zmAU7SRk=;
 b=m/zZLD5q6CGD9vIc/9XVdEtDlptSfYy/aGUIb1QtcWJuSK23ach+RRfsesglmbPa2LHC
 8B4TX8+VZpVvUNGd6LMr+I0VZXEEDEbYE5p1If8bKzACdRUPe5JlOjfzV/5JXoH+90Lo
 MaWMtX7OTUiQWuKMTQxPUb45ely0x2zY1qDVu2t3re7PhAtewJJLvcxqiZxlx0NqTcOw
 tR04W6YYPEitRBkIBS6lAORdcI7kUOFkTRvoYiSad2FDHZODfIpiQnpL/+SeEy3XHeB2
 w5kNjeJSkap9Csk2wGwLyR8nTFN4LERv1hs+crIR7I2OwD/EptbkKovvxbE9N6cF2C9Q Hw==
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jbvypjqts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 21:43:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w57Lh4V8013994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 21:43:04 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w57Lh35e011763;
        Thu, 7 Jun 2018 21:43:03 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 14:43:03 -0700
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
Date: Thu, 7 Jun 2018 17:46:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Stefano, question for you at the end)

On 06/07/2018 02:39 AM, Oleksandr Andrushchenko wrote:
> On 06/07/2018 12:19 AM, Boris Ostrovsky wrote:
>> On 06/06/2018 04:14 AM, Oleksandr Andrushchenko wrote:
>>> On 06/04/2018 11:12 PM, Boris Ostrovsky wrote:
>>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>>> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map
>>>> *map)
>>>>        if (map == NULL)
>>>>            return;
>>>>    +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> *Option 1: kfree(map->frames);*
>>>> +    if (map->dma_vaddr) {
>>>> +        struct gnttab_dma_alloc_args args;
>>>> +
>>>> +        args.dev = map->dma_dev;
>>>> +        args.coherent = map->dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>>>> +        args.nr_pages = map->count;
>>>> +        args.pages = map->pages;
>>>> +        args.frames = map->frames;
>>>> +        args.vaddr = map->dma_vaddr;
>>>> +        args.dev_bus_addr = map->dma_bus_addr;
>>>> +
>>>> +        gnttab_dma_free_pages(&args);
> *Option 2: kfree(map->frames);*
>>>> +    } else
>>>> +#endif
>>>>        if (map->pages)
>>>>            gnttab_free_pages(map->count, map->pages);
>>>> +
>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>> +    kfree(map->frames);
>>>> +#endif
>>>>
>>>> Can this be done under if (map->dma_vaddr) ?
>>>>    In other words, is it
>>>> possible for dma_vaddr to be NULL and still have unallocated frames
>>>> pointer?
>>> It is possible to have vaddr == NULL and frames != NULL as we
>>> allocate frames outside of gnttab_dma_alloc_pages which
>>> may fail. Calling kfree on NULL pointer is safe,
>>
>> I am not questioning safety of the code, I would like avoid another
>> ifdef.
> Ah, I now understand, so you are asking if we can have
> that kfree(map->frames); in the place *Option 2* I marked above.
> Unfortunately no: map->frames is allocated before we try to
> allocate DMA memory, e.g. before dma_vaddr is set:
> [...]
>         add->frames = kcalloc(count, sizeof(add->frames[0]),
>                       GFP_KERNEL);
>         if (!add->frames)
>             goto err;
>
> [...]
>         if (gnttab_dma_alloc_pages(&args))
>             goto err;
>
>         add->dma_vaddr = args.vaddr;
> [...]
> err:
>     gntdev_free_map(add);
>
> So, it is possible to enter gntdev_free_map with
> frames != NULL and dma_vaddr == NULL. Option 1 above cannot be used
> as map->frames is needed for gnttab_dma_free_pages(&args);
> and Option 2 cannot be used as frames != NULL and dma_vaddr == NULL.
> Thus, I think that unfortunately we need that #ifdef.
> Option 3 below can also be considered, but that seems to be not good
> as we free resources in different places which looks inconsistent.


I was only thinking of option 2. But if it is possible to have frames !=
NULL and dma_vaddr == NULL then perhaps we indeed will have to live with
the extra ifdef.


>
> Sorry if I'm still missing your point.
>>
>>> so
>>> I see no reason to change this code.
>>>>>        kfree(map->pages);
>>>>>        kfree(map->grants);
>>>>>        kfree(map->map_ops);
>>>>> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map
>>>>> *map)
>>>>>        kfree(map);
>>>>>    }
>>>>>    -static struct grant_map *gntdev_alloc_map(struct gntdev_priv
>>>>> *priv, int count)
>>>>> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv,
>>>>> int count,
>>>>> +                      int dma_flags)
>>>>>    {
>>>>>        struct grant_map *add;
>>>>>        int i;
>>>>> @@ -155,6 +200,37 @@ static struct grant_map
>>>>> *gntdev_alloc_map(struct gntdev_priv *priv, int count)
>>>>>            NULL == add->pages)
>>>>>            goto err;
>>>>>    +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>> +    add->dma_flags = dma_flags;
>>>>> +
>>>>> +    /*
>>>>> +     * Check if this mapping is requested to be backed
>>>>> +     * by a DMA buffer.
>>>>> +     */
>>>>> +    if (dma_flags & (GNTDEV_DMA_FLAG_WC |
>>>>> GNTDEV_DMA_FLAG_COHERENT)) {
>>>>> +        struct gnttab_dma_alloc_args args;
>>>>> +
>>>>> +        add->frames = kcalloc(count, sizeof(add->frames[0]),
>>>>> +                      GFP_KERNEL);
>>>>> +        if (!add->frames)
>>>>> +            goto err;
>>>>> +
>>>>> +        /* Remember the device, so we can free DMA memory. */
>>>>> +        add->dma_dev = priv->dma_dev;
>>>>> +
>>>>> +        args.dev = priv->dma_dev;
>>>>> +        args.coherent = dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>>>>> +        args.nr_pages = count;
>>>>> +        args.pages = add->pages;
>>>>> +        args.frames = add->frames;
>>>>> +
>>>>> +        if (gnttab_dma_alloc_pages(&args))
> *Option 3: kfree(map->frames);*
>>>>> +            goto err;
>>>>> +
>>>>> +        add->dma_vaddr = args.vaddr;
>>>>> +        add->dma_bus_addr = args.dev_bus_addr;
>>>>> +    } else
>>>>> +#endif
>>>>>        if (gnttab_alloc_pages(count, add->pages))
>>>>>            goto err;
>>>>>    @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map
>>>>> *map)
>>>>>            map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>>>            if (use_ptemod)
>>>>>                map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>> +        else if (map->dma_vaddr) {
>>>>> +            unsigned long mfn;
>>>>> +
>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>> Not pfn_to_mfn()?
>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM: [1]
>>> and [2]
>>> Thus,
>>>
>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of function
>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>      mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>
>>> So, I'll keep __pfn_to_mfn
>>
>> How will this work on non-PV x86?
> So, you mean I need:
> #ifdef CONFIG_X86
> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
> #else
> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
> #endif
>

I'd rather fix it in ARM code. Stefano, why does ARM uses the
underscored version?


-boris
