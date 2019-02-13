Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B87C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8396222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/K+qi+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfBMLvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:51:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41614 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfBMLvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:51:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id e17-v6so1733276lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2TfdZ0yfTGpis63yNWrafK+XaRU06nb4gEkHH7COEE=;
        b=U/K+qi+paWdkDRULPZbGIICjBcrRkimFGR7TkTH7w1oYvIF+e93YHSXDaVWj/b37VA
         UjRTbvEJJ0AToAAHAXAAfJRUCk5rkcnk3F/3SkTbXsdUWx28m7Z7+T2F8lFNQJFo9xmQ
         yAW1oi+5yOG33GEY1qo0lC0ODM7AyCXT0G0/WZEBJzXVm0/A0ebx4dd2dHwXOeqJYWMy
         Sz127F3lpDdjqv8SXg3XcsONDZNgNDVVYfQMm4Xx2/mZa6VEzxn2c3mEgyLX9m8C3WJP
         Ckq+SEd8WJ6Y3CpcLUXcGWyvwI+o0jpqckspDNLT9Kh5W0mRvo2iAi2UwycVxQYkvABN
         oOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2TfdZ0yfTGpis63yNWrafK+XaRU06nb4gEkHH7COEE=;
        b=LXn7eVFKoToOUL3nOwpNE4nlPoiBWi2U+utegPwOmaMG705jTAp9VH9/UsLtaVlM0/
         2OVs/vX91Epn8NplaQEwFiB7S+Om8cRKnb/QDfimEeePAKdNW6pWjtAmZ/1VbuABrmdi
         KwEIQI8rEmSCZz0Wghdkabq1vrn+iluXFkESpMEp24sNkTHy2JiyaeJlTrIkEgwjMuJk
         /d6kHt9Bv+ZNgPox/AmMBA8Ed+FnRfVEzMPuHdiYIjWXQAXljkfELMGiTbf+HRwLbX7D
         p7B4diZSKLKkUUy5qbgxXOGpJ6i6Puz2jYOskm9K2iLWsTVP+Lw8scFEqTYIsHrg454v
         FlKA==
X-Gm-Message-State: AHQUAuZmuSDq9wqOxfwCk8aPeE+yh8KAxPR+Szf8L7I8x3g9l2THDoxY
        VB/Qhf02MfnJEiNkvu6+Kr0=
X-Google-Smtp-Source: AHgI3IbKXU2LyicoJFoNlpLhj27pcZqbW7yAjx3ylCb7UMoTN9ouTk+wlHVAd8f1Fftp/hJv13bKLA==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr73769ljk.80.1550058678351;
        Wed, 13 Feb 2019 03:51:18 -0800 (PST)
Received: from localhost (pat-31-128-146-191.pool.powernet.com.ru. [31.128.146.191])
        by smtp.gmail.com with ESMTPSA id q128-v6sm3374469ljq.14.2019.02.13.03.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 03:51:17 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Wed, 13 Feb 2019 14:51:15 +0300
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213115115.GA8928@yury-thinkpad>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111409.GN9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213111409.GN9565@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:14:09AM +0000, Mel Gorman wrote:
> On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > Hi Mel, all,
> > 
> > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > Backtrace is not too verbose:
> > (gdb) i threads
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> >     at arch/arm64/lib/delay.c:49
> >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> > Reverting the patch
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > fragmentation event occurs") together with following patch
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > helps me to boot normally. 
> > 
> 
> Well, that's a bad start to any day. Thanks for tracking it down. Does
> the following patch help? I can't test it properly as I didn't recreate
> your boot image or initrd but this appears to get past the initial boot
> phase at least.

Hi Mel,

The patch works for me. The day gets better indeed. :-)

Tested-by: Yury Norov <yury.norov@gmail.com>

Yury

> ---8<---
> mm, page_alloc: Fix a division by zero error when boosting watermarks
> 
> Yury Norov reported that an arm64 KVM instance could not boot since after
> v5.0-rc1 and could addressed by reverting the patches
> 
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> 
> The problem is that a division by zero error is possible if boosting occurs
> either very early in boot or if the high watermark is very small. This
> patch checks for the conditions and avoids boosting in those cases.
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Reported-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..ae7e4ba5b9f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> +
> +	/* high watermark be be uninitialised or very small */
> +	if (!max_boost)
> +		return;
> +
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
>  	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> 
