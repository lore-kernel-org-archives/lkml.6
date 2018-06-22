Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E18C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFA7249D6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqb1TCDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFA7249D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934177AbeFVXdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:33:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34768 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbeFVXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:33:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so7438992wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qy3+0q/fVBbc2dAVUxya1AwaevtUb1eg2jOOr+xBLU=;
        b=kqb1TCDjJXLWckIe4SKVZu7TK6ahDjUWu7JvsQSBLChnkm3xxH2vTpAF0/TzKWnNXY
         qvmlvR11ADhDSvDiviImtRvSY+oYcgJOtj7PpUuwmuNm+BHp/YCqj/u/XXuLZ2R3dxZZ
         sXLrbUwpWPvnUbgwC81J75gS89vk52KwUizgF7ryvuBArBsPze318WDSjiFhpu/yCQ9U
         JEfpI2ueMEqDUoyY4XGGAQ2yWIUObZWyesH6idVlFaJqFkePYjn95r+ztnuSBUf63vav
         drh1bJG24m8hTicK4j3EBvwA79caaLQPRNG12fv8U1Mu/8rw/aoWTxKCddyO9LS1qJj3
         Oo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qy3+0q/fVBbc2dAVUxya1AwaevtUb1eg2jOOr+xBLU=;
        b=qUw3bhUlkyCibjHJAXGc9O3FGOpQRcRtEtR47Iew9rkmK8GJk5GXDB/vRtqXwK1YxR
         DzdU4zlwUimwvJvB53ZFrlX5VpO//6HH4LLEBbd87gr19rovik7MNWbbxTdJF3c8agpq
         6z2BGSJ3Y36lIjn1tHVp3BMqJ7G43QTQ51IKq5q72P5yJpeyEPa9KzV8XfVuOkzY+HTs
         0h2HYxTq0hG3Bo3UY6qqJN1RuaJbhOVi/lXJcinIBqu8jYh2rzHVsdJnXfiFu8ZVPwAX
         zZUDv77gEk1OFgdPEymduNbdq6OIz3q+szk64bOUMA20kle2LQZWba1YuOSg1QYLYgqp
         4bvg==
X-Gm-Message-State: APt69E3DSngOTleDcAErrFiKf0AjIlwzWwjKjYjHMmE9tksL2K6sLYRQ
        IqJ+wdrewSGQwrKUDhZMakzEhi9XZL484XIgIICLHg==
X-Google-Smtp-Source: ADUXVKJlIGTGUDysa4TZrkbzgLzJyLRa3wF1u275voxRNu5x6ZqCJjZyl6wW8hS8ZmPAnNI/jCX8lYQWBR92bOb4mDY=
X-Received: by 2002:a1c:6744:: with SMTP id b65-v6mr2935936wmc.9.1529710392516;
 Fri, 22 Jun 2018 16:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180619051327.149716-1-shakeelb@google.com> <20180619051327.149716-4-shakeelb@google.com>
 <20180619162741.GC27423@cmpxchg.org> <20180619174040.GA4304@castle.DHCP.thefacebook.com>
 <CALvZod5_0_LuqWpri=uviE5hHhTMPT0VQOZDgHtTtLhvcCtb3A@mail.gmail.com> <20180619195525.GA19193@castle>
In-Reply-To: <20180619195525.GA19193@castle>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Jun 2018 16:33:00 -0700
Message-ID: <CALvZod7G-ggYTpmdDsNeQRf4upYa34ccOerVmEkEkLOVFrBr2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs, mm: account buffer_head to kmemcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:55 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jun 19, 2018 at 12:51:15PM -0700, Shakeel Butt wrote:
> > On Tue, Jun 19, 2018 at 10:41 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Jun 19, 2018 at 12:27:41PM -0400, Johannes Weiner wrote:
> > > > On Mon, Jun 18, 2018 at 10:13:27PM -0700, Shakeel Butt wrote:
> > > > > The buffer_head can consume a significant amount of system memory and
> > > > > is directly related to the amount of page cache. In our production
> > > > > environment we have observed that a lot of machines are spending a
> > > > > significant amount of memory as buffer_head and can not be left as
> > > > > system memory overhead.
> > > > >
> > > > > Charging buffer_head is not as simple as adding __GFP_ACCOUNT to the
> > > > > allocation. The buffer_heads can be allocated in a memcg different from
> > > > > the memcg of the page for which buffer_heads are being allocated. One
> > > > > concrete example is memory reclaim. The reclaim can trigger I/O of pages
> > > > > of any memcg on the system. So, the right way to charge buffer_head is
> > > > > to extract the memcg from the page for which buffer_heads are being
> > > > > allocated and then use targeted memcg charging API.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > Cc: Jan Kara <jack@suse.cz>
> > > > > Cc: Greg Thelen <gthelen@google.com>
> > > > > Cc: Michal Hocko <mhocko@kernel.org>
> > > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > ---
> > > > >  fs/buffer.c                | 14 +++++++++++++-
> > > > >  include/linux/memcontrol.h |  7 +++++++
> > > > >  mm/memcontrol.c            | 21 +++++++++++++++++++++
> > > > >  3 files changed, 41 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > > > index 8194e3049fc5..26389b7a3cab 100644
> > > > > --- a/fs/buffer.c
> > > > > +++ b/fs/buffer.c
> > > > > @@ -815,10 +815,17 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> > > > >     struct buffer_head *bh, *head;
> > > > >     gfp_t gfp = GFP_NOFS;
> > > > >     long offset;
> > > > > +   struct mem_cgroup *old_memcg;
> > > > > +   struct mem_cgroup *memcg = get_mem_cgroup_from_page(page);
> > > > >
> > > > >     if (retry)
> > > > >             gfp |= __GFP_NOFAIL;
> > > > >
> > > > > +   if (memcg) {
> > > > > +           gfp |= __GFP_ACCOUNT;
> > > > > +           old_memcg = memalloc_memcg_save(memcg);
> > > > > +   }
> > > >
> > > > Please move the get_mem_cgroup_from_page() call out of the
> > > > declarations and down to right before the if (memcg) branch.
> > > >
> > > > >     head = NULL;
> > > > >     offset = PAGE_SIZE;
> > > > >     while ((offset -= size) >= 0) {
> > > > > @@ -835,6 +842,11 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> > > > >             /* Link the buffer to its page */
> > > > >             set_bh_page(bh, page, offset);
> > > > >     }
> > > > > +out:
> > > > > +   if (memcg) {
> > > > > +           memalloc_memcg_restore(old_memcg);
> > > > > +#ifdef CONFIG_MEMCG
> > > > > +           css_put(&memcg->css);
> > > > > +#endif
> > > >
> > > > Please add a put_mem_cgroup() ;)
> > >
> > > I've added such helper by commit 8a34a8b7fd62 ("mm, oom: cgroup-aware OOM killer").
> > > It's in the mm tree.
> > >
> >
> > I was using mem_cgroup_put() defined by Roman's patch but there were a
> > lot of build failure reports where someone was taking this series
> > without Roman's series or applying the series out of order. Andrew
> > asked me to keep it like this and then he will convert these callsites
> > into mem_cgroup_put() after making making sure Roman's series is
> > applied in mm tree. I will recheck with him, how he wants to handle it
> > now.
>
> I can also split the introduction of mem_cgroup_put() into a separate commit,
> as it seems to be usable not only by the cgroup oom stuff.
> Please, let me know, if it's a preferred way to go.
>

Oh I forgot to reply. Yes, let's do that, a separate patch to
introduce mem_cgroup_put() which can used by remote charging and memcg
aware oom-killer patches.

Shakeel
