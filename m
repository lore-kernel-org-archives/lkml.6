Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1316154-1518053803-2-15231161157587992906
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
    t=1518053802; b=bpFKqTrjFJzt12FCPRS+9urYwk7KXVxGfvsSMXGDwa0YM9a
    hijzcj8flqHTijDxXK4AL2RBjiXKXViDKZDQk+FDvLtAXKX6S+TzS6cT1YP7y8FE
    ad/3Ipj9XVG+CbkHRCcHwHsaYsSSQvIpRF4/bRUyWQxIJH4nzdPWQx76EAdEhU2h
    J2ryybBua4FOVWbGSxnVZZkMyYWQUAHdHTVazsPim0RJ3ZtqCWSp+1/T9E75LGd3
    G0giA0QjHnffIp/HdC1dJ9GYHM5sT4p+2yq6OE65mvkoWSu0ToA63OHNF9vnkR77
    4qkHTuTpKTYv9CHsk9MmkosCttvbkGFQrWJt2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518053802; bh=ddJIqtBWrQF3BDfvwSSxQO3IMW
    1ukNALsQQWXP/uLjU=; b=P5hCiPjYMGc/RNE/jVPfdb79DdhFu+ZPn3ZRjRJY7K
    UnxwO6xHJv3YPKmYQSJ2PX5wzJVZ2AnnYGgRcwP74ghBSaNd4g7HZvfHSH/HGZcb
    67C9bUj+FeXDD+TY61md97GENrGmACZ5LVbZPCL0tIAnAB/6Vlp8RMsrhA7JZDpO
    IlBK5FPNvA+1q+2GpwP6PPv7q2vwPwtjqSuuJ9B9wPDZDcAqaC15Hll2XxeBq2XR
    Ezm/JE7xfMTa/iz5yDIqQCiTsf0G8sJNwxyNksF3SB4qtWJDWM44Y8J9ZaUt7R8L
    Q595gDGyM1Ew6mbHyaV3+pa+qSWDFlgQhgcn0PG+TB2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GmS385En x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZzwJ2P7U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GmS385En x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZzwJ2P7U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbeBHBgl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 20:36:41 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:42695 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBHBgk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 20:36:40 -0500
X-Google-Smtp-Source: AH8x225AKLxOvaiRN9aOJfPjWxNqS+WNOuWIldYIJLLxApTIenMtrzG4Z3sC7iArX7+jQ78wzvpa4w==
Date: Thu, 8 Feb 2018 10:36:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
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
Message-ID: <20180208013635.GA596@jagdpanzerIV>
References: <20180207070035.30302-1-ying.huang@intel.com>
 <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (02/07/18 13:05), Andrew Morton wrote:
[..]
> hm.  This is assuming that "cluster==true" means "this is thp swap". 
> That's presently true, but is it appropriate that get_swap_pages() is
> peeking at "cluster" to work out why it is being called?
> 
> Or would it be cleaner to do this in get_swap_page()?  Something like
> 
> --- a/mm/swap_slots.c~a
> +++ a/mm/swap_slots.c
> @@ -317,8 +317,11 @@ swp_entry_t get_swap_page(struct page *p
>  	entry.val = 0;
>  
>  	if (PageTransHuge(page)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP))
> -			get_swap_pages(1, true, &entry);
> +		/* Frontswap doesn't support THP */
> +		if (!frontswap_enabled()) {
> +			if (IS_ENABLED(CONFIG_THP_SWAP))
> +				get_swap_pages(1, true, &entry);
> +		}
>  		return entry;
>  	}

I have proposed exactly the same thing [1], Minchan commented that
it would introduce frontswap dependency to swap_slots.c [2]. Which
is true, but I'd still probably prefer to handle it all in
get_swap_page. Minchan, any objections?

[1] https://marc.info/?l=linux-mm&m=151791052007719&w=2
[2] https://marc.info/?l=linux-mm&m=151792646812617&w=2

	-ss
