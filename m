Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1373DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687D222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5UbIQ13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404953AbfBPE5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:57:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39170 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfBPE4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so20165516otl.6;
        Fri, 15 Feb 2019 20:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wimd3qSTtcutL9MgW1a48UHpmMTASo5reWM4eIi7Glc=;
        b=k5UbIQ13VqZ3BL2ym1HzyqN8gelLKnUG1ahX+KmacsaMxbdj+Wahazyx1y2S56kpG/
         VPxkISx+s2VkfDcg4FBfIzEcQI5MDP8pmE9av23YaK9fn/GxW/zN9ag7pKHEvpmaNe49
         FLHsS1EhLorSo1ZFkoqd3BH3t6YW2nUPEf+CSHj0pWUHYAQGs3YwaGWO6j5vhLt6Hntq
         /5Uyvkp9tgV5ujbv9bqZvFDtPRGhqPNUSy1/F3MjAL5Mc7VaFZdiVxrxnFwK2vy9aedA
         9L8f/fDrqET1lEtQlKx56ZMh70qefIQDh1X1eNkpAYd3Sr2Cd0hEE0F0QCvYs9gm9Ft+
         FvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wimd3qSTtcutL9MgW1a48UHpmMTASo5reWM4eIi7Glc=;
        b=fp31/5siBaCsb/pSdpGJveIl/KCY7UzBZKHDDWUp/MSSTYmoIjWHfneen+POAzj2Yg
         TtpvzQRO714nYaHhMGiBiSMd+fvY8MMCCLBtMx9Xd/KBCiq8LOvG7Nimr6qHjiBU9CLi
         rFMCNWzniwIF9labzO4duM3tJP2BQoKZR7Bw4n+ZcLAVx4IFxLTF0xmfuO9dv/BIMqd/
         kYs31CBddJpfP1jxUf05HfhnjwTHzWDaAsUzmeDRt5qC8Rsqt98HtKghz/gENydBSPPw
         7YEIHU9fX9+5e1ahoM+2CTzOLxDDuNc1F9FJt5YwuPUu501RWd2NCZuVOyLWwaWMX9U2
         yCDQ==
X-Gm-Message-State: AHQUAubwjTJxqWs55t2pFsOW8g+FHaBM8dERxwaWG1wB2VBj2fohHgg4
        JYCtJsbinLdfOC/x5UJu32yokaYM
X-Google-Smtp-Source: AHgI3IbN5K6rg8C4KXh23U9xpdfLnDucm9nfyRIgk0JlsRf8jZk9O2zryzBM7V8c3BP+WXNRVio0YQ==
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr7678341otp.351.1550292968888;
        Fri, 15 Feb 2019 20:56:08 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 3/9] rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri, 15 Feb 2019 20:55:50 -0800
Message-Id: <20190216045556.3514-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
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

