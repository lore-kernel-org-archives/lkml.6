Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A3C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E720874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBK1CTtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfBJRyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:54:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44879 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBJRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id e24so13831747otp.11;
        Sun, 10 Feb 2019 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA40rPEhuXPofIQU7vYAyGMcSK0VqfBQ5xwZGHv+dPM=;
        b=NBK1CTtryHR6sFv2CVIZlk/pkEccWfogqsWQT303Jbs4aAIm5Pnu88qp2UGAPOb7C0
         w0VKUdp8uCjti8rbPCs+KRTQ2AzaqvCNMVAeYThwWoIF08Vcn6pw+PFYg8FPH2wbWBrb
         3IRjUhCNV6nvqKMoTMwiIxcWcodqO3ikHY0CtS26nw0v1/WscuARB6huJV2vHGWp8Ga3
         Z7KHdWUHkTY93tQU6FQjZ14FfBQ6LRu4+uSrj6L36dBtgsVRHXq6if5HVh9geFtVO13b
         RtRH5m/ZrXGdL13DyVbekIGsYnF3pRi1EMLK5KpRFf30Ysn6BOdKEYvZ1d5AR8TLx/XM
         cZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA40rPEhuXPofIQU7vYAyGMcSK0VqfBQ5xwZGHv+dPM=;
        b=WYya8lxyCx8O7YMXLm6Z7d4d3AAxDZjdhy3frTLgAsMYGM2rOIV4acunJksiwaZfDR
         /amreOdFvmWMLjkTeSVaZPLUI7apdnDbJDT7yKAishEBu/xDx8F1wQeMZ8k+TlBMSV7/
         NdfyHrqj7wFt3ebxp8IRUQSWuosVolH5dnDCPFUEnr/JC3R34bA07MtvWS3KHsrJVA7S
         JU/rJHHPcfjp+3TSbvhNQJlxqsanayUn2vZ5SEdsHQ/yoi8z3by0e24+CNceLeYWm136
         NZ8uB1pU+7iyRYHO/oQtcQsOGqRrXEGTB0/8yUq4Xkmdkk9PKHGxmTWywNbj3wxo/aKl
         g9Ow==
X-Gm-Message-State: AHQUAua6p89ifQNrijIZ3GO6fHoAe1PYmyiTFoGBuARZ2tSCB9Lhf2bQ
        DZhd8zumg+n7sYZ5vXEVnbvOVEsL
X-Google-Smtp-Source: AHgI3IY0foCL/qsHvtrQcEDw95JSNHYnE455k0ly5DQ/Lu+KdxP+jB6j68GQgVKbEEqx+Iegb1JYJg==
X-Received: by 2002:a9d:2c46:: with SMTP id f64mr25001914otb.192.1549821205828;
        Sun, 10 Feb 2019 09:53:25 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:25 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 06/16] net: bridge: Stop calling switchdev_port_attr_get()
Date:   Sun, 10 Feb 2019 09:50:55 -0800
Message-Id: <20190210175105.31629-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all switchdev drivers have been converted to checking the
bridge port flags during the prepare phase of the
switchdev_port_attr_set(), we can move straight to trying to set the
desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..939f300522c5 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.brport_flags = flags,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
-		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
-			(unsigned int)p->port_no, p->dev->name);
-		return -EOPNOTSUPP;
-	}
-
-	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
-	attr.flags = SWITCHDEV_F_DEFER;
-	attr.u.brport_flags = flags;
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.19.1

