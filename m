Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBDD26FB7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjOqkSxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBDD26FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeF1TVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:21:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38600 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeF1TVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:21:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so6590711wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl4nwqWfnH9Gvz1ACEYRylPJ37Hrc1olYzQgqFwLlaQ=;
        b=RjOqkSxFKoddwTbAamPV/hqIss4Pj36ZC08NHJGh0ggi/OnSyWS4ey8fHMwf7aL9X7
         YDqo+gqR4VSk/KbmSWpsAsEdff2tYmZa1y4Bn4GOj8SOTRschD34IDdd/F1V73rcUwdu
         Y+ZgKwyA7w1WT0a5cxEr/rvtLoLTqqgoNjwU9cl9ehhSd5EKHerLse6TzDXyV452EOZk
         FpzOhLZ20Ze7QJXHKdI5WDnuTBh4Qi9sc8qPgxNoQc7+wFZf4Kr47USrCwnkJYS20hWl
         jmSsF2AYe+X+rfLG/tBps3nTIYR1SfTEPU+ItFopptjDXwkpHZgEKdMxPkRJ/6bdX8WE
         nPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl4nwqWfnH9Gvz1ACEYRylPJ37Hrc1olYzQgqFwLlaQ=;
        b=tSGSu8l/ues3UBjv5tWiJntTffQezNeTXHionW6EM+H9tg/9cRFM5ulnaHlwy7TrH/
         e4IEOBt6YVeqhc+ikvn3DT6jeU/Dj40Nj1DN4aHjPA0OhiXC3lhzrqd1xJkuB+7tj100
         CZH3c+eCi029u6tysxElKGQ467UEjy+NgSMhxzcZCHfKqRKDP/YaZs9NDM761fVZlNhy
         fkg5FTteEhcRNkEhPBrz7LkhLZI3W3ZfcRj2k4jgYMtnPgPjtsPOy/jLorBVFLE2+U6N
         5QnfswqU3HxuuLmm/TEfWjBGA5V64/peV+Zmng4wGTdqAvRWIfS39C3P10ZHKCYGjwHF
         HJkg==
X-Gm-Message-State: APt69E21vILvg7hpLeNsU8E3BVAGvmcjoDGCWmqX8FOKXkNp6IXYiz8Y
        +F2asF7sg7E1OtaJYF59gFHyZsd3s1CGtqtDfnP0GQ==
X-Google-Smtp-Source: AAOMgpepAIlFn3h/K0sMAdfyWeqiGmHFBxq93nu8YLTm4U5AbzgHhzrDMUHQH7SE9XcJCjojpINMGL0WEFLJUqjdK0Q=
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr10183611wrm.2.1530213698809;
 Thu, 28 Jun 2018 12:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180627191250.209150-1-shakeelb@google.com> <20180627191250.209150-2-shakeelb@google.com>
 <20180628100253.jscxkw2d6vfhnbo5@quack2.suse.cz>
In-Reply-To: <20180628100253.jscxkw2d6vfhnbo5@quack2.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Jun 2018 12:21:26 -0700
Message-ID: <CALvZod5Fy7cUnqMvCqw8M52wm8+wBtGD-bhUibN=Uwdzb+5Kyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:03 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 27-06-18 12:12:49, Shakeel Butt wrote:
> > A lot of memory can be consumed by the events generated for the huge or
> > unlimited queues if there is either no or slow listener.  This can cause
> > system level memory pressure or OOMs.  So, it's better to account the
> > fsnotify kmem caches to the memcg of the listener.
> >
> > However the listener can be in a different memcg than the memcg of the
> > producer and these allocations happen in the context of the event
> > producer. This patch introduces remote memcg charging API which the
> > producer can use to charge the allocations to the memcg of the listener.
> >
> > There are seven fsnotify kmem caches and among them allocations from
> > dnotify_struct_cache, dnotify_mark_cache, fanotify_mark_cache and
> > inotify_inode_mark_cachep happens in the context of syscall from the
> > listener.  So, SLAB_ACCOUNT is enough for these caches.
> >
> > The objects from fsnotify_mark_connector_cachep are not accounted as they
> > are small compared to the notification mark or events and it is unclear
> > whom to account connector to since it is shared by all events attached to
> > the inode.
> >
> > The allocations from the event caches happen in the context of the event
> > producer.  For such caches we will need to remote charge the allocations
> > to the listener's memcg.  Thus we save the memcg reference in the
> > fsnotify_group structure of the listener.
> >
> > This patch has also moved the members of fsnotify_group to keep the size
> > same, at least for 64 bit build, even with additional member by filling
> > the holes.
>
> ...
>
> >  static int __init fanotify_user_setup(void)
> >  {
> > -     fanotify_mark_cache = KMEM_CACHE(fsnotify_mark, SLAB_PANIC);
> > +     fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> > +                                      SLAB_PANIC|SLAB_ACCOUNT);
> >       fanotify_event_cachep = KMEM_CACHE(fanotify_event_info, SLAB_PANIC);
> >       if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
> >               fanotify_perm_event_cachep =
>
> Why don't you setup also fanotify_event_cachep and
> fanotify_perm_event_cachep caches with SLAB_ACCOUNT and instead specify
> __GFP_ACCOUNT manually? Otherwise the patch looks good to me.
>

Hi Jan, IMHO having a visible __GFP_ACCOUNT along with
memalloc_use_memcg() makes the code more explicit and readable that we
want to targeted/remote memcg charging. However if you think
otherwise, I will replace __GFP_ACCOUNT with SLAB_ACCOUNT.

thanks,
Shakeel
