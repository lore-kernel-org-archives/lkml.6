Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F03CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799720856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYVALAM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0799720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeGSRHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:07:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40593 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:07:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so7012910wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBoiAf+fwwTWl+wiFp1yO3mt7hvFDEp3X8YtzX7kZP0=;
        b=AYVALAM1T0pbUtNSDPlYcIIu3Banr3Wr6fsxxrrZR5Z0HyCn4h2o7wnzhVHr0PZZia
         iW0IyRnrkuIQZgQHeJk7qnxSPNRPgL8LhwpYv/lyQitQt33A9IEOtfzlZIQKafAaKKn8
         +HDOM9YG5nP5Eo99YFwWr33tZ+b3kJ7ONZkbvO1no1r/ioUcIUMU0FTiYbIVp269aMRX
         9IzxX1BMj73Pz+LO4oblsZLrP5UDjae7X9ajKWobRUxGADIGligITIPKcfvAQz9K9ygI
         qK5W41HeW9CF0smBfA60bIRhflnyeIqys6j0XAA/IyKFz/OaZptPyElYKD6rsrOp6sW8
         qluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBoiAf+fwwTWl+wiFp1yO3mt7hvFDEp3X8YtzX7kZP0=;
        b=NvASMvTgaHOsdG0pH3YOT599J0N0bBSJnV3RmQbOKE8oxQxV0NtmMJFCEfJ4mWcIv/
         tpH1NKs+SJkvNn8Ja4/QxOgUYVX76Ttgc07HgwrucAQeCLs3KNMpz/uShBml7FTcm4uc
         XTDlO1VHGi75T9xOl56J0tUhSQTKAvFBGYLdhcHNTHIG0MrfiIfgcnTNzAuAj8U49z+M
         0QZ1F1AghhYmBX5d++CXqUJGWDUD2ABMoKsprFdtbJf9buvLguQ2WLhYuhWaPD4c2OB0
         uKukkn6JbMXST6XBHPa/iN2J11tftkkurDJU1CedE7Wh60OhxPtU7s4OWy7ptpUja2j6
         2Arg==
X-Gm-Message-State: AOUpUlGup4dW9QyufSS/bV+3FLzyFyS4CC5lMJmNqk3Uw/D24hGZlOlA
        wpE0hP1LzGBRBZao4hcukHQzDdxF1AVycL7ePRBIfg==
X-Google-Smtp-Source: AAOMgpeHuITw1hAk4ClEGrGCcwsmrhblssy3vKNtEnvO7utuMgtFXrog3I8/GOOzpFN3AHZIJd6MaXjLkr3tzYeQlmQ=
X-Received: by 2002:a1c:9a15:: with SMTP id c21-v6mr4990459wme.112.1532017401874;
 Thu, 19 Jul 2018 09:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <1531994807-25639-1-git-send-email-jing.xia@unisoc.com> <20180719104345.GV7193@dhcp22.suse.cz>
In-Reply-To: <20180719104345.GV7193@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Jul 2018 09:23:10 -0700
Message-ID: <CALvZod55Ku7U3soLtuYY_HL2_mMp5+OT-hngdZkPRGN9xm1a9Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix use after free in mem_cgroup_iter()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     jing.xia.mail@gmail.com, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        chunyan.zhang@unisoc.com, Cgroups <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 3:43 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> [CC Andrew]
>
> On Thu 19-07-18 18:06:47, Jing Xia wrote:
> > It was reported that a kernel crash happened in mem_cgroup_iter(),
> > which can be triggered if the legacy cgroup-v1 non-hierarchical
> > mode is used.
> >
> > Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b8f
> > ......
> > Call trace:
> >   mem_cgroup_iter+0x2e0/0x6d4
> >   shrink_zone+0x8c/0x324
> >   balance_pgdat+0x450/0x640
> >   kswapd+0x130/0x4b8
> >   kthread+0xe8/0xfc
> >   ret_from_fork+0x10/0x20
> >
> >   mem_cgroup_iter():
> >       ......
> >       if (css_tryget(css))    <-- crash here
> >           break;
> >       ......
> >
> > The crashing reason is that mem_cgroup_iter() uses the memcg object
> > whose pointer is stored in iter->position, which has been freed before
> > and filled with POISON_FREE(0x6b).
> >
> > And the root cause of the use-after-free issue is that
> > invalidate_reclaim_iterators() fails to reset the value of
> > iter->position to NULL when the css of the memcg is released in non-
> > hierarchical mode.
>
> Well, spotted!
>
> I suspect
> Fixes: 6df38689e0e9 ("mm: memcontrol: fix possible memcg leak due to interrupted reclaim")
>
> but maybe it goes further into past. I also suggest
> Cc: stable
>
> even though the non-hierarchical mode is strongly discouraged.

Why not set root_mem_cgroup's use_hierarchy to true by default on
init? If someone wants non-hierarchical mode, they can explicitly set
it to false.

> A lack of
> reports for 3 years is encouraging that not many people really use this
> mode.
>
> > Signed-off-by: Jing Xia <jing.xia.mail@gmail.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e6f0d5e..8c0280b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -850,7 +850,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> >       int nid;
> >       int i;
> >
> > -     while ((memcg = parent_mem_cgroup(memcg))) {
> > +     for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> >               for_each_node(nid) {
> >                       mz = mem_cgroup_nodeinfo(memcg, nid);
> >                       for (i = 0; i <= DEF_PRIORITY; i++) {
> > --
> > 1.9.1
>
> --
> Michal Hocko
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe cgroups" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
