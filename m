Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05813C65BAE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B427A20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPP8oa2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLLDfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:35:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39813 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLDfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:35:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so14334921edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 19:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6boLxkCk1IUbRHwGnVlHMUbKszobMYWeXJ40Akpp/hY=;
        b=BPP8oa2x8eEjY+ZEuN67NQrObn36fJVrVUX3d1AzkKPc7BqtyYxL1vuPLUZujEhMqN
         EHK6lBASaV4szqsP/fTm4wwmvD0dcVcMsM2zZZhbJdqzH53/6FAhhYzWsG/Jan4VtnKt
         OPbBNThIyuDogcU4G0nQvIeTY1p9h8pBhmFyr5XSMZehFKXN0udjuTotssr484j8WoYA
         +Y1pIBoYMmbuVP+FmvnmwsAfnORfsxK0oWf6m6bfxTHGnOdwIbQJfpgr1+Yw9A6E4VsL
         3msw8Ye1G6TdMlnb+EJ1hl/z7wB/XZQqi7OXmqQXHgomSqhVD8rQ5FhAdbUwRRnYs0Lh
         UtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6boLxkCk1IUbRHwGnVlHMUbKszobMYWeXJ40Akpp/hY=;
        b=Vm3xKpb9bNcmszObuyh4fo9wgv3grrgAOtwj5FjxieV51ENSnuyNbikFw+b/KVbK/5
         YGxJKmKDct4ajoPWTWGyNHsTa04YauZHf5Nw7cFT3XyeS5n67/h0zFnu6YYIsmKqHdvI
         Pj0Ed7AuJ0PTnh4G0AQjbVpvjkb/BST/m6QLJj8js3xKCi+j7prOM7HK8p5aQT3bPM2U
         AGWS8YU3reyC8mIQIV7NTUTggdJ4XY/dNCdhmMVBeAe51KPIASh2jX8Q+et+xMBqzz25
         9twjAD7FWS1HEzX+qoOCbjrTbneA/PjUU4jknUlU2CXjgT8wZU1IKnZB7bq0kJYKFZwJ
         EiJg==
X-Gm-Message-State: AA+aEWY8AXtGitJkqrkf39E7Ikq7HT+v+61vS5yar4Jk7dg0CmkWJgtQ
        23hZWnn7zbTBnAB/YF397nI=
X-Google-Smtp-Source: AFSGD/VF7OLx4X+E/Whl6EtpIYPGj6JpYP3OiAwMG+V+av7K92R16fi9sCDAIwDclYZn7cRmlFo7KQ==
X-Received: by 2002:a17:906:22ca:: with SMTP id q10-v6mr14091155eja.66.1544585708197;
        Tue, 11 Dec 2018 19:35:08 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c53sm4654017ede.26.2018.12.11.19.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 19:35:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 03:35:06 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, dan.j.williams@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm, memory_hotplug: Don't bail out in
 do_migrate_range prematurely
Message-ID: <20181212033506.tyj747b7kzyvsp4c@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181211135312.27034-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211135312.27034-1-osalvador@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:53:12PM +0100, Oscar Salvador wrote:
>v1 -> v2:
>        - Keep branch to decrease refcount and print out
>          the failed pfn/page
>        - Modified changelog per Michal's feedback
>        - move put_page() out of the if/else branch
>
>---
>>From f81da873be9a5b7845249d1e62a423f054c487d5 Mon Sep 17 00:00:00 2001
>From: Oscar Salvador <osalvador@suse.com>
>Date: Tue, 11 Dec 2018 11:45:19 +0100
>Subject: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
> prematurely
>
>do_migrate_ranges() takes a memory range and tries to isolate the
>pages to put them into a list.
>This list will be later on used in migrate_pages() to know
>the pages we need to migrate.
>
>Currently, if we fail to isolate a single page, we put all already
>isolated pages back to their LRU and we bail out from the function.
>This is quite suboptimal, as this will force us to start over again
>because scan_movable_pages will give us the same range.
>If there is no chance that we can isolate that page, we will loop here
>forever.
>
>Issue debugged in [1] has proved that.
>During the debugging of that issue, it was noticed that if
>do_migrate_ranges() fails to isolate a single page, we will
>just discard the work we have done so far and bail out, which means
>that scan_movable_pages() will find again the same set of pages.
>
>Instead, we can just skip the error, keep isolating as much pages
>as possible and then proceed with the call to migrate_pages().
>
>This will allow us to do as much work as possible at once.
>
>[1] https://lkml.org/lkml/2018/12/6/324
>
>Signed-off-by: Oscar Salvador <osalvador@suse.de>
>---
> mm/memory_hotplug.c | 18 ++----------------
> 1 file changed, 2 insertions(+), 16 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 86ab673fc4e3..68e740b1768e 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1339,7 +1339,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 	unsigned long pfn;
> 	struct page *page;
> 	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
>-	int not_managed = 0;
> 	int ret = 0;
> 	LIST_HEAD(source);
> 
>@@ -1388,7 +1387,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 		else
> 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
> 		if (!ret) { /* Success */
>-			put_page(page);
> 			list_add_tail(&page->lru, &source);
> 			move_pages--;
> 			if (!__PageMovable(page))
>@@ -1398,22 +1396,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 		} else {
> 			pr_warn("failed to isolate pfn %lx\n", pfn);
> 			dump_page(page, "isolation failed");

I see the above code is wrapped with CONFIG_DEBUG_VM on current Linus tree.

This is removed by someone else?

>-			put_page(page);
>-			/* Because we don't have big zone->lock. we should
>-			   check this again here. */
>-			if (page_count(page)) {
>-				not_managed++;
>-				ret = -EBUSY;
>-				break;
>-			}
> 		}
>+		put_page(page);
> 	}
> 	if (!list_empty(&source)) {
>-		if (not_managed) {
>-			putback_movable_pages(&source);
>-			goto out;
>-		}
>-
> 		/* Allocate a new page from the nearest neighbor node */
> 		ret = migrate_pages(&source, new_node_page, NULL, 0,
> 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>@@ -1426,7 +1412,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 			putback_movable_pages(&source);
> 		}
> 	}
>-out:
>+
> 	return ret;
> }
> 
>-- 
>2.13.7

-- 
Wei Yang
Help you, Help me
