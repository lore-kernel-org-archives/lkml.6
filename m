Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753128-1517970194-2-12644981320582292058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517970190; b=SaLs+oe4bczSccqJpGqEPmqfcaq0m6Qi/futl0urxWQpP1A
    +fndbx56Fyk4p68oxkXOLpz3DY9f12kBsQEH3LcBUBJwi5It/4wjf2pSklp2jlHf
    ruA2YidSwtoPWGMeTuJBSPSyOZbXzBRrT6VjnlEKIW8zqoezhHNv4xCe/p0crLtI
    P9EA5OHRfiDMobNIg/W9VV4IKvfkNMjwedM3L1CSVMGdHaIWsq3LYRe0tiGe+IU2
    TOyTm9zMn3Qerq/D31S2QCi3Lkx/OI3LxNrr+LYQm+/C0o7/AQ5TmAPvnG0iCU3G
    oFOlL7+7KyzLD11KCCTJXGWmdnw2XW2Pwpb8rRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1517970190; bh=mI06S9mZAS+q9cfNaNP2tlAjck
    uBIJsnz2lIyo4BwPc=; b=HBiInIk3bxZiDt5rV5bwiQOEnk4rP/l0KvBlnifB53
    HpJZ88kq66mAXsKj32kL09e9PXIyK0h5Fw+fXa41+6xviDuAjjGWQ2ROY0xTzMN2
    mM+3lm0Dga4I5jxovVBJelHZkBZ8NYP0zniInXLed/ZtGtEquZuX0DHQ/6ACuuQg
    hZY5Cts50WusylpFOpQJFAt3ljS4R27s1FAWckzRa6g8IlHTtyFSoiK9//hL6X/l
    Vq30ySBDTsNccDIN3yaXvyu/cKiv7g9juuf+Bk8mO+hOUySSOdYeTqPI+xKG9BhW
    yQ9Ms+COjFTqFbpZHHFtdyNoVk4Cg4fVlc+8HWuorHEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBGCXH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 21:23:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:23655 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeBGCXH (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 21:23:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="16104425"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Minchan Kim <minchan@kernel.org>
Cc: huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, <stable@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm] mm, swap, frontswap: Fix THP swap if frontswap enabled
References: <20180206065404.18815-1-ying.huang@intel.com>
        <20180206083101.GA17082@eng-minchan1.roam.corp.google.com>
        <871shy3421.fsf@yhuang-dev.intel.com>
        <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
        <CAC=cRTNCDLdobmepCA-9s6HxCgWs16adhre_LfT0HxtXg6meyw@mail.gmail.com>
        <20180206143505.GB25912@eng-minchan1.roam.corp.google.com>
