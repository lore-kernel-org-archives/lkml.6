Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2216002-1518210227-2-497607843688253474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518210226; b=CPDhM3z6hZpNV9+wC9LtBqnoylSKCzuTIEk01LITQyAyPt1
    vNWLKlSfj55MGjij44/hpXkPJZDJ4Fv7pyaH3BiFXOgEgfypJG2b0IBCqBk+eZyQ
    kXA/yKxCfOWaXNf13J296jj8cwsRgJ0HYv02v+wmLTfjEqcyybuZIoiipcdIchV+
    lVzS7nNOY6DK+p/dVpHfFYkMkInh5vTrSnMK1o10WN485GUMAIxKhsShEeTJC5hS
    MiCK17ZreDH3XcS6G7yIhZMKihDfhJOu8cY1ulBHoPnzNm+TvbK/u/ga4aeBeNvk
    v5zWpF3QYnEvvWmn+zwNkZ1zpeRkrpenVKlJH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518210226; bh=q2QcCQOAa8kf4g4/e/MRg1i3LfSXLRVRNl9sdXht6Bk=; b=U
    6N3ngUPiNofDFS13JE5tXYsKUUymwPu9WgvwBL29O+EhuYHCWTBrLWhqJ+Szx2lZ
    DHmGn4+iI/KGSIjvNrS81NRHgra/uj2vZN/TMkZCZlpDqUAJY7PeyQXB7EysE8OM
    9B4k+4flOEMHEZ0NwcKRD+pYMBINJnSs3x9nVMQTvEqe93XTLmIA9wFINiUrlHiM
    agvNMtH7CHNNV76BwEdSe3I41kR8LOfJ+kctYTIiEhS2WS3IRKwFc6khNNHtH9Sh
    DNVyDQyX0DCKJOYbxWOXrAWrlWM/1QGBk/Q9ZcGseKL1Kx4xeGD+9EhFGjHYMUwE
    GHgO5WvaboUod5nDgM6IQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeBIVDp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 16:03:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIVDp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 16:03:45 -0500
Date: Fri, 9 Feb 2018 13:03:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH -mm -v3] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-Id: <20180209130339.e91c8709e9c46e5b3f941a29@linux-foundation.org>
In-Reply-To: <20180209084947.22749-1-ying.huang@intel.com>
References: <20180209084947.22749-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri,  9 Feb 2018 16:49:47 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

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
> This is fixed via rejecting to save page in frontswap store functions
> if the page is a THP.  So that the THP will be swapped out to swap
> device.
> 
> Another choice is to split THP if frontswap is enabled.  But it is
> found that the frontswap enabling isn't flexible.  For example, if
> CONFIG_ZSWAP=y (cannot be module), frontswap will be enabled even if
> zswap itself isn't enabled.
> 
> Frontswap has multiple backends, to make it easy for one backend to
> enable THP support, the THP checking is put in backend frontswap store
> functions instead of the general interfaces.
> 
> Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
> Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

I don't think Sergey has tested this version and I suspect this is a
holdover from the earlier patch, so I'll remove this line.

> Suggested-by: Minchan Kim <minchan@kernel.org> # put THP checking in backend
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: stable@vger.kernel.org # 4.14
