Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1970520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1970520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIEAU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34188 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIEAU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id j25-v6so12206484wmc.1;
        Tue, 04 Sep 2018 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kstk68uUEHx449LVdI54BQGDmbM9M+/b6VS7Ke9JL84=;
        b=i/4HsHqFRNkrkJUN4xBi5UoP0lc8Og0xJyZc8IkDz+ORtfWitcid026/ng73k8zNZM
         MZaLudy8yUX7REb1+mv4ozXRfgH1RnVoXp2/rVUAMKuuS6aF783cMZCJC/yVdifpe/Lj
         7X72QrRkPm7WOJ+09Skpppbp6gT1JgaWaCTT9WpZ5CCCLTEIRh6okyHTerA8D0HxqfFw
         Zi4j5YoJ1w2lH053Fs529ghSAXCulTM4GZFqfGx7fOZ3FCF/frqVS6JFNA3yJmJjgvJn
         OVTa6DZ3Ob2IkgfVHOLU45eROKygzH0/uuwlCyVvMBVsK/SmCe205aecup/BtNDHEpsI
         pbcA==
X-Gm-Message-State: APzg51AKzsAnZfD/e46SP7VtRP63ySKSjAdCaLBkCLK+k8YI+zTUhRDy
        cnJIDs6+V+TgU81yr7Dso7oky0ot0kFoVQ==
X-Google-Smtp-Source: ANB0VdZeiHWsZfWKBEbZ3/z11X6kDqmdBpNBTd4krvi+ANZCfCSG9e8c7DWxCX7UMS7RvrRJxlAZgw==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr8855076wmd.150.1536090858284;
        Tue, 04 Sep 2018 12:54:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 7/9] rtnetlink: s/IFLA_IF_NETNSID/IFLA_TARGET_NETNSID/g
Date:   Tue,  4 Sep 2018 21:53:53 +0200
Message-Id: <20180904195355.4695-8-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFLA_TARGET_NETNSID is the new alias for IFLA_IF_NETNSID. This commit
replaces all occurrences of IFLA_IF_NETNSID with the new alias to
indicate that this identifier is the preferred one.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Jiri Benc <jbenc@redhat.com>
---
v1->v2:
- patch added

v0->v1:
- patch not present
---
 net/core/rtnetlink.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b36dab7507a0..67d7898db346 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1012,7 +1012,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_NEW_NETNSID */
 	       + nla_total_size(4)  /* IFLA_NEW_IFINDEX */
 	       + nla_total_size(1)  /* IFLA_PROTO_DOWN */
-	       + nla_total_size(4)  /* IFLA_IF_NETNSID */
+	       + nla_total_size(4)  /* IFLA_TARGET_NETNSID */
 	       + nla_total_size(4)  /* IFLA_CARRIER_UP_COUNT */
 	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
 	       + nla_total_size(4)  /* IFLA_MIN_MTU */
@@ -1594,7 +1594,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm->ifi_flags = dev_get_flags(dev);
 	ifm->ifi_change = change;
 
-	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_IF_NETNSID, tgt_netnsid))
+	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
@@ -1733,7 +1733,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_XDP]		= { .type = NLA_NESTED },
 	[IFLA_EVENT]		= { .type = NLA_U32 },
 	[IFLA_GROUP]		= { .type = NLA_U32 },
-	[IFLA_IF_NETNSID]	= { .type = NLA_S32 },
+	[IFLA_TARGET_NETNSID]	= { .type = NLA_S32 },
 	[IFLA_CARRIER_UP_COUNT]	= { .type = NLA_U32 },
 	[IFLA_CARRIER_DOWN_COUNT] = { .type = NLA_U32 },
 	[IFLA_MIN_MTU]		= { .type = NLA_U32 },
@@ -1900,8 +1900,8 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 
 	if (nlmsg_parse(cb->nlh, hdrlen, tb, IFLA_MAX,
 			ifla_policy, NULL) >= 0) {
-		if (tb[IFLA_IF_NETNSID]) {
-			netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
+		if (tb[IFLA_TARGET_NETNSID]) {
+			netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
 			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
 			if (IS_ERR(tgt_net)) {
 				tgt_net = net;
@@ -1989,7 +1989,7 @@ EXPORT_SYMBOL(rtnl_link_get_net);
  *
  * 1. IFLA_NET_NS_PID
  * 2. IFLA_NET_NS_FD
- * 3. IFLA_IF_NETNSID
+ * 3. IFLA_TARGET_NETNSID
  */
 static struct net *rtnl_link_get_net_by_nlattr(struct net *src_net,
 					       struct nlattr *tb[])
@@ -1999,10 +1999,10 @@ static struct net *rtnl_link_get_net_by_nlattr(struct net *src_net,
 	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD])
 		return rtnl_link_get_net(src_net, tb);
 
-	if (!tb[IFLA_IF_NETNSID])
+	if (!tb[IFLA_TARGET_NETNSID])
 		return get_net(src_net);
 
-	net = get_net_ns_by_id(src_net, nla_get_u32(tb[IFLA_IF_NETNSID]));
+	net = get_net_ns_by_id(src_net, nla_get_u32(tb[IFLA_TARGET_NETNSID]));
 	if (!net)
 		return ERR_PTR(-EINVAL);
 
@@ -2043,13 +2043,13 @@ static int rtnl_ensure_unique_netns(struct nlattr *tb[],
 		return -EOPNOTSUPP;
 	}
 
-	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
+	if (tb[IFLA_TARGET_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
 		goto invalid_attr;
 
-	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_FD]))
+	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_TARGET_NETNSID] || tb[IFLA_NET_NS_FD]))
 		goto invalid_attr;
 
-	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_PID]))
+	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_TARGET_NETNSID] || tb[IFLA_NET_NS_PID]))
 		goto invalid_attr;
 
 	return 0;
@@ -2325,7 +2325,7 @@ static int do_setlink(const struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
-	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_IF_NETNSID]) {
+	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_TARGET_NETNSID]) {
 		struct net *net = rtnl_link_get_net_capable(skb, dev_net(dev),
 							    tb, CAP_NET_ADMIN);
 		if (IS_ERR(net)) {
@@ -2768,8 +2768,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 
-	if (tb[IFLA_IF_NETNSID]) {
-		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
+	if (tb[IFLA_TARGET_NETNSID]) {
+		netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
 		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
@@ -3178,8 +3178,8 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[IFLA_IF_NETNSID]) {
-		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
+	if (tb[IFLA_TARGET_NETNSID]) {
+		netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
 		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
 		if (IS_ERR(tgt_net))
 			return PTR_ERR(tgt_net);
-- 
2.17.1

