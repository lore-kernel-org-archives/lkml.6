Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07242083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omdQ6/2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07242083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeIGVib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:31 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:37486 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:30 -0400
Received: by mail-ua1-f45.google.com with SMTP id y10-v6so12443298uao.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Js8CNh2v6/eZtsk33ccIbs2b1Mpsuw+ORIRUejvWEoY=;
        b=omdQ6/2L0Ty8T0IWyAPDMt667D46rb7SRZyYUnKGdbqUPTKaoOzAXLgjLBMH6d4Kgk
         hoSYTCN5SleVr8ZtRrMZXbez8wbWOZbCLlco4Z0lsmQ0cucUmL+WPql4LzaCiGKh5nYo
         tJXoOBW++nMlsJI4aHPXKnmxudrkMEmnCBIybzN4yCkhi92aEl4l5kmjFswIRDAyA6az
         UMK4hsJbroMi5Qxe6CDK3AYxABKUed4pQ+Ls1ehnneOafx761wf5ize1boQCuDNnlsxv
         Zvn37fufihc9X0VB6q4Gy0fmuzAx+x62J+QIfJgrd3lzG3kjX7LuLWxztWNgN1B7cVrn
         pS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Js8CNh2v6/eZtsk33ccIbs2b1Mpsuw+ORIRUejvWEoY=;
        b=WYhXJxL4M9DllrsPzd28fwM02ceCD8Ix1wKwupfxESu2cUREZSV14ecB5nmoCU1/As
         LEocamBEFmT3KiZBnis2IC91QSCkK+eUiGk7ONA9vo3ZU0cgr5lpojpaceFQBJrRl3yP
         WXAjoxuuqXfhcjPa48ZMihKvEg2Lm0EJ3zu1fCqSfzdQJ/4/U084RGs7Ut4mvPZ4qAsB
         PHVpvFuyJgSpKf6jCnemiy0vi8r102FHzI4lMI5pwxVwmAAiKPDrPWFNDA2cnzA6wZVE
         Q2DpyH5EUjxg/nROSKs+laufECfEFJxsxpvfUK7RSI0t22m+ZsNjiWH3E3ILRfqUjjxZ
         hA7g==
X-Gm-Message-State: APzg51Ck2lj1Nv0k77bZmWYNFUhnfX5gjdGLn2muY2ne/UlTXkJeqS0D
        bnvnvcx+GDlTVepMJIiaxzdj8MM=
X-Google-Smtp-Source: ANB0Vdb2daeVnDtEQEK0mjTDheEd25j9+VwfOoKVQjDJNf8lH4mzApuloivawgbONSqIsJC+luLq5g==
X-Received: by 2002:ab0:4c6c:: with SMTP id d44-v6mr3153708uag.102.1536339401672;
        Fri, 07 Sep 2018 09:56:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id q202-v6sm1039619vke.53.2018.09.07.09.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:56:40 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org
Subject: [PATCH 1/6] openvswitch: convert to kvmalloc
Date:   Fri,  7 Sep 2018 12:56:30 -0400
Message-Id: <20180907165635.8469-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180907165635.8469-1-kent.overstreet@gmail.com>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
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
2.19.0.rc2

