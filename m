Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED7C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDE2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548851400;
	bh=9k04ZpP3Kr8HQVFtVnpFw6tUxur4BKf2WQsC5aSqx0o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=e3EvkqJUbrGMYFZQKf2j14X97bL8CXn5yY44RTn7U80kIklt8+dzhSbqIv3k/MDMY
	 K4B08m+B4v7pK2RY0J+ZS1Iu3z1p/oBpUDXR0uOQGBFe37a5Wmgq2BlOuuUxu1FdZj
	 snR08o5t4F2ZGsnGXRQDuCzsR7lrfwwTIRtytwuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfA3M37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:29:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:53576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfA3M37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:29:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71FFDAE04;
        Wed, 30 Jan 2019 12:29:57 +0000 (UTC)
Date:   Wed, 30 Jan 2019 13:29:55 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
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
In-Reply-To: <20190130090945.GS18811@dhcp22.suse.cz>
Message-ID: <nycvar.YFH.7.76.1901301328560.6626@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com> <20190124002455.GA23181@nautica> <20190124124501.GA18012@nautica> <nycvar.YFH.7.76.1901241523500.6626@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1901272335040.6626@cbobk.fhfr.pm> <20190128000547.GA25155@nautica> <nycvar.YFH.7.76.1901300050550.6626@cbobk.fhfr.pm> <20190130090945.GS18811@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Michal Hocko wrote:

> > > I'm not sure why I'm the main recipient of that mail but answering 
> > > because I am -- let's get these patches in through the regular -mm 
> > > tree though
> > 
> > *prod to mm maintainers* (at least for an opinion)
> 
> Could you repost those patches please? The thread is long and it is not
> really clear what is the most up-to-date state of patches (at least to
> me).

Vlastimil seems to have one extra patch to go on top, so we agreed that 
he'll be sending that as a complete self-contained series (either as a 
followup to the very first e-mail in this monsterthread, or completely 
separately) shortly.

Thanks,

-- 
Jiri Kosina
SUSE Labs

