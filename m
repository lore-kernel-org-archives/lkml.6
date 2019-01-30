Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E9C282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC0B21874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839391;
	bh=32D9OagwTaxStn/ZAQ22u7/rdWwWkySaxp1IprbjQ1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e7NRohuxfgMmJvo2BckPKXWZE+E0+IaNC29L8q0JJVvd+eakdyAlokupvouR1MKCz
	 40xfGWjQUmuqlTUVSkZ1gMLRsre0QJ9ZRYciUXqnW6IZ7khqtiNuGWyEYuE+4HekIu
	 GWxWitxG2vf9iQU+zuHXPtBeXqv+Im0mtCQQP9d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfA3JJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730479AbfA3JJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:09:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4118FAD73;
        Wed, 30 Jan 2019 09:09:47 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:09:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190130090945.GS18811@dhcp22.suse.cz>
References: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm>
 <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
 <20190124002455.GA23181@nautica>
 <20190124124501.GA18012@nautica>
 <nycvar.YFH.7.76.1901241523500.6626@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1901272335040.6626@cbobk.fhfr.pm>
 <20190128000547.GA25155@nautica>
 <nycvar.YFH.7.76.1901300050550.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901300050550.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 00:52:02, Jiri Kosina wrote:
> On Mon, 28 Jan 2019, Dominique Martinet wrote:
> 
> > > So, any objections to aproaching it this way?
> > 
> > I'm not sure why I'm the main recipient of that mail but answering
> > because I am -- let's get these patches in through the regular -mm tree
> > though
> 
> *prod to mm maintainers* (at least for an opinion)

Could you repost those patches please? The thread is long and it is not
really clear what is the most up-to-date state of patches (at least to
me).
-- 
Michal Hocko
SUSE Labs
