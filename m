Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA723C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A4220672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="QySSNsXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A4220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeKZFBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:01:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38201 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeKZFBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:01:18 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so24173971ith.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cO4xDETbEz/pkA49gxSXtcJtXsj+4EyBF/+O7VHKiE=;
        b=QySSNsXVrbhMTad9pQ66izQTBnjzHfz/SQ59o+mDgsvfUmwtZa40t5e67EE3fulUTM
         /IvVSFDLiN43EvqKbB9Ejy0v3SKq3b6Rz9WBIesthjS8janvFOKA5oM4OmU7bMjrc9s1
         BjGBKhYCb6ce71YeoTxE5xJle+wk1JfT4caXKkotMllGDwXa68AddwQpnWVpnAxlOWWn
         1T5xssyL/wJbkF4fD6NhYXJbgYu/ACsxU3CdqOLssgC7Km7+L/lNV04ORisLH5zmXpur
         zbjchn6HpDhRAvV0sN/zJFqgcrVamCR8/rzqiljCrjvAIAsJlGLuviJQI8g8nyt7BdW4
         FffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cO4xDETbEz/pkA49gxSXtcJtXsj+4EyBF/+O7VHKiE=;
        b=sSLmf2ZOy5UGDiU6B2NSX+p0ziTcIlYSby4afR17ZsTR5e6ZSk5PyuK7/aNiYdgDC7
         Vr7aOLbnWnrS5rQUYLCgwns6ImGGKqIxrYLzKOvEebYoFEfBynjWm3UvFP+T1+NGv/3Z
         +vQ90SWN3lUb5y91t9Zy8c+kLhp7OZdzfVZrIpvaz3sPFsdSzUWQtM1C53fMVkcjlXc4
         zY1J4wVzxOb/YpZ6vG2/XzSgm2IDc8YW2YBqkTdNZ34QKQwj4tBjiHcuVJqXMlpzHFPC
         VeMMSOvOB07SfavhtngEbyDSzVf8hpzxOGwUJ1eUGdSNs4luWlyeHTCXl6jkP1Nu9VXH
         5LVw==
X-Gm-Message-State: AGRZ1gKhDXebK4UAzNUoDZec5A9BeQcgKI8muwjNeXJ3WFZTQcRbeqCw
        2I5Xn03vwaF1VDEPY3bdnSi6Lw==
X-Google-Smtp-Source: AJdET5cKuEebQB8o6kmcMVRFiWmoSM26DajGObGNhE3OlDIZtAPDGu+esBPsVbmeoNfme56pbZ3HmQ==
X-Received: by 2002:a02:f95:: with SMTP id 21mr20763961jao.66.1543169380205;
        Sun, 25 Nov 2018 10:09:40 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (047-014-005-015.res.spectrum.com. [47.14.5.15])
        by smtp.gmail.com with ESMTPSA id y8sm5959768ita.5.2018.11.25.10.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 10:09:39 -0800 (PST)
From:   Aaron Conole <aconole@bytheb.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: [RFC -next v0 2/3] netfilter: nf_flow_table: support a new 'snoop' mode
Date:   Sun, 25 Nov 2018 13:09:18 -0500
Message-Id: <20181125180919.13996-3-aconole@bytheb.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125180919.13996-1-aconole@bytheb.org>
References: <20181125180919.13996-1-aconole@bytheb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability for a flow table to receive updates on
all flows added/removed to any flow table in the system.  This will
allow other subsystems in the kernel to register a lookup mechanism
into the nftables connection tracker for those connections which
should be sent to a flow offload table.

Each flow table can now be set with some kinds of flags, and if
one of those flags is the new 'snoop' flag, it will be updated
whenever a flow entry is added or removed to any flow table.

Signed-off-by: Aaron Conole <aconole@bytheb.org>
---
 include/net/netfilter/nf_flow_table.h    |  5 +++
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_flow_table_core.c       | 44 ++++++++++++++++++++++--
 net/netfilter/nf_tables_api.c            | 13 ++++++-
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 77e2761d4f2f..3fdfeb17f500 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -20,9 +20,14 @@ struct nf_flowtable_type {
 	struct module			*owner;
 };
 
