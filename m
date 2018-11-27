Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1C2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcHUfHlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C1C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeK0Nfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:35:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37716 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbeK0Nfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:35:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so17690347edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3DnUS0xGl1BdP8iCaJnj8b8YZZ49GG1NKDzme1M4zk=;
        b=OcHUfHlVixSwdJVIScNNUWjvETbJCfTrK9oHeAYx/PTIF+g0l5/ZVA+6eDIrYNFhN6
         iX48X6cLKvpTjpKpQnKXvKeULK9cWfI8srVJy4MBdl/IQned5vJIuM2qqMlrK3B2D8qn
         tmkFm0ibCh/D+DxsoALiBVWhpyNb23ZPs/Vp5nhltB58nrwEF8dewWatEjjFtf5GpXrG
         hOHQpid+E235ijnx0SvpTYCwFOXREgX/ZWQH9B8XaBceZwBqZiZkKIC401h/Y86wBelT
         QGjPo2oIoGHrdsxAkvCoxJ+7M4l8/Gt63U8uZCoSco4CnxVALJJiJlGLydKkaBuXwUfA
         RVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3DnUS0xGl1BdP8iCaJnj8b8YZZ49GG1NKDzme1M4zk=;
        b=D4hVexg0TvtQd6ylgxqbcd57IzeRFN8lUDnb+SKV/GtZ3NOVRy7T2esH3DdTId3fj2
         sS+MNuduUVhX127GfbrEJBtp1vqLzKf1I5jam2rbWrkXwTNlRvoF8LBfMFeztSd2u+ME
         /tELuwthTXV6OY7BZP2d/VcQGf5wwdqF9q5AJbP3dKq7F2E/r4MGZIbQPTUD1qeftWdS
         FE4eaczGJ6EUxVenEpOxX1C8webjHVMbkn0lQKopR50WTuIp+BQSrL/+JTmucjA27czK
         X7pEOrIpkrq9XeYzwj9ooIUKIBE20MDnYT91xmqGyTEfwNhFt66k9xc7SZ+R1Isit+Ov
         iJ7g==
X-Gm-Message-State: AA+aEWYlzhEdEV4ZNNrRGCNwtLadxYSv5YdHLFH0twGTvaf5YvYXJbxY
        B3ES90JPjb6iZTtt1E0dPF8=
X-Google-Smtp-Source: AFSGD/XRsAd7K2F3z731+DcxKqCj/mSOOOfOZq3kq265ZfNFX5eKhUh0foiW9XAi94s1aEM7B3G5IA==
X-Received: by 2002:a50:93c5:: with SMTP id o63mr24637767eda.20.1543286366565;
        Mon, 26 Nov 2018 18:39:26 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w13sm632899edl.54.2018.11.26.18.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:39:25 -0800 (PST)
Date:   Tue, 27 Nov 2018 02:39:25 +0000
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
Message-ID: <20181127023925.xdramcjenpsawfw6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
 <5BF36EE9.9090808@huawei.com>
 <CADZGycb=kxdqSdbdXNWwmgyWp2CtC3-UFmy1-PqtdgS2BrmyjA@mail.gmail.com>
 <476b5d35-1894-680c-2bd9-b399a3f4d9ed@oracle.com>
 <20181127003638.2oyudcyene6hb6sb@master>
 <6e9efd77-b6af-40f4-56b0-c0572930b3e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9efd77-b6af-40f4-56b0-c0572930b3e0@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:42:28PM -0800, Wengang Wang wrote:
