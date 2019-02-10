Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34A4C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A59A20874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOXyWENM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBJRyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:54:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36455 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfBJRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so13934315otk.3;
        Sun, 10 Feb 2019 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdbv4CO8BhE6pqFGehWefPsAVhnmG6B4RY3j765Q16s=;
        b=tOXyWENMOp400xQqmuZyKf+MB3GpNHvhdbkFAX2zGy4g8bh0TWEkIYy3T+nkt8jao/
         l8+ofIUKfYYEj73BxcyeIyR5dMsKLnnROi1QwRsEEy3HcCQU57ijZVl1IriMc7Wfc3mo
         FPEXAgRxJz3mQdvfa02ChFSxRnroK7aM8g3c7qMQ0XfNUsGlkwaOdLKYzNUhYoy4E5at
         qiJrc4j3eY7kdTrfK9ZjGMiAUUai9Etg7aA5PBEDZ/PjkhlTroGSfKh3DlLu+uMBOLzu
         8SCVftbaX4IW+bVk3k6AoTOuSYP4mGjZPKoVdMvQPSi7lTMg5qBrdIrNdJ68e9XmTCmO
         AprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdbv4CO8BhE6pqFGehWefPsAVhnmG6B4RY3j765Q16s=;
        b=O9v5fJlAoZFSexxegRAh8QqQdWL0Gag7khWn2Lj2CS0RO8c/ATD9Og/2pIPrBG7j+Y
         jbPB+tw2h+sQcyUq63EGSWJ1tQZZTcSJP1024UWilg7GqjUtLkd01J+FgiWhP1gWe2JB
         Z6bxpL66UB/ef1bHgYZzKuwv4yhOOJDAiPp8yBrhGLkhrfI7zszbiNK+35ujunEMqNGD
         K0p2Q36dSZn/2ogBSm9n37OFF8nfYFTDEX1NHSrYlhLkN56y8OpT/nmHEcmVIwfI1x9D
         PsyYIQBG8oY9tuAf/xHj4U7MjlXPcnj0evvpBq7RvQgMVnRcVYnD/wSOO0jhGipWc9p4
         roIg==
X-Gm-Message-State: AHQUAuYEtR3+qnWcHz6uhCRFcNNX+Q07UA0Pqf2SWrnnbEg+o9p4Ms81
        FSApuQeu7YySTP35usVgbvIboAg/
X-Google-Smtp-Source: AHgI3IaK+52ILJCn+nxlaWMncS/QTv7hBWczjfavzEAWqk8pR/Bx0VK1yqh5RWFXU2I8QD/qYWbHWA==
X-Received: by 2002:a9d:6b11:: with SMTP id g17mr23627288otp.70.1549821213472;
        Sun, 10 Feb 2019 09:53:33 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 10/16] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:50:59 -0800
Message-Id: <20190210175105.31629-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
rocker_port_attr_set call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index ff3f14504f4f..b94f940dc7b5 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2811,6 +2811,20 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+rocker_switchdev_port_attr_set_event(unsigned long event, struct net_device *netdev,
+				     struct switchdev_notifier_port_attr_info
+				     *port_attr_info)
+{
+	int err;
+
+	err = rocker_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2823,6 +2837,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

