Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A697218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548805927;
	bh=KevqUReVk+rKgkkiMsfibycVeB5XVVbxY5qYL8RLwRU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q/J0hNMkDwsiAAPYqnf/z6FKmJPyhwqOQMO81c1XTIkC3wKtQfOqPea0neG9FUZAn
	 V0BWWrhBFuxNkxBUvphV9wzJBk86Uv/jjdmjOPFOJXMCERKOqZ/0wtpAX+9mUCqbaf
	 hPKNniFd9pYbtkOymsX0xt+BRh89gZKhv9rM06qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfA2XwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:52:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfA2XwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:52:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78AF7AD2F;
        Tue, 29 Jan 2019 23:52:03 +0000 (UTC)
Date:   Wed, 30 Jan 2019 00:52:02 +0100 (CET)
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
In-Reply-To: <20190128000547.GA25155@nautica>
Message-ID: <nycvar.YFH.7.76.1901300050550.6626@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com> <20190124002455.GA23181@nautica> <20190124124501.GA18012@nautica> <nycvar.YFH.7.76.1901241523500.6626@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1901272335040.6626@cbobk.fhfr.pm> <20190128000547.GA25155@nautica>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Dominique Martinet wrote:

> > So, any objections to aproaching it this way?
> 
> I'm not sure why I'm the main recipient of that mail but answering
> because I am -- let's get these patches in through the regular -mm tree
> though

*prod to mm maintainers* (at least for an opinion)

-- 
Jiri Kosina
SUSE Labs

