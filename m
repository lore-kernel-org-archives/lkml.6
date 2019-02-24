Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F2C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89A720842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgJwtGqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfBXMef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:34:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46392 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBXMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:34:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so3176472pgf.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3yLpMlCMDsuGaB02cG1XH8xADN3ETXn1vX/kUyoKIQ=;
        b=ZgJwtGqu+tpzE0Sxv2rBnzGQOgVnCbdTJWs6MlhjOmVcjzel2NnOzxLme2jKbjJeWe
         xK0/5o0ecLLOWPHsXZKzSd6zgbi7Ayk+jVC1UbUyutgKRnaFKMBtok7NFkgjPNZ/voKE
         6/XH+Rjq9TG++FECnruQColXNmEGsflDw1NKZgJO7HaQsR/mQK++9vNVs4r6xkvqACoE
         oB8bw1zJBJWrwL/fuz09qFJxdRjB7yZPwM4HlkNs2M3SXI+eTm5+mzL7Rp1hEkECGZj5
         ens5fMQO1UEowLbb2bvLHeJoDvWDbG457M+NyhXmt+9+0nZvp6Z7WOOWsKQHrNWtJAWG
         tpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3yLpMlCMDsuGaB02cG1XH8xADN3ETXn1vX/kUyoKIQ=;
        b=GwZtXPci/yNC646TH8zTE/ks8vXpxfKgThNtZN5OwbW6htMhJSNi2jN0hH4P0m3zRA
         7T42rqhcl5d4oi0CQ9zFNX3gafY6PXGquY79GUo8Q7iCZhgIfZtUzKwRqj12Ao17Y+Cw
         5icfztvr383Yu7vcUOIUbF7WsuMB2NfFbWoA/PVAQWinR2/Y6d6kfH6TnBEzew1T4DdY
         scmnxOlcAFzI1CJ0xtdt+pI7jE16ewUyTcgFwhir5H1Rgr48vV3CeJ4ibSbne8D95j8t
         wpCxXS8ym3F+N9FYQagVaFx/j3bkaOIwjdwC1/lx/6XJpJF/NI36IqyxLl0WrDNyttfG
         6CzQ==
X-Gm-Message-State: AHQUAuaLVpcAWbxavf4OQ/nxxdemY6kNdvHnHC6v0MOUmFJIKas8vHn2
        ptffaB42NJW056+sterPcA==
X-Google-Smtp-Source: AHgI3IYYsWafgP2p4U1Cc1O2opO2btKPmB4WsQkz1bQsdyYsJYn8g6ToK1eA9OuugrJ1Yvpy3NyY5w==
X-Received: by 2002:a62:ee03:: with SMTP id e3mr13962942pfi.241.1551011674749;
        Sun, 24 Feb 2019 04:34:34 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:34:34 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm/numa: extract the code of building node fall back list
Date:   Sun, 24 Feb 2019 20:34:04 +0800
Message-Id: <1551011649-30103-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In coming patch, memblock allocator also utilizes node fall back list info.
Hence extracting the related code for reusing.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 mm/page_alloc.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde0..a6967a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5380,6 +5380,32 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 	zonerefs->zone_idx = 0;
 }
 
+int build_node_order(int *node_oder_array, int sz,
+	int local_node, nodemask_t *used_mask)
+{
+	int node, nr_nodes = 0;
+	int prev_node = local_node;
+	int load = nr_online_nodes;
+
+
+	while ((node = find_next_best_node(local_node, used_mask)) >= 0
+		&& nr_nodes < sz) {
+		/*
+		 * We don't want to pressure a particular node.
+		 * So adding penalty to the first node in same
+		 * distance group to make it round-robin.
+		 */
+		if (node_distance(local_node, node) !=
+		    node_distance(local_node, prev_node))
+			node_load[node] = load;
+
+		node_oder_array[nr_nodes++] = node;
+		prev_node = node;
+		load--;
+	}
+	return nr_nodes;
+}
+
 /*
  * Build zonelists ordered by zone and nodes within zones.
  * This results in conserving DMA zone[s] until all Normal memory is
@@ -5390,32 +5416,16 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 static void build_zonelists(pg_data_t *pgdat)
 {
 	static int node_order[MAX_NUMNODES];
-	int node, load, nr_nodes = 0;
+	int local_node, nr_nodes = 0;
 	nodemask_t used_mask;
-	int local_node, prev_node;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
-	load = nr_online_nodes;
-	prev_node = local_node;
 	nodes_clear(used_mask);
 
 	memset(node_order, 0, sizeof(node_order));
-	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
-		/*
-		 * We don't want to pressure a particular node.
-		 * So adding penalty to the first node in same
-		 * distance group to make it round-robin.
-		 */
-		if (node_distance(local_node, node) !=
-		    node_distance(local_node, prev_node))
-			node_load[node] = load;
-
-		node_order[nr_nodes++] = node;
-		prev_node = node;
-		load--;
-	}
-
+	nr_nodes = build_node_order(node_order, MAX_NUMNODES,
+		local_node, &used_mask);
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
 }
-- 
2.7.4

