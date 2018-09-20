Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECB6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4C221523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsZEF5n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4C221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbeIUBS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:18:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38344 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:18:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so8830112edb.5;
        Thu, 20 Sep 2018 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FfxFH2Td1dLQmcGVuwiJOhxW/aruuY4P4zlRnxmeHk0=;
        b=PsZEF5n1nVU2vS6O0VBZ51wriv0/HcYQtOjtpzc5/IU2qz1n6Y3lohD4ehNldhxaWs
         CdJflJqPGOq36qCgj3GH+XxdO7Bh7bIfXIT9XCxH9S1gJpFBHvBnTCDwn831LYIVGf48
         aj6lg2xzcunVruLdz/6PrCaj+WQdh07FBGTH4OBdj06jQSpYvg6Ie6Qy9b5bEksbTam8
         8Nd0qkMLVhjgIitQmtTHMYLgj5tNp3C771NTTNJc1jxE6eiAC6yYHDWEsjzaHuL2t7qW
         L7X3n6XQSZYUcOLexcaySILZrT6s++a+xl+7EKpVh2wxdWwLInea0xFPeO9cp7+sdYOw
         i6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FfxFH2Td1dLQmcGVuwiJOhxW/aruuY4P4zlRnxmeHk0=;
        b=jIgRrNTqavg/SUKykW6dBAh0Ern83//0ENRdcH6OE/LxXyhs6pTK6JWrCnu57EiXt6
         Mbcj6KsXGR20ssJbxswPJpSuTUp6cD7pIxX4V6KW6lzPBLKpUFaaZXh9dw9JbPuPTQ1X
         eu8WVG62hnCT+aJXJ0blw6bsn7iWSJfcOM2yChoahFjpiutacI6WYVp0NYXyj1r01HXP
         eEnxMkUijqCX4MEd99/59HDMHrUGo8lTpspe3+4pol43XzxvvKcdab+ZlHOVnbC8gmes
         KEMTnzDbIlXQtCwRoKvWEI6mgQ9en+LjM0yAV5Q9mTHQsypF3CWOX6gg50LT71OI365o
         9R2w==
X-Gm-Message-State: APzg51CNKUlRI3IOo6enuDTuReyN6aNEQGXm8COsgZMBpR4HpetrFzRR
        ZLxxyGzGPq4tSXW/k5p5izg=
X-Google-Smtp-Source: ANB0VdZJ8kgneSwGkSR+XzrFv+wDkIOQo/jp8HWaH1G0YDFE1foyU2BaBkdgwc+D1alzDLXgZFDBnA==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr6468281edc.229.1537472001961;
        Thu, 20 Sep 2018 12:33:21 -0700 (PDT)
Received: from localhost.localdomain (235.99.60.188.dynamic.wline.res.cust.swisscom.ch. [188.60.99.235])
        by smtp.googlemail.com with ESMTPSA id 25-v6sm1810809edz.45.2018.09.20.12.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:33:21 -0700 (PDT)
From:   Romain Aviolat <r.aviolat@gmail.com>
To:     davem@davemloft.net
Cc:     elena.reshetova@intel.com, ishkamiel@gmail.com, sd@queasysnail.net,
        dan.carpenter@oracle.com, felix.walter@cloudandheat.com,
        r.aviolat@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] DRIVERS: net: macsec: Fix multiple coding style issues
Date:   Thu, 20 Sep 2018 21:33:08 +0200
Message-Id: <20180920193308.22869-1-r.aviolat@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of issues highlighted by checkpatch.pl:

    * Missing a blank line after declarations
    * Alignment should match open parenthesis

Signed-off-by: Romain Aviolat <r.aviolat@gmail.com>
---
 drivers/net/macsec.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7de88b33d5b9..4bb90b6867a2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -64,9 +64,9 @@ struct macsec_eth_header {
 
 #define MACSEC_NUM_AN 4 /* 2 bits for the association number */
 
-#define for_each_rxsc(secy, sc)			\
+#define for_each_rxsc(secy, sc)				\
 	for (sc = rcu_dereference_bh(secy->rx_sc);	\
-	     sc;				\
+	     sc;					\
 	     sc = rcu_dereference_bh(sc->next))
 #define for_each_rxsc_rtnl(secy, sc)			\
 	for (sc = rtnl_dereference(secy->rx_sc);	\
@@ -1142,6 +1142,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
+
 		sc = sc ? macsec_rxsc_get(sc) : NULL;
 
 		if (sc) {
@@ -1584,7 +1585,6 @@ static struct macsec_rx_sa *get_rxsa_from_nl(struct net *net,
 	return rx_sa;
 }
 
-
 static const struct nla_policy macsec_genl_policy[NUM_MACSEC_ATTR] = {
 	[MACSEC_ATTR_IFINDEX] = { .type = NLA_U32 },
 	[MACSEC_ATTR_RXSC_CONFIG] = { .type = NLA_NESTED },
@@ -2156,7 +2156,7 @@ static int macsec_upd_rxsc(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int copy_tx_sa_stats(struct sk_buff *skb,
-			     struct macsec_tx_sa_stats __percpu *pstats)
+			    struct macsec_tx_sa_stats __percpu *pstats)
 {
 	struct macsec_tx_sa_stats sum = {0, };
 	int cpu;
@@ -2176,7 +2176,7 @@ static int copy_tx_sa_stats(struct sk_buff *skb,
 }
 
 static int copy_rx_sa_stats(struct sk_buff *skb,
-			     struct macsec_rx_sa_stats __percpu *pstats)
+			    struct macsec_rx_sa_stats __percpu *pstats)
 {
 	struct macsec_rx_sa_stats sum = {0, };
 	int cpu;
@@ -2202,7 +2202,7 @@ static int copy_rx_sa_stats(struct sk_buff *skb,
 }
 
 static int copy_rx_sc_stats(struct sk_buff *skb,
-			     struct pcpu_rx_sc_stats __percpu *pstats)
+			    struct pcpu_rx_sc_stats __percpu *pstats)
 {
 	struct macsec_rx_sc_stats sum = {0, };
 	int cpu;
@@ -2266,7 +2266,7 @@ static int copy_rx_sc_stats(struct sk_buff *skb,
 }
 
 static int copy_tx_sc_stats(struct sk_buff *skb,
-			     struct pcpu_tx_sc_stats __percpu *pstats)
+			    struct pcpu_tx_sc_stats __percpu *pstats)
 {
 	struct macsec_tx_sc_stats sum = {0, };
 	int cpu;
@@ -2306,7 +2306,7 @@ static int copy_tx_sc_stats(struct sk_buff *skb,
 }
 
 static int copy_secy_stats(struct sk_buff *skb,
-			    struct pcpu_secy_stats __percpu *pstats)
+			   struct pcpu_secy_stats __percpu *pstats)
 {
 	struct macsec_dev_stats sum = {0, };
 	int cpu;
@@ -2962,13 +2962,11 @@ static int macsec_get_iflink(const struct net_device *dev)
 	return macsec_priv(dev)->real_dev->ifindex;
 }
 
-
 static int macsec_get_nest_level(struct net_device *dev)
 {
 	return macsec_priv(dev)->nest_level;
 }
 
-
 static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_init		= macsec_dev_init,
 	.ndo_uninit		= macsec_dev_uninit,
-- 
2.17.1

