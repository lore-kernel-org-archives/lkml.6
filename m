Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1785872-1518452773-2-13430446155054049965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518452772; b=KG6ieGM61Ko+tL1OdBaym6coYS9DXl3I/EKHoyyscuh+pSN
    rn7lx4iDcfAyDhC+1mJjleRV8kK0q5pqIKXGvszqVqt/JkDYseZ7tW0NXaMJV6vN
    FCxV/6P+Tomgk38XsmWth6DAuHCWm1BeM4+oDJqyWndq+72ceEMDK5TpLD6WYq/r
    WVHO3i+ON8m23ef9eRrnU5XXlBEou6Y7UzhsmmWU3EVo53UdD9sFVc4m4/M4k/Hb
    wbs7Ro6lpXJZnBRSVhAqQxUFkw++POQOiGe1Yjul7wNC6nqwEX1M2P9QXtTFnOpr
    +UUwkE9HsEmqWUcrkEReGLvCVwGWT6CGYTKOv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518452772; bh=2bnqJ4GXp+WniHFPjDYSPEKfZlAqnP8uPJa
    94xckVWA=; b=dF3ovWukUI9/njZbScAzKEKaY88V92ztLnGDAOKlW3k0l43ojwf
    Lnib78d2xTuCGoO/4yAKbprSkDwZnxSsLTeIoO/xMtcxOclIM5+Z4ry7mLGBbXBE
    CxR+3q2BsX0TAjcO+QyC7wXJOe4IC+NvnnFuAxK59h305TVV16Mcac5/ndOgcHYt
    pFCw7IIWvntCELCVDLWfaW9erTKMub9Q9uc8/LnZsKwovudpFfBp2+mygh/bZPJU
    ndGE7u/anYvMfU9iSqdAh1mwSohCL24FekbzF2eKJjeEm4BYHguGP/ZdNrZXq9/q
    1NiF89c8wz9jOA5+/U01/5yvdcj0eXlyfCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rP1Vzm7K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ieee.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=arkqDZnh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ieee.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rP1Vzm7K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ieee.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=arkqDZnh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ieee.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964927AbeBLQ0L (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 11:26:11 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43656 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964875AbeBLQ0J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Feb 2018 11:26:09 -0500
X-Google-Smtp-Source: AH8x2250iai1j/eRsUjbS5Zx1p4GPPLyUNgFwMASfHwdfwArWzl/7LThsFj4lguHBrgPwSn3jyvgWQ==
Date: Mon, 12 Feb 2018 11:26:06 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
To: Minchan Kim <minchan@kernel.org>
cc: huang ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
In-Reply-To: <20180208173734.GA80964@eng-minchan1.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1802121117250.19493@thorin>
References: <20180207070035.30302-1-ying.huang@intel.com> <CAC=cRTOacms57fSuQrYjfj_vijxx-9nK9c9u0YQ60qcYJ64Eow@mail.gmail.com> <20180208173734.GA80964@eng-minchan1.roam.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Thu, 8 Feb 2018, Minchan Kim wrote:

> Hi Huang,
> 
> On Thu, Feb 08, 2018 at 11:27:50PM +0800, huang ying wrote:
> > On Wed, Feb 7, 2018 at 3:00 PM, Huang, Ying <ying.huang@intel.com> wrote:
> > > From: Huang Ying <huang.ying.caritas@gmail.com>
> > >
> > > It was reported by Sergey Senozhatsky that if THP (Transparent Huge
> > > Page) and frontswap (via zswap) are both enabled, when memory goes low
> > > so that swap is triggered, segfault and memory corruption will occur
> > > in random user space applications as follow,
> > >
> > > kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
> > >  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
> > >  #1  0x00007fc08889c2f3 malloc (libc.so.6)
> > >  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
> > >  #3  0x0000560e6005e75c n/a (urxvt)
> > >  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
> > >  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
> > >  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
> > >  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
> > >  #8  0x0000560e6005cb55 ev_run (urxvt)
> > >  #9  0x0000560e6003b9b9 main (urxvt)
> > >  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
> > >  #11 0x0000560e6003f9da _start (urxvt)
> > >
> > > After bisection, it was found the first bad commit is
> > > bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
> > > out").
> > >
> > > The root cause is as follow.
> > >
> > > When the pages are written to swap device during swapping out in
> > > swap_writepage(), zswap (fontswap) is tried to compress the pages
> > > instead to improve the performance.  But zswap (frontswap) will treat
> > > THP as normal page, so only the head page is saved.  After swapping
> > > in, tail pages will not be restored to its original contents, so cause
> > > the memory corruption in the applications.
> > >
> > > This is fixed via splitting THP before writing the page to swap device
> > > if frontswap is enabled.  To deal with the situation where frontswap
> > > is enabled at runtime, whether the page is THP is checked before using
> > > frontswap during swapping out too.
> > >
> > > Reported-and-tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Cc: Dan Streetman <ddstreet@ieee.org>
> > > Cc: Seth Jennings <sjenning@redhat.com>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Cc: Shaohua Li <shli@kernel.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: stable@vger.kernel.org # 4.14
> > > Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
> > >
> > > Changelog:
> > >
> > > v2:
> > >
> > > - Move frontswap check into swapfile.c to avoid to make vmscan.c
> > >   depends on frontswap.
> > > ---
> > >  mm/page_io.c  | 2 +-
> > >  mm/swapfile.c | 3 +++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index b41cf9644585..6dca817ae7a0 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
> > >                 unlock_page(page);
> > >                 goto out;
> > >         }
> > > -       if (frontswap_store(page) == 0) {
> > > +       if (!PageTransHuge(page) && frontswap_store(page) == 0) {
> > >                 set_page_writeback(page);
> > >                 unlock_page(page);
> > >                 end_page_writeback(page);
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 006047b16814..0b7c7883ce64 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -934,6 +934,9 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
> > >
> > >         /* Only single cluster request supported */
> > >         WARN_ON_ONCE(n_goal > 1 && cluster);
> > > +       /* Frontswap doesn't support THP */
> > > +       if (frontswap_enabled() && cluster)
> > > +               goto noswap;
> > 
> > I found this will cause THP swap optimization be turned off forever if
> > CONFIG_ZSWAP=y (which cannot =m).  Because frontswap is enabled quite
> > statically instead of dynamically.  If frontswap_ops is registered, it
> > will be enabled unconditionally and forever.  And zswap will register
> > frontswap_ops during initialize regardless whether zswap is enabled or
> > not.
> 
> Indeed.
> 
> > 
> > So I think it will be better to remove swapfile.c changes in this
> > patch, just keep page_io.c changes.  Because THP is more dynamic, it
> 
> Then, I think it should be done by frontswap backend rather than generic
> swap layer. Because there are two backends now and one of them can support
> first.

I like this approach.  It allows zswap or xen tmem to support THP in the 
future.

> 
> diff --git a/drivers/xen/tmem.c b/drivers/xen/tmem.c
> index bf13d1ec51f3..bdaf309aeea6 100644
> --- a/drivers/xen/tmem.c
> +++ b/drivers/xen/tmem.c
> @@ -284,6 +284,9 @@ static int tmem_frontswap_store(unsigned type, pgoff_t offset,
>         int pool = tmem_frontswap_poolid;
>         int ret;
>  
> +       if (PageTransHuge(page))
> +               return -EINVAL;
> +
>         if (pool < 0)
>                 return -1;
>         if (ind64 != ind)
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c004aa4fd3f4..e343534d2892 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1007,6 +1007,9 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>         u8 *src, *dst;
>         struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
>  
> +       if (PageTransHuge(page))
> +               return -EINVAL;
> +
>         if (!zswap_enabled || !tree) {
>                 ret = -ENODEV;
>                 goto reject;
> 
> 
