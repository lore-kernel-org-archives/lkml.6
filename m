Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EBE20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJK9oqyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeGWRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:19:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36991 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeGWRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:19:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so1297150wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRCRWxPa5qhRdztjFVMXQMWVdzdRusjpODKHDjNtIpQ=;
        b=oJK9oqyGMmqDX4tysDZpRJLCSEyrPZ1Bz6Wq4maicB36VaC1gB79X4ikJk2NLyLL7Q
         41Trmh+y9QMHe3B77u/zO0Gg4YGOIhiJga1JwVjHBAoYheB4g+3CBaQHz0zDwJK6vlmY
         SmDf6PSTjO/nZlXfkDqS2pngqDy+D9V6k4H/YW72NJEWrcSjy7/P29Q0S/Fgme5PKeBO
         Z1LHPlKrxz9E1BzSLqIZHUJx2MhnvsXdlGo5DvbQnUyYQSiXtuL3ctUn/m2eSXmyWtmF
         j5YKYhl8HUumFxqr7Sv5LetznIqf22hsuBMoTGABKnqR2/ofIZta6P6FIJQ/BuOIUG/O
         DcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRCRWxPa5qhRdztjFVMXQMWVdzdRusjpODKHDjNtIpQ=;
        b=QaDuen6Nvs9xtHb1WlOnBmqIrWlpTUkwNcCVB/h1bb0qRsdVHw/Tm0qP7g/K29Yoyu
         LkQpNHaAwJhQy26FzcOWsQ+MbhvOhp79OkkNnNH8738nlzZcmJl54JSD+wbczcUZqbyR
         z72kHiAQfT9jP5EONeGboimRJw9o1eMK9bMA2gUWz+H5J1JmPqhM3O/xDzowSv8EVbic
         NYDkU6Ok+tlhjzLBLl6w08OxmRNbAqVUqyrL9MVaf8CVyAQ5g7+p/TwK1Fuzd6vHbQzb
         ALhVhK+maPVHB6fkpzASRQ7xfU/DLFNS3I0oX83qMbcBP2L/nXGnOSdPk+NXvzsiqjBm
         6XEg==
X-Gm-Message-State: AOUpUlFB1FfuS9Gzi8jDmUZiG5SF1vkGWhM280FE2aLQRWndfqyOgr25
        VgQuqOEdOxZOdenKCeNUlWIXadQI1baZWyaI3KIyqA==
X-Google-Smtp-Source: AAOMgpfxybzKGagctgj/woisP8++Qqqco2w53v3rdxjUXagzvwD+BbaotOynmjC1MQIenaPhp2a88M0ZyLWKsG3Ytog=
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr9609874wra.101.1532362661769;
 Mon, 23 Jul 2018 09:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <1531994807-25639-1-git-send-email-jing.xia@unisoc.com>
 <20180719104345.GV7193@dhcp22.suse.cz> <CALvZod55Ku7U3soLtuYY_HL2_mMp5+OT-hngdZkPRGN9xm1a9Q@mail.gmail.com>
 <20180723064441.GA17905@dhcp22.suse.cz>
In-Reply-To: <20180723064441.GA17905@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 23 Jul 2018 09:17:28 -0700
Message-ID: <CALvZod5UwJp8cM3OcjCDadkjKgAnGHj8XVcgjFk5Thcst02MAQ@mail.gmail.com>
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

On Sun, Jul 22, 2018 at 11:44 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 19-07-18 09:23:10, Shakeel Butt wrote:
> > On Thu, Jul 19, 2018 at 3:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [CC Andrew]
> > >
> > > On Thu 19-07-18 18:06:47, Jing Xia wrote:
> > > > It was reported that a kernel crash happened in mem_cgroup_iter(),
> > > > which can be triggered if the legacy cgroup-v1 non-hierarchical
> > > > mode is used.
> > > >
> > > > Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b8f
> > > > ......
> > > > Call trace:
> > > >   mem_cgroup_iter+0x2e0/0x6d4
> > > >   shrink_zone+0x8c/0x324
> > > >   balance_pgdat+0x450/0x640
> > > >   kswapd+0x130/0x4b8
> > > >   kthread+0xe8/0xfc
> > > >   ret_from_fork+0x10/0x20
> > > >
> > > >   mem_cgroup_iter():
> > > >       ......
> > > >       if (css_tryget(css))    <-- crash here
> > > >           break;
> > > >       ......
> > > >
> > > > The crashing reason is that mem_cgroup_iter() uses the memcg object
> > > > whose pointer is stored in iter->position, which has been freed before
> > > > and filled with POISON_FREE(0x6b).
> > > >
> > > > And the root cause of the use-after-free issue is that
> > > > invalidate_reclaim_iterators() fails to reset the value of
> > > > iter->position to NULL when the css of the memcg is released in non-
> > > > hierarchical mode.
> > >
> > > Well, spotted!
> > >
> > > I suspect
> > > Fixes: 6df38689e0e9 ("mm: memcontrol: fix possible memcg leak due to interrupted reclaim")
> > >
> > > but maybe it goes further into past. I also suggest
> > > Cc: stable
> > >
> > > even though the non-hierarchical mode is strongly discouraged.
> >
> > Why not set root_mem_cgroup's use_hierarchy to true by default on
> > init? If someone wants non-hierarchical mode, they can explicitly set
> > it to false.
>
> We do not change defaults under users feet usually.

Then how non-hierarchical mode is being discouraged currently? I don't
see any comments in the docs.

Shakeel
