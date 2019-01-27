Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F1DC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5620882
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548628547;
	bh=l6UMu/2x4OWi0Y+SJq0JSEzyFitC+pTg7s2Ap7kBkvI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ncOYLbI1GnrXUHpwOeN3gZuLxHyS5pPmuk87L3MzuPVJuXM773Lr/mpj0OpyhC5zK
	 x1GWRSa5qnuSUWkW5gOpDFvWW3DNRxC7R6+MuUS+eFTEdt9TtA4eCmjX8VBsDEPICa
	 hlk507qIy2/s6Cng7e34/WjtzMEbx8sbkZpobAoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfA0Wfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 17:35:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbfA0Wfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 17:35:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DB8FAE9D;
        Sun, 27 Jan 2019 22:35:44 +0000 (UTC)
Date:   Sun, 27 Jan 2019 23:35:42 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <nycvar.YFH.7.76.1901241523500.6626@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1901272335040.6626@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com> <20190124002455.GA23181@nautica> <20190124124501.GA18012@nautica> <nycvar.YFH.7.76.1901241523500.6626@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Jiri Kosina wrote:

> > Jiri, you've offered resubmitting the last two patches properly, can you 
> > incorporate this change or should I just send this directly? (I'd take 
> > most of your commit message and add your name somewhere)
> 
> I've been running some basic smoke testing with the kernel from
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/jikos/jikos.git/log/?h=pagecache-sidechannel-v2
> 
> (attaching the respective two patches to apply on top of latest Linus' 
> tree to this mail as well), and everything looks good so far.

So, any objections to aproaching it this way?

I've not been able to spot any obvious breakage so far with it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

