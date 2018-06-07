Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Vr8mMiPcGFv0YgAAmS7hNA
	; Thu, 07 Jun 2018 07:17:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3D6C608B8; Thu,  7 Jun 2018 07:17:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqQgH8Ox"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 14204605A2;
	Thu,  7 Jun 2018 07:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14204605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeFGHRx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:17:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39125 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeFGHRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:17:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id t134-v6so13003199lff.6;
        Thu, 07 Jun 2018 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E3iHG2JWghxF6FWC6gLANrZCoMi0uKfX+Lqvj+6B4YE=;
        b=JqQgH8OxIaXW3tZGrX0simLwxL9pSfRKLtr1EyURw9FArYkaQvsRhPwjo7ydaFs12D
         g86FXjLNgOB3QuvurPo0DKAh6RjbCRIUdq6QdN1XSSdVeWiqqiny4v9L1QkTPRS1eiS+
         5nihBDHCXTeugLIlayCHkiYziMDDQK6PI9XtfKoPnl2UJvlDlACln/wJ4nvU9xDZAISr
         IxJkp8ATjfS+IuubOV6wITifha/IolmCI4i1qZtJ9bVhHHJvAadaAAYLSuu0E0oKIMd0
         7+3YZUsX08YPhgXy/fw7g2tGPra9eZNVl6+Zyber1zy61vgyFZUU+0DCVUUVF2wcdsXV
         54gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E3iHG2JWghxF6FWC6gLANrZCoMi0uKfX+Lqvj+6B4YE=;
        b=b/w3NJ0eL9CAc1aJe3eSuL12yilUBRcCNxr173m4PWTEGvJyczGhpbH1EPLs50sHWB
         86VJ5cDgxBac85WgK5h8XfOM+UCReUl8wa5r0VvcI+oESqEEDpf1lGD+44tqasVd2F4X
         ut/u2EAjMbPjhPFhO+Tc3qS+NLhS7J22OUu1m4CJK+kWOFacg/WLnidNnJ/Hz4Nxqu7k
         /YMGAMP0DfGrLBQeNo1uHMmBW7gelOqOWvtr2X2whIoZm6dYiOuDWIECS1kjsYS3xFvj
         ztkOiOW/tJe7Xb8tmA6MKCh93YSeK1WCjlQfllkqhQY1Ef1hko367coYCPydGN/8zCEv
         Ailw==
X-Gm-Message-State: APt69E2R7dLf0Ba8p2iK9mVBSSxTzjeO4MvrbVQpvKCVl2rQrfrkPQhv
        JjNxygT6jm0ljJkt4DSTTZY=
X-Google-Smtp-Source: ADUXVKLXhEPKL9KlrD320WW0XnXlZpZpGf+60EqzQdvlbw6gWyqF8A8t9zoYnFn9QvLA0/wKXtdr6Q==
X-Received: by 2002:a19:5ad4:: with SMTP id y81-v6mr527747lfk.82.1528355869455;
        Thu, 07 Jun 2018 00:17:49 -0700 (PDT)
Received: from [10.17.182.9] (ll-55.209.223.85.sovam.net.ua. [85.223.209.55])
        by smtp.gmail.com with ESMTPSA id c74-v6sm6703916lfh.78.2018.06.07.00.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 00:17:48 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] xen/gntdev: Add initial support for dma-buf UAPI
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-7-andr2000@gmail.com>
 <29c1f1fb-2d52-e3df-adce-44fdee135413@oracle.com>
 <d2bbda68-af74-58b1-36a6-d8af47ad8beb@gmail.com>
 <7c73fae9-2dac-f3e8-bad8-0dadb73ad7af@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <4e15c758-a314-9fdc-1d70-4a465137a6f9@gmail.com>
Date: Thu, 7 Jun 2018 10:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7c73fae9-2dac-f3e8-bad8-0dadb73ad7af@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 12:32 AM, Boris Ostrovsky wrote:
> On 06/06/2018 05:06 AM, Oleksandr Andrushchenko wrote:
>> On 06/04/2018 11:49 PM, Boris Ostrovsky wrote:
>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>> +struct gntdev_dmabuf_export_args {
>>> +    int dummy;
>>> +};
>>>
>>> Please define the full structure (at least what you have in the next
>>> patch) here.
>> Ok, will define what I have in the next patch, but won't
>> initialize anything until the next patch. Will this work for you?
> Sure, I just didn't see the need for the dummy argument that you remove
> later.
Ok
>>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>>> index 9813fc440c70..7d58dfb3e5e8 100644
>>>> --- a/drivers/xen/gntdev.c
>>>> +++ b/drivers/xen/gntdev.c
>>> ...
>>>
>>>>    +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>>> This code belongs in gntdev-dmabuf.c.
>> The reason I have this code here is that it is heavily
>> tied to gntdev's internal functionality, e.g. map/unmap.
>> I do not want to extend gntdev's API, so gntdev-dmabuf can
>> access these. What is more dma-buf doesn't need to know about
>> maps done by gntdev as there is no use of that information
>> in gntdev-dmabuf. So, it seems more naturally to have
>> dma-buf's related map/unmap code where it is: in gntdev.
> Sorry, I don't follow. Why would this require extending the API? It's
> just moving routines to a different file that is linked to the same module.
I do understand your intention here and tried to avoid dma-buf
related code in gntdev.c as much as possible. So, let me explain
my decision in more detail.

There are 2 use-cases we have: dma-buf import and export.

While importing a dma-buf all the dma-buf related functionality can
easily be kept inside gntdev-dmabuf.c w/o any issue as all we need
from gntdev.c is dev, dma_buf_fd, count and domid for that.

But in case of dma-buf export we need to:
1. struct grant_map *map = gntdev_alloc_map(priv, count, dmabuf_flags);
2. gntdev_add_map(priv, map);
3. Set map->flags
4. ret = map_grant_pages(map);
5. And only now we are all set to export the new dma-buf from *map->pages*

So, until 5) we use private gtndev.c's API not exported to outside world:
a. struct grant_map
b. static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, 
int count,
                       int dma_flags)
c. static void gntdev_add_map(struct gntdev_priv *priv, struct grant_map 
*add)
d. static int map_grant_pages(struct grant_map *map)

Thus, all the above cannot be accessed from gntdev-dmabuf.c
This is why I say that gntdev.c's API will need to be extended to 
provide the above
a-d if we want all dma-buf export code to leave in gntdev-dmabuf.c.
But that doesn't seem good to me and what is more a-d are really gntdev.c's
functionality, not dma-buf's which only needs pages and doesn't really 
care from
where those come.
That was the reason I partitioned export into 2 chunks: gntdev + 
gntdev-dmabuf.

You might also ask why importing side does Xen related things (granting 
references+)
in gntdev-dmabuf, not gntdev so it is consistent with the dma-buf exporter?
This is because importer uses grant-table's API which seems to be not 
natural for gntdev.c,
so it can leave in gntdev-dmabuf.c which has a use-case for that, while 
gntdev
remains the same.
> Since this is under CONFIG_XEN_GNTDEV_DMABUF then why shouldn't it be in
> gntdev-dmabuf.c? In my view that's the file where all dma-related
> "stuff" lives.
Agree, but IMO grant_map stuff for dma-buf importer is right in its 
place in gntdev.c
and all the rest of dma-buf specifics live in gntdev-dmabuf.c as they should
>
> -boris
>
>
> -boris
>
Thank you,
Oleksandr
