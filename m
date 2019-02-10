Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F61C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1593C2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbh1qNuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBJXku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35162 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBJXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so10642705otm.2;
        Sun, 10 Feb 2019 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+qa45j97TVXUzWcSqT4ciJ6lwUcGt6+aO3V+0751xI=;
        b=qbh1qNujKyGmbNz+1T9Nr6c9HSQkjUaarSeCf/9YLVdDqinl/qBWvJjo2sNIkOEPkZ
         uvBRvnjFH4RLzhEtJ2ikcxVmdQPf71HM2T7XZbnE9ATdvYHY8QOsMDd3sSA+TYr95XpH
         /LiIo+jWgR/tLt8FffOqyK18qxBGk/g+BHqy2jPRGNKyfzHrVhxg5YjKLFYQE0z9+Q3h
         TKuvAwVBIhq91CRQsQlQw8fbDmM7P1Sx738dKVtmDcfGYf1H2SpW2ylFQV0kpWeVJJ17
         IPoxnKGxcBr2JwDElcobZ7+yZeC+lJBOwDkL0plplNAb0yt31wdU2ymwVNhvYAuNjxKe
         OUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+qa45j97TVXUzWcSqT4ciJ6lwUcGt6+aO3V+0751xI=;
        b=hmGeTEQC0+ZZ/A5iOI3UHU7PQ+Sfc553Ay80eGfqLhe3GJqZdkaURsig7s6z5fQhp4
         rl2LpXz9gTqwHJwOKFQZ2MhcWjDvE1A6qD9F1Ic5hGlnLcuOJ3+p9h1UmE648PGq5LGE
         GeudNyA8hGNbzptR92Y4eaGst/f2clHfabWczSq/OOtXoFJ73qv94qIdNrBvf8yo48PS
         YphrtXVoL6YRT2E0d1DvmVcVBpGfVVkobH8Rd3OqzjcnNtCcXB3cooQIkPbjSg7YZjcb
         /YUDZxLx7F029pK4s0KmR9xBNHypR867f8KuwypSSk7vIewlpTZ3pyGLQVwiJt4CpY2P
         9AAg==
X-Gm-Message-State: AHQUAuYQxLuH2iQR1m5KWeGLS1JtcjfauxJ5xEubIAebZMXnr12xmf7+
        BEtrDMkqs9WsHGUcumKKtwMNBZ9L
X-Google-Smtp-Source: AHgI3IZ2sCQtMYA2mmii2TFKIpLA97gLXWkojCfDJ4KF3oZ2drFU95/t0+DxS3mm/3z8Nmo7k7g2JA==
X-Received: by 2002:a9d:46b:: with SMTP id 98mr25266588otc.339.1549842027366;
        Sun, 10 Feb 2019 15:40:27 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 7/9] net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Sun, 10 Feb 2019 15:40:05 -0800
Message-Id: <20190210234007.16173-8-f.fainelli@gmail.com>
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

