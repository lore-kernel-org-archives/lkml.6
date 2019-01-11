Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24833C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547192220;
	bh=KWw9lLAPvLC5RQzak/MkMz1rq9z4GvHhoJ1BhkBa8FE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=z1OO6iHRrpqKQ2niDquhrahuoZRFr5HHOVKv6n6WuQh4WT1WjaUIg4EW4vyQcefY4
	 9qtIBLcqBWS5a7cz60OQIIK8GnwIm1VdbOu1lovi6NZEYrfHP1dBTGVlWppDfajMN4
	 i1RH7n9dn95mkNIBp8bDSFtXRwdnfJnTHKPvbJUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfAKHg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:36:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:59860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbfAKHg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:36:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51535B07C;
        Fri, 11 Jan 2019 07:36:57 +0000 (UTC)
Date:   Fri, 11 Jan 2019 08:36:55 +0100 (CET)
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
In-Reply-To: <20190110004424.GH27534@dastard>
Message-ID: <nycvar.YFH.7.76.1901110836110.6626@cbobk.fhfr.pm>
References: <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com> <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com> <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com> <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Dave Chinner wrote:

> Sounds nice from a theoretical POV, but reality has taught us very 
> different lessons.
> 
> FWIW, a quick check of XFS's history so you understand how long this 
> behaviour has been around. It was introduced in the linux port in 2001 
> as direct IO support was being added:
> 
> commit e837eac23662afae603aaaef7c94bc839c1b8f67
> Author: Steve Lord <lord@sgi.com>
> Date:   Mon Mar 5 16:47:52 2001 +0000
> 
>     Add bounds checking for direct I/O, do the cache invalidation for
>     data coherency on direct I/O.

Out of curiosity, which repository is this from please? Even google 
doesn't seem to know about this SHA.

Thanks,

-- 
Jiri Kosina
SUSE Labs

