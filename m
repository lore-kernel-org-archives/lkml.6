Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CBC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1ED21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGHRTrlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfBIAda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBIAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so2449899pfi.2;
        Fri, 08 Feb 2019 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrfBV6sMfKn5kftN7j9UYGK0gm1FsB0zr8/yiSFRNK8=;
        b=rGHRTrlUuKJbkPSNg+GmzA527l10JLzlMKa7WYVso+1dpglnGx3fCMH4Nxlr1q8q25
         byp/loWueYScC7XukBSJ+wlvh63tLUo+GLHN7dAEaP9tFDejX12zOPBqk0Xge6p7UUXb
         tuHK2Q380fFi4xHkJpRqNlIPCr4CszWQgr3QHUL9YnBa4sj8SZj4qy8ovJj0j5+XSgDa
         Z4JbbVeW0P5UWDkN+y9MbsVJsZZAiSqnd5+BpzNPJATeUMVOeARauAYM+hdp24moILNb
         opHFqcW6t5GDZ4NbbPGfOT5ZH1HnsHD9SYzIgN3yBkT0pAkBfGW8w7RSg/oM5AfN+kSH
         UQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrfBV6sMfKn5kftN7j9UYGK0gm1FsB0zr8/yiSFRNK8=;
        b=qvGuY+p41r4vcJm53Enqu1bB2U7kY7gKqU5uPzpn/1SxTvY3IW9Mp4hddskhScCfOj
         NVj3N+3pWOcyutkjMDUskAybrZ05WpOL67pawIRVNPOaTGUYeSD+8/5O+lIwQoE73Z1Z
         BKBUU/t+PbpHzGvT2OiWEtq4FZcMbY4CdOAvk5tnG9zdsjxVVDvg9Ni/eu9u76rC2AE6
         bZVM3/4tx98l/HjbMOTGpFnVdheXW3jF7LhzM3LxjWkczfk5x+PLhGUjSsgknFgY5bq1
         sTveUNjQnPid6h8HuzCaAeryVCS5Zoeo4jijco8KC60BqmHr3ktHeUPSYmfx3gvNrMFA
         BGow==
X-Gm-Message-State: AHQUAuYJu9oEAqtOgRkk21UmlqlSW9UIqWwxs0yIusIQNvWiGRccQ8lF
        +3NHHBssFmiL9WjIOPnnPu72oL+y
X-Google-Smtp-Source: AHgI3IY1wuMTxQBkyiirTMYdHhUAplOL8f9UOJlzif+8npwyasKkhIgpEl4uMm0AXTh/+E2rxJfOcA==
X-Received: by 2002:a63:6704:: with SMTP id b4mr23208648pgc.100.1549672405257;
        Fri, 08 Feb 2019 16:33:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 04/16] net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Fri,  8 Feb 2019 16:32:36 -0800
Message-Id: <20190209003248.31088-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
add support for a function that processes the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute and returns not supported
for any flag set, since DSA does not currently support toggling those
bridge port attributes (yet).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa_priv.h |  3 +++
 net/dsa/port.c     | 10 ++++++++++
 net/dsa/slave.c    |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..97594f0b6efb 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..2ce3752203cf 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,16 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans)
+{
+	if (brport_flags)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 70395a0ae52e..212fc1cc27fc 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -292,6 +292,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

