Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B5C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C099720855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIVhll2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBJXkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46641 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so14585536otm.13;
        Sun, 10 Feb 2019 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWVdHii8ckcvI1Css/ppCdD5B7yTXb8aPWmds2fbqAc=;
        b=UIVhll2JY7NyNcFWY+FaVozzgAko5FkXAbOhZC4y4yEQa0Unnqa9tDmWlBkbhBDTkb
         LAk5v+zCfJZbeLAaUEEdhmn+uSPpBDc05yKkrAkWFJZ/soU/KFUJZcvgJ5ykZIZBCTGp
         54Cdhv1F+GZtRhfaPMSWce/4ps2jtAnrfh9VTXbUphGoZP/qnNDEbD/+rfd/UsWGGl+k
         aN17JYDTkA/mybijkjcTes+d6pRkw/ltA6pJ/4qoAshsUEyQ3zazwEQe1pwwqcYJGcOF
         pnxyD7eTEnSxN2kGpln6T66fP0yfpFX/yQt4HcuEFxUnwL8T6L/2aspcnFA9LidTVAel
         kWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWVdHii8ckcvI1Css/ppCdD5B7yTXb8aPWmds2fbqAc=;
        b=n8VYG+a6Fpl1pb+JgnO1K6i/6JbfNsttTx2lZRhwrSkOaz26qrxrSHZ7m7o9Y3O5eK
         5ASW8Auobd/Az0pwMrpCfD1I8uSuPyNs0cihtRYaZ0mnCUTY0N5wQgPHOU81wqC65zz0
         NaAaVzBNj9k0cDXiIwRt31ICDZBOdoXdcMcz9yd+LX0ma4hVUTE9tYlD8SKN5nxzZdD+
         IouRSH6NU3/eyKphDiPyy66HVJm+LfQ0ERFJDJJp65X24TGsOH5ldKQKN6m2M5aZWCo0
         lm0g8b/ZQFG/bFmXsudevZtDh8bfGwdlaG6ZepqU1+V2J42MmOAyPK04rfk7W5arSoch
         S1qw==
X-Gm-Message-State: AHQUAuZqlcYiqbb4pYfFWvdnYoJY6cuPniqNdrjgOSda34PX8rroIyQP
        Vc6kvd6oaGWdSFWRAO+bpGFZoqtz
X-Google-Smtp-Source: AHgI3Iam04GhUxAqATkV8J4wYWk6iwyyDNxwNtQw69NMyPgbeQaMRB9vczd4e52g2eEaLgAa6Piq7Q==
X-Received: by 2002:a05:6830:138e:: with SMTP id d14mr6931856otq.172.1549842018113;
        Sun, 10 Feb 2019 15:40:18 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
Date:   Sun, 10 Feb 2019 15:40:00 -0800
Message-Id: <20190210234007.16173-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
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

