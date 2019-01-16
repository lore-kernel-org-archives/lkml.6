Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B51C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793B820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="cWZPwt+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391321AbfAPOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:25:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46392 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbfAPOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:25:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so3074046ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKzPXtLR8WK+kYBaXkxlRXyQmDpLzKOFCJeFgi7BsI8=;
        b=cWZPwt+fp+WUBJFnN6P+QMvKTGcmuXXCE8p5UwLKPO+QBx0HT+8LL8X28BNOoldYvM
         4uqPw094RtCSLlO2Kt/nYeorgEsIvX+xsAMSw2gQJouCsANGCz67zmjC0uCHodJXK4Yo
         rWXZ8Pj+R85uDXnevkzpQVwQX38K2bZTlIUdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKzPXtLR8WK+kYBaXkxlRXyQmDpLzKOFCJeFgi7BsI8=;
        b=m0InYrC7VWnywZnwHz3/ApMxhtdIxU2cUI3+Sabe1f+QGinxZjL9tnsq7rjquU5XoH
         LYiQlqmlbztN6Vohuxq09QKbCII6Yn65dBn4A66JgcGEPI+1ANx9rAn8vbCXi2U2sJnP
         kaNsDl4ylZE5iyTgKGBIyV8YgemWB3AixpNARQgEFFFp5wpf3V19kc0Kb+s/axe4Tp6T
         7+sTPHzLoSXxOQ2hbY0FizM/9HxGJz9010GCniM+tT81A01FL2//YOfk+z1fYQmQZqP2
         ZP/T5m97iE4dg3NBNvKXcuVBhqLYp1bOEC60VCPAM34HWwOIr5+8rSXoBm4w2O61ly+/
         /lHA==
X-Gm-Message-State: AJcUukfxW464oGZ0icHBG/abgKjNPrbYW2gBHEEHvxMuOyLIz5KNYUyX
        ZVrKsAoXu8vG2bPe5KNZUQVxow==
X-Google-Smtp-Source: ALg8bN5LWMSoQaSwjwU3O74SEHtf6m3+xPZvOUVn4iRc+L9xCLMZ34yDef2jUPYi3cWBtk7eYrF9qA==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr9945292pla.216.1547648707299;
        Wed, 16 Jan 2019 06:25:07 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id a17sm9211783pgm.26.2019.01.16.06.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:25:06 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 1/5] net: lorawan: Refine the coding style
Date:   Wed, 16 Jan 2019 22:24:54 +0800
Message-Id: <20190116142458.19542-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 include/linux/lora/lorawan_netdev.h |  5 ++--
 net/lorawan/socket.c                | 43 ++++++++++++++---------------
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/include/linux/lora/lorawan_netdev.h b/include/linux/lora/lorawan_netdev.h
index 5bffb5164f95..a6c94cb96bf4 100644
--- a/include/linux/lora/lorawan_netdev.h
+++ b/include/linux/lora/lorawan_netdev.h
@@ -1,9 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
-/*-
+/*
  * LoRaWAN stack related definitions
  *
- * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
- *
+ * Copyright (c) 2018 Jian-Hong Pan <starnight@g.ncu.edu.tw>
  */
 
 #ifndef __LORAWAN_NET_DEVICE_H__
diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
index 7ef106b877ca..0ec2d2bf1682 100644
--- a/net/lorawan/socket.c
+++ b/net/lorawan/socket.c
@@ -1,36 +1,33 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
-/*-
+/*
  * LoRaWAN stack related definitions
  *
- * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
- *
+ * Copyright (c) 2018 Jian-Hong Pan <starnight@g.ncu.edu.tw>
  */
 
 #define	LORAWAN_MODULE_NAME	"lorawan"
 
 #define	pr_fmt(fmt)		LORAWAN_MODULE_NAME ": " fmt
 
+#include <linux/if_arp.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/list.h>
+#include <linux/lora/lorawan_netdev.h>
+#include <linux/module.h>
 #include <linux/net.h>
-#include <linux/if_arp.h>
 #include <linux/termios.h>		/* For TIOCOUTQ/INQ */
 #include <net/sock.h>
