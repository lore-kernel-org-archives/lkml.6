Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1206410-1517924090-2-3937338840796192521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517924090; b=EINOCGO7FedZyqyVKDqrLHVYSajQ8HrivvicbcQe/fxnUl3
    SZxhFbgz2iJBQmpoUyVVxwDnlAYb+P4wBVhxopyimMflgv4EuCEVhESCJyprHChH
    4UuQNV8MenrjQVNHL+knx5bCn8NxOddN9ufxa7kf9NbryR/jiNAKrRl+nF4M5aIn
    j6eqRmhFjUvS6NHFPTzwbshxKljUwuIQFE41VM+DGbcefuU7A0BT6Hm4dFq/kDTL
    PK+6+39h2J9XJDK7C2R7r7EmgA5PRbL16c4Q/jAxu3ino61waZkGuAw9LBUIp7ra
    xAseTVxzcK4zuWDHred3CEuCEXMmmKUQMhmQ0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517924090; bh=PJL9lTaN6VALXtxDtC2di88f+ibT1E72s4BA9X
    rzmqc=; b=oEd3tCSM/rNuubPsoctlhTariQZd8MzZOBnbsBuMvw1ckKJ8fXSscs
    BTUngdRKh/+/ifpkoAKw67pu1akvyMR1iiQ3W7UnKiatLVNPRLPbJ9VmVmJj6x56
    yK/dPw5v7R1MyMItVi/zPCPDcvJ8P5qRzr2DokTQEMUvAXm7DAmCeGI5TxSCC5yB
    E82oL3bVXSAyPtQ+UsAwfKelnwQ8OocWUgna58UZ7jc4VUCI6D9GImaDq/M2+HE2
    y4ccVE5bFp5kS3EA66GNSC+otl0z9SMkGn/8dN2MVuA9pzolWrZM70HpEy4KejnV
    /8hBqnHcROk2P9jmHJ4mlty/RfHAcAwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BG4I5yQF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWEmw3Pr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BG4I5yQF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWEmw3Pr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBFNer (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 08:34:47 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33300 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBFNeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 08:34:46 -0500
X-Google-Smtp-Source: AH8x225Q1OFTaA+ssrik5I8d4Jv0n3AmSQ7BboyYso3xMhj2Cl0Sk1Sg9AoA2QAUOrr7PZIeU43MdHbdh6DYbRzYC24=
MIME-Version: 1.0
In-Reply-To: <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
References: <20180206065404.18815-1-ying.huang@intel.com> <20180206083101.GA17082@eng-minchan1.roam.corp.google.com>
 <871shy3421.fsf@yhuang-dev.intel.com> <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
From: huang ying <huang.ying.caritas@gmail.com>
Date: Tue, 6 Feb 2018 21:34:44 +0800
Message-ID: <CAC=cRTNCDLdobmepCA-9s6HxCgWs16adhre_LfT0HxtXg6meyw@mail.gmail.com>
Subject: Re: [PATCH -mm] mm, swap, frontswap: Fix THP swap if frontswap enabled
To: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 5:02 PM, Minchan Kim <minchan@kernel.org> wrote:
> On Tue, Feb 06, 2018 at 04:39:18PM +0800, Huang, Ying wrote:
>> Hi, Minchan,
>>
>> Minchan Kim <minchan@kernel.org> writes:
>>
>> > Hi Huang,
>> >
>> > On Tue, Feb 06, 2018 at 02:54:04PM +0800, Huang, Ying wrote:
>> >> From: Huang Ying <ying.huang@intel.com>
>> >>
>> >> It was reported by Sergey Senozhatsky that if THP (Transparent Huge
>> >> Page) and frontswap (via zswap) are both enabled, when memory goes low
>> >> so that swap is triggered, segfault and memory corruption will occur
>> >> in random user space applications as follow,
>> >>
>> >> kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
>> >>  #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
>> >>  #1  0x00007fc08889c2f3 malloc (libc.so.6)
>> >>  #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
>> >>  #3  0x0000560e6005e75c n/a (urxvt)
>> >>  #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
>> >>  #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
>> >>  #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
>> >>  #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
>> >>  #8  0x0000560e6005cb55 ev_run (urxvt)
>> >>  #9  0x0000560e6003b9b9 main (urxvt)
>> >>  #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
>> >>  #11 0x0000560e6003f9da _start (urxvt)
>> >>
>> >> After bisection, it was found the first bad commit is
>> >> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
>> >> out").
>> >>
>> >> The root cause is as follow.
>> >>
>> >> When the pages are written to storage device during swapping out in
>> >> swap_writepage(), zswap (fontswap) is tried to compress the pages
>> >> instead to improve the performance.  But zswap (frontswap) will treat
>> >> THP as normal page, so only the head page is saved.  After swapping
>> >> in, tail pages will not be restored to its original contents, so cause
>> >> the memory corruption in the applications.
>> >>
>> >> This is fixed via splitting THP at the begin of swapping out if
>> >> frontswap is enabled.  To avoid frontswap to be enabled at runtime,
>> >> whether the page is THP is checked before using frontswap during
>> >> swapping out too.
>> >
>> > Nice catch, Huang. However, before the adding a new dependency between
>> > frontswap and vmscan that I want to avoid if it is possible, let's think
>> > whether frontswap can support THP page or not.
>> > Can't we handle it with some loop to handle all of subpages of THP page?
>> > It might be not hard?
>>
>> Yes.  That could be an optimization over this patch.  This patch is just
>> a simple fix to make things work and be suitable for stable tree.
>
> Yub, it would be more complex than this patch. However, this patch introduces
> a new dependency to vmscan.c. IOW, we have been good without knowing frontswap
> in vmscan.c but from now on, we should be aware of that, which is unfortunate.
>
> Can't we simple do like that if you want to make it simple and rely on someone
> who makes frontswap THP-aware later?
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 42fe5653814a..4bf1725407aa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -934,7 +934,11 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
>
>         /* Only single cluster request supported */
>         WARN_ON_ONCE(n_goal > 1 && cluster);
> +#ifdef CONFIG_FRONTSWAP
> +       /* Now, frontswap doesn't support THP page */
> +       if (frontswap_enabled() && cluster)
> +               return;
> +#endif
>         avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
>         if (avail_pgs <= 0)
>                 goto noswap;
>

This can avoid introduce dependency on frontswap in vmscan.c.  But
IMHO it doesn't look like the right place to place the logic.
vmscan.c is the place we put policy to determine whether to split THP.

[snip]