Date: Wed, 07 Feb 2018 10:23:03 +0800
In-Reply-To: <20180206143505.GB25912@eng-minchan1.roam.corp.google.com>
        (Minchan Kim's message of "Tue, 6 Feb 2018 06:35:05 -0800")
Message-ID: <87fu6d1qt4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Minchan Kim <minchan@kernel.org> writes:

> On Tue, Feb 06, 2018 at 09:34:44PM +0800, huang ying wrote:
>> On Tue, Feb 6, 2018 at 5:02 PM, Minchan Kim <minchan@kernel.org> wrote:
>> > On Tue, Feb 06, 2018 at 04:39:18PM +0800, Huang, Ying wrote:
>> >> Hi, Minchan,
>> >>
>> >> Minchan Kim <minchan@kernel.org> writes:
>> >>
>> >> > Hi Huang,
>> >> >
>> >> > On Tue, Feb 06, 2018 at 02:54:04PM +0800, Huang, Ying wrote:
>> >> >> From: Huang Ying <ying.huang@intel.com>
>> >> >>
>> >> >> It was reported by Sergey Senozhatsky that if THP (Transparent Huge
>> >> >> Page) and frontswap (via zswap) are both enabled, when memory goes low
>> >> >> so that swap is triggered, segfault and memory corruption will occur
>> >> >> in random user space applications as follow,
>> >> >>
>> >> >> kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
>> >> >>  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
>> >> >>  #1  0x00007fc08889c2f3 malloc (libc.so.6)
>> >> >>  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
>> >> >>  #3  0x0000560e6005e75c n/a (urxvt)
>> >> >>  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
>> >> >>  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
>> >> >>  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
>> >> >>  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
>> >> >>  #8  0x0000560e6005cb55 ev_run (urxvt)
>> >> >>  #9  0x0000560e6003b9b9 main (urxvt)
>> >> >>  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
>> >> >>  #11 0x0000560e6003f9da _start (urxvt)
>> >> >>
>> >> >> After bisection, it was found the first bad commit is
>> >> >> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
>> >> >> out").
>> >> >>
>> >> >> The root cause is as follow.
>> >> >>
>> >> >> When the pages are written to storage device during swapping out in
>> >> >> swap_writepage(), zswap (fontswap) is tried to compress the pages
>> >> >> instead to improve the performance.  But zswap (frontswap) will treat
>> >> >> THP as normal page, so only the head page is saved.  After swapping
>> >> >> in, tail pages will not be restored to its original contents, so cause
>> >> >> the memory corruption in the applications.
>> >> >>
>> >> >> This is fixed via splitting THP at the begin of swapping out if
>> >> >> frontswap is enabled.  To avoid frontswap to be enabled at runtime,
>> >> >> whether the page is THP is checked before using frontswap during
>> >> >> swapping out too.
>> >> >
>> >> > Nice catch, Huang. However, before the adding a new dependency between
>> >> > frontswap and vmscan that I want to avoid if it is possible, let's think
>> >> > whether frontswap can support THP page or not.
>> >> > Can't we handle it with some loop to handle all of subpages of THP page?
>> >> > It might be not hard?
>> >>
>> >> Yes.  That could be an optimization over this patch.  This patch is just
>> >> a simple fix to make things work and be suitable for stable tree.
>> >
>> > Yub, it would be more complex than this patch. However, this patch introduces
>> > a new dependency to vmscan.c. IOW, we have been good without knowing frontswap
>> > in vmscan.c but from now on, we should be aware of that, which is unfortunate.
>> >
>> > Can't we simple do like that if you want to make it simple and rely on someone
>> > who makes frontswap THP-aware later?
>> >
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 42fe5653814a..4bf1725407aa 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -934,7 +934,11 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
>> >
>> >         /* Only single cluster request supported */
>> >         WARN_ON_ONCE(n_goal > 1 && cluster);
>> > +#ifdef CONFIG_FRONTSWAP
>> > +       /* Now, frontswap doesn't support THP page */
>> > +       if (frontswap_enabled() && cluster)
>> > +               return;
>> > +#endif
>> >         avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
>> >         if (avail_pgs <= 0)
>> >                 goto noswap;
>> >
>> 
>> This can avoid introduce dependency on frontswap in vmscan.c.  But
>> IMHO it doesn't look like the right place to place the logic.
>> vmscan.c is the place we put policy to determine whether to split THP.
>
> It adds split policy in vmscan.c like you said.
>
> shrink_page_list already relies on swap_file.c to decide split a THP page.
> IOW, if a THP swap stuff is not avilable, split a thp.
> It's totally same logic. I don't see any difference at all.
>
> shrink_page_list:
>
> if (!add_to_swap(page)) {
> 	if (PageTransHuge(page))
> 		goto activate_locked;
> 	if (split_huge_page_to_list(page, page_list))
> 		goto activate_locked;
> 	count_vm_event(THP_SWPOUT_FALLBACK);
> 	if (!add_to_swap(page))
> 		goto activate_locked;
> }

OK.  I will change the code as you suggested.

Best Regards,
Huang, Ying
