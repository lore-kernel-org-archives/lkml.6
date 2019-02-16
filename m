Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD09222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFGn89vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394655AbfBPE4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39174 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403987AbfBPE4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so20165646otl.6;
        Fri, 15 Feb 2019 20:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mF0clASfsS+m8euYRGx6YKoVXE9ceDzoQVGxi2l5BWo=;
        b=YFGn89vUvVsfPxvmLts9a6/QqTx599AR0R9V2aeo45jm/odT2FJDqDfbGzJtWIBqwP
         2xcuPkRlwuiisCfrKgRcrHX1EDJw3LZ1rZb4K0t65gtZwp0Ks+ssFRkcOyX5+kQaDSTX
         QUXSGUBRa2483elu9SBGwQHNxlXBIqUhmgg7ATQjOe6nGdrbCQkf8/uaHb7l9pJNED2V
         dt/S7olxRGSeL5qnSqUGPiP3dCgYodTx9APORX62qkf6zdWcTu855jj3CXkt8S+YkzZx
         Ru1adCgBJxkNsUKJL4m3ZKVz9iV/PP+roGxXEAgNPDx5q2IwdZQSCnEfQFOdW53DP5lz
         oNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mF0clASfsS+m8euYRGx6YKoVXE9ceDzoQVGxi2l5BWo=;
        b=R2Xo94jI+6WmcLlGWVj/pyj+gTl9uC9V21nFCErd/Zl+chbSH2FEg+bdXiGtpC1N41
         79u2BzMa7M6stKgxZqJwnZVAB03k3MUGKGj3Pg0GNYPit17XNnq2Et/g6ek+tARMZVrN
         FcktqXekzklFNirRVTbrUgOFD8jje3M+7vyfTq83+ZT+Ukcy4LyN8i2c69kQyEo/R9ka
         hQjQ9Xf1K5dDToEo81++41Oqbu5NbYV+CxslXR1xBBiK4MVCQYs6N9fRRPMaeIIo/abu
         c5m+7jbib7ZHk9CtgM2cnJHiX880qe52cRwWT2z8WObkikr42LuGkGaYpmJOZqpOdOoM
         0pGA==
X-Gm-Message-State: AHQUAuZpW2ykR2lcumfs8o2YR4UQwYYGgGX5ARDx2gt24KOWA13aAXk8
        JsNgkDubqA48TqdPbdAro444QvlH
X-Google-Smtp-Source: AHgI3IZs9RcYfUnCeBl7AEecpPhkSothh3fXDl2YMsUlhtf2r8Pcot8cf0WUD6b0PLJsjx0bTSyQ2Q==
X-Received: by 2002:aca:b302:: with SMTP id c2mr7463649oif.144.1550292972643;
        Fri, 15 Feb 2019 20:56:12 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 5/9] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri, 15 Feb 2019 20:55:52 -0800
Message-Id: <20190216045556.3514-6-f.fainelli@gmail.com>
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

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
ocelot_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..850a49033a30 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1618,9 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET: /* fallthrough */
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

