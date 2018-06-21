Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D57721EA4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddIpZeRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D57721EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFUUO6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:14:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35644 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbeFUUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:14:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id l8-v6so4447969wrr.2;
        Thu, 21 Jun 2018 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PBJi5chp3HZzw5kkLKHlKCBDe5LsJc9Lk7cWakQM+Uc=;
        b=ddIpZeRccOMiiKGlwy/00tO4UnBlZYaBk1i7ZlgEKakiRkplbpjCC0+k+l2VrPnDIL
         CfSF2AU4YzzHLrnZiZIhQsGMe8LxbITzbZJnqGvAppFomDXGYn5Rm9YoXtcb6Kv5DHnA
         k+lch0MmFzOClMzqT0FmImfFxAeKiDyFeR40rMRzNau6Q5aqmdNOo0F4finASRN14bY2
         R7B09W2VZJk8yz2I6661X8yw63+N62fhVWtoei6QV0w+YnvCY8Dv6XN9GfyCZgBpe/vQ
         etS2lIKiUvLMQzHr1BdBFmKhUkEfNhFzT1OiaLYDCPWmeKmFCpTBrJhMOoy7KxnMoIxo
         q78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PBJi5chp3HZzw5kkLKHlKCBDe5LsJc9Lk7cWakQM+Uc=;
        b=FPFgIIbeYRJGEV0hn5QlHoqqVddlRMMkvUxjiLgdhfiTrETPy9LPsxQbLpE1cPzfDG
         vNIRYUaniJrcu2pf7ORCE4nOrlW7NyvBZJIhdRwB6K7TloqfZMgNdKcwZq2YKwkPY2V/
         S9NFPlUdhnobujy1NVwXTT7lwghUg/BpHaJPVDHQIrkRjQPMjOJv6gufhYzB7GPN4eer
         se/r0NDEYqSwQBcqLfz054wMy6iANTXvIrt0/2Qvms8nMwzwUA4RzlMsM34pkgnIDTzn
         HoBQMpWJsukxFlR1njg7TyV1i6nXD0lQ/vSQHAdbxRiuWNcl9q/fh+o+j7IBuEGq25YP
         CvDg==
X-Gm-Message-State: APt69E33h+7S18WN0MACsxLFYZiiJIt5fOqu0KsxTAt9cZlBEJz+DMyt
        JmGjIo9Xxl0q9xGHXKzXTkww6JI=
X-Google-Smtp-Source: ADUXVKLMuz2bPjQrsSwpqBTfVip26/HNrMvx6UdYkNAfq7l64Dyi1j09yxzUd0PASODoxbexDxiX9Q==
X-Received: by 2002:adf:f546:: with SMTP id j6-v6mr21779774wrp.241.1529612092687;
        Thu, 21 Jun 2018 13:14:52 -0700 (PDT)
Received: from localhost.Home ([2a02:c7d:9bd5:a300:d0b3:e272:20b0:ca8a])
        by smtp.gmail.com with ESMTPSA id n18-v6sm8950136wrj.58.2018.06.21.13.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 13:14:52 -0700 (PDT)
From:   Garry McNulty <garrmcnu@gmail.com>
To:     netdev@vger.kernel.org
Cc:     stephen@networkplumber.org, davem@davemloft.net, jiri@resnulli.us,
        nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Garry McNulty <garrmcnu@gmail.com>
Subject: [PATCH] net: bridge: fix potential null pointer dereference on return from br_port_get_rtnl()
Date:   Thu, 21 Jun 2018 21:14:27 +0100
Message-Id: <20180621201427.4961-1-garrmcnu@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

br_port_get_rtnl() can return NULL if the network device is not a bridge
port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
br_port_fill_slave_info() callbacks dereference this pointer without
checking. Currently this is not a problem because slave devices always
set this flag. Add null check in case these conditions ever change.

Detected by CoverityScan, CID 1339613 ("Dereference null return value")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 net/bridge/br_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 9f5eb05b0373..b3ad135b7157 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -947,13 +947,14 @@ static int br_port_slave_changelink(struct net_device *brdev,
 				    struct netlink_ext_ack *extack)
 {
 	struct net_bridge *br = netdev_priv(brdev);
+	struct net_bridge_port *p = br_port_get_rtnl(dev);
 	int ret;
 
-	if (!data)
+	if (!data || !p)
 		return 0;
 
 	spin_lock_bh(&br->lock);
-	ret = br_setport(br_port_get_rtnl(dev), data);
+	ret = br_setport(p, data);
 	spin_unlock_bh(&br->lock);
 
 	return ret;
@@ -963,7 +964,9 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
 				   const struct net_device *brdev,
 				   const struct net_device *dev)
 {
-	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
+	struct net_bridge_port *p = br_port_get_rtnl(dev);
+
+	return p ? br_port_fill_attrs(skb, p) : -EINVAL;
 }
 
 static size_t br_port_get_slave_size(const struct net_device *brdev,
-- 
2.14.4

