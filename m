Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E1FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8F26966
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik1pqeN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE8F26966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeF0FvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:51:03 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33873 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeF0FvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:51:01 -0400
Received: by mail-yw0-f193.google.com with SMTP id n187-v6so290787ywd.1;
        Tue, 26 Jun 2018 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ps+gAwVXdy5arvYGiUVzRS5jQtBXjkjTtbqkRwO+pY=;
        b=ik1pqeN4HmLDtEM0WCXzJYAWEinZTCSPmfiLRPFWHRZ22upQKlUTmTyeDt0DFH8+ZR
         hv7KWMaGy+Eb6DKp4qAAdJBAK6JiMpumaqg6nPYLY0xYj2+Gf83UpxhqLg9yF8RVWx8E
         qgB1y53ye0VMbBBjtIyavMisdZJc3hAZF4BR/JibliY9uUZwqEHNXXxuNibix1c29Sy6
         aHnmK6lZGmmqvgdazswRDDt0mnqyT1iXXAzV/V10ybhafZlr/QbL6VRF+B+O++cEEmD7
         v7TqqAPBmaWekddA8li1ZyEJkdbtYsgc10tJBeWyx491jvMbrgDLGotKYvQpfigdhHL7
         eWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ps+gAwVXdy5arvYGiUVzRS5jQtBXjkjTtbqkRwO+pY=;
        b=Xpbrrf6APdZsgqKgyWwk9fv9eFoQKPEj8Mnhpec9qPo8zWeKt0ZdNw/5TFsbmmAZaT
         SN16heq/e8xz4mtluQ9c9qEi4h0FPXWvpW00nWyH8psOenv6yS771bXHOx0ppC++Ifae
         iGqiUdRHZ6bZ0fkWBUxbiUYSbmMGbqZ18swOlJoLsFsR2yRd1BbSt0o4keLVqcnb2xk2
         obScZC2ZOXjPrfrap1tCn2HsBGNa5AC19mjR2NohFku30gG56XwLrzAHxcC3WAvGyXnd
         fYmNxAcknx2xmYVKvjl6QDNRLHFU/pf4Dszuu3iNJbnJFX61NlrcYGewnkbkuRmDdCyC
         xFVQ==
X-Gm-Message-State: APt69E1m/ykIe/6ZT0rXV/OT0Xsz/8qXL7T3tU2VVZKNtdJbF8LLNdaj
        EPr1aOwOVs3iH3u+rsbKP7stJB/VKI9VtDmbCb0=
X-Google-Smtp-Source: AAOMgpfpvfQorZozhCNLDDoyiQqQ2GXyGWtQhNwP2TgK7h5lJkdLf1LevFQGPsX4wC6gxRz0xx3GxJqsl7DORApw3uE=
X-Received: by 2002:a0d:d84c:: with SMTP id a73-v6mr2130018ywe.379.1530078660475;
 Tue, 26 Jun 2018 22:51:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1b04:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 22:50:59
 -0700 (PDT)
In-Reply-To: <CALvZod5VU0_==ggX82P19v=X7zpKj1xO5qPZ1mep4yRVhr7qaw@mail.gmail.com>
References: <20180625230659.139822-1-shakeelb@google.com> <20180625230659.139822-2-shakeelb@google.com>
 <20180626190619.GB3958@cmpxchg.org> <CALvZod5VU0_==ggX82P19v=X7zpKj1xO5qPZ1mep4yRVhr7qaw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Jun 2018 08:50:59 +0300
Message-ID: <CAOQ4uxhZ81xGucQtZv+koCKCHtJn9yDGSd9MwBaL2Ew+6t0suQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
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

On Tue, Jun 26, 2018 at 11:05 PM, Shakeel Butt <shakeelb@google.com> wrote:
> On Tue, Jun 26, 2018 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Mon, Jun 25, 2018 at 04:06:58PM -0700, Shakeel Butt wrote:
>> > @@ -140,8 +141,9 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
>> >                                                struct inode *inode, u32 mask,
>> >                                                const struct path *path)
>> >  {
>> > -     struct fanotify_event_info *event;
>> > +     struct fanotify_event_info *event = NULL;
>> >       gfp_t gfp = GFP_KERNEL;
>> > +     struct mem_cgroup *old_memcg = NULL;
>> >
>> >       /*
>> >        * For queues with unlimited length lost events are not expected and
>> > @@ -151,19 +153,25 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
>> >       if (group->max_events == UINT_MAX)
>> >               gfp |= __GFP_NOFAIL;
>> >
>> > +     /* Whoever is interested in the event, pays for the allocation. */
>> > +     if (group->memcg) {
>> > +             gfp |= __GFP_ACCOUNT;
>> > +             old_memcg = memalloc_use_memcg(group->memcg);
>> > +     }
>>
>> group->memcg is only NULL when memcg is disabled or there is some
>> offlining race. Can you make memalloc_use_memcg(NULL) mean that it
>> should charge root_mem_cgroup instead of current->mm->memcg? That way
>> we can make this site unconditional while retaining the behavior:
>>
>>         gfp_t gfp = GFP_KERNEL | __GFP_ACCOUNT;
>>
>>         memalloc_use_memcg(group->memcg);
>>         kmem_cache_alloc(..., gfp);
>> out:
>>         memalloc_unuse_memcg();
>>
>> (dropping old_memcg and the unuse parameter as per the other mail)
>>
>
> group->memcg is only NULL when memcg is disabled (i.e.
> get_mem_cgroup_from_mm() returns root_mem_cgroup for offlined
> mm->memcg). Though group->memcg can point to an offlined memcg.
>
> If I understand you correctly this is what we want:
>
> 1. If group->memcg is NULL then __GFP_ACCOUNT is a noop i.e. memcg is disabled.
> 2. If group->memcg is root_mem_cgroup, then __GFP_ACCOUNT again is a
> kind of noop (charges to root_mem_cgroups are bypassed).
> 3. If group->memcg is offlined memcg, then make __GFP_ACCOUNT noop by
> returning root_mem_cgroup from get_mem_cgroup_from_current().
> 4. Else charge group->memcg.
>
> This seems reasonable. After your Ack and Amir's or Jan's answer to
> the nesting query, I will resend the next version of this patch
> series.
>
> In future if we find any use-cases of memalloc_use_memcg nesting then
> we can make it work for nesting.
>

For the fsnotify use case memalloc_use_memcg() certainly doesn't
need to nest, but I wonder, if that facility becomes popular among different
subsystems, how exactly do you intend to monitor that it doesn't grow
nested use cases? I would suggest that you at least leave a
WARN_ON_ONCE if memalloc_use_memcg() is called and
active_memcg is already set.

Thanks,
Amir.
