Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223968-1518020908-2-16779639592449358058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518020907; b=bL9YulMKgsJ9B45CDxjGptgYoUtN5ZJh8xkg9kUkOxkuRF/
    lFTnvXmZXZnT5hdG7CKczD88U28Z3juQHxqmQ2Edtc7qnEo6azS/kRznhWWVNz63
    5qsSDjvAOmUw4BsRzG25+5KCIhoTSACPMzi+w1yzpkQcYq6MBPpbW4G48qeOwrVv
    PJCHVfE/ar6nV3OJQj9PrXAQmS5AQI2PXiBAGV4HlJw401zhcjQ7U/rMepBx6vAe
    3qmHEkfhXiuzFHC2YzXoc6Yab2dcZY6fwcDsMiH46KFpwPBJ+2hbhtNsYcTY2Kty
    iabC3A2BW8ysRM/bu0+gbjEXxoblVceMuhKUYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518020907; bh=4aQJm6/HJ+N7evqIdD9BVgDprQ
    tJROl1yMUpbL5uTHY=; b=omqef0vjVSolWAoN6zfVzG3jxtE5WP2eemCKTCOnme
    hSLjk/SyKEi+gADWnJ3sioNTiPvJWYFTUsZC+x2ZYm7cDPophN6sCMSOEohJv5iw
    9YUHBaC6OGB5KmrC7q42ThheFe1aZfv7a7f/fm0MIJagvMg5aS+2mExBjLKIreKz
    7NtzuxgW6GoTOxovXjqWvY6wKubHbmgTk8hOzCjN9QDBRGY3nQ9r4xfhn6pBUrPz
    sNaThfLsK1Yd/nxLKAeIuvSA/GhyjyRQr7DkuuMST9wdAgZvy5O8hDTZ7gcoYgZw
    CPqbjkzd1pOZ2qEROG2u0qSCuQvTHG4sIDzwe9sT10hA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ND8LqhNo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ND8LqhNo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeBGQ2Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 11:28:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeBGQ2X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 11:28:23 -0500
Date: Wed, 7 Feb 2018 11:27:50 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-ID: <20180207162750.GB26849@char.us.oracle.com>
References: <20180207070035.30302-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207070035.30302-1-ying.huang@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070207
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

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

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
