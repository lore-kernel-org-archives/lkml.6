Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EBEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71721222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahoaNyqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404851AbfBPE4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35246 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbfBPE4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so20225988otm.2;
        Fri, 15 Feb 2019 20:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fkZ8Pbunho/ROChBNcoRtJbkTRL9WKmA1WtJKIo9O4=;
        b=ahoaNyqhdWq5zT6UXmmAu7audKOPLLdh29zLeLuaCPcvb92C213qlB9ba0nR9FOQZm
         oabUHCgWTb9FHDdsn1U7Mj+QHRCr8ujGF9sM7iinBJvmQD4lQqQ3ywuEdbX+UgjQeiEx
         2DMflfz360cqvF1F18DDXkzErMF8QblEKDEhE8BvfVEKuiWoJA4RPvzA9ZZ7WE9pAx3y
         qzqKnnThLvw0s2rz7IfN9X/z9n/xxK1Ye0ZM9DGSHS7rDoTOvo0qC0pNpMYdpninX4nb
         SGZbnxvmrKrCdbiFG+/W88rhWID8hmgjYZB2JhOLJDMDPQkWuiRQrBj6E7Ez7TyD5NiR
         nmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fkZ8Pbunho/ROChBNcoRtJbkTRL9WKmA1WtJKIo9O4=;
        b=tqWoKlXz1hqBgU+d0HRXD6eCvh0vG8kTkV2Av+Oe9XLdYsxX8t/g13tQNeofQt2Qlm
         QD8gQ0ElrhuxYPWNLyHQ/bk1TXQWgKZNmsGvHcmHWBVT+ldeYTetITcK77oLCaGACcPz
         aH1AL2kkrCWPfARpY56zPeq1n7qqrb9lmCnylJSFQB4rQ2mHfts489wDyQ31wiHT1HdD
         a062zd646FbsmN6aLdyXgcROxUdlW8Sg2CUwAUaae0gx5J/xafnjs1JMzymgl01uulbS
         NGDwP7OsvXHI3s4GIwgkz3ytOiVjgEjRnVSGMtMqkJQMsovKw7WNtFOn5Wz6y9cQRX7R
         Aq8A==
X-Gm-Message-State: AHQUAubjrRM0XCBxQQutEz+1ch5PwNI+uzAkEyjCaoF3z9ffZa9/BEwL
        lLSff+sD4tQuNyWXoc/qJFG+k1z+
X-Google-Smtp-Source: AHgI3IY/eN9TT4i4imrq4jRrUw7QzRdnG9vI4Bc2/X9VzDno7g7vLr6TYfJD8KVkor/6MpkeK/BPQQ==
X-Received: by 2002:a05:6808:24c:: with SMTP id m12mr6777539oie.174.1550292974493;
        Fri, 15 Feb 2019 20:56:14 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 6/9] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri, 15 Feb 2019 20:55:53 -0800
Message-Id: <20190216045556.3514-7-f.fainelli@gmail.com>
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

