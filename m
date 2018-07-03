Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CB7216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4MTYq1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CB7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeGCTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:19:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGCTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:19:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so3469123wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heGv6udbXzO0xqQtylOJLEkgSvHSE6n2YUOdzGiz/V4=;
        b=P4MTYq1GU65DBLtptZkN2GH+n34oteeJa4v7D0/xOFZUNu0uMgG5aYt47Kw+xRsorv
         7pldFIeByHcxR4wtDnToXCz5+uEDW1iGEIsyAnXCarS07fq+yWn+L1e0cTms8rEyk5Ge
         qD+aYttTGsiJE+M88/poknz/pZ9gRz5+yE+0cUzZ6k0qq9T3IcOhLzuMAn4OKCUfHyvw
         Wg/SbAmI+j1ntSQE9GEqgTQwz+YrJg/UmqlzBKnU8zBXp64SW9s230FX/5C4/R9QxIfC
         PbuaRCHUWk2hQMHoZWd+aLsRBVfxA4FsATo6fbEVKUhKC3Su+UOHfRv73kwvi/FeEFbo
         n4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heGv6udbXzO0xqQtylOJLEkgSvHSE6n2YUOdzGiz/V4=;
        b=MuE4EPtJThvYBAH0j1KJ5y7Bp2edpYmS9xKz1jJqnVt8G9HMm1+nx9LiUTkVnSBWuc
         PxVPnEkyjC6lQYey95TUIMOQurhQJNp+1gTFs2piq+/gbKIE3aEMdlhzoNNdWMLlEVHW
         KhBFUM9lh/X7pVWa2VrXMZSId5UzzVWjjaWwLa1GXEkag0IB/x3oBOKgJHSp7Kcm8GO1
         ZYjqa8oFu7crxoYvkrrCRiKm8vyETmr4WhON/N2D/s/58ErYzAc7FKekJ6jKzNqp1c/K
         GkAZ8UozgEXTTZ2/nOtjRxJAj/T84ZgAtk8IqaaJihLzLvePHaeWFAi7e5yQj5KRVNwW
         fv5A==
X-Gm-Message-State: APt69E0haEuwug2fgcfTZUjUbaIloazpiLzZwMPutdS4aK/eMc/MfTpi
        NknV0dvvOY/VS8eiPb8BBs/BIIhAIp+UyRVyRwDzmw==
X-Google-Smtp-Source: AAOMgpfwQS9mI8nMXgeqF4hl9Vk61R4H5B/w57dcEQ30iSwd0cigtR2rAXP0jY1LfxvQK/kLfvSrBwUiN/WlmCS3sCc=
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr12455699wmf.112.1530645587538;
 Tue, 03 Jul 2018 12:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org> <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
 <20180703175808.GC4834@bombadil.infradead.org> <94c282fd-1b5a-e959-b344-01a51fd5fc2e@virtuozzo.com>
In-Reply-To: <94c282fd-1b5a-e959-b344-01a51fd5fc2e@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Jul 2018 12:19:35 -0700
Message-ID: <CALvZod7v4n62PVvC50VSNV12ZV0WdsY4GOQt68EmY4u5fc9hfQ@mail.gmail.com>
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
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:13 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 03.07.2018 20:58, Matthew Wilcox wrote:
> > On Tue, Jul 03, 2018 at 06:46:57PM +0300, Kirill Tkhai wrote:
> >> shrinker_idr now contains only memcg-aware shrinkers, so all bits from memcg map
> >> may be potentially populated. In case of memcg-aware shrinkers and !memcg-aware
> >> shrinkers share the same numbers like you suggest, this will lead to increasing
> >> size of memcg maps, which is bad for memory consumption. So, memcg-aware shrinkers
> >> should to have its own IDR and its own numbers. The tricks like allocation big
> >> IDs for !memcg-aware shrinkers seem bad for me, since they make the code more
> >> complicated.
> >
> > Do we really have so very many !memcg-aware shrinkers?
> >
> > $ git grep -w register_shrinker |wc
> >      32     119    2221
> > $ git grep -w register_shrinker_prepared |wc
> >       4      13     268
> > (that's an overstatement; one of those is the declaration, one the definition,
> > and one an internal call, so we actually only have one caller of _prepared).
> >
> > So it looks to me like your average system has one shrinker per
> > filesystem, one per graphics card, one per raid5 device, and a few
> > miscellaneous.  I'd be shocked if anybody had more than 100 shrinkers
> > registered on their laptop.
> >
> > I think we should err on the side of simiplicity and just have one IDR for
> > every shrinker instead of playing games to solve a theoretical problem.
>
> It just a standard situation for the systems with many containers. Every mount
> introduce a new shrinker to the system, so it's easy to see a system with
> 100 or ever 1000 shrinkers. AFAIR, Shakeel said he also has the similar
> configurations.
>

I can say on our production systems, a couple thousand shrinkers is normal.

Shakeel
