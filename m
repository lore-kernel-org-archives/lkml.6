Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF44C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CCD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLXyW3d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CCD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIGWvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:51:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46241 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:51:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so7343432pga.13;
        Fri, 07 Sep 2018 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Tx2tzQPbs0mhzLEDntzrIfs+/Rw7FbkFH17kGuU3js=;
        b=fLXyW3d4zKOQkIFdN++YTiy03vqkJ7C86pIGpIIZSbeb83Ef1JNiDr8Ll5IfNuVtcr
         Iz2Gwjb/SOarqtW80iSpGAnWUYHEmF/aOZ5DRMaazN0xIHHB1t475GEdXOpq8Ug2bdny
         Z0y0jFGGJvuFFddy5+zU6kxruyiStuSS+dGidF4yD6G7cdXIBlaVfupSc0YH3UhNfR35
         Q4jXFChA2pP5eMxowMc3Wj10NagXFBVt5leJnerEZjeHy1CjgHUMknfsmcGfJEzoFCKs
         LuKZ8yAnU9e6+Uwubir1qQKlENddzsCGHdIyiZcuJlry6+fEF9YpKKJUR2DYps0FrE9a
         1Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Tx2tzQPbs0mhzLEDntzrIfs+/Rw7FbkFH17kGuU3js=;
        b=LUb0YjnhusYv+MbbIpP3lfrUhNsLnRi2tZq8s8cdd+r7wYIGie1IleGMCGrjVNDrJ1
         LD5fHyj5f8iDY7Am746S0TrgpdK3dFB8RvX15gwKa9IbBbwfh/w8KjPn/gYecf2OEhbv
         J+aM5/zAqKrTGZiuSMYr+s5l2FWyA2k7HfQLK+7BiU2pIqSaWKNKySP2cWnBJrTE09ai
         mHe3KtOpT7dZw7QzVst/8MdJY+DN8iUvGBBJyjOIXMEFYpQC03nbNYg5NZPf39ZgMn0W
         SuJZd2+PY0zfOaQY1qDQvjePVHL9i1Ex/lRcOb5pY3C8k6dron8dGAKXynPqTGBYA4Kt
         7ZNA==
X-Gm-Message-State: APzg51Ae5NJ22WSGZmSWWbWlV/+a0+tjlYCPLtUBfP4aN0dzdAtHQ60s
        YJY6UJpfxJgwMIzReLk9610gImro
X-Google-Smtp-Source: ANB0VdYakElWYvaPfZjs8OCn3/02V99hVpbiB0At665l3w3ez5i5xPfYUAkLBY90wxH3d/GlD71bXw==
X-Received: by 2002:a62:3703:: with SMTP id e3-v6mr9843108pfa.117.1536343752808;
        Fri, 07 Sep 2018 11:09:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d9-v6sm12882290pfb.86.2018.09.07.11.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:09:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: Expose tagging protocol to user-space
Date:   Fri,  7 Sep 2018 11:09:02 -0700
Message-Id: <20180907180908.3223-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way for user-space to know what a given DSA network device's
tagging protocol is. Expose this information through a dsa/tagging
attribute which reflects the tagging protocol currently in use.

This is helpful for configuration (e.g: none behaves dramatically
different wrt. bridges) as well as for packet capture tools when there
is not a proper Ethernet type available.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-net-dsa |  7 +++
 net/dsa/dsa.c                                 | 43 +++++++++++++++++++
 net/dsa/dsa_priv.h                            |  1 +
 net/dsa/slave.c                               | 28 ++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-dsa

diff --git a/Documentation/ABI/testing/sysfs-class-net-dsa b/Documentation/ABI/testing/sysfs-class-net-dsa
new file mode 100644
index 000000000000..f240221e071e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-dsa
@@ -0,0 +1,7 @@
+What:		/sys/class/net/<iface>/tagging
+Date:		August 2018
+KernelVersion:	4.20
+Contact:	netdev@vger.kernel.org
+Description:
+		String indicating the type of tagging protocol used by the
+		DSA slave network device.
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 9f3209ff7ffd..45f70859f550 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -70,6 +70,49 @@ const struct dsa_device_ops *dsa_device_ops[DSA_TAG_LAST] = {
 	[DSA_TAG_PROTO_NONE] = &none_ops,
 };
 
