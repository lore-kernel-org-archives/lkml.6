Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676752084A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkhrFO7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676752084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbeGCPqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:46:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34235 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:46:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so2483452wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYtgD7zn9yg2dQjcXD0huLkS89N8S4LNFPb6cSqrwrs=;
        b=kkhrFO7+0ElNuSFm+gKeEOwA6RI6U8NEnpTPfKyi4ItyFDOnp1wGwVPXLCOWxvtU1w
         LP/YGqqko+ZD1vH6+gDsEcXYNPRVJ2j9d7tvXOOpRjqtV+jxQr+b+xyJx2BazBhUZhjR
         34EAL4XlgkJ0v5/AmihMynDou50ds+0Y6RtREEyFZSTCareGO0vyTW7h20hDCLbWy6K7
         Q7+OCLM0hNMKhn3Rc1e0wQhOjex4SJXPNOu9w3ZZiFrsHK2oQJihT24FkHlzgk+DHuGE
         kUfgdqxF9sMP9fO5C6AnjS5qxum5M3IlB7/QxIl4971KbiHiA4/5O8E+PF2pxNrMEeC5
         dN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYtgD7zn9yg2dQjcXD0huLkS89N8S4LNFPb6cSqrwrs=;
        b=VajFsQG9p1h4U36EQKQjP4Dgi+CgqQntUaE2x0et1NVLO9caJEINROI/mKUYjj0X4F
         PUmPT8kk5NlhJxDsVF4SJ5Vdv9+SyLHFFy4V9Wqc+QSJTiK0CmTpmnQeJfMPoCRZlseZ
         vWCxtp+vmJXHDQamnNhtooJZpIKi4DBTeSHXUYRXoDE6c2MB8KOldvIg8UTVlNjIoFG6
         5jzBpXCyW2sNU3uF7AMhDRCcp5NItVk8x/PQDYXMUpg6xC80y23ulxUmBup67I9wlVI+
         vrKsF/jeIGfRijNJvuf8Swd9keocikKIyHEgY/d/u4OA6TzcuUB5ZurMT5FLZCt7CFjY
         fyOA==
X-Gm-Message-State: APt69E2255lvyv7kOATQlYAaO4iQT1r1VyF0bWNr2szk6eS5t3XQKuv+
        SROPxq7QS2GKcf/HFbmx10TLBlMe1SDItb447J2sFA==
X-Google-Smtp-Source: AAOMgpcW1qus/WFrDYBRbKrJKILpupUfUHWNMIKFj8/UTed/7I6b3dJmiQjskvcS7L5+FKplra0cY8ajP5Fmkj8t2jk=
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr23572404wrd.272.1530632800511;
 Tue, 03 Jul 2018 08:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain> <20180703152723.GB21590@bombadil.infradead.org>
In-Reply-To: <20180703152723.GB21590@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Jul 2018 08:46:28 -0700
Message-ID: <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
> > +++ b/mm/vmscan.c
> > @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
> >  static LIST_HEAD(shrinker_list);
> >  static DECLARE_RWSEM(shrinker_rwsem);
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static DEFINE_IDR(shrinker_idr);
> > +static int shrinker_nr_max;
>
> So ... we've now got a list_head (shrinker_list) which contains all of
> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
>
> Why not replace the shrinker_list with the shrinker_idr?  It's only used
> twice in vmscan.c:
>
> void register_shrinker_prepared(struct shrinker *shrinker)
> {
>         down_write(&shrinker_rwsem);
>         list_add_tail(&shrinker->list, &shrinker_list);
>         up_write(&shrinker_rwsem);
> }
>
>         list_for_each_entry(shrinker, &shrinker_list, list) {
> ...
>
> The first is simply idr_alloc() and the second is
>
>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
>
> I understand there's a difference between allocating the shrinker's ID and
> adding it to the list.  You can do this by calling idr_alloc with NULL
> as the pointer, and then using idr_replace() when you want to add the
> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
>
> This will actually reduce the size of each shrinker and be more
> cache-efficient when calling the shrinkers.  I think we can also get
> rid of the shrinker_rwsem eventually, but let's leave it for now.

Can you explain how you envision shrinker_rwsem can be removed? I am
very much interested in doing that.

thanks,
Shakeel
