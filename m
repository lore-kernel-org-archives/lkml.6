Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7195BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249892081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="d6dhjg1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249892081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeKGXUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:20:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37213 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeKGXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:20:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so13853274wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jl8MYawzITDgmCl5rhB3yH9WMi43VqVhKT4Mb/LyXb4=;
        b=d6dhjg1zfGs+mWIdGwllijTl8LpKULXmD8VGQBLYkb/xr/O0Qv+ufKAYzJ6V+6SXld
         JkvQI7pFgtCmfsgCBn0a1XoBE6ltnutElsg0h09ul9leOCV3MHdYqv3H1K7KSr8/m9qq
         1SQN10G4UJYSgRofV5tFAdPQWdzZNAB27gsHpwAnMPsuhtxPVbkDdn5CFE3DE6L9VeZX
         /Wlk6WKtS8NtUlZ3rPax2v5p0Fm53lCko/E0Wbm4SPi7WbHVNryFniBwWzAtdtqdUk2M
         NufXQMw51Rkb7Sz/fsZKPTIt9v2whyUy1CLplDvScueF47EIBMK47KQW8BrO/Awx6DWH
         cYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jl8MYawzITDgmCl5rhB3yH9WMi43VqVhKT4Mb/LyXb4=;
        b=hL93dhAmTRFjs7+m0lE9auiS7uWL6mGNBd/KBPyCBtAxBsOfBdt3mksZMpK+L1tfmX
         AjruG8kQvMDo8IYG+soRTh7bwqaefVScRB6OvB79pqGPJhqNb7pXC+KX/YFwjnN5r/mj
         jMuYKdcU+oI3+tl1MwOpjX5K4XqsWDaiEbNqc+mJjWJXvqrokpPi+P+HP6r9ggGuoQ5m
         NwDEaqQHG3+u3BddmdAotDg/J8ty0DmskpEer/wcCVPdBRNceGymGhQnIzM6WC3ifeWo
         9YNyx36bQuyAZAKNzGx0N1c2N3OPt4LI9bXZzrstm9b/A6goZMm2m3kEU4I4qjbA3hLt
         kkcg==
X-Gm-Message-State: AGRZ1gJ6qW86Sm1br5p8v7qIFA0OyuC+BfjmKEqR0UA2sav0XvjJ4UHC
        sxbfjcctx06YxunN6LyJZ0al/g==
X-Google-Smtp-Source: AJdET5c4K+mF1Noj87hVtypOIEmSTh+hUDCV+7xlrT0jhMPTb3oeHcZG1pbPSh3zoNv8QnXWcxwPfA==
X-Received: by 2002:adf:f181:: with SMTP id h1-v6mr292413wro.79.1541598573014;
        Wed, 07 Nov 2018 05:49:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8070:8895:9700:887:8ecc:df73:24eb])
        by smtp.gmail.com with ESMTPSA id y83-v6sm1206778wmb.20.2018.11.07.05.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:49:32 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org
Cc:     tyhicks@canonical.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 2/2] br_netfilter: namespace bridge netfilter sysctls
Date:   Wed,  7 Nov 2018 14:48:59 +0100
Message-Id: <20181107134859.19896-3-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107134859.19896-1-christian@brauner.io>
References: <20181107134859.19896-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the /proc/sys/net/bridge folder is only created in the initial
network namespace. This patch ensures that the /proc/sys/net/bridge folder
is available in each network namespace if the module is loaded and
disappears from all network namespaces when the module is unloaded.

In doing so the patch makes the sysctls:

bridge-nf-call-arptables
bridge-nf-call-ip6tables
bridge-nf-call-iptables
bridge-nf-filter-pppoe-tagged
bridge-nf-filter-vlan-tagged
bridge-nf-pass-vlan-input-dev

apply per network namespace. This unblocks some use-cases where users would
like to e.g. not do bridge filtering for bridges in a specific network
namespace while doing so for bridges located in another network namespace.

The netfilter rules are afaict already per network namespace so it should
be safe for users to specify whether bridge devices inside a network
namespace are supposed to go through iptables et al. or not. Also, this can
already be done per-bridge by setting an option for each individual bridge
via Netlink. It should also be possible to do this for all bridges in a
network namespace via sysctls.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/net/netfilter/br_netfilter.h |   3 +-
 net/bridge/br_netfilter_hooks.c      | 116 ++++++++++++++++++++-------
 net/bridge/br_netfilter_ipv6.c       |   2 +-
 3 files changed, 91 insertions(+), 30 deletions(-)