+const char *dsa_tag_protocol_to_str(const struct dsa_device_ops *ops)
+{
+	const char *protocol_name[DSA_TAG_LAST] = {
+#ifdef CONFIG_NET_DSA_TAG_BRCM
+		[DSA_TAG_PROTO_BRCM] = "brcm",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_BRCM_PREPEND
+		[DSA_TAG_PROTO_BRCM_PREPEND] = "brcm-prepend",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_DSA
+		[DSA_TAG_PROTO_DSA] = "dsa",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_EDSA
+		[DSA_TAG_PROTO_EDSA] = "edsa",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_KSZ
+		[DSA_TAG_PROTO_KSZ] = "ksz",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_LAN9303
+		[DSA_TAG_PROTO_LAN9303] = "lan9303",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_MTK
+		[DSA_TAG_PROTO_MTK] = "mtk",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_QCA
+		[DSA_TAG_PROTO_QCA] = "qca",
+#endif
+#ifdef CONFIG_NET_DSA_TAG_TRAILER
+		[DSA_TAG_PROTO_TRAILER] = "trailer",
+#endif
+		[DSA_TAG_PROTO_NONE] = "none",
+	};
+	unsigned int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(protocol_name) != DSA_TAG_LAST);
+
+	for (i = 0; i < ARRAY_SIZE(dsa_device_ops); i++)
+		if (ops == dsa_device_ops[i])
+			return protocol_name[i];
+
+	return protocol_name[DSA_TAG_PROTO_NONE];
+};
+
 const struct dsa_device_ops *dsa_resolve_tag_protocol(int tag_protocol)
 {
 	const struct dsa_device_ops *ops;
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 3964c6f7a7c0..2868b5bb7e7d 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -86,6 +86,7 @@ struct dsa_slave_priv {
 /* dsa.c */
 const struct dsa_device_ops *dsa_resolve_tag_protocol(int tag_protocol);
 bool dsa_schedule_work(struct work_struct *work);
+const char *dsa_tag_protocol_to_str(const struct dsa_device_ops *ops);
 
 /* legacy.c */
 #if IS_ENABLED(CONFIG_NET_DSA_LEGACY)
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 1c45c1d6d241..3f840b6eea69 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1058,6 +1058,27 @@ static struct device_type dsa_type = {
 	.name	= "dsa",
 };
 
+static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
+			    char *buf)
+{
+	struct net_device *dev = to_net_dev(d);
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+
+	return sprintf(buf, "%s\n",
+		       dsa_tag_protocol_to_str(dp->cpu_dp->tag_ops));
+}
+static DEVICE_ATTR_RO(tagging);
+
+static struct attribute *dsa_slave_attrs[] = {
+	&dev_attr_tagging.attr,
+	NULL
+};
+
+static const struct attribute_group dsa_group = {
+	.name	= "dsa",
+	.attrs	= dsa_slave_attrs,
+};
+
 static void dsa_slave_phylink_validate(struct net_device *dev,
 				       unsigned long *supported,
 				       struct phylink_link_state *state)
@@ -1353,8 +1374,14 @@ int dsa_slave_create(struct dsa_port *port)
 		goto out_phy;
 	}
 
+	ret = sysfs_create_group(&slave_dev->dev.kobj, &dsa_group);
+	if (ret)
+		goto out_unreg;
+
 	return 0;
 
+out_unreg:
+	unregister_netdev(slave_dev);
 out_phy:
 	rtnl_lock();
 	phylink_disconnect_phy(p->dp->pl);
@@ -1378,6 +1405,7 @@ void dsa_slave_destroy(struct net_device *slave_dev)
 	rtnl_unlock();
 
 	dsa_slave_notify(slave_dev, DSA_PORT_UNREGISTER);
+	sysfs_remove_group(&slave_dev->dev.kobj, &dsa_group);
 	unregister_netdev(slave_dev);
 	phylink_destroy(dp->pl);
 	free_percpu(p->stats64);
-- 
2.17.1

