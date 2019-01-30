Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A81C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE021901
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870085;
	bh=ZyS6klAeRtY896DZU900KjFEnEeGKmNIWPcLg0oiT0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ax6oN/9zVpbruNVcvLCm856D6siwHCp0us1Q6hRM38YN81JFXDKlN64ScxIjOi4tU
	 GYAHJSab1SqKm9+DONSWZ78IKcOcYwOzI0dXx0Z2pd48mCS3YSMk6nMkD/XeewOgnu
	 SAyAizDcx/qaOzHF2BhxarDnFGd5zxR285m1dn5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfA3RlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:41:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:44328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727765AbfA3RlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BBD1AF51;
        Wed, 30 Jan 2019 17:41:21 +0000 (UTC)
Date:   Wed, 30 Jan 2019 18:41:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130174117.GC18811@dhcp22.suse.cz>
References: <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
 <20190130170658.GY50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130170658.GY50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 09:06:58, Tejun Heo wrote:
> Hello, Michal.
> 
> On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > > Yeah, cgroup.events and .stat files as some of the local stats would
> > > be useful too, so if we don't flip memory.events we'll end up with sth
> > > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > > which is gonna be hilarious.
> > 
> > Why cannot we simply have memory.events_tree and be done with it? Sure
> > the file names are not goin to be consistent which is a minus but that
> > ship has already sailed some time ago.
> 
> Because the overall cost of shitty interface will be way higher in the
> longer term.

But we are discussing the file name effectively. I do not see a long
term maintenance burden. Confusing? Probably yes but that is were the
documentation would be helpful.
-- 
Michal Hocko
SUSE Labs
