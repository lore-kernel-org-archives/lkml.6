Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C187C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EDF260DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Egiy5RCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EDF260DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933221AbeFZUGL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:06:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37915 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754979AbeFZUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:06:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so18450045wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7FVMGJWHOZkxWyXcdo36JkO3xwzZOdCUPu5WvzQPEg=;
        b=Egiy5RCh6DAmIf2HiXn77yjfDD3Xjah/greibEYUXcxxlqczW0R+a4TtrKJb0sYqRD
         j+3fhiqOQ8eOyscy+60SO1yTfNZxJPD4/cOPaCwPUBm5d9MPB9srwBSbaTZ7QUasJ7lv
         Er6YuGbTJ07eGC7achVVqTnMGxK9UPrhGBPeYOOPOs9dy/PR2Yth+OH8a6M8e5CcMuuz
         0gb384MUTDY8o6a3n8i2Y9lCfdURGuqkeb4Tfx5upQuOZUdd80jdNt0QtYtrpUrp6uIz
         r9MSGR+l2r1FmroiqPAwaFum4mSsjvQUD2iGYJtaFLyoM9b2sSKlHSm5xLEsl0NXtz0N
         zLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7FVMGJWHOZkxWyXcdo36JkO3xwzZOdCUPu5WvzQPEg=;
        b=kSm9NDOFM79/dtuVb7k0t7IiJkKc74vr55u9ovgZ/zIC+2fE1K5C7t/PRZSpPlyJ4T
         +f6ipQKCIMcpBG3WoOG1rWht1Fyy4fFYJXVBDvZ8/tIYmen0zQFfDouwvtSV5KqbH02p
         n+nptiMKt7DyqQ2M3jxWzW6aOUYwxMrGcsVFF4960/ZNh8d7J4wCkuJfXVlqMjtM06Bg
         I7Y7PMxhImCv9CdCalXUzflQpdveRIPV0Spb7JgrIxOW6Wa+iDyqEJwaoifyW0Jcq+wu
         amOnGwfWmTcsS0QVFwNGjxoiRW/o5L4YSSKgPb26/3eJuAimfv4txk8WMYMjOEymm+k1
         YYvQ==
X-Gm-Message-State: APt69E2nRHQuGP6fs/7CBhUeLdhQTAZ7YjUn3OuXgPtbuStLVuN3qr29
        Oyj5FI231pYKhMeiwvYR76GVlmgm3Kyd5wgorMoCqA==
X-Google-Smtp-Source: AAOMgpec1EmzFqpBvmkCinVLCtChTprcNDsoQRjYGA+Do9F7h9go30EdPel2Dbkk81ftniSAfYk5tIQCkXVMHEgTf8s=
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr2861555wrm.8.1530043567387;
 Tue, 26 Jun 2018 13:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180625230659.139822-1-shakeelb@google.com> <20180625230659.139822-2-shakeelb@google.com>
 <20180626190619.GB3958@cmpxchg.org>
In-Reply-To: <20180626190619.GB3958@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Jun 2018 13:05:55 -0700
Message-ID: <CALvZod5VU0_==ggX82P19v=X7zpKj1xO5qPZ1mep4yRVhr7qaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Jun 25, 2018 at 04:06:58PM -0700, Shakeel Butt wrote:
> > @@ -140,8 +141,9 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
> >                                                struct inode *inode, u32 mask,
> >                                                const struct path *path)
> >  {
> > -     struct fanotify_event_info *event;
> > +     struct fanotify_event_info *event = NULL;
> >       gfp_t gfp = GFP_KERNEL;
> > +     struct mem_cgroup *old_memcg = NULL;
> >
> >       /*
> >        * For queues with unlimited length lost events are not expected and
> > @@ -151,19 +153,25 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
> >       if (group->max_events == UINT_MAX)
> >               gfp |= __GFP_NOFAIL;
> >
> > +     /* Whoever is interested in the event, pays for the allocation. */
> > +     if (group->memcg) {
> > +             gfp |= __GFP_ACCOUNT;
> > +             old_memcg = memalloc_use_memcg(group->memcg);
> > +     }
>
> group->memcg is only NULL when memcg is disabled or there is some
> offlining race. Can you make memalloc_use_memcg(NULL) mean that it
> should charge root_mem_cgroup instead of current->mm->memcg? That way
> we can make this site unconditional while retaining the behavior:
>
>         gfp_t gfp = GFP_KERNEL | __GFP_ACCOUNT;
>
>         memalloc_use_memcg(group->memcg);
>         kmem_cache_alloc(..., gfp);
> out:
>         memalloc_unuse_memcg();
>
> (dropping old_memcg and the unuse parameter as per the other mail)
>

group->memcg is only NULL when memcg is disabled (i.e.
get_mem_cgroup_from_mm() returns root_mem_cgroup for offlined
mm->memcg). Though group->memcg can point to an offlined memcg.

If I understand you correctly this is what we want:

1. If group->memcg is NULL then __GFP_ACCOUNT is a noop i.e. memcg is disabled.
2. If group->memcg is root_mem_cgroup, then __GFP_ACCOUNT again is a
kind of noop (charges to root_mem_cgroups are bypassed).
3. If group->memcg is offlined memcg, then make __GFP_ACCOUNT noop by
returning root_mem_cgroup from get_mem_cgroup_from_current().
4. Else charge group->memcg.

This seems reasonable. After your Ack and Amir's or Jan's answer to
the nesting query, I will resend the next version of this patch
series.

In future if we find any use-cases of memalloc_use_memcg nesting then
we can make it work for nesting.

thanks,
Shakeel
