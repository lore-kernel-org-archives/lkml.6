Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F672075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d58hx9Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F672075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGRS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:27:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36669 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:27:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so3756975wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZYeckDqVnvjTR9erNTdqy4HhRKO22TXccYXwYJJf2U=;
        b=d58hx9JfVwPhppsDGlzMzDWtrr/xxCRUY+AkN27Z35eiVzW6mBxAqgySBJGRJZDaHk
         JPlBZh9MMCHTdOOtTj+reQh96Xm+tsiNfuWbSNCLAu5kwRdN76qKHOZLOcaaeIVXLQUV
         8vrk9I5qdfJnTQm6nhLAO4Xs41CSvIRx2Ov8OaohxwZq91ry+tKGQPNMdWBQ002sZwbi
         sEc+Ue+PxQZ171cQ7uadGT+ZaZPjepfZLDlDx3TRUGCzBeSGgkkGH7gkweJXu4FK5gFr
         xhCjfQ9pKNFdgGidLXGV/aYnPU6MHjAxKxPnj3V8yZJIIWGzQ7N3tcGxGO2sQCQDvGpE
         YEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZYeckDqVnvjTR9erNTdqy4HhRKO22TXccYXwYJJf2U=;
        b=pm+lwrlbTVHCi4+rTPb5pFbOqdzo1q6M07mDa/BLwYcj94gmPZ2wo+QTnsdTaNSeJM
         7i9MXKYYSoPNYjIQbA28u2rwyrccDPL88m5VspEYyANpQtyaA7/HGi4V4ay/VdITrQYr
         hCfWePt6Ho0eKP1+WM25FhqYOzgTy2iEieJEH5fs52cMqrcamgWQAckMSqxuk7p3qxTu
         qazLK9t3vtzvKcNs7p2WLhbBx/dku8qirpon9wyBhh8mXWAuMnK0s9hZdOWdXP3Lha+Y
         rymNeOmYXrOtxq4u20yuJsUoIhyfkpmjHn+Oours+nUhcEyQlwr4Il7Wq2ApG83iFIKh
         Z2tQ==
X-Gm-Message-State: AOUpUlGUO6HESL8ginw9uaUm4fIDEO0Ot+RdVKi+3kUTwjDYWNq+kHNb
        nPxuixvZNjuRsIJ6enst0XQzyUtjwezX4LuIUtR/0g==
X-Google-Smtp-Source: AAOMgpdBYtvIYkyKZRlBtuOZwhBvakGMLHykE70t4hAgF6UH1YLrq5Z23TOsK34mIrWvYOLXpkA8ee4EqqkTdjJT+x0=
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr2171420wmd.142.1531936130614;
 Wed, 18 Jul 2018 10:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com> <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
In-Reply-To: <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Jul 2018 10:48:38 -0700
Message-ID: <CALvZod5UsYzNs_FJqy2U4HiZ+SdKzKZtzdK1OYcV7v_91kqn8A@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     bmerry@ska.ac.za
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:40 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 18 July 2018 at 17:49, Shakeel Butt <shakeelb@google.com> wrote:
> > On Wed, Jul 18, 2018 at 8:37 AM Bruce Merry <bmerry@ska.ac.za> wrote:
> >> That sounds promising. Is there any way to tell how many zombies there
> >> are, and is there any way to deliberately create zombies? If I can
> >> produce zombies that might give me a reliable way to reproduce the
> >> problem, which could then sensibly be tested against newer kernel
> >> versions.
> >>
> >
> > Yes, very easy to produce zombies, though I don't think kernel
> > provides any way to tell how many zombies exist on the system.
> >
> > To create a zombie, first create a memcg node, enter that memcg,
> > create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
> > That memcg will be a zombie until you delete that tmpfs file.
>
> Thanks, that makes sense. I'll see if I can reproduce the issue. Do
> you expect the same thing to happen with normal (non-tmpfs) files that
> are sitting in the page cache, and/or dentries?
>

Normal files and their dentries can get reclaimed while tmpfs will
stick and even if the data of tmpfs goes to swap, the kmem related to
tmpfs files will remain in memory.

Shakeel