>
>
>On 2018/11/26 16:36, Wei Yang wrote:
>> On Mon, Nov 26, 2018 at 08:57:54AM -0800, Wengang Wang wrote:
>> > 
>> > On 2018/11/25 17:59, Wei Yang wrote:
>> > > On Tue, Nov 20, 2018 at 10:58 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> > > > On 2018/11/17 9:33, Wengang Wang wrote:
>> > > > > The this_cpu_cmpxchg makes the do-while loop pass as long as the
>> > > > > s->cpu_slab->partial as the same value. It doesn't care what happened to
>> > > > > that slab. Interrupt is not disabled, and new alloc/free can happen in the
>> > > > > interrupt handlers. Theoretically, after we have a reference to the it,
>> > > > > stored in _oldpage_, the first slab on the partial list on this CPU can be
>> > > > > moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>> > > > > then somehow can be added back as head to partial list of current
>> > > > > kmem_cache_cpu, though that is a very rare case. If that rare case really
>> > > > > happened, the reading of oldpage->pobjects may get a 0xdead0000
>> > > > > unexpectedly, stored in _pobjects_, if the reading happens just after
>> > > > > another CPU removed the slab from kmem_cache_node, setting lru.prev to
>> > > > > LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>> > > > > prevents slabs from being moved to kmem_cache_node and being finally freed.
>> > > > > 
>> > > > > We see in a vmcore, there are 375210 slabs kept in the partial list of one
>> > > > > kmem_cache_cpu, but only 305 in-use objects in the same list for
>> > > > > kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>> > > > > with negative _pobjects_ has the value of 0xdead0004, the next page looks
>> > > > > good (_pobjects is 1).
>> > > > > 
>> > > > > For the fix, I wanted to call this_cpu_cmpxchg_double with
>> > > > > oldpage->pobjects, but failed due to size difference between
>> > > > > oldpage->pobjects and cpu_slab->partial. So I changed to call
>> > > > > this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>> > > > > happen in between, but just want to make sure the first slab did expereince
>> > > > > a remove and re-add. This patch is more to call for ideas.
>> > > > Have you hit the really issue or just review the code ?
>> > > > 
>> > > > I did hit the issue and fixed in the upstream patch unpredictably by the following patch.
>> > > > e5d9998f3e09 ("slub: make ->cpu_partial unsigned int")
>> > > > 
>> > > Zhong,
>> > > 
>> > > I took a look into your upstream patch, while I am confused how your patch
>> > > fix this issue?
>> > > 
>> > > In put_cpu_partial(), the cmpxchg compare cpu_slab->partial (a page struct)
>> > > instead of the cpu_partial (an unsigned integer). I didn't get the
>> > > point of this fix.
>> > I think the patch can't prevent pobjects from being set as 0xdead0000 (the
>> > primary 4 bytes of LIST_POISON2).
>> > But if pobjects is treated as unsigned integer,
>> > 
>> > 2266???????????????????????????????????????????????? pobjects = oldpage->pobjects;
>> > 2267???????????????????????????????????????????????? pages = oldpage->pages;
>> > 2268???????????????????????????????????????????????? if (drain && pobjects > s->cpu_partial) {
>> > 2269???????????????????????????????????????????????????????????????? unsigned long flags;
>> > 
>> Ehh..., you mean (0xdead0000 > 0x02) ?
>Yes.
>
>> This is really a bad thing, if it wordarounds the problem like this.
>It does.
>> I strongly don't agree this is a *fix*. This is too tricky.
>It's tricky. I don't know for what purpose the patch went in. The commit
>message was just saying _pobjects_ should be "unsigned"...

Well, upstream accepts that commit is reasonable, since pobjects is not
possible to be negative. This is two different things.

But relates that commit with the  problem here is not proper.

>
>thanks,
>wengang
>
>> > line 2268 will be true in put_cpu_partial(), thus code goes to
>> > unfreeze_partials(). This way the slabs in the cpu partial list can be moved
>> > to kmem_cache_nod and then freed. So it fixes (or say workarounds) the
>> > problem I see here (huge number of empty slabs stay in cpu partial list).
>> > 
>> > thanks
>> > wengang
>> > 
>> > > > Thanks,
>> > > > zhong jiang

-- 
Wei Yang
Help you, Help me