+enum nf_flowtable_flags {
+	NF_FLOWTABLE_F_SNOOP		= 0x1,
+};
+
 struct nf_flowtable {
 	struct list_head		list;
 	struct rhashtable		rhashtable;
+	u32				flags;
 	const struct nf_flowtable_type	*type;
 	struct delayed_work		gc_work;
 };
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 7de4f1bdaf06..f1cfe30aecde 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1482,6 +1482,7 @@ enum nft_object_attributes {
  * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration(NLA_U32)
  * @NFTA_FLOWTABLE_USE: number of references to this flow table (NLA_U32)
  * @NFTA_FLOWTABLE_HANDLE: object handle (NLA_U64)
+ * @NFTA_FLOWTABLE_FLAGS: flags (NLA_U32)
  */
 enum nft_flowtable_attributes {
 	NFTA_FLOWTABLE_UNSPEC,
@@ -1491,6 +1492,7 @@ enum nft_flowtable_attributes {
 	NFTA_FLOWTABLE_USE,
 	NFTA_FLOWTABLE_HANDLE,
 	NFTA_FLOWTABLE_PAD,
+	NFTA_FLOWTABLE_FLAGS,
 	__NFTA_FLOWTABLE_MAX
 };
 #define NFTA_FLOWTABLE_MAX	(__NFTA_FLOWTABLE_MAX - 1)
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index b7a4816add76..289a2299eea2 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -15,6 +15,7 @@
 struct flow_offload_entry {
 	struct flow_offload	flow;
 	struct nf_conn		*ct;
+	struct nf_flow_route	route;
 	struct rcu_head		rcu_head;
 };
 
@@ -78,6 +79,7 @@ flow_offload_alloc(struct nf_conn *ct, struct nf_flow_route *route)
 		goto err_dst_cache_reply;
 
 	entry->ct = ct;
+	entry->route = *route;
 
 	flow_offload_fill_dir(flow, ct, route, FLOW_OFFLOAD_DIR_ORIGINAL);
 	flow_offload_fill_dir(flow, ct, route, FLOW_OFFLOAD_DIR_REPLY);
@@ -100,6 +102,18 @@ flow_offload_alloc(struct nf_conn *ct, struct nf_flow_route *route)
 }
 EXPORT_SYMBOL_GPL(flow_offload_alloc);
 
+static struct flow_offload *flow_offload_clone(struct flow_offload *flow)
+{
+	struct flow_offload *clone_flow_val;
+	struct flow_offload_entry *e;
+
+	e = container_of(flow, struct flow_offload_entry, flow);
+
+	clone_flow_val = flow_offload_alloc(e->ct, &e->route);
+
+	return clone_flow_val;
+}
+
 static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
 {
 	tcp->state = TCP_CONNTRACK_ESTABLISHED;
@@ -182,7 +196,7 @@ static const struct rhashtable_params nf_flow_offload_rhash_params = {
 	.automatic_shrinking	= true,
 };
 
-int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
+static void __flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 {
 	flow->timeout = (u32)jiffies;
 
@@ -192,12 +206,30 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 	rhashtable_insert_fast(&flow_table->rhashtable,
 			       &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
 			       nf_flow_offload_rhash_params);
+}
+
+int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
+{
+	struct nf_flowtable *flowtable;
+
+	__flow_offload_add(flow_table, flow);
+
+	mutex_lock(&flowtable_lock);
+	list_for_each_entry(flowtable, &flowtables, list) {
+		if (flowtable != flow_table &&
+		    flowtable->flags & NF_FLOWTABLE_F_SNOOP) {
+			struct flow_offload *flow_clone =
+				flow_offload_clone(flow);
+			__flow_offload_add(flowtable, flow_clone);
+		}
+	}
+	mutex_unlock(&flowtable_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(flow_offload_add);
 
-static void flow_offload_del(struct nf_flowtable *flow_table,
-			     struct flow_offload *flow)
+static void __flow_offload_del(struct nf_flowtable *flow_table,
+			       struct flow_offload *flow)
 {
 	struct flow_offload_entry *e;
 
@@ -210,6 +242,12 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
 
 	e = container_of(flow, struct flow_offload_entry, flow);
 	clear_bit(IPS_OFFLOAD_BIT, &e->ct->status);
+}
+
+static void flow_offload_del(struct nf_flowtable *flow_table,
+			     struct flow_offload *flow)
+{
+	__flow_offload_del(flow_table, flow);
 
 	flow_offload_free(flow);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 42487d01a3ed..8148de9f9a54 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5569,6 +5569,15 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 	if (err < 0)
 		goto err3;
 
+	if (nla[NFTA_FLOWTABLE_FLAGS]) {
+		flowtable->data.flags =
+			ntohl(nla_get_be32(nla[NFTA_FLOWTABLE_FLAGS]));
+		if (flowtable->data.flags & ~NF_FLOWTABLE_F_SNOOP) {
+			err = -EINVAL;
+			goto err4;
+		}
+	}
+
 	err = nf_tables_flowtable_parse_hook(&ctx, nla[NFTA_FLOWTABLE_HOOK],
 					     flowtable);
 	if (err < 0)
@@ -5694,7 +5703,9 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 	    nla_put_string(skb, NFTA_FLOWTABLE_NAME, flowtable->name) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
 	    nla_put_be64(skb, NFTA_FLOWTABLE_HANDLE, cpu_to_be64(flowtable->handle),
-			 NFTA_FLOWTABLE_PAD))
+			 NFTA_FLOWTABLE_PAD) ||
+	    nla_put_be32(skb, NFTA_FLOWTABLE_FLAGS,
+			 htonl(flowtable->data.flags)))
 		goto nla_put_failure;
 
 	nest = nla_nest_start(skb, NFTA_FLOWTABLE_HOOK);
-- 
2.19.1

