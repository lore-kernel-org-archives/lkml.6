Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B584C2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNJVO/C1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeKGGCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:02:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33214 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeKGGCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:02:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so3056145pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwn1jIK+9o157IkSfQLb3TEpLXwjXhR4GIPdl3tuL1s=;
        b=vNJVO/C1FgwiWFVwsxapR/La9bnAR5wyviG834LikGdKK5Ygfj2SzHa9bSyO1zeGbF
         3bbxBtVBEILSSzUi6EJWJxADSr3aGvtZLXA9GgjLS98ESbQUackK3pYJXXiWI3nRbSUf
         0+Z4eK5pfe/AoI8iZxzHkWFls+0FVf4s2pmJN6D87k91UJeCd7j2djajXUUmIqrDiHAF
         YVnO4YiP5O0L37rB/8o6QjDCPXzkXg+SmcHppaY2gGsSQSr03Wxzf/Jmr06uuxvORj5W
         Zn7abfQlkrNmjBIO3ToSbQv8SWO2u4ftZXAKMzn8k37LhXyy6f1atTI0JJMvI0hQ36nY
         trAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwn1jIK+9o157IkSfQLb3TEpLXwjXhR4GIPdl3tuL1s=;
        b=Z/ddVUXGn5ci/J+FFCOE0kXzsN/UqNXEO5L7iCXZPRKScBrc5ucr0CVToGwjFZ11gQ
         3lg3nv60XbeaY+k10PikOWTNX1sLSKXzGJWRQW68yz0AH1LN5UuWnrZzco+AilMFD5Uc
         fsy5tX+1xelH4YFKXjSDcyno3ui/JTYM/Dvs0K04ctCkMVDmPsFAM97I08SBS59hIzQu
         TcrtEuoPJx5yxwxwk+Sgcf0yzfzmqYPWh+hi5e2u55dRtPuZ7IONqVp65FEAWJ4KQn7l
         osHmGffnKiBUBlfYpYXKFHIKdgM/KGu0Wk5PkpyYY3P1HqybVgHV5ymOYXMxql510GV6
         PkUA==
X-Gm-Message-State: AGRZ1gKdspOeHrYzgNhA8uuyZ0H7X9fxhH6BqadgUhG6xOkXGurLmpUY
        oGMZGpETXO+r7yPymMIKp78=
X-Google-Smtp-Source: AJdET5dh+P38fmvTQrYfGfH6QyFpbFNtrjSJqvnphSJuHXQGdidmxRccuFO3GG+w92iFT9+eWLy0FA==
X-Received: by 2002:a62:449b:: with SMTP id m27-v6mr27840487pfi.82.1541536523646;
        Tue, 06 Nov 2018 12:35:23 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id r8-v6sm26301026pfk.157.2018.11.06.12.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 12:35:22 -0800 (PST)
Date:   Wed, 7 Nov 2018 07:35:18 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, memory_hotplug: check zone_movable in
 has_unmovable_pages
Message-ID: <20181106203518.GC9042@350D>
References: <20181106095524.14629-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106095524.14629-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:55:24AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Page state checks are racy. Under a heavy memory workload (e.g. stress
> -m 200 -t 2h) it is quite easy to hit a race window when the page is
> allocated but its state is not fully populated yet. A debugging patch to
> dump the struct page state shows
> : [  476.575516] has_unmovable_pages: pfn:0x10dfec00, found:0x1, count:0x0
> : [  476.582103] page:ffffea0437fb0000 count:1 mapcount:1 mapping:ffff880e05239841 index:0x7f26e5000 compound_mapcount: 1
> : [  476.592645] flags: 0x5fffffc0090034(uptodate|lru|active|head|swapbacked)
> 
> Note that the state has been checked for both PageLRU and PageSwapBacked
> already. Closing this race completely would require some sort of retry
> logic. This can be tricky and error prone (think of potential endless
> or long taking loops).
> 
> Workaround this problem for movable zones at least. Such a zone should
> only contain movable pages. 15c30bc09085 ("mm, memory_hotplug: make
> has_unmovable_pages more robust") has told us that this is not strictly
> true though. Bootmem pages should be marked reserved though so we can
> move the original check after the PageReserved check. Pages from other
> zones are still prone to races but we even do not pretend that memory
> hotremove works for those so pre-mature failure doesn't hurt that much.
> 
> Reported-and-tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Fixes: "mm, memory_hotplug: make has_unmovable_pages more robust")
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>
> Hi,
> this has been reported [1] and we have tried multiple things to address
> the issue. The only reliable way was to reintroduce the movable zone
> check into has_unmovable_pages. This time it should be safe also for
> the bug originally fixed by 15c30bc09085.
> 
> [1] http://lkml.kernel.org/r/20181101091055.GA15166@MiWiFi-R3L-srv
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 863d46da6586..c6d900ee4982 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7788,6 +7788,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		if (PageReserved(page))
>  			goto unmovable;
>  
> +		/*
> +		 * If the zone is movable and we have ruled out all reserved
> +		 * pages then it should be reasonably safe to assume the rest
> +		 * is movable.
> +		 */
> +		if (zone_idx(zone) == ZONE_MOVABLE)
> +			continue;
> +
>  		/*


There is a WARN_ON() in case of failure at the end of the routine,
is that triggered when we hit the bug? If we're adding this patch,
the WARN_ON needs to go as well.

The check seems to be quite aggressive and in a loop that iterates
pages, but has nothing to do with the page, did you mean to make
the check

zone_idx(page_zone(page)) == ZONE_MOVABLE

it also skips all checks for pinned pages and other checks


Balbir Singh. 
