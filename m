Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2359611-1518085082-2-5918207043194440155
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
    t=1518085082; b=nwS0JkJVVvpRq5Kf5qmRMY0CMX9TENTHs9cv/1LLBwNBP1B
    mM/e4Ee7vA20y8D9x2O6wXEiv9kCqISJYmvVN0hDVx/OhZgtAvYRID2GC/3eGgox
    iOnzUgbrnLsJ/N+apBt38/VjyQwf7x4wdSZPP+7LZ1a2ffvAO0LPMXZ6qUS7YDE2
    VNUaUVrezUzuV5GlzbgGdrfY8mS1DEiW6Gm1WB8CMtn7/iFAweCy0+wJpQJKAYxB
    zczccAHenSaO7bD07Buy2djWjDsh3NyocDZ2QAeiM3AHZj5IhtEUVD1d9tB+q90K
    6eiENrELb69yI/HsKwK2fjkSOQM13j6pGA4X5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518085082; bh=jChV1d4+s6ah2wHV1mvecDSJfT
    AmcGujZG3Bd0o1ozE=; b=LVMbGDRJxaE7zGW9NIJ8XLuNeXxzJqp3qkvTxpIEwa
    7Khg9zfKg/D3zhNFYKFaU/GSFZSvTTltrZgZQxhrfbX6eO5sftes8xundPUY2kll
    qX7mWjExSPtvkFBwvznC4eW1LoMXJWzq5fvokivbXxTo2Dx+XCxqznx+r1RKrSH8
    V84XvlAAzmqzCReoIk/sGTK52HNthKGJmp9lSO6uPe2g3QFr6nqfR3BwCYtGkRrV
    UpXiHuWgXoR/1FuPR+OS+il0yV/0plr731WtUlyKYabwvnExj2NRZavhT6I2Db0g
    JtInQSnkaBe4qY9s525mOljIwJ3OsoWEpS2k/Dg2ZOmQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ebs6307Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dSNhAavm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ebs6307Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dSNhAavm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbeBHKSA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 05:18:00 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44890 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBHKR6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 05:17:58 -0500
X-Google-Smtp-Source: AH8x227R1nyHV1LVFuFrTX5h6iSgNM0oKDlhOzJi6eB34LfoV0k/CrEd2SVQkehx0BPKlTTE5q6lhQ==
Date: Thu, 8 Feb 2018 02:17:52 -0800
From: Minchan Kim <minchan@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Message-ID: <20180208101752.GA74192@eng-minchan1.roam.corp.google.com>
References: <20180207070035.30302-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207070035.30302-1-ying.huang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 03:00:35PM +0800, Huang, Ying wrote:
> From: Huang Ying <huang.ying.caritas@gmail.com>
> 
> It was reported by Sergey Senozhatsky that if THP (Transparent Huge
> Page) and frontswap (via zswap) are both enabled, when memory goes low
> so that swap is triggered, segfault and memory corruption will occur
> in random user space applications as follow,
> 
> kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
>  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
>  #1  0x00007fc08889c2f3 malloc (libc.so.6)
>  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
>  #3  0x0000560e6005e75c n/a (urxvt)
>  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
>  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
>  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
>  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
>  #8  0x0000560e6005cb55 ev_run (urxvt)
>  #9  0x0000560e6003b9b9 main (urxvt)
>  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
>  #11 0x0000560e6003f9da _start (urxvt)
> 
> After bisection, it was found the first bad commit is
> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
> out").
> 
> The root cause is as follow.
> 
> When the pages are written to swap device during swapping out in
> swap_writepage(), zswap (fontswap) is tried to compress the pages
> instead to improve the performance.  But zswap (frontswap) will treat
> THP as normal page, so only the head page is saved.  After swapping
> in, tail pages will not be restored to its original contents, so cause
> the memory corruption in the applications.
> 
> This is fixed via splitting THP before writing the page to swap device
> if frontswap is enabled.  To deal with the situation where frontswap
> is enabled at runtime, whether the page is THP is checked before using
> frontswap during swapping out too.
> 
> Reported-and-tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: stable@vger.kernel.org # 4.14
> Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
> 
> Changelog:
> 
> v2:
> 
> - Move frontswap check into swapfile.c to avoid to make vmscan.c
>   depends on frontswap.
> ---
>  mm/page_io.c  | 2 +-
>  mm/swapfile.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b41cf9644585..6dca817ae7a0 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  		unlock_page(page);
>  		goto out;
>  	}
> -	if (frontswap_store(page) == 0) {
> +	if (!PageTransHuge(page) && frontswap_store(page) == 0) {

Why do we need this?

If frontswap_enabled is enabled but it doesn't support THP, it doesn't allow
cluster allocation by below logic so any THP page shouldn't come this path.
What do I missing now?

>  		set_page_writeback(page);
>  		unlock_page(page);
>  		end_page_writeback(page);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 006047b16814..0b7c7883ce64 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -934,6 +934,9 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
>  
>  	/* Only single cluster request supported */
>  	WARN_ON_ONCE(n_goal > 1 && cluster);
> +	/* Frontswap doesn't support THP */
> +	if (frontswap_enabled() && cluster)
> +		goto noswap;
>  
>  	avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
>  	if (avail_pgs <= 0)
> -- 
> 2.15.1
> 
