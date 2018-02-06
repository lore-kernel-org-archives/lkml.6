Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716755-1517910513-2-8894184252420795276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517910512; b=ZjSb0P5KFMn6W0K+cJcUgtPz3iTBPHPCCOfErWMk99LRd/I
    7ClfNj/dc8U8d9Hj4fERqDPIm1qVWv2Gpv2/lZKpXjwPov0Q0hxV+wlOX6lVhmNL
    UVo1JhmH6rxQVo/f++txv1uWmCaaS3YgrjT/6F4DmgNeT6aztLt2CTLCZR44/KIj
    X6At1CfY7SOjwPvgvMZyo3agZ4lVj4Jg0lgJ5i64umkSW3yTfjKDD9owdlyhlBrN
    AUwepHLmXKjaTUr1SoLfIfwRL3HI9JTu6E72EhPtL4zl7UXBK3jmqEqqyqDBTPAn
    Ghj11m+xSP7f7S72SopgpNBYY/zONLZXc90co0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517910512; bh=J2vy23NO4LgKrT6PyeBDu8YTbM
    aAufRvPG5TxzbUyWs=; b=BYprsAoEmDci4qxEYvEJgCLp54EF1KN5N2QbRbDSYk
    2ckyUyC4GRnWKgyLVnFmhAbjK5ORkF+iu+Z/qANQ2vG5t25PsQOGR8qwY17dSs6K
    peEfw8gDmIqN042D0KSAEA6t6BRjKxcHFlZCNEpA+aeq2wOi57FywiRkvNBI6ot6
    RRe9SGWmdUNqksJavUOlWOD287TXxOfo/LFtThzzH7LH2mNu4bs60+N9+lmbRm/8
    eFSCiIedF9J+RaZ4BiV/LC5GOHaTUrKc2c08EjoNYkZghYTKAu9jUm2Jl876j8iY
    xT7EOhzBtVTiRRKfa7fk69YCAHfDXFUJawEvm91hKneQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TPiec2bO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Epyo/RiW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TPiec2bO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Epyo/RiW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBFJsa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 04:48:30 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37469 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFJs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 04:48:28 -0500
X-Google-Smtp-Source: AH8x2276xsm3TWO4wVUs72qIU6b5hVfRkQ9GedaYnjtf6EaCuSPZPMlkuw6/ConHSd0ezvRtZUO1UQ==
Date: Tue, 6 Feb 2018 18:48:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Message-ID: <20180206094822.GA2265@jagdpanzerIV>
References: <20180206065404.18815-1-ying.huang@intel.com>
 <20180206083101.GA17082@eng-minchan1.roam.corp.google.com>
 <871shy3421.fsf@yhuang-dev.intel.com>
 <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On (02/06/18 01:02), Minchan Kim wrote:
[..]
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

Wouldn't #ifdef CONFIG_THP_SWAP be better? frontswap_enabled() is 'false'
on CONFIG_FRONTSWAP configs, should be compiled out anyway.

> +       /* Now, frontswap doesn't support THP page */
> +       if (frontswap_enabled() && cluster)
> +               return;
> +#endif
>         avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
>         if (avail_pgs <= 0)
>                 goto noswap;

Looks interesting. Technically, can be done earlier - in get_swap_page(),
can't it? get_swap_page() has the PageTransHuge(page) && CONFIG_THP_SWAP
condition checks. Can add frontswap dependency there. Something like

	if (PageTransHuge(page)) {
		if (IS_ENABLED(CONFIG_THP_SWAP))
+			if (!frontswap_enabled())
				get_swap_pages(1, true, &entry);
		return entry;
	}

	-ss