-#include <linux/lora/lorawan_netdev.h>
 
 /**
  * dgram_sock - This structure holds the states of Datagram socket
  *
  * @sk:			network layer representation of the socket
- *			sk must be the first member of dgram_sock
  * @src_devaddr:	the LoRaWAN device address for this connection
  * @bound:		this socket is bound or not
  * @connected:		this socket is connected to the destination or not
- * @want_ack:		this socket needs to ack for the connection or not
  */
 struct dgram_sock {
-	struct sock sk;
+	struct sock sk;	/* sk must be the first member of dgram_sock */
 	u32 src_devaddr;
 
 	u8 bound:1;
@@ -136,7 +133,7 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	size_t tlen;
 	int ret;
 
-	pr_debug("%s: going to send %zu bytes", __func__, size);
+	pr_debug("%s: going to send %zu bytes\n", __func__, size);
 	if (msg->msg_flags & MSG_OOB) {
 		pr_debug("msg->msg_flags = 0x%x\n", msg->msg_flags);
 		return -EOPNOTSUPP;
@@ -532,7 +529,7 @@ static const struct proto_ops lrw_dgram_ops = {
 };
 
 static int
-lorawan_creat(struct net *net, struct socket *sock, int protocol, int kern)
+lrw_create(struct net *net, struct socket *sock, int protocol, int kern)
 {
 	struct sock *sk;
 	int ret;
@@ -557,7 +554,7 @@ lorawan_creat(struct net *net, struct socket *sock, int protocol, int kern)
 		ret = sk->sk_prot->hash(sk);
 		if (ret) {
 			sk_common_release(sk);
-			goto lorawan_creat_end;
+			goto lrw_create_end;
 		}
 	}
 
@@ -567,14 +564,14 @@ lorawan_creat(struct net *net, struct socket *sock, int protocol, int kern)
 			sk_common_release(sk);
 	}
 
-lorawan_creat_end:
+lrw_create_end:
 	return ret;
 }
 
 static const struct net_proto_family lorawan_family_ops = {
 	.owner		= THIS_MODULE,
 	.family		= PF_LORAWAN,
-	.create		= lorawan_creat,
+	.create		= lrw_create,
 };
 
 static int
@@ -617,29 +614,29 @@ lrw_dgram_deliver(struct net_device *ndev, struct sk_buff *skb)
 }
 
 static int
-lorawan_rcv(struct sk_buff *skb, struct net_device *ndev,
+lrw_rcv(struct sk_buff *skb, struct net_device *ndev,
 	    struct packet_type *pt, struct net_device *orig_ndev)
 {
 	if (!netif_running(ndev))
-		goto lorawan_rcv_drop;
+		goto lrw_rcv_drop;
 
 	if (!net_eq(dev_net(ndev), &init_net))
-		goto lorawan_rcv_drop;
+		goto lrw_rcv_drop;
 
 	if (ndev->type != ARPHRD_LORAWAN)
-		goto lorawan_rcv_drop;
+		goto lrw_rcv_drop;
 
 	if (skb->pkt_type != PACKET_OTHERHOST)
 		return lrw_dgram_deliver(ndev, skb);
 
-lorawan_rcv_drop:
+lrw_rcv_drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
 }
 
 static struct packet_type lorawan_packet_type = {
 	.type		= htons(ETH_P_LORAWAN),
-	.func		= lorawan_rcv,
+	.func		= lrw_rcv,
 };
 
 static int __init
@@ -665,7 +662,7 @@ lrw_sock_init(void)
 	proto_unregister(&lrw_dgram_prot);
 
 lrw_sock_init_end:
-	return 0;
+	return ret;
 }
 
 static void __exit
@@ -680,7 +677,7 @@ lrw_sock_exit(void)
 module_init(lrw_sock_init);
 module_exit(lrw_sock_exit);
 
-MODULE_AUTHOR("Jian-Hong Pan, <starnight@g.ncu.edu.tw>");
-MODULE_DESCRIPTION("LoRaWAN socket kernel module");
+MODULE_AUTHOR("Jian-Hong Pan <starnight@g.ncu.edu.tw>");
+MODULE_DESCRIPTION("LoRaWAN socket protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NETPROTO(PF_LORAWAN);
-- 
2.20.1

