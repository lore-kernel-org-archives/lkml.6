Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE06DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5C3207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="b267o0z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfBVSWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:22:53 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44992 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:22:52 -0500
Received: by mail-yw1-f68.google.com with SMTP id x21so1169551ywx.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1iRUWXUez0vQmzuA6ScUoUTtthAjz8oJPlMkoBcgCo=;
        b=b267o0z6qksczZ6tdLwpa3oMpBghC7VNreLZWEEy860EODd2+i/QjS4nWyY/ryDODy
         a5G8IZp8wvWZSWhb7LkpNdYs8nPu3EkOMlFPeqdRA++vk8m1TL08DMGGvBd6ZgP9Rpca
         6uBxZmBrK0rW0yNb2CK8KhQs3FNIRWoyUwECysD6/T4pXlFsnJTz6wcq8L5GoBjcEu7I
         RoN+qZym0HIiSVeQtM0NP3F50AmXJmjmn609rEXS5ph0WTJkbe8D0l5DG8rP0GWSIYfU
         3F7gjmpDG5rf9TUjQfVAHmOLn1pXQ6iCoXcwdNB7bCIG/6Kbwc3dgPl6o4khb+jF1Z84
         fbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1iRUWXUez0vQmzuA6ScUoUTtthAjz8oJPlMkoBcgCo=;
        b=UWxvRwC9NZrF2YHGfbgNlRS+Oyqre35FK20tjRhrPil9HFO1AoE+Sryp5D2dXQ1ZDR
         DvBDKt7gL09WWSIBtvP8R35kArqVZShS1AZZfdyItIBwdVrqTfhboLJ+hWTtWN7YJNV/
         OU/vYpkzxUGykcCZ+zrA8jfuxvGOkCS+BDERumPKa7k9w8J9mFRNipOT0G0vTgeqoiVB
         uHuFE2PSp3EdhNSKmCl6Bt+obiR0ZjDA+5tyAZHKQ5TFr2i84OAdiOkCQUCm51n7r7zF
         fIrF5NB+DdCNsswwx4BPxU9sGYfTAIrKysfT6TCw/QEgUDgEp9quD7qwvvtWrw4rBOTk
         Jv7w==
X-Gm-Message-State: AHQUAuZWkpJ0MQQaBjfu6wqC7IwGvzSrjc8QjL2kyJ9XFwpkMOocMcFl
        gEg7r+lm47ATbRDJLaM7yzPqew==
X-Google-Smtp-Source: AHgI3IaeDDfPbp7vXQTiAzbg0tyYv6REAy+eU0RB6B1ee5L/C1zIpSF2uD275SBiZWz5/J1nf8/SGg==
X-Received: by 2002:a81:36ca:: with SMTP id d193mr4536619ywa.388.1550859771539;
        Fri, 22 Feb 2019 10:22:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:cd3d])
        by smtp.gmail.com with ESMTPSA id c124sm683685ywe.12.2019.02.22.10.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:22:50 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:22:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 5/5] mm/vmscan: don't forcely shrink active anon lru list
Message-ID: <20190222182249.GC15440@cmpxchg.org>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
 <20190222174337.26390-5-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222174337.26390-5-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:43:37PM +0300, Andrey Ryabinin wrote:
> shrink_node_memcg() always forcely shrink active anon list.
> This doesn't seem like correct behavior. If system/memcg has no swap, it's
> absolutely pointless to rebalance anon lru lists.
> And in case we did scan the active anon list above, it's unclear why would
> we need this additional force scan. If there are cases when we want more
> aggressive scan of the anon lru we should just change the scan target
> in get_scan_count() (and better explain such cases in the comments).
> 
> Remove this force shrink and let get_scan_count() to decide how
> much of active anon we want to shrink.

This change breaks the anon pre-aging.

The idea behind this is that the VM maintains a small batch of anon
reclaim candidates with recent access information. On every reclaim,
even when we just trim cache, which is the most common reclaim mode,
but also when we just swapped out some pages and shrunk the inactive
anon list, at the end of it we make sure that the list of potential
anon candidates is refilled for the next reclaim cycle.

The comments for this are above inactive_list_is_low() and the
age_active_anon() call from kswapd.

Re: no swap, you are correct. We should gate that rebalancing on
total_swap_pages, just like age_active_anon() does.
