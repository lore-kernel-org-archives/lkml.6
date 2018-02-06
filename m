Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727095-1517907790-2-8912181182608764162
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
    t=1517907789; b=k6eJI1i2LdfgveA7zcPyVWlhBgzYa73N3IK4JPF8v6VxYLm
    hdOdoj9u+vsaFjyU9x6PThi45ZVDu7TQMuSZRsYxaYuwPYH16W8xxtmSoPBYfMfV
    MGwFLT7zhUhpsQtXLFTkgFRIAwQdgaX5i2u536QcFqO9h8bZ/g2KBjjdxY/AP4mX
    75UyI7OcByAeuj7rONJrLVe07p0bQqg7wSlbnMrK0qraEHRGLd6ZEWEpNu9Rkczs
    gx/8N03SN+V9hs3gAnLZPuVCZge556mnIkm1pmRi8BVn5JVwjsBHA+L74tLpSjVt
    7u5oO8LE6NQBdgmscGY2zQJNeMMHSlNmESKQZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517907789; bh=aMRuWLg2u1hMpfwuxZeFkvr99V
    fu/2VvnJAdu6AR9OU=; b=wEp/gXCprda2OPy0emejJhrWfCwLvCPdsyXX2wadbA
    HN+NbW2Zebf7FOlS8dB+xxotcd1jaQwzpWD4CL4NeE+PS0iLFkwhMuvlAyX7nHGL
    N3nnAsRM57QutT98VzkG/nh+b6eQsQmIP7eSZbKCKGlDcp8sVTRE+ANmCPWFyMvL
    uwmpL2GFjux9kPnwwifflScAXa50FCoSVg6RIygWxaz75sPAchcF2eoNb7UNPzJc
    wEeusLcm01B+2zNGQcJmO0Cj/sS8najfXwOOSp5oHb+exkBEzhuMBrQ2iDiVSgKo
    Hqrl2jk5Jg7bmvaDMQG5GGC0A4y2FKg28jniu5fzQxrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OZ/aWZWs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gjdYKlBR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OZ/aWZWs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gjdYKlBR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeBFJC6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 04:02:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:54561 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFJCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 04:02:53 -0500
X-Google-Smtp-Source: AH8x225TYZE28euZwDdN4V/9KrHefRSvUfYTvLLyK1aeaZq/QOdDerG82aNln+vkRe/OFel1DLOXCw==
Date: Tue, 6 Feb 2018 01:02:44 -0800
From: Minchan Kim <minchan@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-ID: <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
References: <20180206065404.18815-1-ying.huang@intel.com>
 <20180206083101.GA17082@eng-minchan1.roam.corp.google.com>
 <871shy3421.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871shy3421.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 04:39:18PM +0800, Huang, Ying wrote:
> Hi, Minchan,
> 
> Minchan Kim <minchan@kernel.org> writes:
> 
> > Hi Huang,
> >
> > On Tue, Feb 06, 2018 at 02:54:04PM +0800, Huang, Ying wrote:
> >> From: Huang Ying <ying.huang@intel.com>
> >> 
> >> It was reported by Sergey Senozhatsky that if THP (Transparent Huge
> >> Page) and frontswap (via zswap) are both enabled, when memory goes low
> >> so that swap is triggered, segfault and memory corruption will occur
> >> in random user space applications as follow,
> >> 
> >> kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
> >>  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
> >>  #1  0x00007fc08889c2f3 malloc (libc.so.6)
> >>  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
> >>  #3  0x0000560e6005e75c n/a (urxvt)
> >>  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
> >>  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
> >>  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
> >>  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
> >>  #8  0x0000560e6005cb55 ev_run (urxvt)
> >>  #9  0x0000560e6003b9b9 main (urxvt)
> >>  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
> >>  #11 0x0000560e6003f9da _start (urxvt)
> >> 
> >> After bisection, it was found the first bad commit is
> >> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
> >> out").
> >> 
> >> The root cause is as follow.
> >> 
> >> When the pages are written to storage device during swapping out in
> >> swap_writepage(), zswap (fontswap) is tried to compress the pages
> >> instead to improve the performance.  But zswap (frontswap) will treat
> >> THP as normal page, so only the head page is saved.  After swapping
> >> in, tail pages will not be restored to its original contents, so cause
> >> the memory corruption in the applications.
> >> 
> >> This is fixed via splitting THP at the begin of swapping out if
> >> frontswap is enabled.  To avoid frontswap to be enabled at runtime,
> >> whether the page is THP is checked before using frontswap during
> >> swapping out too.
> >
> > Nice catch, Huang. However, before the adding a new dependency between
> > frontswap and vmscan that I want to avoid if it is possible, let's think
> > whether frontswap can support THP page or not.
> > Can't we handle it with some loop to handle all of subpages of THP page?
> > It might be not hard?
> 
> Yes.  That could be an optimization over this patch.  This patch is just
> a simple fix to make things work and be suitable for stable tree.

