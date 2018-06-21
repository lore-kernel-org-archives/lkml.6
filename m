Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1CE20875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiYfm4XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1CE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeFUDrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:47:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36167 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeFUDrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:47:03 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so761461pgd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bPrDYcwIcXMjEMAXfR8McSPzsZfSvzFdMYpEkZTb0LQ=;
        b=IiYfm4XD0xa5WbqAsJNVAnBTIBFkHlQXKWIQvKxiUz3AsJeXgPkfe8VuniHSuTvpbE
         1bQykgUsp9RyzuqHZ4jqc6Eufeb0QVN4OOtdQhTsgPM8q8znNbKZmqW3ly/BfcfXZ4/0
         f0ncdA8/TXFUlxbTPUcw5CBB3Th7o/w0fMOfe9uXN36EdJXq4W+jUy3mgnmpDT16gnD7
         GGjVaDml1ye4Lfjmg6QubARYD7bkvx9E/7ooM+Ms6i81BVbPNaLmGkD1oawHsqKGuNDi
         +KBTk5TUXczNn/ewPBrQ7PkvOlA17emAUHEFAHAq7xwWH6Id+t5RekqFfRlNAL8dILjI
         uOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bPrDYcwIcXMjEMAXfR8McSPzsZfSvzFdMYpEkZTb0LQ=;
        b=bjQE9ReeO2+lPkdePSIB+UCUqZ65paEI6YkQXDYdelduh89+tv8t+uKfkPAOO9NEdM
         ro9cWkyLDQn14MjB9vBQm4MARaX+lsZ3pM7yjk1EvjU1Qpf/Ts/IfDSVS7+Ge9JtFgdM
         3H483tG3BT7UV1Cb0XD96y0VDNZcVMS89DNXhYE6S1/CnfZk4STc65EtdjrEVbG5ch32
         tcZL90petMJY3uak0+sDzgPEgf/LMmdpasdwGfweBprlW/dm0DbIWZp+780a+YAy4HRO
         AI3h9tMibCKOSJzVAMuRju5c/U9HNNNM+8mKhrs3100SXzNdLlY7HC1zKDqCqntB6RZd
         jmvQ==
X-Gm-Message-State: APt69E2rITTLTkwhdK2uY7vX+Pg1j+1YxigsUAvz4JTX3TKq+D1p/R3p
        +pZ4ElxKiVCkJeCbkQeVy0NxDnO9
X-Google-Smtp-Source: ADUXVKKbg3FLetwyhKD9icA+IK0runKmFToPfBoVlseKpBefgPsbtwYWchds37Cleca2O/R8DV2FLQ==
X-Received: by 2002:a62:e208:: with SMTP id a8-v6mr25373197pfi.6.1529552822834;
        Wed, 20 Jun 2018 20:47:02 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id z18-v6sm4817763pgc.0.2018.06.20.20.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:47:02 -0700 (PDT)
Subject: Re: [PATCH] mm: mempool: Fix a possible sleep-in-atomic-context bug
 in mempool_resize()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        gregkh@linuxfoundation.org, jthumshirn@suse.de,
        pombredanne@nexb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180621030714.10368-1-baijiaju1990@gmail.com>
 <20180621033839.GB12608@bombadil.infradead.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <7a900944-5281-2e07-54f9-fc7574d2c538@gmail.com>
Date:   Thu, 21 Jun 2018 11:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180621033839.GB12608@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/21 11:38, Matthew Wilcox wrote:
> On Thu, Jun 21, 2018 at 11:07:14AM +0800, Jia-Ju Bai wrote:
>> The kernel may sleep with holding a spinlock.
>> The function call path (from bottom to top) in Linux-4.16.7 is:
>>
>> [FUNC] remove_element(GFP_KERNEL)
>> mm/mempool.c, 250: remove_element in mempool_resize
>> mm/mempool.c, 247: _raw_spin_lock_irqsave in mempool_resize
>>
>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>>
>> This bug is found by my static analysis tool (DSAC-2) and checked by
>> my code review.
> But ... we don't use the flags argument.
>
> static void *remove_element(mempool_t *pool, gfp_t flags)
> {
>          void *element = pool->elements[--pool->curr_nr];
>
>          BUG_ON(pool->curr_nr < 0);
>          kasan_unpoison_element(pool, element, flags);
>          check_element(pool, element);
>          return element;
> }
>
> ...
>
> static void kasan_unpoison_element(mempool_t *pool, void *element, gfp_t flags)
> {
>          if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
>                  kasan_unpoison_slab(element);
>          if (pool->alloc == mempool_alloc_pages)
>                  kasan_alloc_pages(element, (unsigned long)pool->pool_data);
> }
>
> So the correct patch would just remove this argument to remove_element() and
> kasan_unpoison_element()?

Yes, I also find this.
I can submit a patch that removes the flag in:
Definitions of kasan_unpoison_element() and remove_element()
Three calls to remove_element() and one call to kasan_unpoison_element() 
in mempool.c.

Do you think it is okay?


Best wishes,
Jia-Ju Bai
