Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CFB2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/lTDE27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeLQNTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:19:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeLQNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so12266968wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdZbaGumofDlzZscmjO4/1rMOKWdjFWAqxsY9I7b5SE=;
        b=j/lTDE27lH7MxG4lMbX9tzV+iq68peIvXYgGh3qJ3uCOBOedbAVAYxsEC1DyuAIR3u
         Rd0IZXh5AltOP9wibZwA6iLMh3V8Sba3CU0726CcMsoF7I1zx2w7LYBprxXUvgyTwYN+
         aBcZcymzlgsj+wrO268Q67tCbuFoGKVTVy/fnRaYCbt2I5TkcR3r5i3CgCJD/K78ccM0
         AZsJq4fz/ANgnWAOrNeAyS7AF8WoB7cBJOYWcVvRskAx6MBFcdmArYSwY2XhPctUka5N
         FN0nksOHeFCI00KgutFOog0J2WT/bCycAdWNIe8OaEueu4EpXTETRt2J7fdvrGo5VDLN
         H0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdZbaGumofDlzZscmjO4/1rMOKWdjFWAqxsY9I7b5SE=;
        b=oOEkngayeHYb0HOSjGhE+PtbQeKvkfONyxJVw6WAYKPzlG3cRl/pfydC19YwU9awXE
         lowmvVoPtZl0n3GZc4gDpt36hSIG5sRxKHnKb0JyL8iTp6zT1Xqn8JyenYgcSvt3xctV
         87H1yHzqkdUutV7KQxDiowt2et4kCCE1F0/yun9SJoywNFpKdvtO0pL5rBwo06qrJk/d
         QDhJ1NeuUAKuKZaSpfrw3GmKkw/RqvCBI9s3o5DABxSlQwr04tA3iEb5Gt8Fy8GeZhSt
         vFX0Yl+GOU0kKptkCpTZTnjBYeRPjbxq13Ycf0mOfO71PprDXnoPC3AwoVCtDQHqvQJ5
         JleQ==
X-Gm-Message-State: AA+aEWb37ADRPtW7WM/gReWSFrkRRS1GXcMVlBmMO57i8u0veG/QKTYW
        Oc8SEUA0lIy9UQwlcCpKyw==
X-Google-Smtp-Source: AFSGD/V2wUyAUQq2JOXad5CS2vvNODEyhSBTqFjav3CiduetD60Q8cj9lFNxNDB26MVkgM1o27nR6w==
X-Received: by 2002:adf:f189:: with SMTP id h9mr10660364wro.35.1545052778948;
        Mon, 17 Dec 2018 05:19:38 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:38 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/7] openvswitch: convert to kvmalloc
Date:   Mon, 17 Dec 2018 08:19:23 -0500
Message-Id: <20181217131929.11727-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was no real need for this code to be using flexarrays, it's just
implementing a hash table - ideally it would be using rhashtables, but
that conversion would be significantly more complicated.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: dev@openvswitch.org
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 net/openvswitch/flow.h         |  1 -
 net/openvswitch/flow_netlink.h |  1 -
 net/openvswitch/flow_table.c   | 51 ++++++++--------------------------
 net/openvswitch/flow_table.h   |  3 +-
 4 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index c670dd24b8..4f06278166 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -30,7 +30,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 #include <linux/cpumask.h>
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
diff --git a/net/openvswitch/flow_netlink.h b/net/openvswitch/flow_netlink.h
index 6657606b2b..66f9553758 100644
--- a/net/openvswitch/flow_netlink.h
+++ b/net/openvswitch/flow_netlink.h
@@ -30,7 +30,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 80ea2a7185..cfb0098c9a 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -111,29 +111,6 @@ int ovs_flow_tbl_count(const struct flow_table *table)
 	return table->count;
 }
 
-static struct flex_array *alloc_buckets(unsigned int n_buckets)
-{
-	struct flex_array *buckets;
-	int i, err;
-
-	buckets = flex_array_alloc(sizeof(struct hlist_head),
-				   n_buckets, GFP_KERNEL);
-	if (!buckets)
-		return NULL;
-
-	err = flex_array_prealloc(buckets, 0, n_buckets, GFP_KERNEL);
-	if (err) {
-		flex_array_free(buckets);
-		return NULL;
-	}
-
-	for (i = 0; i < n_buckets; i++)
-		INIT_HLIST_HEAD((struct hlist_head *)
-					flex_array_get(buckets, i));
-
-	return buckets;
-}
-
 static void flow_free(struct sw_flow *flow)
 {
 	int cpu;
@@ -168,31 +145,30 @@ void ovs_flow_free(struct sw_flow *flow, bool deferred)
 		flow_free(flow);
 }
 
-static void free_buckets(struct flex_array *buckets)
-{
-	flex_array_free(buckets);
-}
-
-
 static void __table_instance_destroy(struct table_instance *ti)
 {
-	free_buckets(ti->buckets);
+	kvfree(ti->buckets);
 	kfree(ti);
 }
 
 static struct table_instance *table_instance_alloc(int new_size)
 {
 	struct table_instance *ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+	int i;
 
 	if (!ti)
 		return NULL;
 
-	ti->buckets = alloc_buckets(new_size);
-
+	ti->buckets = kvmalloc_array(new_size, sizeof(struct hlist_head),
+				     GFP_KERNEL);
 	if (!ti->buckets) {
 		kfree(ti);
 		return NULL;
 	}
+
+	for (i = 0; i < new_size; i++)
+		INIT_HLIST_HEAD(&ti->buckets[i]);
+
 	ti->n_buckets = new_size;
 	ti->node_ver = 0;
 	ti->keep_flows = false;
@@ -249,7 +225,7 @@ static void table_instance_destroy(struct table_instance *ti,
 
 	for (i = 0; i < ti->n_buckets; i++) {
 		struct sw_flow *flow;
-		struct hlist_head *head = flex_array_get(ti->buckets, i);
+		struct hlist_head *head = &ti->buckets[i];
 		struct hlist_node *n;
 		int ver = ti->node_ver;
 		int ufid_ver = ufid_ti->node_ver;
@@ -294,7 +270,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 	ver = ti->node_ver;
 	while (*bucket < ti->n_buckets) {
 		i = 0;
-		head = flex_array_get(ti->buckets, *bucket);
+		head = &ti->buckets[*bucket];
 		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
 			if (i < *last) {
 				i++;
@@ -313,8 +289,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 static struct hlist_head *find_bucket(struct table_instance *ti, u32 hash)
 {
 	hash = jhash_1word(hash, ti->hash_seed);
-	return flex_array_get(ti->buckets,
-				(hash & (ti->n_buckets - 1)));
+	return &ti->buckets[hash & (ti->n_buckets - 1)];
 }
 
 static void table_instance_insert(struct table_instance *ti,
@@ -347,9 +322,7 @@ static void flow_table_copy_flows(struct table_instance *old,
 	/* Insert in new table. */
 	for (i = 0; i < old->n_buckets; i++) {
 		struct sw_flow *flow;
-		struct hlist_head *head;
-
-		head = flex_array_get(old->buckets, i);
+		struct hlist_head *head = &old->buckets[i];
 
 		if (ufid)
 			hlist_for_each_entry(flow, head,
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 2dd9900f53..de5ec6cf51 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -29,7 +29,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
@@ -37,7 +36,7 @@
 #include "flow.h"
 
 struct table_instance {
-	struct flex_array *buckets;
+	struct hlist_head *buckets;
 	unsigned int n_buckets;
 	struct rcu_head rcu;
 	int node_ver;
-- 
2.20.1

