Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A20214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klxRRvRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A20214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeK0Lcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:32:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43650 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeK0Lcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:32:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id f4so17486259edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IxhGUgSnl1U8EVi8yixIQDGMIPIU+M0XjhnTW/O+KRw=;
        b=klxRRvRUUZht2PaCk43JuplSX8u7gdmcWKc5R6kmlMYEbOu0BTC84m5CzxJxG8KjJ2
         Or0h0/6JfUixdyQ3GICw7kp2UTLl6Dnu08m46T3i8nznZ3l9jsC5m9MWiIA1d8nffd+D
         GgnONyw6el0qBohxuO1mQTJFC2SIvWyl2AZuaCcAlqwdrh8/dNif4DZJqVvvH/VqMei5
         dDWdEuyq44YmDhERhwe2Oh5HKACAkTyiwWSZeQ1mPkTmVMyxLjNbFkPEzJWo19THmC1H
         gaUBQm1Vf7BiaqigNt6Hxok/fCYlijM6QafHdjDQ3m+8Q0oQZiHMoUeiMSH7HmQEpLvv
         U8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IxhGUgSnl1U8EVi8yixIQDGMIPIU+M0XjhnTW/O+KRw=;
        b=WEz6/QKF+o2OEqFjwuPvXQJLQ6DGoUaI7roixxAj2sZPhaDJfSCQoGdB7Oxg1sKN4M
         DSEHa/Qj/UlwBUeKkyQImMoyIjT8+RlqyUH1uBgoAo1RbuClu3HCQ5DygTJEAtco3l5D
         PFps/jq9JkgHt/rhAf3eB6g/LZIvruVM2Buc7Fq56b33RqkoySM4geDHOWm2+MMk+bEg
         qJtilCqAlbI8unO8TwX5shm+Ko32npgARQjzkNTQmknQPoT9a/4qCqsgb8aJ9YpHczlw
         QSzWN/nJ+sfdsVAVbQGDRbHKUpCK7jI86SpeQV9RZwTeZ2QZWxfaWcTFmQKXG2Dgr1L4
         robw==
X-Gm-Message-State: AA+aEWaJJ5yL09iE69e+9xeaAiaDkN8YqleJiXzmYDsaXKL/HjhtmVHL
        qkaND2oIZIUcxgxyjSzHJ3UlDst4
X-Google-Smtp-Source: AFSGD/WphFa2EfCYFEUwiOdfVxgBdVgBJZ9AWMMQqGuiVuk2YlC3qV6DmKpglIyXU0tgsQZKYbkHAA==
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr25480621edg.121.1543279000117;
        Mon, 26 Nov 2018 16:36:40 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f19-v6sm304142eje.28.2018.11.26.16.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 16:36:39 -0800 (PST)
Date:   Tue, 27 Nov 2018 00:36:38 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wengang Wang <wen.gang.wang@oracle.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
Message-ID: <20181127003638.2oyudcyene6hb6sb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
 <5BF36EE9.9090808@huawei.com>
 <CADZGycb=kxdqSdbdXNWwmgyWp2CtC3-UFmy1-PqtdgS2BrmyjA@mail.gmail.com>
 <476b5d35-1894-680c-2bd9-b399a3f4d9ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476b5d35-1894-680c-2bd9-b399a3f4d9ed@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:57:54AM -0800, Wengang Wang wrote:
>
>
>On 2018/11/25 17:59, Wei Yang wrote:
>> On Tue, Nov 20, 2018 at 10:58 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> > On 2018/11/17 9:33, Wengang Wang wrote:
>> > > The this_cpu_cmpxchg makes the do-while loop pass as long as the
>> > > s->cpu_slab->partial as the same value. It doesn't care what happened to
>> > > that slab. Interrupt is not disabled, and new alloc/free can happen in the
>> > > interrupt handlers. Theoretically, after we have a reference to the it,
>> > > stored in _oldpage_, the first slab on the partial list on this CPU can be
>> > > moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>> > > then somehow can be added back as head to partial list of current
>> > > kmem_cache_cpu, though that is a very rare case. If that rare case really
>> > > happened, the reading of oldpage->pobjects may get a 0xdead0000
>> > > unexpectedly, stored in _pobjects_, if the reading happens just after
>> > > another CPU removed the slab from kmem_cache_node, setting lru.prev to
>> > > LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>> > > prevents slabs from being moved to kmem_cache_node and being finally freed.
>> > > 
>> > > We see in a vmcore, there are 375210 slabs kept in the partial list of one
>> > > kmem_cache_cpu, but only 305 in-use objects in the same list for
>> > > kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>> > > with negative _pobjects_ has the value of 0xdead0004, the next page looks
>> > > good (_pobjects is 1).
>> > > 
>> > > For the fix, I wanted to call this_cpu_cmpxchg_double with
>> > > oldpage->pobjects, but failed due to size difference between
>> > > oldpage->pobjects and cpu_slab->partial. So I changed to call
>> > > this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>> > > happen in between, but just want to make sure the first slab did expereince
>> > > a remove and re-add. This patch is more to call for ideas.
>> > Have you hit the really issue or just review the code ?
>> > 
>> > I did hit the issue and fixed in the upstream patch unpredictably by the following patch.
>> > e5d9998f3e09 ("slub: make ->cpu_partial unsigned int")
>> > 
>> Zhong,
>> 
>> I took a look into your upstream patch, while I am confused how your patch
>> fix this issue?
>> 
>> In put_cpu_partial(), the cmpxchg compare cpu_slab->partial (a page struct)
>> instead of the cpu_partial (an unsigned integer). I didn't get the
>> point of this fix.
>
>I think the patch can't prevent pobjects from being set as 0xdead0000 (the
>primary 4 bytes of LIST_POISON2).
>But if pobjects is treated as unsigned integer,
>
>2266???????????????????????????????????????????????? pobjects = oldpage->pobjects;
>2267???????????????????????????????????????????????? pages = oldpage->pages;
>2268???????????????????????????????????????????????? if (drain && pobjects > s->cpu_partial) {
>2269???????????????????????????????????????????????????????????????? unsigned long flags;
>

Ehh..., you mean (0xdead0000 > 0x02) ?

This is really a bad thing, if it wordarounds the problem like this.
I strongly don't agree this is a *fix*. This is too tricky.

>line 2268 will be true in put_cpu_partial(), thus code goes to
>unfreeze_partials(). This way the slabs in the cpu partial list can be moved
>to kmem_cache_nod and then freed. So it fixes (or say workarounds) the
>problem I see here (huge number of empty slabs stay in cpu partial list).
>
>thanks
>wengang
>
>> > Thanks,
>> > zhong jiang

-- 
Wei Yang
Help you, Help me
