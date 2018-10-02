Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55466C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EAE2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxuXC+JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EAE2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJBPpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:45:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJBPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:45:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so1266258wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nusUpm91VinQ9JB+4t13cqixOKrr+i5naSRoY+MqUt8=;
        b=kxuXC+JPjm0wUpAZk48ozsFm9Pm+PUCHZDOYD4YF05OJovFUoOkZYMUevHaIlwSFu/
         yN4Y/7XBgN4Tkjb08XvHCBKAP5qUOi0SQelVQBi2E8zVJ+NBBjBdlYK689jdxJ4lnSWS
         rNXfecH+i3O3w3v74JX9xJdoaCObuOGz2OnRXnrA3qEUwkLgvT3cq3JlPMkmIijNa7dL
         nOi8/BAn5cVA4hXpwgFe5qKwa01Jr2DtFDVrlwzhF5FTirOQBq5ujrDYRlkLLXTpCJsn
         P0y6wz01fD47bGAZsZJJtIErfW76sJhaqkXHsRu1ovCOAZJ3+1DHzrU5KYFUwZ0OYqlZ
         rhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nusUpm91VinQ9JB+4t13cqixOKrr+i5naSRoY+MqUt8=;
        b=bcp5etfBdQnnu42MXwgy70kZp0Qt8Z/r9GhpzOfwsCjW2JOvNci6ctT2MNtQYhKOFg
         cqyYDyAaADNfImv0yHWqYF53tw+n1yIQdBiM01YxtfJtxw1BUBGHwrA+nSo+ZucNS39b
         mcvtRD0MERiJT1cKyNMYrI4LKzwO5z5KsiFys7UUOC8Mh6CuVJWURwp8g22ebOSWILwq
         tvzV23mn2yI0mJLAewawF57Vveze/eUB3ry4LPBh4kUk0YWh5VStGsRGHDUOtnriJqct
         OMQE/a7Lgh/BqQiZZd0ZQlJm13hEz8ZvZEPgzcuRyLGKTU+fDehPcwz3c+SrJgUt4zln
         pBug==
X-Gm-Message-State: ABuFfojUJgUxXmY5ycCu1E22/BlJyxaBunwDti7ZRpIvsTz01O66c4qv
        wZunMh1n7sa3T16F+BVWyHY=
X-Google-Smtp-Source: ACcGV60pqWGb+HyW6jDRsGStDOmW+2gbykitAQlc3A0YEbUmhISk7T9C/KbrWR/DJf2lfhmP1GLs8w==
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr10448153wrb.283.1538470985362;
        Tue, 02 Oct 2018 02:03:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i131-v6sm10506645wmg.26.2018.10.02.02.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:03:04 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:03:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] locking/lockdep: Add a faster path in
 __lock_release()
Message-ID: <20181002090302.GA116695@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538157201-29173-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> When __lock_release() is called, the most likely unlock scenario is
> on the innermost lock in the chain.  In this case, we can skip some of
> the checks and provide a faster path to completion.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index add0468..ca002c0 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3625,6 +3625,13 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
>  	curr->lockdep_depth = i;
>  	curr->curr_chain_key = hlock->prev_chain_key;
>  
> +	/*
> +	 * The most likely case is when the unlock is on the innermost
> +	 * lock. In this case, we are done!
> +	 */
> +	if (i == depth - 1)
> +		return 1;
> +
>  	if (reacquire_held_locks(curr, depth, i + 1))
>  		return 0;
>  
> @@ -3632,10 +3639,14 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
>  	 * We had N bottles of beer on the wall, we drank one, but now
>  	 * there's not N-1 bottles of beer left on the wall...
>  	 */
> -	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1))
> -		return 0;
> +	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1);
>  
> -	return 1;
> +	/*
> +	 * Since reacquire_held_locks() would have called check_chain_key()
> +	 * indirectly via __lock_acquire(), we don't need to do it again
> +	 * on return.
> +	 */
> +	return 0;

Minor nit:

	s/depth - 1/depth-1

for slightly better readability.

Thanks,

	Ingo
