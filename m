Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C21C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9EC2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUcYuk9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9EC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKZMwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:52:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37471 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:52:42 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so12640438ioc.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kek+oZ6K3t/3VHkMYHtyuoVBR/cg4/3cOlsVuML8ags=;
        b=jUcYuk9E1QGX8XQ+k1YblCowJ+R0VQutr+cHDMn21JYNLzKdw2W5SvpqBFBWaiWq7i
         gsuzBdjbvBzr1Xjdh2xaaJK31x/D8jRUKBQlsH9WM7mNAAkRShOIedjoGERpVfQ/vJR0
         PZeIcHtmhLeT1AkzWIKvH2J1rDGwg2jFMHJjeilGDl1P60hkjqvL/EmdUnE+g6U3fQfB
         1423uyfrS8xSfFC9qVRbx5w4y1Mq4NBlBfSDeEDZT1MJPAvnJO3ItA9ZRkGAGqSoG8Ew
         azNcjMGzKPpJ+x502R/0Tjz9ymrzURqiArRxQMpMabPrcb0AaRJ732zwTuZW1hgz1pZO
         /HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kek+oZ6K3t/3VHkMYHtyuoVBR/cg4/3cOlsVuML8ags=;
        b=SSG9q6rhfnI1z7TuQnYXzt0ULfju/sM+EDoT89bhQicjqF02YnE1bYNQCXS+d3yWYb
         vyWIxoTOLVndO4npLnX3e9I7dvr7ckS1/ky7l7ONgP09dW+eG0SdPCZJmFkluYFScvGY
         lzjJmzu2APgL0Cf6TlWZCDKGxY3Ucx6gNmXCPWDvJfobGJUM8zI4MbartLOniAdJde1A
         trHnBaoUqHbJ+wLSkljYRIOqzn+Tsn9F6FxQMwBSBTYSwmRJZhOzTydE5FTbmdtINeYf
         SVHBsV9QQX/+idktkSyCWog2dL4WqwnmD9XkWn2oglRo+zNiFITAto21cBODZKfkoHOH
         v08Q==
X-Gm-Message-State: AA+aEWbWSXoEYchIORLHpJmOdSN5FYvUyKC5fLdGO+ADNPXDDD9d8thw
        /gg/26DS/EXDcKKxOLKRl7VhY9yuTz20yl3hx8Q=
X-Google-Smtp-Source: AFSGD/WVg+RPOsGN7/VmCs3cegIaHL1mxuiRq1KuooSoT6JAuoE1bi8d0X9BbFoP7QNNgrTBKuBnEzfH/MGMiwA63Ck=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr19472878ion.111.1543197609129;
 Sun, 25 Nov 2018 18:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20181117013335.32220-1-wen.gang.wang@oracle.com> <5BF36EE9.9090808@huawei.com>
In-Reply-To: <5BF36EE9.9090808@huawei.com>
From:   Wei Yang <richard.weiyang@gmail.com>
Date:   Mon, 26 Nov 2018 09:59:58 +0800
Message-ID: <CADZGycb=kxdqSdbdXNWwmgyWp2CtC3-UFmy1-PqtdgS2BrmyjA@mail.gmail.com>
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Wengang Wang <wen.gang.wang@oracle.com>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:58 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> On 2018/11/17 9:33, Wengang Wang wrote:
> > The this_cpu_cmpxchg makes the do-while loop pass as long as the
> > s->cpu_slab->partial as the same value. It doesn't care what happened to
> > that slab. Interrupt is not disabled, and new alloc/free can happen in the
> > interrupt handlers. Theoretically, after we have a reference to the it,
> > stored in _oldpage_, the first slab on the partial list on this CPU can be
> > moved to kmem_cache_node and then moved to different kmem_cache_cpu and
> > then somehow can be added back as head to partial list of current
> > kmem_cache_cpu, though that is a very rare case. If that rare case really
> > happened, the reading of oldpage->pobjects may get a 0xdead0000
> > unexpectedly, stored in _pobjects_, if the reading happens just after
> > another CPU removed the slab from kmem_cache_node, setting lru.prev to
> > LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
> > prevents slabs from being moved to kmem_cache_node and being finally freed.
> >
> > We see in a vmcore, there are 375210 slabs kept in the partial list of one
> > kmem_cache_cpu, but only 305 in-use objects in the same list for
> > kmalloc-2048 cache. We see negative values for page.pobjects, the last page
> > with negative _pobjects_ has the value of 0xdead0004, the next page looks
> > good (_pobjects is 1).
> >
> > For the fix, I wanted to call this_cpu_cmpxchg_double with
> > oldpage->pobjects, but failed due to size difference between
> > oldpage->pobjects and cpu_slab->partial. So I changed to call
> > this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
> > happen in between, but just want to make sure the first slab did expereince
> > a remove and re-add. This patch is more to call for ideas.
> Have you hit the really issue or just review the code ?
>
> I did hit the issue and fixed in the upstream patch unpredictably by the following patch.
> e5d9998f3e09 ("slub: make ->cpu_partial unsigned int")
>

Zhong,

I took a look into your upstream patch, while I am confused how your patch
fix this issue?

In put_cpu_partial(), the cmpxchg compare cpu_slab->partial (a page struct)
instead of the cpu_partial (an unsigned integer). I didn't get the
point of this fix.

> Thanks,
> zhong jiang
> > Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
> > ---
> >  mm/slub.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index e3629cd..26539e6 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> >  {
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >       struct page *oldpage;
> > +     unsigned long tid;
> >       int pages;
> >       int pobjects;
> >
> > @@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> >       do {
> >               pages = 0;
> >               pobjects = 0;
> > -             oldpage = this_cpu_read(s->cpu_slab->partial);
> >
> > +             tid = this_cpu_read(s->cpu_slab->tid);
> > +             /* read tid before reading oldpage */
> > +             barrier();
> > +
> > +             oldpage = this_cpu_read(s->cpu_slab->partial);
> >               if (oldpage) {
> >                       pobjects = oldpage->pobjects;
> >                       pages = oldpage->pages;
> > @@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> >               page->pobjects = pobjects;
> >               page->next = oldpage;
> >
> > -     } while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
> > -                                                             != oldpage);
> > +             /* we dont' change tid, but want to make sure it didn't change
> > +              * in between. We don't really hope alloc/free not happen on
> > +              * this CPU, but don't want the first slab be removed from and
> > +              * then re-added as head to this partial list. If that case
> > +              * happened, pobjects may read 0xdead0000 when this slab is just
> > +              * removed from kmem_cache_node by other CPU setting lru.prev
> > +              * to LIST_POISON2.
> > +              */
> > +     } while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
> > +                                      oldpage, tid, page, tid) == 0);
> > +
> >       if (unlikely(!s->cpu_partial)) {
> >               unsigned long flags;
> >
>
>
