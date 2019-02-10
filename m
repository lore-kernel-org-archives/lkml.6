Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC09C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CFB20855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6WW505n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBJXlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:41:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40294 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfBJXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so14663357oth.7;
        Sun, 10 Feb 2019 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wimd3qSTtcutL9MgW1a48UHpmMTASo5reWM4eIi7Glc=;
        b=d6WW505n2D6Ai8v02lBLPTa42g/O5qhgRtT1+h2y+aH4CnQZCsVCQt+9DtznUuKUwL
         MrgHluxaOXpvtPbKlTPfozwlFXLvO4TDcUJPl6anYO1TaHVFx2+Q7KH0Ntduq382lKwk
         In88ioYF4P5IjElH1QneSj6DAGQDuTuQe+mOGmeD/b7/PKp50QaM3Ai8Xtb7+rwKrULn
         Pne7o6FCUKLib396WBOMzow4XdOmytHkM0zzsKP6thCrQ4sljebEZ6PMhosh3677IrTj
         gDA8nMzBlMCjKZeW062CxS0VYMjyDh7utmT4jmBb9EIZthddMpZQphlN4HZ31n9C7tg8
         ROhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wimd3qSTtcutL9MgW1a48UHpmMTASo5reWM4eIi7Glc=;
        b=qRpQrmqMSgURCCk8F0BI2Dt1I6FyTvfBMbwtyHkzrp9hjx5/tzCArHaUPXn6h3eqlZ
         PR1OGGLKyicz0UcyXWePhcMhMmTtAP1N4pSWzH/iUTayeYYcV0mMmC5XBEEOK8XlOeui
         KlID1A3jAXVGmDbWzs4DC6kZWDxCB2ny0BZegGLk10+jUXJrdmPnNZ9ns7kRUveENzaV
         M/pwN8Up7TaI5i2U5iBKioocH8IVxdCHnSfrOwIc6eIMywyzfrQU1veDgnwvYZgDSXzF
         3j/V/QOdkk9Q1EGCvjz0uKtFtEKU4kt/KX6v9MH2ZefHc28RY8vRB7L+S9HNVMdlw55u
         XjbA==
X-Gm-Message-State: AHQUAuZiSYXdKLVe+OCYukgpMEuWfnMOrWIn3ZqfOjfYNZx1PEHCa6gP
        bHGP1/2LVuH/0+PkZb1Cb/MFvcFt
X-Google-Smtp-Source: AHgI3IYa70XhLQzY7XLzR8jQJypiJhI09bYksi53PeWi8B+tCyRK6I2MBrZIFH2zH8eTjelugwSYmQ==
X-Received: by 2002:a9d:2661:: with SMTP id a88mr25550055otb.91.1549842019950;
        Sun, 10 Feb 2019 15:40:19 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 3/9] rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Sun, 10 Feb 2019 15:40:01 -0800
Message-Id: <20190210234007.16173-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
rocker_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..591008c8fa74 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2835,6 +2835,27 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
+				 struct switchdev_notifier_port_attr_info
+				 *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = rocker_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = rocker_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2847,6 +2868,9 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

