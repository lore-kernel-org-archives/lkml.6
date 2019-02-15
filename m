Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E091C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6525A218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+m6yOLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404832AbfBOWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:54:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43001 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404629AbfBOWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so5632494plp.9;
        Fri, 15 Feb 2019 14:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l46VvHT7eqrMkE6E40frKPiWzb4eR8K705HCwYquJCU=;
        b=c+m6yOLHHnoPkllcF2apu1UUUyZhWn90E9JbS6Mv0V+cXNRzwSE9dLKIcuJH4/VXMT
         sCuNtXXY3ZT+zbtftR/Si2teaR4xrzeMZ3NrYioQNXs5sECpThYXU06875Yz0dHikB3+
         BUmySfMmKKfmQ91u3/AVB50e6MPGae47/v8YRrQhU3gaDuxPFjk7te949mpPsRXhDcB4
         aPQdVPMdPjVPi+MuxlqUxmpIBjIeq2tLTeyV73wWnkeXUV7D59scLXriqB/LA7vHUItP
         mnxwR2gGk+u7EuLkVDKaPy0DVKKcu1H7MdnQCirB36USQRT/VhKZl0zKr1EeqrdYZkVl
         tDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l46VvHT7eqrMkE6E40frKPiWzb4eR8K705HCwYquJCU=;
        b=dB0tAKu8obwYeIko42VwGMJaGbBjcZNGJ+g0Z/y65WQBo059OuuXAHVgvcOsuewLI7
         6/SNXU7uvigh+EETY59GV6zcM818r2NVPd7mw6lggjUJHSHCehpeZkrtowsCGzwKsa94
         wCAIpea/gaDX4qQvOzXX7PxgRTtOVaNqP1GPP3SRC1SQfrIg2PoWz++DHcrnmB1g1KEM
         u2OiJLIhaMRBz6LU0BJf4QlvvixEdMWFIad7wZZUyZIxqUeamn3OuX/ewqz8Mgu1QTB3
         p2z8Og4X8WVAbi1Q7NAdZ39IF8IQNlt68nLWE0PvxNhSn4sZ2FhKGfAxScNJ5A12qC43
         uLUg==
X-Gm-Message-State: AHQUAuaGxvUXJnK4RwNFD7z/O+Cp9vF5fLNCJP/0tkTumt2zgp3WA+4J
        M0AP8JOXQagvB4+HJNHypWQQvpN/
X-Google-Smtp-Source: AHgI3IZ7yG9LEJ7lOWxbEjGLuFG2Z8hL9PxkGfo4i3AXlCWu8HUQnPBfO07G7fQecqAW1Pft+DMNjA==
X-Received: by 2002:a17:902:44c:: with SMTP id 70mr11360520ple.318.1550271208903;
        Fri, 15 Feb 2019 14:53:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 7/9] net: bridge: Stop calling switchdev_port_attr_get()
Date:   Fri, 15 Feb 2019 14:53:11 -0800
Message-Id: <20190215225313.32303-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all switchdev drivers have been converted to check the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
do not support accordingly, we can migrate the bridge code to try to set
that attribute first, check the results and then do the actual setting.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..af57c4a2b78a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,21 +64,19 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
+		.u.brport_flags = mask,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
+	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err == -EOPNOTSUPP)
 		return 0;
-	if (err)
-		return err;
 
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
+	if (err) {
 		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
 			(unsigned int)p->port_no, p->dev->name);
 		return -EOPNOTSUPP;
@@ -87,6 +85,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
 	attr.flags = SWITCHDEV_F_DEFER;
 	attr.u.brport_flags = flags;
+
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

