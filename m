Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2359611-1518085531-2-14188861700308733191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518085530; b=l6iH+tlwIahEihddSO7bNGAshcEe7tmISot2vmq6V+8v1do
    8XoCpefO8y/7wNgJee9yMfPlxVOFHoUYOecVRNB3ZUBYG8LD4NA+NCozJGzaZrnm
    Lu1iioS0+SX4p0NQ2MmlduYqgFJlkv9l3o2WCIHD0LL1xaFocgyAq6QkWMsQWCsl
    +JT0n+9BBw3l97s+WUOsVov/ExT/zoeC7DL8P0Mo9EEtZ+C8lEI0Kmu7x/rk1WlR
    GcRrpohLbUF8V7kXKDqI4/lyV1dSkpYWLh7cbnjvbldATAuPntCX7R1piN97SGv5
    LfJU7m6vMjda7VuvWQlE73fuAECU9FTXBdfp6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518085530; bh=3znYVh0HbInxX2st/2aT7LDUnH
    AkA5mImraH4dZEA3Y=; b=nloe/NvLO5jquEpx9rkeQ9lqHV/NENX/I/9xW0YSeR
    pauKIrfmiC+sWGObZUGsB1RggDF4jW1kACeRSxf+K4D8fUw4DfOneMf2KKRrXpf6
    qxE2sHqYJykGz1tUGQ4Qe4InzE5OAphYBPOR7q7Ur8HbFNX0Xfmzi8uBw6PJjjVG
    hn2sHGj3RcLurkmQD7eHRd5/5fZkidOkb4uoFyEonLwQNhsybNj1Tt0xTCY+Vckp
    N4Hlfde8EqBsky0nNGLo8xzVrM6bixUzBLKXNzqY3rP5h8W2ToK+65Jz/DlQaxxa
    caFOOxOj/x96AwUFARpIQH1bYCKyy08FyQaIxAMrIPsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AA0EByc7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A6JLh3fg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AA0EByc7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A6JLh3fg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBHKZ2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 05:25:28 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35600 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeBHKZ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 05:25:27 -0500
X-Google-Smtp-Source: AH8x227emK7OoAyxlzIzxGgdKVgS7TAbe9TdbHHG4gzHizGneAJ7HVSYZ5H0sfTPHnl5/S+mVN9//w==
Date: Thu, 8 Feb 2018 02:25:21 -0800
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-ID: <20180208102521.GB74192@eng-minchan1.roam.corp.google.com>
References: <20180207070035.30302-1-ying.huang@intel.com>
 <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
 <20180208013635.GA596@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208013635.GA596@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 10:36:35AM +0900, Sergey Senozhatsky wrote:
> On (02/07/18 13:05), Andrew Morton wrote:
> [..]
> > hm.  This is assuming that "cluster==true" means "this is thp swap". 
> > That's presently true, but is it appropriate that get_swap_pages() is
> > peeking at "cluster" to work out why it is being called?
> > 
> > Or would it be cleaner to do this in get_swap_page()?  Something like
> > 
> > --- a/mm/swap_slots.c~a
> > +++ a/mm/swap_slots.c
> > @@ -317,8 +317,11 @@ swp_entry_t get_swap_page(struct page *p
> >  	entry.val = 0;
> >  
> >  	if (PageTransHuge(page)) {
> > -		if (IS_ENABLED(CONFIG_THP_SWAP))
> > -			get_swap_pages(1, true, &entry);
> > +		/* Frontswap doesn't support THP */
> > +		if (!frontswap_enabled()) {
> > +			if (IS_ENABLED(CONFIG_THP_SWAP))
> > +				get_swap_pages(1, true, &entry);
> > +		}
> >  		return entry;
> >  	}
> 
> I have proposed exactly the same thing [1], Minchan commented that
> it would introduce frontswap dependency to swap_slots.c [2]. Which
> is true, but I'd still probably prefer to handle it all in
> get_swap_page. Minchan, any objections?

I didn't want to spread out frontswap stuff unless it has good value
because most of frontswap functions are located in mm/swapfile.c
at this moment. It gives me good feeling frontswap's abstraction
is wonderful.
However, if frontswap matainer has no problem, I am not against, either.

Thanks.
