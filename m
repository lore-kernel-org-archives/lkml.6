Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B8D20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXcOXwYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfBUA6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47031 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id o6so13182978pls.13;
        Wed, 20 Feb 2019 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZxdWd5BQlnzdNHuRiN/vDhYfkVgZqkkTonly3+6XNg=;
        b=bXcOXwYtbhyqPtx2gy03bNk8/8R7tM/L1iu2dyH+wXVFAhsCx6o0VQ1qc/dSnhZ+38
         LQEUYG6vjjvIqpgCAYzdT3oLXkWrPf06Sr6v5NqzygTmK3yZKXPeXcxlA0PcLsLmn3x4
         iF9LuC9X1R95bA5ONPpwcqwQy/R8pHoRkVCynAqs7IxhYNy1jDZdEnwXU8D7P/7IGFdO
         RYqv5J+4irDAO3u4mPb2YGAKDOKHpBKMw8fbn99v5eQ5kY7tDwq9Ro6sVwKX4T8ya9l6
         OFZvDWpclJ3ByYNXXTeSSFPmiXmF6hzDUeuYT9gFMlmdg19h17zvgxAqsnYhgChJB99P
         R2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZxdWd5BQlnzdNHuRiN/vDhYfkVgZqkkTonly3+6XNg=;
        b=m3T7UeARCwgVGEQ3Z/j1nS1UlJBxtZFz4lCHhAdck32FNlkbFiEIg2PvQPK+G7cfSV
         G+eoWDQOdz1oJSqnU3OabhfXL9KOGFeop0A3eb0RKgkR/adBQ8RzzmwgtcGYR+Gke1G5
         6lULwbD75lekHNLY2m27HOpGoGzx8Me7D9UXP5uC3FzsjxDi0msL3UJXqt3A+201FfOH
         r0/vv7HII64OemM7OANXlqZz8zxQvgGAE+o7ZnABu5640sPCkxft7ABaDW6+KlqM16Mo
         XSfcHcBREanbLWt1QwZb2t4QODk63va1Crzc3ekYx7OadyF+UdU4chRPhx7J8Ky1lZbH
         pCBA==
X-Gm-Message-State: AHQUAubdUNGQq8FqSjY1UfXeQBhlocgXRP7PcKmvMnoi7/ka53OmW+Sz
        uXn2iukYllqEef5QsKaSGTdPCYl+
X-Google-Smtp-Source: AHgI3IZcUm/MP/oVvhlrZ3ifzJBKZ9lhu5uorDdW9K5wkkk0bSejwctch4Jzkx+eo9nN3lbhGC5R3w==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr22432913pls.27.1550710727459;
        Wed, 20 Feb 2019 16:58:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 3/8] staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
Date:   Wed, 20 Feb 2019 16:58:21 -0800
Message-Id: <20190221005826.26317-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
handle the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute and check
that the bridge port flags being configured are supported.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..331625137717 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -666,6 +666,16 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 	return ethsw_port_set_stp_state(port_priv, state);
 }
 
+static int port_attr_br_flags_pre_set(struct net_device *netdev,
+				      struct switchdev_trans *trans,
+				      unsigned long flags)
+{
+	if (flags & ~(BR_LEARNING | BR_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
 				  unsigned long flags)
@@ -698,6 +708,10 @@ static int swdev_port_attr_set(struct net_device *netdev,
 		err = port_attr_stp_state_set(netdev, trans,
 					      attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = port_attr_br_flags_pre_set(netdev, trans,
+						 attr->u.brport_flags);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = port_attr_br_flags_set(netdev, trans,
 					     attr->u.brport_flags);
-- 
2.17.1

