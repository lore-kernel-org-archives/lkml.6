Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910CDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BED2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3GCrOXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BED2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeKFPB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:01:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35100 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKFPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:01:58 -0500
Received: by mail-it1-f195.google.com with SMTP id v11so9959706itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ecz96OisFOefJV91RAs0gl1wjGoiHBxXhRFmTTSXIGE=;
        b=i3GCrOXUpAfqAu7EfI7MVIpLdEnJxCWV3EB7qbh2uhd85rTza/bqCtS1SBK7JNEa+V
         UZRqpF78K8nLYLNjR081LuZyFYUq1qzIvFG7Bx31vZCWJoiQ2A5vizwW3aVamtOPfSKe
         zVzky7chI1qVtWqx8SsvvFPd7uL+fYG30KrASyk8X/mxoW+1X1XliboIAPcWKK24GIO2
         WNH4KF6QmZ1w7hejoBdR0DFdIW+Crg/vQL9VsD7RXFR514OApzPN7BlxLlTLqjmyfq2W
         dd963j3+ENXCZW5wleDJn8EJN0y4FOwuHLCvdUt+ozs4L4dAbD6GJuAshf9HGAiR4ei8
         tQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ecz96OisFOefJV91RAs0gl1wjGoiHBxXhRFmTTSXIGE=;
        b=WHc7CSxsEey0qF20lkVDBfwKpD8r81LcIPzIk2iQRg/1QNs9CLSTWg9boZn/6EasLx
         v6mm1hzoVKa7fa6641datEw28c131jy/UzYNzr6gJNbfgWsiddkbVbaYUe+QA1sVFfsy
         ie9LyapvvRh6UjJHrfQT1HGzFqTUnLxNEiybIO30udd3V1DcAOAAG8ux4m4uSbeQkELv
         Ha6uYSzuCLLoZrcZimyNNexYTTyT/gB2AmDk7ehnQXqN+D8oIaY6iUMkVhKQWaDoqply
         /1CZ3m1QHfcJiEhqVJwtJ6uO5yMsinLEsW+xc5b6+/4VhHhTpcnboVNpvdx+rvXXRWRK
         NTOQ==
X-Gm-Message-State: AGRZ1gI2I8aKGgootE1q4tRrGwEnzOMyTO4OM6OgLgmrXS/FzkzsBmw7
        xe0tx3lhFOn9o5ZmVVhffXgI2g8rpTy7bKOIaAMYiw==
X-Google-Smtp-Source: AJdET5f1dRRB6BO5O85yEQhNj67Jm4xKpFSXwWBUbr/JwW1/PGYiSP2vcQNMQNvpspA3fXatMWqnNDTNzjAdWQ/PQdw=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr894704ite.12.1541482709163;
 Mon, 05 Nov 2018 21:38:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 21:38:08 -0800 (PST)
In-Reply-To: <2c42ba08-f78a-36f6-5a5d-21dd00861872@suse.cz>
References: <20181104125028.3572-1-tiny.windzz@gmail.com> <2c42ba08-f78a-36f6-5a5d-21dd00861872@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Nov 2018 06:38:08 +0100
Message-ID: <CACT4Y+a+7gqs+gdfePuVGZ-bDGvb8ieE8ugA-pK1AZ8HwfecQg@mail.gmail.com>
Subject: Re: [PATCH] mm, slab: remove unnecessary unlikely()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 11:18 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> +CC Dmitry
>
> On 11/4/18 1:50 PM, Yangtao Li wrote:
>> WARN_ON() already contains an unlikely(), so it's not necessary to use
>> unlikely.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Maybe also change it back to WARN_ON_ONCE? I already considered it while
> reviewing Dmitry's patch and wasn't sure. Now I think that what can
> happen is that either a kernel bug is introduced that _ONCE is enough to
> catch (two separate bugs introduced to both hit this would be rare, and
> in that case the second one will be reported after the first one is
> fixed), or this gets called with a user-supplied value, and then we want
> to avoid spamming dmesg with multiple warnings that the user could
> trigger at will.


If you asking me, I am fine both changes.
I was mainly interested in removing the bogus warnings that actually fire.


>> ---
>>  mm/slab_common.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 7eb8dc136c1c..4f54684f5435 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1029,10 +1029,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>>
>>               index = size_index[size_index_elem(size)];
>>       } else {
>> -             if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>> -                     WARN_ON(1);
>> +             if (WARN_ON(size > KMALLOC_MAX_CACHE_SIZE))
>>                       return NULL;
>> -             }
>>               index = fls(size - 1);
>>       }
>>
>>
>
