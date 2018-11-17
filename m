Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A57EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC620868
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyEA0jnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBC620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeKQNGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:06:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32917 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbeKQNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:06:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id r27so18208525eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5TLIYNEVARxGwK/XJnA4BtoZJzochE2UFBxQ2gakYF0=;
        b=OyEA0jnGEcKUVNK2PM7cSXVTRRQtMZJQx17O2OOEZ2WuX1rKb4eoUvNIkokLysrc49
         iC3N1mJyxT1kddRPiw0GVD8d6fC1bGHDZQn02Y8lHav02s4Mv6oILyUI93dS6/Qpz9Ve
         Qe/Bnv3pa9hVJgYPe4i03+g5tPEd1Lt8wnRqxOyln0CTSDuQvmUWGpW9zBWgX2SZFywo
         9Jr8WvDTlRBEf8G2GBjOnrhiyTs9lQyVE94Ko0T9wnLksa6JnColnZU9uKhUyI2ip2kt
         FmFZx10T8eFkEYJwtf11crVFQpa1CLqKBA7zWphIEd/OG1meGUpikjqdVkLeQVCiuOWr
         sRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5TLIYNEVARxGwK/XJnA4BtoZJzochE2UFBxQ2gakYF0=;
        b=mRsRmo4Rf21bZU6tHSZQXNeDAKJcBcOhXyk/S5AhaFRF1k/B/A0Xe/9JvOe0UZ+tln
         nYHvyazA5gU7mdXQdqbVsx7mN40daoaX6MetjQzAjRHiXa+WQ/KbwOTbHe+aH4wvkKkL
         f080j0/GwhtuZxgQpAuVLdITmoxl2g9c61Hf851aUJSTwJCNFqBQCXOLV71hP2OyQwXB
         jaCH7jyFVq6l1h2FJWTcGeIghYq6gAnvdMwbp9p/3oy/h0XcrT3vWNLsSW31c1kFBWkS
         potwPS2lbWq/lZJkFB4gufrEp/kRHao0YuKm6e/iAJBd4TQTlxO9JpL3wZh2PBI2Uz9s
         nz+w==
X-Gm-Message-State: AGRZ1gLRbWUbvOMF1C6ybwgI6AS7RobuIBko618yA9viVoP4QoB3qyJQ
        /F9CEKZJ42qn27ZMOHF/+D4=
X-Google-Smtp-Source: AJdET5ePg2hKOLsKIcQfl9qR7/ReKefZHLXQOVHdax7Ox2jEuaxsyulNu/mEZ2dQ9JklBRbN8Js/WA==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr11563537eds.285.1542423094323;
        Fri, 16 Nov 2018 18:51:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm5222265ejb.4.2018.11.16.18.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 18:51:33 -0800 (PST)
Date:   Sat, 17 Nov 2018 02:51:33 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wengang Wang <wen.gang.wang@oracle.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
Message-ID: <20181117025133.czjubpjqm4b6kqin@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117013335.32220-1-wen.gang.wang@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:33:35PM -0800, Wengang Wang wrote:
>The this_cpu_cmpxchg makes the do-while loop pass as long as the
>s->cpu_slab->partial as the same value. It doesn't care what happened to
>that slab. Interrupt is not disabled, and new alloc/free can happen in the
>interrupt handlers. Theoretically, after we have a reference to the it,
>stored in _oldpage_, the first slab on the partial list on this CPU can be
>moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>then somehow can be added back as head to partial list of current
>kmem_cache_cpu, though that is a very rare case. If that rare case really

I didn't fully catch up with this case.

When put_cpu_partial() is called, this means we are trying to freeze an
frozen page and this pages is fully occupied. Since page->freelist is
NULL.

A full page is supposed to be on no where when has_cpu_partial() is
true.

So I don't understand when it will be moved to different kmem_cache_cpu.

>happened, the reading of oldpage->pobjects may get a 0xdead0000
>unexpectedly, stored in _pobjects_, if the reading happens just after
>another CPU removed the slab from kmem_cache_node, setting lru.prev to
>LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>prevents slabs from being moved to kmem_cache_node and being finally freed.

Looks this page is removed from some list. This happens in which case? I
mean the page is previouly on which list?

>
>We see in a vmcore, there are 375210 slabs kept in the partial list of one
>kmem_cache_cpu, but only 305 in-use objects in the same list for
>kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>with negative _pobjects_ has the value of 0xdead0004, the next page looks
>good (_pobjects is 1).
>
>For the fix, I wanted to call this_cpu_cmpxchg_double with
>oldpage->pobjects, but failed due to size difference between
>oldpage->pobjects and cpu_slab->partial. So I changed to call
>this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>happen in between, but just want to make sure the first slab did expereince
>a remove and re-add. This patch is more to call for ideas.
>
>Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
>---
> mm/slub.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
>diff --git a/mm/slub.c b/mm/slub.c
>index e3629cd..26539e6 100644
>--- a/mm/slub.c
>+++ b/mm/slub.c
>@@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> {
> #ifdef CONFIG_SLUB_CPU_PARTIAL
> 	struct page *oldpage;
>+	unsigned long tid;
> 	int pages;
> 	int pobjects;
> 
>@@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> 	do {
> 		pages = 0;
> 		pobjects = 0;
>-		oldpage = this_cpu_read(s->cpu_slab->partial);
> 
>+		tid = this_cpu_read(s->cpu_slab->tid);
>+		/* read tid before reading oldpage */
>+		barrier();
>+
>+		oldpage = this_cpu_read(s->cpu_slab->partial);
> 		if (oldpage) {
> 			pobjects = oldpage->pobjects;
> 			pages = oldpage->pages;
>@@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> 		page->pobjects = pobjects;
> 		page->next = oldpage;
> 
>-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
>-								!= oldpage);
>+		/* we dont' change tid, but want to make sure it didn't change
>+		 * in between. We don't really hope alloc/free not happen on
>+		 * this CPU, but don't want the first slab be removed from and
>+		 * then re-added as head to this partial list. If that case
>+		 * happened, pobjects may read 0xdead0000 when this slab is just
>+		 * removed from kmem_cache_node by other CPU setting lru.prev
>+		 * to LIST_POISON2.
>+		 */
>+	} while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
>+					 oldpage, tid, page, tid) == 0);
>+
> 	if (unlikely(!s->cpu_partial)) {
> 		unsigned long flags;
> 
>-- 
>2.9.5

-- 
Wei Yang
Help you, Help me
