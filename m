Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D163C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19951222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCMNWxM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbfBPE4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34754 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394617AbfBPE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so20238997oty.1;
        Fri, 15 Feb 2019 20:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWVdHii8ckcvI1Css/ppCdD5B7yTXb8aPWmds2fbqAc=;
        b=BCMNWxM5zaaINeR/+8ZVcbNv5XBD/+MqdBwzZC6Y+Y3j7uPrNsnlA7xqY2YbsizSpT
         5x/onSuYPJhbCdfs7Voc+XmulP4h3GkduZngv9lxoLFQ68fYVw/6N19J/DE+Mq+aYl1y
         M96TaWEwa9qrRJv5pSRfsuZD/fuaC1NSUPGVvSuXKpJbADC1H4e4rfncGKfL2S8Douy4
         iKTwNBipSujejKAfq3Zq/x2+u7ee/RrZUjLkdODVE7nztfZCE2trkFxFcWyGdQzEVFOY
         fwxIeHqNdAqi7BQ+588q4fI2Y5BW16KWrCFjLrMS/60pGSQPtKGkqYX0h8+5GhQsFdlZ
         k04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWVdHii8ckcvI1Css/ppCdD5B7yTXb8aPWmds2fbqAc=;
        b=mwzkitrdMdbW03hRifdo5mFXa7KxYpnHSGuqVN7GvL5OuLnZCrW3ZKqSKf6a1V/+5R
         PcwqmnBtQrfjU/gXlV4J9G7g7vd8sS0LW7a1g6oNlntvK3L1q3H7puzo9ZVRK+IRsT98
         kjFyX/BdQgTbP2Ea1GFp8r72SAPXWOMsZpDajLpJYJzgdJsHALgQAbSPT9rXe72uIkcx
         cTxqcCB/1Qi9cQqFHb+zH+WLDDu8s6ik2W9kezAJavorvYgfRbQivqrIWHWhONi/FXet
         jnZZhyKFx3YWBRZAziMsQzOACgmdKJD2n5e5UL2JfyTabwJwphrauPkMd4RvSOUsrzpv
         ZJLw==
X-Gm-Message-State: AHQUAubnDb0IkAHbRC99ChdHPrnt5yRmlfiSv+gcFFB0X+mJU4xcrLp+
        2V4QFhOb4E9yHiY3Aeul5gSeOsGJ
X-Google-Smtp-Source: AHgI3IY1/SzNVXqKo6d9T3R0icCeRwnYWlSnrYqKcqDwzRXhEma6aW/eFbGmzOpUdDJu2gIWgyE3VQ==
X-Received: by 2002:a05:6830:125a:: with SMTP id s26mr7162172otp.74.1550292967078;
        Fri, 15 Feb 2019 20:56:07 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
Date:   Fri, 15 Feb 2019 20:55:49 -0800
Message-Id: <20190216045556.3514-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..b8becabbef38 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -143,6 +143,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -165,6 +168,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.19.1

