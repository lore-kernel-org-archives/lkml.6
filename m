Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="MBC71ieo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfA3Tae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:30:34 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33013 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfA3Tae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:30:34 -0500
Received: by mail-yb1-f196.google.com with SMTP id m132so316244ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u4lGJa1eqm311IjOZIxyEEk5pH4RS2fwSIKRlT/c2bc=;
        b=MBC71ieoROyzpJYMm/RoM48yebOSHThzuo7d3oPiagXJfjLAD5AOCg12b0GXqJMHgo
         byQdg6fKygYXahH3gh70/beX8rcnd9A2w876UhzSUZRp1EC54kTTM02cUEIHzQF34GZP
         9/ViuRdoaByPgSw4yx6n4p8Dlns+T5Pw4L87bee6Hw8nuxjJXB+l8mHHb+lYM9bSEsYh
         p5FehOxBq3izQVdqa3zLxdA2sCUSafZvMUY7D91qtNGspuKGT1tm/XhwTSyKShEMwbNq
         n0dQ3h57xSEY0s45uLv7teLyVuciOaDK0y8LFHR9WeANLuoFKihiVwRYKw4TT3+TpzQm
         g2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4lGJa1eqm311IjOZIxyEEk5pH4RS2fwSIKRlT/c2bc=;
        b=R7H73/HSX7C3lfnNK56M2aT5jd8wn4e6xWCwY/boNZaUb0I5It/Rg0EiyKG4ivNb57
         mcigafHUXoohdV0FQ1bApf5TpCEhMiHzRAi/dFU7G0YgjBZeJ0JR3rUIAFojZkcKiup+
         aAI8Btp3rQiXXCffslmv1iiUGqisVdxg/ydchjPjE20z3Iv4JQZja0ksaBO9FO5dj57r
         iMJ4VG5dKcFE1bhWXHCJNommbDB0kVvnynIgZXuxT1wbUn/gs8wQzs/QfNzSJfO8pyMQ
         0IOJ/vKSRAx3JRCgpWoLtBlYFpKTOl6GW3grhfcX3L3/5GEhT7EuNDuJV5tYTbBNT1fw
         uX3Q==
X-Gm-Message-State: AJcUukfHNyY3L+CeryC0voVseGUhfnvT1r9Ik0NEphCHQ5SlHdS18a03
        YgCBUrbPPlUkD3qeoVAOO8C4tg==
X-Google-Smtp-Source: ALg8bN6aWM4PfrnEWZ0n7/syAfcjFDV7n2/VR+Rg6LPSuim4pyDJ52BuMPbRR8vl2JyQ6Vsoq/7SFg==
X-Received: by 2002:a25:9001:: with SMTP id s1mr29449505ybl.493.1548876628452;
        Wed, 30 Jan 2019 11:30:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id c127sm789304ywb.67.2019.01.30.11.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:30:27 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:30:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130193026.GA21410@cmpxchg.org>
References: <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
 <20190130170658.GY50184@devbig004.ftw2.facebook.com>
 <CALvZod5ma62fRKqrAhMcuNT3GYT3FpRX+DCmeVr2nDg1u=9T8w@mail.gmail.com>
 <20190130192712.GA21279@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130192712.GA21279@cmpxchg.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:27:12PM -0500, Johannes Weiner wrote:
> On Wed, Jan 30, 2019 at 11:11:44AM -0800, Shakeel Butt wrote:
> > Hi Tejun,
> > 
> > On Wed, Jan 30, 2019 at 9:07 AM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > Hello, Michal.
> > >
> > > On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > > > > Yeah, cgroup.events and .stat files as some of the local stats would
> > > > > be useful too, so if we don't flip memory.events we'll end up with sth
> > > > > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > > > > which is gonna be hilarious.
> > > >
> > > > Why cannot we simply have memory.events_tree and be done with it? Sure
> > > > the file names are not goin to be consistent which is a minus but that
> > > > ship has already sailed some time ago.
> > >
> > > Because the overall cost of shitty interface will be way higher in the
> > > longer term.  cgroup2 interface is far from perfect but is way better
> > > than cgroup1 especially for the memory controller.  Why do you think
> > > that is?
> > >
> > 
> > I thought you are fine with the separate interface for the hierarchical events.
> 
> Every other file in cgroup2 is hierarchical, but for recursive
> memory.events you'd need to read memory.events_tree?
> 
> Do we hate our users that much? :(

FTR, I would be okay with adding .local versions to existing files
where such a behavior could be useful. But that seems to be a separate
discussion from fixing memory.events here.
