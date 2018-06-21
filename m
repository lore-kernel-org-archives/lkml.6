Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACDDC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0C0208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrVI0aD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0C0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbeFUFyl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:54:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46460 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFUFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:54:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so886876pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2wEtePim7Z/LifK/L4IZyc2/sPIfRuyxZWMViU+EqgA=;
        b=OrVI0aD2/zFp8Yu4iJxIz6l2sLZuyFVpNJFrTXYksvgZOdUmC2wq6xo3ijGRgYuIlP
         vcuX9iWgpojsz6HPkZ5E5zuPn78lhYFq8ZGSuDz2SQB+1fZvgMOg7DnAwgdEefef3PNW
         FeNE02p2ld8K54iqu0UvpH/vPCHq2+ekD7seeMWBLqtOvbQ6moTIAa+RUq9hTXzgwPpO
         +dPU8xak9O91wKYs7YdyKIEWu/9461hp8dIbLpFE0zRdIFX8fDEC59dOUAu0lQrqCnNN
         PZSfNnYflG+bVI86D4hNkle1YsVd9FFi3PKxwKcV2MMpJcFYwV1YwqsIK1cF41ait/YM
         k5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2wEtePim7Z/LifK/L4IZyc2/sPIfRuyxZWMViU+EqgA=;
        b=Rj88dCScg6b1WjGNn38zJY+Ogyz2VXs7OtseO16GLvKynropJ1A8e1xg0PUiNe8YD4
         3mOfFA14qE19zexPuvc7rgMGtO08e4ssHYybT37vyZsIRIL0vYiDqh8SvUJKx3E/Zq9a
         eeidGG8qOAR4bb7yU/r5ccxm9bcB6nod/Kl9xgb5rSS254z3Bwoc7RA9DOpxQsKPYxVe
         yNenzaiIK7JUcC/ZIOAJ/LnqrhjyAcJnLuTNyp30YNuz3wvgs52RNBaCUK/1W71C2CBg
         2BP2uX8o4JUs8AN8+g6KFSAB045FNYlBS5kGwXWzQ5BrgAFG7jcngRftJcP7yrfxNHCw
         LjuQ==
X-Gm-Message-State: APt69E2n6PGn/qn1Mxsm4U7MwlShgwa8T70w69Cxlt2ex+L5mRE8aTUt
        CdyWQW+IfkW97PnbCivXyR2Upvs9pXzkxRwlmhh4gA==
X-Google-Smtp-Source: ADUXVKKe8w7Pu2/qowQgzdyigMXsegh0h7kfVFSL/8sW/59HRL4tLfi9PhI3hCvPpyc5APNqSsAY5r4oezCwzptsz0I=
X-Received: by 2002:a63:6345:: with SMTP id x66-v6mr4749137pgb.96.1529560478950;
 Wed, 20 Jun 2018 22:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 20 Jun 2018 22:54:18
 -0700 (PDT)
In-Reply-To: <7a900944-5281-2e07-54f9-fc7574d2c538@gmail.com>
References: <20180621030714.10368-1-baijiaju1990@gmail.com>
 <20180621033839.GB12608@bombadil.infradead.org> <7a900944-5281-2e07-54f9-fc7574d2c538@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Jun 2018 07:54:18 +0200
Message-ID: <CACT4Y+avpKvoRKUsoZ=VUiN79RVEJAtzOCgkz0ZXRLFL4fSCbg@mail.gmail.com>
Subject: Re: [PATCH] mm: mempool: Fix a possible sleep-in-atomic-context bug
 in mempool_resize()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 5:46 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> On 2018/6/21 11:38, Matthew Wilcox wrote:
>>
>> On Thu, Jun 21, 2018 at 11:07:14AM +0800, Jia-Ju Bai wrote:
>>>
>>> The kernel may sleep with holding a spinlock.
>>> The function call path (from bottom to top) in Linux-4.16.7 is:
>>>
>>> [FUNC] remove_element(GFP_KERNEL)
>>> mm/mempool.c, 250: remove_element in mempool_resize
>>> mm/mempool.c, 247: _raw_spin_lock_irqsave in mempool_resize
>>>
>>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>>>
>>> This bug is found by my static analysis tool (DSAC-2) and checked by
>>> my code review.
>>
>> But ... we don't use the flags argument.
>>
>> static void *remove_element(mempool_t *pool, gfp_t flags)
>> {
>>          void *element = pool->elements[--pool->curr_nr];
>>
>>          BUG_ON(pool->curr_nr < 0);
>>          kasan_unpoison_element(pool, element, flags);
>>          check_element(pool, element);
>>          return element;
>> }
>>
>> ...
>>
>> static void kasan_unpoison_element(mempool_t *pool, void *element, gfp_t
>> flags)
>> {
>>          if (pool->alloc == mempool_alloc_slab || pool->alloc ==
>> mempool_kmalloc)
>>                  kasan_unpoison_slab(element);
>>          if (pool->alloc == mempool_alloc_pages)
>>                  kasan_alloc_pages(element, (unsigned
>> long)pool->pool_data);
>> }
>>
>> So the correct patch would just remove this argument to remove_element()
>> and
>> kasan_unpoison_element()?
>
>
> Yes, I also find this.
> I can submit a patch that removes the flag in:
> Definitions of kasan_unpoison_element() and remove_element()
> Three calls to remove_element() and one call to kasan_unpoison_element() in
> mempool.c.
>
> Do you think it is okay?

Hi Jia-Ju,

Removing an unused argument within a single file looks good to me.
