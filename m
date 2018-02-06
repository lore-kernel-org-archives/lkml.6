Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517926497-2-11412679294097986303
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
    t=1517926496; b=Lv6OLKLY0kFVYWV+1RwIzyVDb/Ksx0LFXJa8oySgRqAve5w
    /Qaz+BDhnWzp1hUiD59PTQmurlKKwzj2hGY3E2UvniEM/PgjKAzb9uHVXjWVih5i
    niOVh02US07unmSRBm2MlpZ0zmR9nbVfowUGuRiuAY2amZ4UCuTvjeqonIcIa3kQ
    guSrcoYaMFXLFm8CryvOZUwtfJxlDUNEd0JVAIja6bHwtedvcyOro0M1K/ase3kQ
    eariSpl1w4LJbOE8mXFaGvSAD7vtOPyHyWs4w3YrtuNzEWLI18vUkw0SHTEA9YDb
    GIIbReR9YwCLHA+vJN3XmRex+LZg1IuSmMFCV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517926496; bh=K4Fik9PEAsLtvI7keVqaqkfSLt
    mhoURwZW7q7lQohI0=; b=dHLA+ODILn08kZeoKYNL9ITvzVlcndzCohgaiz4agd
    DbwGmu4FOYKlsIC9vGoOdWg0JP2pZeHl94VtymNITz0zWCaXUrOhkFFWVwL522Va
    waTQRHqtZao47goKH9hEb4gyJT09qEQo1sXgBIoRuGGLP5YCGNhdZCqwctRbN8OO
    KcCGxyEjzbA8a+gDSL81mtPDLRh+eQElTjLIB2JzJOSbBjQC78Mnd9GpuwyJTtBh
    Jqg3iuiK9QwQbH5erJqBHwk191iQqSqK+HKW0Oc7N7dnLLRKg1ubM7VAZoweo6ox
    9/WHocMG23webTCvD6+GEFF9cKL0T8KzJ6Rs0kVZS6lw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W7XMUeWb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WKytvDDm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W7XMUeWb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WKytvDDm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBFOO2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:14:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35261 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeBFOO0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:14:26 -0500
X-Google-Smtp-Source: AH8x224l+kGu7rmYRfngVHg+iC3bVWraGSOiPr2mat7yKgQb+m+nXSpF828nICb0CgZkxjJgh9h0Aw==
Date: Tue, 6 Feb 2018 06:14:18 -0800
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
Message-ID: <20180206141418.GA25912@eng-minchan1.roam.corp.google.com>
References: <20180206065404.18815-1-ying.huang@intel.com>
 <20180206083101.GA17082@eng-minchan1.roam.corp.google.com>
 <871shy3421.fsf@yhuang-dev.intel.com>
 <20180206090244.GA20545@eng-minchan1.roam.corp.google.com>
 <20180206094822.GA2265@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206094822.GA2265@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sergey,

On Tue, Feb 06, 2018 at 06:48:22PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> On (02/06/18 01:02), Minchan Kim wrote:
> [..]
> > Can't we simple do like that if you want to make it simple and rely on someone
> > who makes frontswap THP-aware later?
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 42fe5653814a..4bf1725407aa 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -934,7 +934,11 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
> >  
> >         /* Only single cluster request supported */
> >         WARN_ON_ONCE(n_goal > 1 && cluster);
> > +#ifdef CONFIG_FRONTSWAP
> 
> Wouldn't #ifdef CONFIG_THP_SWAP be better? frontswap_enabled() is 'false'
> on CONFIG_FRONTSWAP configs, should be compiled out anyway.

Agree.

> 
> > +       /* Now, frontswap doesn't support THP page */
> > +       if (frontswap_enabled() && cluster)
> > +               return;
> > +#endif
> >         avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
> >         if (avail_pgs <= 0)
> >                 goto noswap;
> 
> Looks interesting. Technically, can be done earlier - in get_swap_page(),
> can't it? get_swap_page() has the PageTransHuge(page) && CONFIG_THP_SWAP
> condition checks. Can add frontswap dependency there. Something like
> 
> 	if (PageTransHuge(page)) {
> 		if (IS_ENABLED(CONFIG_THP_SWAP))
> +			if (!frontswap_enabled())
> 				get_swap_pages(1, true, &entry);
> 		return entry;
> 	}

Looks better but it introduces frontswap thing to swap_slots.c while
all frontswap works in swapfile.c.
