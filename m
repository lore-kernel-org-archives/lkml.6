Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F32AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547713129;
	bh=tZwLhtiovcwoGS1l5zX/PQWdkur+bGTu1c1lr0bJxUg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=TPMtCKyLuEKBxyAFVL9VGGUCLsJsNVCfWTwUoGd+PHpJy9y+qE/Mi44tRyuHJcY0+
	 8p4dDcFMXrPVkGXmWvOdePQPh7HcIsMESuUBI/KSvxGuV2z8M7I6y3hi5VAHSoKH/5
	 lfjF6rk8q1hZaZJvmJ9iWEnWgqslWzA76/0U4vAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfAQISq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:18:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:59692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfAQISo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:18:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DD94AEE5;
        Thu, 17 Jan 2019 08:18:43 +0000 (UTC)
Date:   Thu, 17 Jan 2019 09:18:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <20190117022244.GV4205@dastard>
Message-ID: <nycvar.YFH.7.76.1901170917490.6626@cbobk.fhfr.pm>
References: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com> <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com> <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com> <20190110004424.GH27534@dastard> <nycvar.YFH.7.76.1901110836110.6626@cbobk.fhfr.pm>
 <20190117022244.GV4205@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Dave Chinner wrote:

> > > commit e837eac23662afae603aaaef7c94bc839c1b8f67
> > > Author: Steve Lord <lord@sgi.com>
> > > Date:   Mon Mar 5 16:47:52 2001 +0000
> > > 
> > >     Add bounds checking for direct I/O, do the cache invalidation for
> > >     data coherency on direct I/O.
> > 
> > Out of curiosity, which repository is this from please? Even google 
> > doesn't seem to know about this SHA.
> 
> because oss.sgi.com is no longer with us, it's fallen out of all the
> search engines.  It was from the "archive/xfs-import.git" tree on
> oss.sgi.com:
> 
> https://web.archive.org/web/20120326044237/http://oss.sgi.com:80/cgi-bin/gitweb.cgi
> 
> but archive.org doesn't have a copy of the git tree. It contained
> the XFS history right back to the first Irix commit in 1993. Some of
> us still have copies of it sitting around....

For cases like this, would it be worth pushing it to git.kernel.org as an 
frozen historical reference archive?

Thanks,

-- 
Jiri Kosina
SUSE Labs

