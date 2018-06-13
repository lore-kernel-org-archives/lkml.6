Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21E22C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C388B208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVsKOfha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C388B208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935409AbeFMTmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:42:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33489 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbeFMTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:42:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so1566856plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JnxyggYD9zx2Gt61YHC6ARQk7XLmrJSEvyT6gCFYKRc=;
        b=LVsKOfhaIf/jDIx1Ja83pOikTQnaRJ+AlGE6Ux1dU9n3r77fBSjp4aYYIxks33rNVP
         d/MtTU4WxfNAXcw30AEkr9uciuckK8f7J2X2Ap2aSzAYpi/dv8heR9ZwY0b6AQo/jCfI
         p8crT5SIEJ+Yfd/6HrJI6Bxmm5NwSlyCYOTFNXK3xzgchfDY6pFQQoIXWHuWjaDKAAox
         UWyRM/znJRtGN2hPMsj7+MO1US3pzPcQE4jWQmoDWvSLWo1r9D1OdObXSeeHuVRgMoy0
         +sseJTltZakmG4716lpBZqRdgBrgis7kojVtSSCrcUAMtWGxKt/WrJvTMbxfQavlM1cb
         SM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JnxyggYD9zx2Gt61YHC6ARQk7XLmrJSEvyT6gCFYKRc=;
        b=T0325oU8DzhvQPzrrmI/BcCAcixoN98O0umrv7ETy5yGWTeCsFa0LmcoTApaaV7LbX
         9JASwwekpmtO4uW+0yUJ5cvNZkBqg8OiznlWa6ZwtAUmP7zaO0TpXExZU4wrdKskG+79
         X5+5kTPWGH+xnDBV7arFc0s8Tm3W3fWrmoGsWEckQRWaiKOedUPjXR181+jpVarDJZzi
         MI0Cf9FzKfFjHDPEubcONkM4MNzNdDTIm42urxb3z+SLiz0cZ/H65FeCXbyP4xs2a9/K
         15BcGpQl6R38airm6D+Iq7QG8ecJDeZwCu6iRhBPL3WmmW2qkzkfOUKkXa/atZdHHDTf
         jPqQ==
X-Gm-Message-State: APt69E0cuDVjnPLdM7e1R1wROMLGTEb8BDsU03VUL3GCZIbZjEOhW5FX
        kwK4r+SdhLWqHNKKvZtEhqxs9Uu7k30=
X-Google-Smtp-Source: ADUXVKIoSXbvcfcMFKgKkEV99QkpkqXsAc8CqAIAQix092crFluW4wc4XlugnwGUQA7O68Zf/R5Zow==
X-Received: by 2002:a17:902:7686:: with SMTP id m6-v6mr6590665pll.340.1528918952890;
        Wed, 13 Jun 2018 12:42:32 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r26-v6sm8313704pfj.180.2018.06.13.12.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 12:42:31 -0700 (PDT)
Date:   Wed, 13 Jun 2018 12:42:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm, page_alloc: actually ignore mempolicies for high
 priority allocations
In-Reply-To: <20180612122624.8045-1-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.21.1806131241300.32038@chino.kir.corp.google.com>
References: <20180612122624.8045-1-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Vlastimil Babka wrote:

> The __alloc_pages_slowpath() function has for a long time contained code to
> ignore node restrictions from memory policies for high priority allocations.
> The current code that resets the zonelist iterator however does effectively
> nothing after commit 7810e6781e0f ("mm, page_alloc: do not break __GFP_THISNODE
> by zonelist reset") removed a buggy zonelist reset. Even before that commit,
> mempolicy restrictions were still not ignored, as they are passed in
> ac->nodemask which is untouched by the code.
> 
> We can either remove the code, or make it work as intended. Since
> ac->nodemask can be set from task's mempolicy via alloc_pages_current() and
> thus also alloc_pages(), it may indeed affect kernel allocations, and it makes
> sense to ignore it to allow progress for high priority allocations.
> 
> Thus, this patch resets ac->nodemask to NULL in such cases. This assumes all
> callers can handle it (i.e. there are no guarantees as in the case of
> __GFP_THISNODE) which seems to be the case. The same assumption is already
> present in check_retry_cpuset() for some time.
> 
> The expected effect is that high priority kernel allocations in the context of
> userspace tasks (e.g. OOM victims) restricted by mempolicies will have higher
> chance to succeed if they are restricted to nodes with depleted memory, while
> there are other nodes with free memory left.
> 

Hi Vlastimil,

Is this expected as a change back to previous behavior that we have lost 
or is this new development for high priority allocations?  I don't think 
we have ignored mempolicies for things like GFP_ATOMIC allocations in the 
past.

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 07b3c23762ad..ec8c92ff8b3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4164,11 +4164,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		alloc_flags = reserve_flags;
>  
>  	/*
> -	 * Reset the zonelist iterators if memory policies can be ignored.
> -	 * These allocations are high priority and system rather than user
> -	 * orientated.
> +	 * Reset the nodemask and zonelist iterators if memory policies can be
> +	 * ignored. These allocations are high priority and system rather than
> +	 * user oriented.
>  	 */
>  	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
> +		ac->nodemask = NULL;
>  		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
>  					ac->high_zoneidx, ac->nodemask);
>  	}