diff --git a/include/net/netfilter/br_netfilter.h b/include/net/netfilter/br_netfilter.h
index 74af19c3a8f7..e51f5961272b 100644
--- a/include/net/netfilter/br_netfilter.h
+++ b/include/net/netfilter/br_netfilter.h
@@ -48,7 +48,8 @@ static inline struct rtable *bridge_parent_rtable(const struct net_device *dev)
 	return port ? &port->br->fake_rtable : NULL;
 }
 
-struct net_device *setup_pre_routing(struct sk_buff *skb);
+struct net_device *setup_pre_routing(struct sk_buff *skb,
+				     const struct net *net);
 void br_netfilter_enable(void);
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 656a084f4825..8a33268f2750 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -72,17 +72,17 @@ static inline __be16 vlan_proto(const struct sk_buff *skb)
 		return 0;
 }
 
-#define IS_VLAN_IP(skb) \
+#define IS_VLAN_IP(skb, net) \
 	(vlan_proto(skb) == htons(ETH_P_IP) && \
-	 init_net.brnf.filter_vlan_tagged)
+	 net->brnf.filter_vlan_tagged)
 
-#define IS_VLAN_IPV6(skb) \
+#define IS_VLAN_IPV6(skb, net) \
 	(vlan_proto(skb) == htons(ETH_P_IPV6) && \
-	 init_net.brnf.filter_vlan_tagged)
+	 net->brnf.filter_vlan_tagged)
 
-#define IS_VLAN_ARP(skb) \
+#define IS_VLAN_ARP(skb, net) \
 	(vlan_proto(skb) == htons(ETH_P_ARP) &&	\
-	 init_net.brnf.filter_vlan_tagged)
+	 net->brnf.filter_vlan_tagged)
 
 static inline __be16 pppoe_proto(const struct sk_buff *skb)
 {
@@ -90,15 +90,15 @@ static inline __be16 pppoe_proto(const struct sk_buff *skb)
 			    sizeof(struct pppoe_hdr)));
 }
 
-#define IS_PPPOE_IP(skb) \
+#define IS_PPPOE_IP(skb, net) \
 	(skb->protocol == htons(ETH_P_PPP_SES) && \
 	 pppoe_proto(skb) == htons(PPP_IP) && \
-	 init_net.brnf.filter_pppoe_tagged)
+	 net->brnf.filter_pppoe_tagged)
 
-#define IS_PPPOE_IPV6(skb) \
+#define IS_PPPOE_IPV6(skb, net) \
 	(skb->protocol == htons(ETH_P_PPP_SES) && \
 	 pppoe_proto(skb) == htons(PPP_IPV6) && \
-	 init_net.brnf.filter_pppoe_tagged)
+	 net->brnf.filter_pppoe_tagged)
 
 /* largest possible L2 header, see br_nf_dev_queue_xmit() */
 #define NF_BRIDGE_MAX_MAC_HEADER_LENGTH (PPPOE_SES_HLEN + ETH_HLEN)
@@ -408,12 +408,14 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	return 0;
 }
 
