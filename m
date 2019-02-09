Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E80C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD620821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3p0JEGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfBIAeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so2449560pfe.1;
        Fri, 08 Feb 2019 16:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gC6qN8gW7l0/Xih4ramw9jRenVphqEEw7U5/9M1CtJo=;
        b=Z3p0JEGJ0tuQHURCXiZ/p8OP8gu/dORp5dMLVmKBAvRQdD0BBKtQ4ANFa23yEJ6snN
         1F+4EdDVm+VdWMSzuQekgQASBRStCBbZIBkzvCNwyZcxWIOxU7QAsuvARpPlN69dAhaY
         GJtVBklZ9I4YJ9aomca0qQtgkTtlQ4KqvFAu+0HHQDaEOGiEPBbuhggtnpECezB8rqtK
         iOUBktk03PHLKMThdzU6sMM9/Mjg0jYWxPfA/rWhtRhT9m2F1ibpJxGQFwPHzZcXHyA5
         ZpG+UjW2bnWM6Uzb9JN8KRuJ0oRXrsLWS7bEBD9WaO78739BRuGzxHaiyQ0HGldstZ8G
         OJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gC6qN8gW7l0/Xih4ramw9jRenVphqEEw7U5/9M1CtJo=;
        b=U4a96vE9bIC+ahKi57JATViFKqngrL8fvOHXC03qhTp6Z9ebKGyF0x09Yh69Ydnfec
         vvAkxPBc4FdMGmUKVevznMnwdJtAiTmPirM66fCfOEg5SVy97ETazoJMh9Ktmv7UAC05
         AuhRhMxTd3sjVdq2YpKvYbh3+mm9hILf79Y3c+EwVMan1Gt0vGaAQbRXYQg+GhtGuQwd
         o+Y+7xT56WfR3A+2aIF35rDuzK0liUSQc6Rn4ivNcJQQc0S/gDSI9Mo5RdvyPBCLZDtL
         NIpNPB4yjB6IWsou60PC9Y85UlVcVKe7EMjcKt692vbgv7m57Cb+YPgIqQlBWoK+kAsN
         G7PA==
X-Gm-Message-State: AHQUAuYHH9N12JVPmBfqwJCpFOT0Wy3/uKlHmBzEl1CnnPjKV08ol2YG
        vrjCsvXchlhm96Xp1XMqqdXYbnT+
X-Google-Smtp-Source: AHgI3Iahjnmv+YZ2sdiIuUGtSspGoNTWyHpVd0Lek6K7NRWyMTQ8u1QwKhuQdk7gywcHFVs7j9BACg==
X-Received: by 2002:a62:9305:: with SMTP id b5mr24736803pfe.10.1549672436513;
        Fri, 08 Feb 2019 16:33:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 11/16] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:43 -0800
Message-Id: <20190209003248.31088-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
dsa_slave_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ae34be949d79..f8c7c1b2cd2f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1544,6 +1544,24 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+					      port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1556,6 +1574,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

