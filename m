Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD475C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956DA21386
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2+dCzDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956DA21386
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934020AbeGCRAr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:00:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40707 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932440AbeGCRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:00:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so3046011wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZXhjE6V9pncHIVkrKXyhz5H/SV6HatopHW3Gb7tPUk=;
        b=W2+dCzDyaToehKv+5SqvA71dFVMTQwCZNNOIOM87BrlIzdiXSUQI1CMLxW8jT0zwTP
         rTl6Ki4MUY99fMKOPYH9tzklzICFh6tbemYyA8gghv21C3lX2bpcN9Xv7hM56M0EVvTY
         xOu4ITKum6EsfJbLOYgdlenNvQJd5Ql4+lN6rJpgXCNBGKNm8xf+P/8EBpNZDuhNBNPx
         gZDlATl2zUYgs2BXKi3tBRV/RjGsFA0UW3ktdDs7/3/H7i48vZSc1sC5mc0NCiU/JB/+
         nNwnlx/RqJnLkZFz/0f8G0PkviX2mzpRsLnR6EWkphnfT9ze06cvEZGCZEHDWbI9o4mk
         aNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZXhjE6V9pncHIVkrKXyhz5H/SV6HatopHW3Gb7tPUk=;
        b=FSwRPS89W/88/KiWekZhurvkT89p//t442eBkTpOJdH0jU9ue5VFyYUEnme4Lv0nFK
         Qs3plPwCStQuhc6qh7Nthb8Gqvs079fs1OOn1vGdWPmZkijywgicFwobV1nzrLxhySdD
         jVlQ51qzahldN7GsJwEC6IjLaxrj3F6zwlh3PWgqgx3eCDlBMw6SikDLUbKrd8dOH83B
         KItzimiDQJZWH6cUdxJCBGqpVLEc4neKtUm+Yu9ZfNuMNQE7YJsIHhoUsVf+jPOiyD8V
         maGh8xBZF7ermE/Wp5/jUCAhb8o4YMjBZyu9bJzREj03H4AZyMeKc/PHs8t7+d3lpBJ1
         XksQ==
X-Gm-Message-State: APt69E1OcRY+a4uncrJwc9k7nKFHmOSjxVkTqbudlhOdYtj8y6VwktWg
        jCgLQT3dyBmnFRWccMj8gftkeTsO+FD/TQSTxGMBWA==
X-Google-Smtp-Source: AAOMgpcYT2PTTP6Nc6t2fK3UeOlIA7g1tdGlsRmG2lgabrQAqi9S8PR35hQe6OgqVZ5ZhTlgqnt/QvtyNCbmiScrwps=
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr12180964wmf.112.1530637244031;
 Tue, 03 Jul 2018 10:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org> <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
 <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
In-Reply-To: <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Jul 2018 10:00:32 -0700
Message-ID: <CALvZod6eomn1Mt5r28tMthq4b+3MWuWJKgishf_N4UjortzvHw@mail.gmail.com>
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:17 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Shakeel,
>
> On 03.07.2018 18:46, Shakeel Butt wrote:
> > On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
> >>> +++ b/mm/vmscan.c
> >>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
> >>>  static LIST_HEAD(shrinker_list);
> >>>  static DECLARE_RWSEM(shrinker_rwsem);
> >>>
> >>> +#ifdef CONFIG_MEMCG_KMEM
> >>> +static DEFINE_IDR(shrinker_idr);
> >>> +static int shrinker_nr_max;
> >>
> >> So ... we've now got a list_head (shrinker_list) which contains all of
> >> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
> >>
> >> Why not replace the shrinker_list with the shrinker_idr?  It's only used
> >> twice in vmscan.c:
> >>
> >> void register_shrinker_prepared(struct shrinker *shrinker)
> >> {
> >>         down_write(&shrinker_rwsem);
> >>         list_add_tail(&shrinker->list, &shrinker_list);
> >>         up_write(&shrinker_rwsem);
> >> }
> >>
> >>         list_for_each_entry(shrinker, &shrinker_list, list) {
> >> ...
> >>
> >> The first is simply idr_alloc() and the second is
> >>
> >>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
> >>
> >> I understand there's a difference between allocating the shrinker's ID and
> >> adding it to the list.  You can do this by calling idr_alloc with NULL
> >> as the pointer, and then using idr_replace() when you want to add the
> >> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
> >>
> >> This will actually reduce the size of each shrinker and be more
> >> cache-efficient when calling the shrinkers.  I think we can also get
> >> rid of the shrinker_rwsem eventually, but let's leave it for now.
> >
> > Can you explain how you envision shrinker_rwsem can be removed? I am
> > very much interested in doing that.
>
> Have you tried to do some games with SRCU? It looks like we just need to
> teach count_objects() and scan_objects() to work with semi-destructed
> shrinkers. Though, this looks this will make impossible to introduce
> shrinkers, which do synchronize_srcu() in scan_objects() for example.
> Not sure, someone will actually use this, and this is possible to consider
> as limitation.
>

Hi Kirill, I tried SRCU and the discussion is at
https://lore.kernel.org/lkml/20171117173521.GA21692@infradead.org/T/#u

Paul E. McKenney suggested to enable SRCU unconditionally. So, to use
SRCU for shrinkers, we first have to push unconditional SRCU.

Tetsuo had another lockless solution which was a bit involved but does
not depend on SRCU.

thanks,
Shakeel