-static struct net_device *brnf_get_logical_dev(struct sk_buff *skb, const struct net_device *dev)
+static struct net_device *brnf_get_logical_dev(struct sk_buff *skb,
+					       const struct net_device *dev,
+					       const struct net *net)
 {
 	struct net_device *vlan, *br;
 
 	br = bridge_parent(dev);
-	if (init_net.brnf.pass_vlan_indev == 0 || !skb_vlan_tag_present(skb))
+	if (net->brnf.pass_vlan_indev == 0 || !skb_vlan_tag_present(skb))
 		return br;
 
 	vlan = __vlan_find_dev_deep_rcu(br, skb->vlan_proto,
@@ -423,7 +425,7 @@ static struct net_device *brnf_get_logical_dev(struct sk_buff *skb, const struct
 }
 
 /* Some common code for IPv4/IPv6 */
-struct net_device *setup_pre_routing(struct sk_buff *skb)
+struct net_device *setup_pre_routing(struct sk_buff *skb, const struct net *net)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
@@ -434,7 +436,7 @@ struct net_device *setup_pre_routing(struct sk_buff *skb)
 
 	nf_bridge->in_prerouting = 1;
 	nf_bridge->physindev = skb->dev;
-	skb->dev = brnf_get_logical_dev(skb, skb->dev);
+	skb->dev = brnf_get_logical_dev(skb, skb->dev, net);
 
 	if (skb->protocol == htons(ETH_P_8021Q))
 		nf_bridge->orig_proto = BRNF_PROTO_8021Q;
@@ -469,8 +471,9 @@ static unsigned int br_nf_pre_routing(void *priv,
 		return NF_DROP;
 	br = p->br;
 
-	if (IS_IPV6(skb) || IS_VLAN_IPV6(skb) || IS_PPPOE_IPV6(skb)) {
-		if (!init_net.brnf.call_ip6tables &&
+	if (IS_IPV6(skb) || IS_VLAN_IPV6(skb, state->net) ||
+	    IS_PPPOE_IPV6(skb, state->net)) {
+		if (!state->net->brnf.call_ip6tables &&
 		    !br_opt_get(br, BROPT_NF_CALL_IP6TABLES))
 			return NF_ACCEPT;
 
@@ -478,11 +481,12 @@ static unsigned int br_nf_pre_routing(void *priv,
 		return br_nf_pre_routing_ipv6(priv, skb, state);
 	}
 
-	if (!init_net.brnf.call_iptables &&
+	if (!state->net->brnf.call_iptables &&
 	    !br_opt_get(br, BROPT_NF_CALL_IPTABLES))
 		return NF_ACCEPT;
 
-	if (!IS_IP(skb) && !IS_VLAN_IP(skb) && !IS_PPPOE_IP(skb))
+	if (!IS_IP(skb) && !IS_VLAN_IP(skb, state->net) &&
+	    !IS_PPPOE_IP(skb, state->net))
 		return NF_ACCEPT;
 
 	nf_bridge_pull_encap_header_rcsum(skb);
@@ -493,7 +497,7 @@ static unsigned int br_nf_pre_routing(void *priv,
 	nf_bridge_put(skb->nf_bridge);
 	if (!nf_bridge_alloc(skb))
 		return NF_DROP;
-	if (!setup_pre_routing(skb))
+	if (!setup_pre_routing(skb, state->net))
 		return NF_DROP;
 
 	nf_bridge = nf_bridge_info_get(skb);
@@ -515,7 +519,7 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct net_device *in;
 
-	if (!IS_ARP(skb) && !IS_VLAN_ARP(skb)) {
+	if (!IS_ARP(skb) && !IS_VLAN_ARP(skb, net)) {
 
 		if (skb->protocol == htons(ETH_P_IP))
 			nf_bridge->frag_max_size = IPCB(skb)->frag_max_size;
@@ -569,9 +573,11 @@ static unsigned int br_nf_forward_ip(void *priv,
 	if (!parent)
 		return NF_DROP;
 
-	if (IS_IP(skb) || IS_VLAN_IP(skb) || IS_PPPOE_IP(skb))
+	if (IS_IP(skb) || IS_VLAN_IP(skb, state->net) ||
+	    IS_PPPOE_IP(skb, state->net))
 		pf = NFPROTO_IPV4;
-	else if (IS_IPV6(skb) || IS_VLAN_IPV6(skb) || IS_PPPOE_IPV6(skb))
+	else if (IS_IPV6(skb) || IS_VLAN_IPV6(skb, state->net) ||
+		 IS_PPPOE_IPV6(skb, state->net))
 		pf = NFPROTO_IPV6;
 	else
 		return NF_ACCEPT;
@@ -602,7 +608,7 @@ static unsigned int br_nf_forward_ip(void *priv,
 		skb->protocol = htons(ETH_P_IPV6);
 
 	NF_HOOK(pf, NF_INET_FORWARD, state->net, NULL, skb,
-		brnf_get_logical_dev(skb, state->in),
+		brnf_get_logical_dev(skb, state->in, state->net),
 		parent,	br_nf_forward_finish);
 
 	return NF_STOLEN;
@@ -621,18 +627,18 @@ static unsigned int br_nf_forward_arp(void *priv,
 		return NF_ACCEPT;
 	br = p->br;
 
-	if (!init_net.brnf.call_arptables &&
+	if (!state->net->brnf.call_arptables &&
 	    !br_opt_get(br, BROPT_NF_CALL_ARPTABLES))
 		return NF_ACCEPT;
 
 	if (!IS_ARP(skb)) {
-		if (!IS_VLAN_ARP(skb))
+		if (!IS_VLAN_ARP(skb, state->net))
 			return NF_ACCEPT;
 		nf_bridge_pull_encap_header(skb);
 	}
 
 	if (arp_hdr(skb)->ar_pln != 4) {
-		if (IS_VLAN_ARP(skb))
+		if (IS_VLAN_ARP(skb, state->net))
 			nf_bridge_push_encap_header(skb);
 		return NF_ACCEPT;
 	}
@@ -787,9 +793,11 @@ static unsigned int br_nf_post_routing(void *priv,
 	if (!realoutdev)
 		return NF_DROP;
 
-	if (IS_IP(skb) || IS_VLAN_IP(skb) || IS_PPPOE_IP(skb))
+	if (IS_IP(skb) || IS_VLAN_IP(skb, state->net) ||
+	    IS_PPPOE_IP(skb, state->net))
 		pf = NFPROTO_IPV4;
-	else if (IS_IPV6(skb) || IS_VLAN_IPV6(skb) || IS_PPPOE_IPV6(skb))
+	else if (IS_IPV6(skb) || IS_VLAN_IPV6(skb, state->net) ||
+		 IS_PPPOE_IPV6(skb, state->net))
 		pf = NFPROTO_IPV6;
 	else
 		return NF_ACCEPT;
@@ -1071,6 +1079,49 @@ static inline void br_netfilter_sysctl_default(struct netns_brnf *brnf)
 	brnf->pass_vlan_indev = 0;
 }
 
+static __net_init int br_netfilter_sysctl_init_net(struct net *net)
+{
+	struct ctl_table *table = brnf_table;
+
+	if (net_eq(net, &init_net))
+		return 0;
+
+	table = kmemdup(table, sizeof(brnf_table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	table[0].data = &net->brnf.call_arptables;
+	table[1].data = &net->brnf.call_iptables;
+	table[2].data = &net->brnf.call_ip6tables;
+	table[3].data = &net->brnf.filter_vlan_tagged;
+	table[4].data = &net->brnf.filter_pppoe_tagged;
+	table[5].data = &net->brnf.pass_vlan_indev;
+
+	net->brnf.ctl_hdr = register_net_sysctl(net, "net/bridge", table);
+	if (!net->brnf.ctl_hdr) {
+		kfree(table);
+		return -ENOMEM;
+	}
+
+	br_netfilter_sysctl_default(&net->brnf);
+
+	return 0;
+}
+
+static __net_exit void br_netfilter_sysctl_exit_net(struct net *net)
+{
+	if (net_eq(net, &init_net))
+		return;
+
+	unregister_net_sysctl_table(net->brnf.ctl_hdr);
+	kfree(net->brnf.ctl_hdr->ctl_table_arg);
+}
+
+static struct pernet_operations br_netfilter_sysctl_ops = {
+	.init = br_netfilter_sysctl_init_net,
+	.exit = br_netfilter_sysctl_exit_net,
+};
+
 static int __init br_netfilter_init(void)
 {
 	int ret;
@@ -1097,6 +1148,14 @@ static int __init br_netfilter_init(void)
 		unregister_pernet_subsys(&brnf_net_ops);
 		return -ENOMEM;
 	}
+
+	ret = register_pernet_subsys(&br_netfilter_sysctl_ops);
+	if (ret < 0) {
+		unregister_netdevice_notifier(&brnf_notifier);
+		unregister_pernet_subsys(&brnf_net_ops);
+		unregister_net_sysctl_table(init_net.brnf.ctl_hdr);
+		return ret;
+	}
 #endif
 	RCU_INIT_POINTER(nf_br_ops, &br_ops);
 	printk(KERN_NOTICE "Bridge firewalling registered\n");
@@ -1110,6 +1169,7 @@ static void __exit br_netfilter_fini(void)
 	unregister_pernet_subsys(&brnf_net_ops);
 #ifdef CONFIG_SYSCTL
 	unregister_net_sysctl_table(init_net.brnf.ctl_hdr);
+	unregister_pernet_subsys(&br_netfilter_sysctl_ops);
 #endif
 }
 
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 96c072e71ea2..d2220e502b6f 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -227,7 +227,7 @@ unsigned int br_nf_pre_routing_ipv6(void *priv,
 	nf_bridge_put(skb->nf_bridge);
 	if (!nf_bridge_alloc(skb))
 		return NF_DROP;
-	if (!setup_pre_routing(skb))
+	if (!setup_pre_routing(skb, state->net))
 		return NF_DROP;
 
 	nf_bridge = nf_bridge_info_get(skb);
-- 
2.19.1

