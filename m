Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9AC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4192173C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNJJyBLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBJRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36452 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfBJRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so13934243otk.3;
        Sun, 10 Feb 2019 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81DjCgz+iyCtT5UWtxC0sunQeOYy1ppR2RSyv4AVzCg=;
        b=CNJJyBLB2tLVddFJ2LsHHczCUzrZYJe/u6ZVOeym6EOWO1QRjP5hyihNVBivQ1uhSR
         8knwLaI67D+lt3XKeg5r/JTvmLzUPf/u9RFutmQbgYG4YU3QqO1vNA752Oh0GAy1Ye+v
         eiuSrpkdK66kPRe4DfZYKrnWjthWxulQ4/hehAQZpQgKBaFgHXoA30cd2ohrJ8GxhOYo
         TzM0gAjPOwO/CROxdjsxhsJ1fimeWoQunp0Flkbl3kdSYDfhzVsZkiQ1uJbVm2t6HpIs
         gikhmHG5EIRAhiBpkAoFGtptYr/sXsSxlL+6RjRUSYKD+lUNW4srNIECQIND8JNFSoNo
         Uu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81DjCgz+iyCtT5UWtxC0sunQeOYy1ppR2RSyv4AVzCg=;
        b=dBoRJIgK59DXL7baaITU/jwhgdnaFY7VvgQ5ubVG+emoYGu1Nmwtq4QG8kQ+87T8xR
         /VS+o5NJnP5FvVkRIDJcOzzDhbOCr4ep+4KHoHywsY7Tay5Sng3WSHSL/6B0h1DY9hIp
         T5bevipdZgy1EEwJHWoaxNv0p5TAT0weFlCncD4P8RNhwUA/vIz+z4wcACkUTJZp6N8Q
         U/BEVE6vqRaNVm17bfimFnhnHVm+RP+FxM+J1ntXf6jmRPA5CWjlhNoYC/bpD8Crgzf1
         PTNncaCcItjfqspFPGwED1CiTzv8vNHmMYnJM3f3It7qyHSwrve+makHVaVYX6lSFR5j
         BqVA==
X-Gm-Message-State: AHQUAuZdogtFcL45JujMXicvivaHcHIu9S9dgNLdsHd+gx8NkloJscpp
        os9VhqhXeIEbvH+uAQIYAyxWOxeH
X-Google-Smtp-Source: AHgI3IZUL6jmhc8slPtrF6LepLmL3NLmXatG4Q8O4c2Im2NzEN9BBoNrUtYbnj9jY0h0tzuRJoWUhg==
X-Received: by 2002:a9d:6a:: with SMTP id 97mr8181051ota.313.1549821211584;
        Sun, 10 Feb 2019 09:53:31 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:30 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 09/16] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:50:58 -0800
Message-Id: <20190210175105.31629-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
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
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 96cd3e795f7f..7bc6a004d32a 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -135,6 +135,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -163,6 +164,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.19.1

