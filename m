Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D73C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162D42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEKKgLcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfA3Thz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:37:55 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39956 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbfA3Thy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:37:54 -0500
Received: by mail-yb1-f194.google.com with SMTP id y13so301379ybr.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynztbY1mL0CpFlAEvrgll//q6zMLgn4eN+pIRdt4AAk=;
        b=hEKKgLcCzb2TF8FQN9P2G70rLcqxOf+LMks/+bF+A75PISRGD8IJ9dC5LM2uk05Xwq
         55VsBJhulcECv3kpovgOaIni5zJcPfJUS59855DCJ7ExDIP5ewLYj3ZjEVsiCG6PTEPM
         Zqiv5d0Kub8BDoQ50wztXVuUhutgHbqGzcZzom1m9me6gBYX7Vl5RrUWDnYxTiznNLZs
         gSZPPN52kSVg6gWY1zJ5H1OUEUDHNjAOiFC+pL2T/p3giL4aVbqLAjXkrufL5hGaOC6Z
         tlCSEkC13nHm6KoldXcMhad4Ey3Nrts77/IJMgMhS0kiTkyCLuCCX209hI2fh1TRz8xD
         uO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynztbY1mL0CpFlAEvrgll//q6zMLgn4eN+pIRdt4AAk=;
        b=Wtf89BX/eyX7ykexIZ3Au3Kcn4Vou38Coa5MqOdWM3OYQkH6N+9lR1B3LXpILKD48v
         7cl6MzHz7Z90ubsePGCf4TkohVMF/9Zr50pvvdu/gQpAYof+uCyons/YSbFFBkQKn70K
         48OVOiGeVN+XD/BW4zDJYSMVBijHiZO1ysmDkyy2G/36/ZVfiUawjR8fFpfqPu8kjyHJ
         oQZU+Uuw+U+oA+S7jM3Ye6/RDUx3AIMExkXXWuEPeS8zqfNLQsUU9HPksobrYNvBZxeG
         xXeIPTOsYEM3KEkH2bq6+z3KQ30Ws//GSflxoUMgjGgSEapCdPvz1pr03MBRNW5liZBy
         x8EQ==
X-Gm-Message-State: AJcUukfzWhBXSimmUV4d8kWRU4RsHp0qJO9q3bqQ/s3Le3Yco+vg9WbG
        6IinGw8T49B7QPyZ5DhKx2Zkn2jCDkvYTKR09XHYzg==
X-Google-Smtp-Source: ALg8bN4m6DdZb64I2TwM1WAOhkdzCmwIj2WgVfJC+FcPK4G0gACjv2e4CSsynpbc+jp0qKmatItJpljIxuFrLjpZ2A4=
X-Received: by 2002:a25:6f8b:: with SMTP id k133mr29688224ybc.496.1548877073376;
 Wed, 30 Jan 2019 11:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20190128151859.GO18811@dhcp22.suse.cz> <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz> <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz> <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz> <20190130170658.GY50184@devbig004.ftw2.facebook.com>
 <CALvZod5ma62fRKqrAhMcuNT3GYT3FpRX+DCmeVr2nDg1u=9T8w@mail.gmail.com>
 <20190130192712.GA21279@cmpxchg.org> <20190130193026.GA21410@cmpxchg.org>
In-Reply-To: <20190130193026.GA21410@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jan 2019 11:37:41 -0800
Message-ID: <CALvZod65htZmApWkv-MrAjg6V1OGBLmdyFP_030LARD7ajS3mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:30 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jan 30, 2019 at 02:27:12PM -0500, Johannes Weiner wrote:
> > On Wed, Jan 30, 2019 at 11:11:44AM -0800, Shakeel Butt wrote:
> > > Hi Tejun,
> > >
> > > On Wed, Jan 30, 2019 at 9:07 AM Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > Hello, Michal.
> > > >
> > > > On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > > > > > Yeah, cgroup.events and .stat files as some of the local stats would
> > > > > > be useful too, so if we don't flip memory.events we'll end up with sth
> > > > > > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > > > > > which is gonna be hilarious.
> > > > >
> > > > > Why cannot we simply have memory.events_tree and be done with it? Sure
> > > > > the file names are not goin to be consistent which is a minus but that
> > > > > ship has already sailed some time ago.
> > > >
> > > > Because the overall cost of shitty interface will be way higher in the
> > > > longer term.  cgroup2 interface is far from perfect but is way better
> > > > than cgroup1 especially for the memory controller.  Why do you think
> > > > that is?
> > > >
> > >
> > > I thought you are fine with the separate interface for the hierarchical events.
> >
> > Every other file in cgroup2 is hierarchical, but for recursive
> > memory.events you'd need to read memory.events_tree?
> >
> > Do we hate our users that much? :(
>
> FTR, I would be okay with adding .local versions to existing files
> where such a behavior could be useful. But that seems to be a separate
> discussion from fixing memory.events here.

Oh ok, the dispute is on the name of the interface. I am fine with
whatever the decision is made as we (Google) are still not using these
interfaces. However what's the way forward here?

thanks,
Shakeel
