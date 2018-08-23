Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71CAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8392C208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8392C208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeHWNNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:13:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHWNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:13:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so4054033wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cpcRsGbw0z3r31ECxEzONbei22xlUGBcywq1hG/oUZE=;
        b=tkUl88j8v/XGfB96ShcG/nCXBIb1i42z8vMXf+t/TMIDmN63yOTxEE5m9uD0fRljIg
         EzpexgFhnDG/aypcfVlfWv/LSh0j+v/uLxrAQOJYrNt9AzeacF2NcdP1EWFLCQS1h4i3
         is7nmFJ0dLeMEhtvqWs9IbPFtYQAuFoPbgP9UHgUAmLjX3ykeiMP2P+pWUn9cDvIRJTm
         RaZsFLNvXrZgWtMJrF6RRYoTzDNTzQNWb3BjpzYoO8OFyzrPKZWzM9sMi8yQiTK6w3hx
         6iiv7aY2msSdkfIIqV5AT4UXlwDir6Gxv61R/0rsQqxPUa0QBb9GGIVHz+z8lqlp4nzW
         z+IQ==
X-Gm-Message-State: APzg51DKuZMnizKrH5gcynC4ELpXinr9Mfb7rxnMzzZiNJRGbaxCMw0F
        XDpqG5BK729gRpygUrqdNFU=
X-Google-Smtp-Source: ANB0VdbQuN0iv0DhLQRbnqCOhtYQQDYR6TIoZZY0pCrprKi+ure6oOUn6/I8rAA56gb0s+Aiy9blqA==
X-Received: by 2002:a5d:4990:: with SMTP id r16-v6mr1224179wrq.116.1535017484692;
        Thu, 23 Aug 2018 02:44:44 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b2-v6sm4351591wmh.3.2018.08.23.02.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 02:44:44 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 517E7124A71; Thu, 23 Aug 2018 11:44:43 +0200 (CEST)
Date:   Thu, 23 Aug 2018 11:44:43 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 5/5] mm/memory_hotplug: Simplify
 node_states_check_changes_offline
Message-ID: <20180823094443.GA14924@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
 <20180822093226.25987-6-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822093226.25987-6-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:32:26AM +0200, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> This patch tries to simplify node_states_check_changes_offline
> and make the code more understandable by:
> 
> - Removing the if (N_MEMORY == N_NORMAL_MEMORY) wrong statement
> - Removing the if (N_MEMORY == N_HIGH_MEMORY) wrong statement
> - Re-structure the code a bit
> - Removing confusing comments
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

I realized I made a mistake here.
I was not counting the present pages correctly.
I will send a new version after the merge-windows gets closed.

Sorry for the noise

For the sake of clarity, the patch should have been:


---

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 006a7b817724..bca11da4e11f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1487,23 +1487,12 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	enum zone_type zt, zone_last = ZONE_NORMAL;
 
 	/*
-	 * If we have HIGHMEM or movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_NORMAL,
-	 * set zone_last to ZONE_NORMAL.
-	 *
-	 * If we don't have HIGHMEM nor movable node,
-	 * node_states[N_NORMAL_MEMORY] contains nodes which have zones of
-	 * 0...ZONE_MOVABLE, set zone_last to ZONE_MOVABLE.
-	 */
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	/*
-	 * check whether node_states[N_NORMAL_MEMORY] will be changed.
-	 * If the memory to be offline is in a zone of 0...zone_last,
-	 * and it is the last present memory, 0...zone_last will
-	 * become empty after offline , thus we can determind we will
-	 * need to clear the node from node_states[N_NORMAL_MEMORY].
+	 * If the current zone is whithin (0..ZONE_NORMAL],
+	 * check if the amount of pages that are going to be
+	 * offlined is above or equal to the sum of the present
+	 * pages of these zones.
+	 * If that happens, we need to take this node out of
+	 * node_state[N_NORMAL_MEMORY]
 	 */
 	for (zt = 0; zt <= zone_last; zt++)
 		present_pages += pgdat->node_zones[zt].present_pages;
@@ -1514,21 +1503,15 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 
 #ifdef CONFIG_HIGHMEM
 	/*
-	 * If we have movable node, node_states[N_HIGH_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_HIGHMEM,
-	 * set zone_last to ZONE_HIGHMEM.
-	 *
-	 * If we don't have movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_MOVABLE,
-	 * set zone_last to ZONE_MOVABLE.
+	 * If the current zone is whithin (0..ZONE_HIGHMEM], check if
+	 * the amount of pages that are going to be offlined is above
+	 * or equal to the sum of the present pages of these zones.
+	 * If that happens, we need to take this node out of
+	 * node_state[N_HIGH_MEMORY]
 	 */
-	zone_last = ZONE_HIGHMEM;
-	if (N_MEMORY == N_HIGH_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	for (; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= zone_last && nr_pages >= present_pages)
+	zt = ZONE_HIGHMEM;
+	present_pages += pgdat->node_zones[zt].present_pages;
+	if (zone_idx(zone) <= zt && nr_pages >= present_pages)
 		arg->status_change_nid_high = zone_to_nid(zone);
 	else
 		arg->status_change_nid_high = -1;
@@ -1541,18 +1524,14 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 #endif
 
 	/*
-	 * node_states[N_HIGH_MEMORY] contains nodes which have 0...ZONE_MOVABLE
+	 * Count pages from ZONE_MOVABLE as well.
+	 * If the amount of pages that are going to be offlined is above
+	 * or equal the sum of the present pages of all zones, we need
+	 * to remove this node from node_state[N_MEMORY]
 	 */
-	zone_last = ZONE_MOVABLE;
+	zt = ZONE_MOVABLE;
+	present_pages += pgdat->node_zones[zt].present_pages;
 
-	/*
-	 * check whether node_states[N_HIGH_MEMORY] will be changed
-	 * If we try to offline the last present @nr_pages from the node,
-	 * we can determind we will need to clear the node from
-	 * node_states[N_HIGH_MEMORY].
-	 */
-	for (; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
 	if (nr_pages >= present_pages)
 		arg->status_change_nid = zone_to_nid(zone);
 	else
 

-- 
Oscar Salvador
SUSE L3
