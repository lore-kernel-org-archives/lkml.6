Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BRigMaVqGlsEZgAAmS7hNA
	; Fri, 08 Jun 2018 11:38:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1E4C2607DC; Fri,  8 Jun 2018 11:38:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMCV3aw9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C469602FC;
	Fri,  8 Jun 2018 11:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C469602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHLih (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:38:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44301 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:38:35 -0400
Received: by mail-lf0-f66.google.com with SMTP id 36-v6so19554787lfr.11;
        Fri, 08 Jun 2018 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fEYfh+jdxCPT42CuFuSfKqN/GGx6tW1nhsHdbvEUEMM=;
        b=gMCV3aw95bUlDRXFwX/P8aM+rDiFwIc9FtXOZ1j73VnwcWdUiQK8uhdx6K/Qdn71RO
         MWrN7YI+rPQI9Wg6O25ZHzwetkfw0BQtja64w8gWJF8y9dpMpp3iOz136ZwMrfdhVnSr
         qfsvEROfQxvWO17e3mn77+qNfxRwC8wXcgki+2TKHNj+lUjQ/BXOK64BKJg7Z7hZnblo
         onSxSmcWnT/kXu/jUsQ9BoTNXkVgVTBS25B57rDSqk6zqScPYe0/YOx0MJzBLwGAKw9F
         wHvqe5uFckAumSyfjduEjjKI/QRh9ss4vbB73dJjmJWhrrOfpXpCH0sL5dHKWefDGfku
         X7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fEYfh+jdxCPT42CuFuSfKqN/GGx6tW1nhsHdbvEUEMM=;
        b=cghHDyf0lb3o5oOdzrdO8Mg7Gci3T12yUPlCeFEBsi70DmN0CQ4ASnOabIUAbeALkb
         uSWJriuJiRWK2bkkuECFrVFEL1X4lgb+YC6KheqGVi6YfXYr3FxQx4vmz/A9KUFntG+j
         s0+1hStw1AFUvPe4bGVdWxfiWzR9qMDjE6/e5R6W4CT4ysyeX6aWEJrK43aRVWbznpol
         /e+lKQN26j8F5A1erdg41bbBFmTXedAtN/Tzm2uVhiTajXylLU2BH6rEEdc1XEDIAhmh
         WgPQ+HPSoHfXpGgzPulRYMs44ZJnYvEoFilSp165qEjPawzgCUphWP9S11Jez5+yLRRh
         XJwg==
X-Gm-Message-State: APt69E2X/8dlqiFkVNBiBbiAxGR7ZlD8kgv/0LCbC4YNlSOUN21F5EWg
        mu/z2UPMn3MexPmVXniTUe7gB++t
X-Google-Smtp-Source: ADUXVKJ8XtYCCZfU0nVxtOUD5y5EOIAMb0miukBOzMxV5L/uz7XS6PGzHrkh9iit5VsjFKy0dAgKfQ==
X-Received: by 2002:a2e:60:: with SMTP id 93-v6mr4524689lja.96.1528457913318;
        Fri, 08 Jun 2018 04:38:33 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id i188-v6sm942389lfe.34.2018.06.08.04.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 04:38:32 -0700 (PDT)
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
 <4e15c758-a314-9fdc-1d70-4a465137a6f9@gmail.com>
 <41d794ce-a318-b2f1-5ad7-e9500175bdc8@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <113e3bf5-1e20-2ea0-9ad4-06e5d83df905@gmail.com>
Date: Fri, 8 Jun 2018 14:38:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <41d794ce-a318-b2f1-5ad7-e9500175bdc8@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 01:26 AM, Boris Ostrovsky wrote:
> On 06/07/2018 03:17 AM, Oleksandr Andrushchenko wrote:
>> On 06/07/2018 12:32 AM, Boris Ostrovsky wrote:
>>> On 06/06/2018 05:06 AM, Oleksandr Andrushchenko wrote:
>>>> On 06/04/2018 11:49 PM, Boris Ostrovsky wrote:
>>>>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>>>>> index 9813fc440c70..7d58dfb3e5e8 100644
>>>>>> --- a/drivers/xen/gntdev.c
>>>>>> +++ b/drivers/xen/gntdev.c
>>>>> ...
>>>>>
>>>>>>     +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>>>>> This code belongs in gntdev-dmabuf.c.
>>>> The reason I have this code here is that it is heavily
>>>> tied to gntdev's internal functionality, e.g. map/unmap.
>>>> I do not want to extend gntdev's API, so gntdev-dmabuf can
>>>> access these. What is more dma-buf doesn't need to know about
>>>> maps done by gntdev as there is no use of that information
>>>> in gntdev-dmabuf. So, it seems more naturally to have
>>>> dma-buf's related map/unmap code where it is: in gntdev.
>>> Sorry, I don't follow. Why would this require extending the API? It's
>>> just moving routines to a different file that is linked to the same
>>> module.
>> I do understand your intention here and tried to avoid dma-buf
>> related code in gntdev.c as much as possible. So, let me explain
>> my decision in more detail.
>>
>> There are 2 use-cases we have: dma-buf import and export.
>>
>> While importing a dma-buf all the dma-buf related functionality can
>> easily be kept inside gntdev-dmabuf.c w/o any issue as all we need
>> from gntdev.c is dev, dma_buf_fd, count and domid for that.
>>
>> But in case of dma-buf export we need to:
>> 1. struct grant_map *map = gntdev_alloc_map(priv, count, dmabuf_flags);
>> 2. gntdev_add_map(priv, map);
>> 3. Set map->flags
>> 4. ret = map_grant_pages(map);
>> 5. And only now we are all set to export the new dma-buf from
>> *map->pages*
>>
>> So, until 5) we use private gtndev.c's API not exported to outside world:
>> a. struct grant_map
>> b. static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv,
>> int count,
>>                        int dma_flags)
>> c. static void gntdev_add_map(struct gntdev_priv *priv, struct
>> grant_map *add)
>> d. static int map_grant_pages(struct grant_map *map)
>>
>> Thus, all the above cannot be accessed from gntdev-dmabuf.c
>> This is why I say that gntdev.c's API will need to be extended to
>> provide the above
>> a-d if we want all dma-buf export code to leave in gntdev-dmabuf.c.
>
>
> I still don't understand why you feel this would be extending the API.
> These routines and the struct can be declared in local header file and
> this header file will not be visible to anyone but gntdev.c and
> gntdev-dmabuf.c.
Ok, this is what I meant: I will need to move private structures
and some function prototypes from gntdev.c into a header file,
thus extending its API: before the header nothing were exposed.
Sorry for not being clear here.
>   You can, for example, put this into gntdev-dmabuf.h
> (and then rename it to something else, like gntdev-common.h).
Sure, I will move all I need into that shared header
>
>
>> But that doesn't seem good to me and what is more a-d are really
>> gntdev.c's
>> functionality, not dma-buf's which only needs pages and doesn't really
>> care from
>> where those come.
>> That was the reason I partitioned export into 2 chunks: gntdev +
>> gntdev-dmabuf.
>>
>> You might also ask why importing side does Xen related things
>> (granting references+)
>> in gntdev-dmabuf, not gntdev so it is consistent with the dma-buf
>> exporter?
>> This is because importer uses grant-table's API which seems to be not
>> natural for gntdev.c,
>> so it can leave in gntdev-dmabuf.c which has a use-case for that,
>> while gntdev
>> remains the same.
>
> Yet another reason why this code should be moved: importing and
> exporting functionalities logically belong together. The fat that they
> are implemented using different methods is not relevant IMO.
>
> If you have code which is under ifdef CONFIG_GNTDEV_DMABUF and you have
> file called gntdev-dmabuf.c it sort of implies that this code should
> live in that file (unless that code is intertwined with other code,
> which is not the case here).
Ok, will move as discussed above
>
> -boris
Thank you,
Oleksandr
>
>
>>> Since this is under CONFIG_XEN_GNTDEV_DMABUF then why shouldn't it be in
>>> gntdev-dmabuf.c? In my view that's the file where all dma-related
>>> "stuff" lives.
>> Agree, but IMO grant_map stuff for dma-buf importer is right in its
>> place in gntdev.c
>> and all the rest of dma-buf specifics live in gntdev-dmabuf.c as they
>> should
>>> -boris
>>>
>>>
>>> -boris
>>>
>> Thank you,
>> Oleksandr
