Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC252222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcFaSHh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404870AbfBPE4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37602 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404346AbfBPE4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so20175503otp.4;
        Fri, 15 Feb 2019 20:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+qa45j97TVXUzWcSqT4ciJ6lwUcGt6+aO3V+0751xI=;
        b=FcFaSHh9GTusYG+TxIBEfPP25fgaQVjrVPxE4xneUPe9kaMtoa45ca1d09nX0ZSChU
         EWLx6yStLRi052xJOtfnTNKSqZT5cZPMUAkyGjCOvC2WVbVzYGxLlqXENxDCt2bwIv6o
         1Hu/78xUt7xYcPWZGn0kCI+0x5+T6j23BVsjvtxwGkDuPdsz790atD0uHMJ23V0s8jBN
         ftlCeqrb/V+lNmTp6DW+2hYob/pIPwIbz1/M9Ksh2mFkYInAW2mfPGysazZXPEhnqzHw
         Hx8TJ1/rLzJV4qcHl6PWnc3wODy6Un9uRJHJN8ZnoxOrTSz7vrdUSHuO0zSxHPZfUfG0
         eO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+qa45j97TVXUzWcSqT4ciJ6lwUcGt6+aO3V+0751xI=;
        b=Z9r4g1Ewg7Kyfy7NCtVDNzxsRhyidJ+DuqfX0Qsl2jg5F2udjJokHs1jsuX9Qtrpjf
         +CvBJmn0I0w6mkhzttXeonKqcJKCLJo3Xb7w8Dgu9u5gh7ufDxftPjeTtdvD4WkIaaUJ
         3Wpt3VyahmSD5KHdXNmWCQfXPW07Vx/yFZNNzX30f/Gb1vPr6M3efA0GBDCSrQkwnydU
         lcr55FDikG4L3g0KjAar6a4nVUmtnnJCMUrdXiZv6pkhslVsSLAzJTJq+pOKswnRc4Dq
         R03J2pKe7n+qwM5FhvxAetVMyktZYn0BOIHOTpCMwKG9ggggITd2cT6Z6Wy9DgPXbz6C
         U4dQ==
X-Gm-Message-State: AHQUAuboy7jPxfHWTvRJDgBu9WAcDzosaOmUDa2w/lsQ1caCpD1H9YWz
        0WJyWNTZL5LnqcrC7HVFGXQVs6DZ
X-Google-Smtp-Source: AHgI3IZbDt57Dg//m55tm8qpuXwdHI+Qci1WZBGucHnjUCHMiC263dNrgrKHHTvOczI6WgHW/zgrcg==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr8099580oig.49.1550292976354;
        Fri, 15 Feb 2019 20:56:16 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 7/9] net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri, 15 Feb 2019 20:55:54 -0800
Message-Id: <20190216045556.3514-8-f.fainelli@gmail.com>
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

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
dsa_slave_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..2a14a38f5f93 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1558,6 +1558,27 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
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
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = dsa_slave_port_attr_get(netdev, port_attr_info->attr);
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
@@ -1570,6 +1591,9 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