Yub, it would be more complex than this patch. However, this patch introduces
a new dependency to vmscan.c. IOW, we have been good without knowing frontswap
in vmscan.c but from now on, we should be aware of that, which is unfortunate.

Can't we simple do like that if you want to make it simple and rely on someone
who makes frontswap THP-aware later?

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 42fe5653814a..4bf1725407aa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -934,7 +934,11 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
 
        /* Only single cluster request supported */
        WARN_ON_ONCE(n_goal > 1 && cluster);
+#ifdef CONFIG_FRONTSWAP
+       /* Now, frontswap doesn't support THP page */
+       if (frontswap_enabled() && cluster)
+               return;
+#endif
        avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
        if (avail_pgs <= 0)
                goto noswap;


> 
> I think it may be too complex for stable tree to handle THP in zswap.
> 
> Best Regards,
> Huang, Ying
> 
> >> 
> >> Reported-and-tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> Cc: Dan Streetman <ddstreet@ieee.org>
> >> Cc: Seth Jennings <sjenning@redhat.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Cc: Shaohua Li <shli@kernel.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Cc: Shakeel Butt <shakeelb@google.com>
> >> Cc: stable@vger.kernel.org # 4.14
> >> Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
> >> ---
> >>  mm/page_io.c |  2 +-
> >>  mm/vmscan.c  | 16 +++++++++++++---
> >>  2 files changed, 14 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/mm/page_io.c b/mm/page_io.c
> >> index b41cf9644585..6dca817ae7a0 100644
> >> --- a/mm/page_io.c
> >> +++ b/mm/page_io.c
> >> @@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
> >>  		unlock_page(page);
> >>  		goto out;
> >>  	}
> >> -	if (frontswap_store(page) == 0) {
> >> +	if (!PageTransHuge(page) && frontswap_store(page) == 0) {
> >>  		set_page_writeback(page);
> >>  		unlock_page(page);
> >>  		end_page_writeback(page);
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index bee53495a829..d1c1e00b08bb 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -55,6 +55,7 @@
> >>  
> >>  #include <linux/swapops.h>
> >>  #include <linux/balloon_compaction.h>
> >> +#include <linux/frontswap.h>
> >>  
> >>  #include "internal.h"
> >>  
> >> @@ -1063,14 +1064,23 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >>  					/* cannot split THP, skip it */
> >>  					if (!can_split_huge_page(page, NULL))
> >>  						goto activate_locked;
> >> +					/*
> >> +					 * Split THP if frontswap enabled,
> >> +					 * because it cannot process THP
> >> +					 */
> >> +					if (frontswap_enabled()) {
> >> +						if (split_huge_page_to_list(
> >> +							page, page_list))
> >> +							goto activate_locked;
> >> +					}
> >>  					/*
> >>  					 * Split pages without a PMD map right
> >>  					 * away. Chances are some or all of the
> >>  					 * tail pages can be freed without IO.
> >>  					 */
> >> -					if (!compound_mapcount(page) &&
> >> -					    split_huge_page_to_list(page,
> >> -								    page_list))
> >> +					else if (!compound_mapcount(page) &&
> >> +						 split_huge_page_to_list(page,
> >> +							page_list))
> >>  						goto activate_locked;
> >>  				}
> >>  				if (!add_to_swap(page)) {
> >> -- 
> >> 2.15.1
> >> 
