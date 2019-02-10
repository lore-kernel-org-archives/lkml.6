Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE0C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876020855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDmhKikD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBJXk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39217 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBJXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so14663777otl.6;
        Sun, 10 Feb 2019 15:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fkZ8Pbunho/ROChBNcoRtJbkTRL9WKmA1WtJKIo9O4=;
        b=qDmhKikDDNTrsUJq3gj07F1+SEgorzAwYbmXFSZaille2smNGYGbr5ImIGdZZc6cED
         WH1B7zXuCRAWeiW3qS2j40hqhj12cQqhbuMNRbLoISs2AZheDJPsL3zBKmLRCbOzqTdN
         Fnh0QoOLfFFjl2Zy6zKaf0/8cmlNCQHV+SLbTwy+zbwZ01cDF/Ea/kGhwyk/8FrI56z9
         fI5oYUtIqlYldZuZnpZpog6L4+6EAKvcshlI+02L2zTQSgmH3WPWFbYsE1L+PsxRgGY7
         A9Zv0K7zVGW6BkPg02HSQrGqBuv9hDmfOc4WxWKx/2GRZ3Lvqn/1HDAq2BAeRumJkGZ5
         oqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fkZ8Pbunho/ROChBNcoRtJbkTRL9WKmA1WtJKIo9O4=;
        b=BzTh5fcFKs9VxiWYMBh/2n5/82kRiTDk1WrnakYjJI8MnJxPX86RecxEMt3auqgW0k
         JXAH8CeNdbtzEc5TwgwgvF7myd1zKhQ0DfJbKwh8m5Co2PP27CJ4sZFfypos+bHtXQRV
         SusVTv5YAe+pvH1LKh4qOecdT/5umjPWfL1mh/eyb8mLG4Tbb6Qg46f4oRmS2kUz1Ahk
         +YBKVijNkWFoPeNCfeXeW+n707LMp4rFCNrqsar58tgQW/8HYFyy1IpWdhklF1dzOYwh
         6kU+RfYZ/+j2IaSkFcB67VhkaZEoAiKHuLkRX7B4e29CnegPiE58yq0IymFcZT+iFK4A
         mbbQ==
X-Gm-Message-State: AHQUAuboePLnteyQuaGAtJegYOiT9rul2GGvepD++NHUuFNyWz3P7CNv
        g4aVyhIk3AGTe4kWejVRNesXkR0e
X-Google-Smtp-Source: AHgI3IZMRJhu6n/VpjYP46dQcKj5fKv8LrqxH+yZsAXE22l7T+90XMsdUs24rZGlBF/9lAWHlqh9tQ==
X-Received: by 2002:a9d:6f8e:: with SMTP id h14mr24029067otq.241.1549842025577;
        Sun, 10 Feb 2019 15:40:25 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 6/9] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Sun, 10 Feb 2019 15:40:04 -0800
Message-Id: <20190210234007.16173-7-f.fainelli@gmail.com>
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

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
swdev_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..bc9e7de07200 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1111,6 +1111,27 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = swdev_port_attr_set(netdev, port_attr_info->attr,
+					  port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = swdev_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1123,6 +1144,9 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return ethsw_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

