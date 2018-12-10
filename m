Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsepZqgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA59320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeLJXMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:12:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34934 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:12:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so11269482ljb.2;
        Mon, 10 Dec 2018 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUkVQVVj/jbRWJc36SBKKWUFDbhEi+Pzqwit5TLxls0=;
        b=QsepZqgDnVPDyULumJO53KHW0MfKDyySgxvy7rqejng1kZBQmOwgZLNfg+t3mOa+ha
         GmSe6LoQmiuywFjnLSv83mI5RQXIZ6spuQTkcE45UfgH39ZsWK6v/qBdkNKO0mwUYi+z
         60UOK3DuHLIpxzSeq8rl/Lr61Et4/GP6B+StLEbEoTIPP80uCGDWlLCdH2S8BzuRLq7l
         MDA/DLbZ0c1jPuYWQNqOR1qBW6oxkw1g5In7StrTqX+CYLVRKkfzTm07d1JkRj47WS1g
         xUHI3JlR2VjxLJAcWkHbjTi+TPfhFV6fFxOSHtQsbf4eoiTkFPQHt+MS0a8yz2ZkE7uW
         lmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUkVQVVj/jbRWJc36SBKKWUFDbhEi+Pzqwit5TLxls0=;
        b=fM+wSiwcCiSw/YG/ryKwkmqvnIBC7MD/qkJhnn2+D9ERCuvSrnrUD52mAM8YLm3KvM
         amf/c6RgCYHH97wvY+brloAUo8dHeRIELuIN+gin5+7zLHccHxg1MDk+vWInZlwEzvKj
         PpSgLe6NI+IHN+cuHZjHmxGXOjbLkWLDvqLgkgz8jwPLYDG//sHQzJgr+i6pr9vdjqpX
         oEwzFSA77N3qBIe+2EXFvXkfV29fqqbADii3erjvHUp1c17m502B5rxpguZ7LkeJwQrr
         K2JQAojiVXSEdhi4dyPdOL5hl7nc8ZfcW0DNsgHY46I3YfYGC2UAacs9kSt4cvKYkABc
         RjCg==
X-Gm-Message-State: AA+aEWYAvdMhQOMBMDGghj7dQ8C8ugnLvVitw3FPIlk76MZPWK+VGQHC
        kYr44AXdOnYradm5JDK3Hjlvxf4jCmytiQ==
X-Google-Smtp-Source: AFSGD/VZj4vEWr7VAYzO7aGRhTTmCUwtmGMnb3Vf89i/lbcNyM0gFxNRIn2r967RPM2vH/i+rUq+Wg==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr8217629ljm.72.1544483536719;
        Mon, 10 Dec 2018 15:12:16 -0800 (PST)
Received: from localhost.localdomain (broadband-77-37-232-150.ip.moscow.rt.ru. [77.37.232.150])
        by smtp.gmail.com with ESMTPSA id s24sm2286193lfc.30.2018.12.10.15.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:12:15 -0800 (PST)
From:   Darya Litvintseva <litv.daria@gmail.com>
Cc:     alex.mikhalevich@gmail.com, litv.daria@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix braces and comments codestyle
Date:   Tue, 11 Dec 2018 02:11:39 +0300
Message-Id: <20181210231140.5280-1-litv.daria@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Darya Litvintseva <litv.daria@gmail.com>
---
 net/ethernet/eth.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index fd8faa0dfa61..3b430e245d58 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -90,9 +90,7 @@ int eth_header(struct sk_buff *skb, struct net_device *dev,
 	else
 		eth->h_proto = htons(len);
 
-	/*
-	 *      Set the source hardware address.
-	 */
+	/* Set the source hardware address.*/
 
 	if (!saddr)
 		saddr = dev->dev_addr;
@@ -103,9 +101,7 @@ int eth_header(struct sk_buff *skb, struct net_device *dev,
 		return ETH_HLEN;
 	}
 
-	/*
-	 *      Anyway, the loopback-device should never use this function...
-	 */
+	/* Anyway, the loopback-device should never use this function... */
 
 	if (dev->flags & (IFF_LOOPBACK | IFF_NOARP)) {
 		eth_zero_addr(eth->h_dest);
@@ -170,13 +166,11 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 			skb->pkt_type = PACKET_BROADCAST;
 		else
 			skb->pkt_type = PACKET_MULTICAST;
-	}
-	else if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
+	} else if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
 						   dev->dev_addr)))
 		skb->pkt_type = PACKET_OTHERHOST;
 
-	/*
-	 * Some variants of DSA tagging don't have an ethertype field
+	/* Some variants of DSA tagging don't have an ethertype field
 	 * at all, so we check here whether one of those tagging
 	 * variants has been configured on the receiving interface,
 	 * and if so, set skb->protocol without looking at the packet.
@@ -187,8 +181,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	if (likely(eth_proto_is_802_3(eth->h_proto)))
 		return eth->h_proto;
 
-	/*
-	 *      This is a magic hack to spot IPX packets. Older Novell breaks
+	/*      This is a magic hack to spot IPX packets. Older Novell breaks
 	 *      the protocol design and runs IPX over 802.3 without an 802.2 LLC
 	 *      layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
 	 *      won't work for fault tolerant netware but does for the rest.
@@ -197,8 +190,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	if (sap && *sap == 0xFFFF)
 		return htons(ETH_P_802_3);
 
-	/*
-	 *      Real 802.2 LLC
+	/* Real 802.2 LLC
 	 */
 	return htons(ETH_P_802_2);
 }
@@ -212,6 +204,7 @@ EXPORT_SYMBOL(eth_type_trans);
 int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
+
 	memcpy(haddr, eth->h_source, ETH_ALEN);
 	return ETH_ALEN;
 }
@@ -355,7 +348,7 @@ void ether_setup(struct net_device *dev)
 {
 	dev->header_ops		= &eth_header_ops;
 	dev->type		= ARPHRD_ETHER;
-	dev->hard_header_len 	= ETH_HLEN;
+	dev->hard_header_len	= ETH_HLEN;
 	dev->min_header_len	= ETH_HLEN;
 	dev->mtu		= ETH_DATA_LEN;
 	dev->min_mtu		= ETH_MIN_MTU;
-- 
2.19.1

