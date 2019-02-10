Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27FC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382E020874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji9es3ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfBJRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:54:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41872 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBJRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so13892949otk.8;
        Sun, 10 Feb 2019 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHCeq/zNU8Vz6vIUbaa4+CfDxZLSbpk+FdXHMruBdy8=;
        b=Ji9es3ngnoEFQk/V5XYuhKH9kud+ZWCCSh07BAcEfY67Vo1fFDHdSCxhdN9kuKQzcx
         osggmOvP6UvQggn1eoLoZ+oZQC383AkZ2aVEUdP2PelBIa1urYS1PJfpElQ4I/m00Gra
         zRZwLNb2BBH9Y/LnjI6fKANk0V7Us3W9tBfuDrkYBlgZ8Qo0vjGYYZnjsw5wkRIgrWQE
         GzCPDYth2p+viqkGcSg6vhyfERlcIqxXht/ge0Yt2IJ2u5/GawUKI7NjPiIq12lT8fnw
         Pfv5vl+ju5BEW0H+vLeohmFOrHrFiRBmlSsVBRZ1KJlf3Q9KotnNbwkUzcA+tMIH+V7h
         3WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHCeq/zNU8Vz6vIUbaa4+CfDxZLSbpk+FdXHMruBdy8=;
        b=HErbSNq4cJV7W+I8ay89ZFHUiIKS1hupltAjDomJvPxgcjGbgHxJ81Rszzl+XnQsid
         SH8iCIHguqDKrmWh5FN/Ic6FimNMZAIRNuiTJRudYTlk5iwN+NkUD88h/1cq28dH687h
         3RKgivTRbsSYLphHcPN/uPUfFNp+Ue4CV8egIBi37HG1RS/Anw+9TDY+SOILJDu23Me4
         xqUwBbQsy/jsZx1WyDw5MtIVz2Yorgqm1IcHO6F0GaGfCbn83UE5bvJ+GAIDB5isjCt7
         RQZ4ydhDACfO2NvwssGE5MQhFoYFzZ1iD6m+D+vr/Pyg3RnslT6lKM5E6ZKRJGe09HA5
         FwTw==
X-Gm-Message-State: AHQUAua1E0xfy0IIkQCbyaG13OILcWZb2LoYzjg/qfWnyMk2ww+ac92J
        LGttrYJqVfQFmoI7HKm14CVcWdwi
X-Google-Smtp-Source: AHgI3IZOE9L0HosyaPIzwxemT5iDZHDB3MU3Xdb6W2uqaiam/1+N3pBOc8gwtohbN4R6jyyhhEMA9w==
X-Received: by 2002:a9d:6143:: with SMTP id c3mr24707297otk.227.1549821215346;
        Sun, 10 Feb 2019 09:53:35 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 11/16] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:51:00 -0800
Message-Id: <20190210175105.31629-12-f.fainelli@gmail.com>
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

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
dsa_slave_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d8eb33979368..ee4b94c5e68e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1547,6 +1547,20 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+				      port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1559,6 +1573,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

