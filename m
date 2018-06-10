Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HurJAqxoHVuzaAAAmS7hNA
	; Sun, 10 Jun 2018 18:06:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E088660791; Sun, 10 Jun 2018 18:06:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHs95GWW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 343F1604D4;
	Sun, 10 Jun 2018 18:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 343F1604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeFJSGc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 14:06:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38551 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753507AbeFJSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 14:06:30 -0400
Received: by mail-oi0-f67.google.com with SMTP id d5-v6so16000230oib.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WjEvthiFiuZgBjvWCHDOWrHW4PoRFuIWNG3Pd4GhuEo=;
        b=IHs95GWWpaGs7S2rtEOBIaf/MWDgWYfqeQ/hTkJdsLcT0qpC6eF6lqj/WsU7dL5GtZ
         Sei3DAob6C/+n27kNNzxrhTFpEd+OCF0fZVivxCYaqW6plR4/g5APKQc6gCcIvgpqI3E
         6nDkRQqLqkphlvwnsk8uHdeMXgm0pUpiaPmPy+YKE2oxeA6qTnmGj18aV9gJKTAlKT3Z
         9CL4pxbrGQixgJoWoP7ogHtq/YQpTxYt3j81qo0YcFc2YqsVAF0DU9deR+AIph3mI8nC
         0yQCWQufLwlhX2K1thO4tOFVKnG44hMMYSegJssXZ4+y4csTUU3EIV1uiheYUQZNI4Jp
         XzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WjEvthiFiuZgBjvWCHDOWrHW4PoRFuIWNG3Pd4GhuEo=;
        b=kGRxfJ9BpwgSt+zRpkkvJFm8QffzuGzbIcagFoIpukfmmU3slvnUj/4KMhCcCnDb8W
         KubK4W8A2zrAc56mHcWmD6pdTnWm9wNyUCZDgFjJgiG3yqe4NJ9xaB3xSIMXR+4NiSUo
         GUufy5RXjhx+l6ytI8LqS/fKYTrHthc6ZLgmAooeQtMmosCbkTOseXHXK3RgBQCJm/M6
         ahLaADB6z0/UtmUctaMcY9WWrq0QK2fGG3AMBirfypLZdKTNwCHFFpEjVwbJZJ+/Q1jk
         BM0UzswQsxz73RJU7LM165LPNr0YKr13hCOH2hou2ZSsw1mWS7GRqo45SmSAbQDYftfr
         J0ng==
X-Gm-Message-State: APt69E1tMi500VKfXrB1R2WSzw8PtpYVPDMLpJ3HoRGUOko913WYH7Zu
        qrAiPto1zhlPTLUbxIeZK6CroA4ClBQ=
X-Google-Smtp-Source: ADUXVKK1T2/Kc+G9iuyCaU7hBGxJ8uY8OnaDC5CauEGHgZh996/NN4gIr4vQTKyd0hJpwpY2qwF9Kw==
X-Received: by 2002:aca:5116:: with SMTP id f22-v6mr7494926oib.78.1528653989022;
        Sun, 10 Jun 2018 11:06:29 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w88-v6sm20970391ota.48.2018.06.10.11.06.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Jun 2018 11:06:28 -0700 (PDT)
Date: Sun, 10 Jun 2018 11:06:15 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Ben Hutchings <ben@decadent.org.uk>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ivan Kalvachev <ikalvachev@gmail.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3.16 183/410] mm: pin address_space before dereferencing
 it while isolating an LRU page
In-Reply-To: <lsq.1528380321.441239617@decadent.org.uk>
Message-ID: <alpine.LSU.2.11.1806101101550.9044@eggly.anvils>
References: <lsq.1528380321.441239617@decadent.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018, Ben Hutchings wrote:

> 3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

Not an objection as such, but if you're including this one,
please be sure to add 145e1a71e090575c74969e3daa8136d1e5b99fc8
"mm: fix the NULL mapping case in __isolate_lru_page()"

Thanks,
Hugh

> 
> ------------------
> 
> From: Mel Gorman <mgorman@techsingularity.net>
> 
> commit 69d763fc6d3aee787a3e8c8c35092b4f4960fa5d upstream.
> 
> Minchan Kim asked the following question -- what locks protects
> address_space destroying when race happens between inode trauncation and
> __isolate_lru_page? Jan Kara clarified by describing the race as follows
> 
> CPU1                                            CPU2
> 
> truncate(inode)                                 __isolate_lru_page()
>   ...
>   truncate_inode_page(mapping, page);
>     delete_from_page_cache(page)
>       spin_lock_irqsave(&mapping->tree_lock, flags);
>         __delete_from_page_cache(page, NULL)
>           page_cache_tree_delete(..)
>             ...                                   mapping = page_mapping(page);
>             page->mapping = NULL;
>             ...
>       spin_unlock_irqrestore(&mapping->tree_lock, flags);
>       page_cache_free_page(mapping, page)
>         put_page(page)
>           if (put_page_testzero(page)) -> false
> - inode now has no pages and can be freed including embedded address_space
> 
>                                                   if (mapping && !mapping->a_ops->migratepage)
> - we've dereferenced mapping which is potentially already free.
> 
> The race is theoretically possible but unlikely.  Before the
> delete_from_page_cache, truncate_cleanup_page is called so the page is
> likely to be !PageDirty or PageWriteback which gets skipped by the only
> caller that checks the mappping in __isolate_lru_page.  Even if the race
> occurs, a substantial amount of work has to happen during a tiny window
> with no preemption but it could potentially be done using a virtual
> machine to artifically slow one CPU or halt it during the critical
> window.
> 
> This patch should eliminate the race with truncation by try-locking the
> page before derefencing mapping and aborting if the lock was not
> acquired.  There was a suggestion from Huang Ying to use RCU as a
> side-effect to prevent mapping being freed.  However, I do not like the
> solution as it's an unconventional means of preserving a mapping and
> it's not a context where rcu_read_lock is obviously protecting rcu data.
> 
> Link: http://lkml.kernel.org/r/20180104102512.2qos3h5vqzeisrek@techsingularity.net
> Fixes: c82449352854 ("mm: compaction: make isolate_lru_page() filter-aware again")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> [bwh: Backported to 3.16: adjust context]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  mm/vmscan.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1206,6 +1206,7 @@ int __isolate_lru_page(struct page *page
>  
>  		if (PageDirty(page)) {
>  			struct address_space *mapping;
> +			bool migrate_dirty;
>  
>  			/* ISOLATE_CLEAN means only clean pages */
>  			if (mode & ISOLATE_CLEAN)
> @@ -1214,10 +1215,19 @@ int __isolate_lru_page(struct page *page
>  			/*
>  			 * Only pages without mappings or that have a
>  			 * ->migratepage callback are possible to migrate
> -			 * without blocking
> +			 * without blocking. However, we can be racing with
> +			 * truncation so it's necessary to lock the page
> +			 * to stabilise the mapping as truncation holds
> +			 * the page lock until after the page is removed
> +			 * from the page cache.
>  			 */
> +			if (!trylock_page(page))
> +				return ret;
> +
>  			mapping = page_mapping(page);
> -			if (mapping && !mapping->a_ops->migratepage)
> +			migrate_dirty = mapping && mapping->a_ops->migratepage;
> +			unlock_page(page);
> +			if (!migrate_dirty)
>  				return ret;
>  		}
>  	}
> 
> 
