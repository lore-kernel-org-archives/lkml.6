Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A75C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4AA21888
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vw6cJwVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4AA21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeGCTyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:54:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37953 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeGCTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:54:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so3455196wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GvlemKWZpyQHbsmt36VQbP7iEkkVAGcDvdqv3ps1u4=;
        b=Vw6cJwVRvs155ttwrltN2oE5BeFmRSMexbV4DZC+xahIyHFTvDyGBCH4uhXMh5ya3Q
         in9nDDCgzh3H/2WLak5DpFaEZOtumRNkA2pTN+2jyF2zf6KhzJZcM24LPmFiJ7ejpQJb
         IWFKCSfJjtmiaEMutFdpaOEu+LORZ9aZKWvKQBMlZeAtFHUweC1TbWaTYPsxLh453a6e
         6gjq7iezhd/xgBXfCfmexqrjunIzpkuZNghtIRsHxkWSUfBVfWkTvrecCLMnwFcbK5ep
         m1MkaIYxlVQEoJPRL7ZzDHh1p/+fOqmSTenQzTymzCLYh3pZs3VgxkL1hLAO81KWOzuD
         oZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GvlemKWZpyQHbsmt36VQbP7iEkkVAGcDvdqv3ps1u4=;
        b=euF/HOnLs/6rNZQMJ+krl8dHmPZnwzfFpG3DNFzt8vRpMq+ryf1V9+kB22fXWNnZaE
         8UjxKA2t073Rvem6a2rg0X6Ns+6tOP5rHwCdj91UzfmbKpNPwR7LfjPLVz5dQa2KcWIK
         jq4E7CmexcmWq/bhdIIy3GaHgkklHtK7jcbAGYeLCobjsJ1tQSUXgDtUHwQgbELto1Th
         pW8tP/vi2uXfAtVcKSSXUYSQYQr3UM2E/HdpjEP3pqBy69UaNt2fJYJymtNbf8J4xJn3
         ZT8MdLOje2CWx2VXkblag/PUKVJVDPH5uY03M0pARx+3aYZ5z49thunV9uScfIW2ZqXo
         0ZVw==
X-Gm-Message-State: APt69E2j4Z2TGF7k7mo6Mpq3vMsmzsoK/dlZbBpJYP9vu5vRyKYaR0vH
        +Lh950bQPUpanna6OZT0LqtYmUUBaQg00JpW+B52Jw==
X-Google-Smtp-Source: AAOMgpflHJ0aUdVgGfV1C88RewEH12/h3H7PLfHJB0kkMZK92W2Rf+7hTm8iqG0ZErb88discTmjiaVu5UWxmjr2bCA=
X-Received: by 2002:a1c:a484:: with SMTP id n126-v6mr12557746wme.140.1530647683067;
 Tue, 03 Jul 2018 12:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org> <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
 <20180703175808.GC4834@bombadil.infradead.org> <94c282fd-1b5a-e959-b344-01a51fd5fc2e@virtuozzo.com>
 <CALvZod7v4n62PVvC50VSNV12ZV0WdsY4GOQt68EmY4u5fc9hfQ@mail.gmail.com> <20180703192517.GA22738@bombadil.infradead.org>
In-Reply-To: <20180703192517.GA22738@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Jul 2018 12:54:31 -0700
Message-ID: <CALvZod44__V3=Z45rnVVfFUqJM7_tdbBFjwXXtPOttb7TcMSyg@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 12:25 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 03, 2018 at 12:19:35PM -0700, Shakeel Butt wrote:
> > On Tue, Jul 3, 2018 at 12:13 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > > > Do we really have so very many !memcg-aware shrinkers?
> > > >
> > > > $ git grep -w register_shrinker |wc
> > > >      32     119    2221
> > > > $ git grep -w register_shrinker_prepared |wc
> > > >       4      13     268
> > > > (that's an overstatement; one of those is the declaration, one the definition,
> > > > and one an internal call, so we actually only have one caller of _prepared).
> > > >
> > > > So it looks to me like your average system has one shrinker per
> > > > filesystem, one per graphics card, one per raid5 device, and a few
> > > > miscellaneous.  I'd be shocked if anybody had more than 100 shrinkers
> > > > registered on their laptop.
> > > >
> > > > I think we should err on the side of simiplicity and just have one IDR for
> > > > every shrinker instead of playing games to solve a theoretical problem.
> > >
> > > It just a standard situation for the systems with many containers. Every mount
> > > introduce a new shrinker to the system, so it's easy to see a system with
> > > 100 or ever 1000 shrinkers. AFAIR, Shakeel said he also has the similar
> > > configurations.
> > >
> >
> > I can say on our production systems, a couple thousand shrinkers is normal.
>
> But how many are !memcg aware?  It sounds to me like almost all of the
> shrinkers come through the sget_userns() caller, so the other shrinkers
> are almost irrelevant.

I would say almost half. Sorry I do not have exact numbers. Basically
we use ext4 very extensively and majority of shrinkers are related to
ext4 (again I do not have exact numbers). One ext4 mount typically
registers three shrinkers, one memcg-aware (sget) and two non-memcg
aware (ext4_es_register_shrinker, ext4_xattr_create_cache).

Shakeel
