Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60662081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ+35K7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60662081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeK2InY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:43:24 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46678 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2InY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:43:24 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so11351586ywe.13;
        Wed, 28 Nov 2018 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcREcZFLQT/C2j921gV62NNDdhrR+J2aV3MAuqaBKAo=;
        b=eZ+35K7Fi/9O12SlzjZgQ/Hp8D/fDVZFwhA44VNs5usN3Z/uvQ7JoUbx3OeMyUjZ71
         DaoH5QNwqDvOQTTm7k0swWKBeOJ2q4itwWYaxfjzrMlXnsBL/y+n6hP0o8weZXcCbEe/
         tPMZrIV09ldLxlSFK3EObLFfmAmZdPvDjfklNPjf5NbkIcBcpnWQKz2DHNS7t3rEeubC
         ReZxfaPppoItFrmcuFkyO3j1fovohhR0bM/GUkcxr1lYm7wRlzi6YAisBR8Q+t4yJbXW
         HvPa5jDkDlfHls/T+oGO5kbQNPfmUjIxAN3qEbkrf0RmfGH/jvtnBuqZwyK/2tv/V+ar
         cJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcREcZFLQT/C2j921gV62NNDdhrR+J2aV3MAuqaBKAo=;
        b=T3dkOa+d5CLRIabLIiC+5k5eqsQyKr4vhRUzNjbkOxTtI+jxFI7zH2Bhd610w3t1tB
         DFcHODNO2Sx4JAFXvLo/U9H9hLGXjLEvkHGn5/Nto75XyRH1i16qnkOLbBBdiRYP0Hpb
         DseZwWv37NcEZ49I0wzrz0SGxhm7wNd8amMra8GRQ1UTZimb7FpqVDs8zS8/HntvBdub
         7o7tAaFOJbhEmCB3KZeiU/twqmGm6O9jDcnLNVv0Xxk5HqyyH6u9wtLbWbPnPSl+0qra
         DFf5YINjRKrobk3cAxfuuJkcfJIp2zMPFIjqnUs9Jw6ZogWZUrLasbSqXh+i036AYm8+
         e2sA==
X-Gm-Message-State: AA+aEWZOdgPKQEqL3X54pZX3I+hQXdgcBBqYDpiJyvCRrW+24t7uBcbt
        YZGMv98tpwDB5OK6QvYNXkLxWh7u
X-Google-Smtp-Source: AFSGD/Wjq444xMWJKDzbPTVsaSL6jKxUZAf4Rd3tPlY13iGvMo4MnCYzUF9CLo+/Cujt4cNRpUd4WQ==
X-Received: by 2002:a81:6a04:: with SMTP id f4mr2719222ywc.485.1543441221268;
        Wed, 28 Nov 2018 13:40:21 -0800 (PST)
Received: from cox.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j65sm2118157ywf.21.2018.11.28.13.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:40:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Fix tagging attribute location
Date:   Wed, 28 Nov 2018 13:40:04 -0800
Message-Id: <20181128214012.16397-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While introducing the DSA tagging protocol attribute, it was added to the DSA
slave network devices, but those actually see untagged traffic (that is their
whole purpose). Correct this mistake by putting the tagging sysfs attribute
under the DSA master network device where this is the information that we need.

While at it, also correct the sysfs documentation mistake that missed the
"dsa/" directory component of the attribute.

Fixes: 98cdb4807123 ("net: dsa: Expose tagging protocol to user-space")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-net-dsa |  2 +-
 net/dsa/master.c                              | 34 ++++++++++++++++++-
 net/dsa/slave.c                               | 28 ---------------
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-dsa b/Documentation/ABI/testing/sysfs-class-net-dsa
index f240221e071e..985d84c585c6 100644
--- a/Documentation/ABI/testing/sysfs-class-net-dsa
+++ b/Documentation/ABI/testing/sysfs-class-net-dsa
@@ -1,4 +1,4 @@
-What:		/sys/class/net/<iface>/tagging
+What:		/sys/class/net/<iface>/dsa/tagging
 Date:		August 2018
 KernelVersion:	4.20
 Contact:	netdev@vger.kernel.org
diff --git a/net/dsa/master.c b/net/dsa/master.c
index c90ee3227dea..5e8c9bef78bd 100644
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -158,8 +158,31 @@ static void dsa_master_ethtool_teardown(struct net_device *dev)
 	cpu_dp->orig_ethtool_ops = NULL;
 }
 
+static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
+			    char *buf)
+{
+	struct net_device *dev = to_net_dev(d);
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+
+	return sprintf(buf, "%s\n",
+		       dsa_tag_protocol_to_str(cpu_dp->tag_ops));
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
 int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 {
+	int ret;
+
 	/* If we use a tagging format that doesn't have an ethertype
 	 * field, make sure that all packets from this point on get
 	 * sent to the tag format's receive function.
@@ -168,11 +191,20 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 
 	dev->dsa_ptr = cpu_dp;
 
-	return dsa_master_ethtool_setup(dev);
+	ret = dsa_master_ethtool_setup(dev);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&dev->dev.kobj, &dsa_group);
+	if (ret)
+		dsa_master_ethtool_teardown(dev);
+
+	return ret;
 }
 
 void dsa_master_teardown(struct net_device *dev)
 {
+	sysfs_remove_group(&dev->dev.kobj, &dsa_group);
 	dsa_master_ethtool_teardown(dev);
 
 	dev->dsa_ptr = NULL;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7d0c19e7edcf..aec78f5aca72 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1058,27 +1058,6 @@ static struct device_type dsa_type = {
 	.name	= "dsa",
 };
 
-static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
-			    char *buf)
-{
-	struct net_device *dev = to_net_dev(d);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-
-	return sprintf(buf, "%s\n",
-		       dsa_tag_protocol_to_str(dp->cpu_dp->tag_ops));
-}
-static DEVICE_ATTR_RO(tagging);
-
-static struct attribute *dsa_slave_attrs[] = {
-	&dev_attr_tagging.attr,
-	NULL
-};
-
-static const struct attribute_group dsa_group = {
-	.name	= "dsa",
-	.attrs	= dsa_slave_attrs,
-};
-
 static void dsa_slave_phylink_validate(struct net_device *dev,
 				       unsigned long *supported,
 				       struct phylink_link_state *state)
@@ -1374,14 +1353,8 @@ int dsa_slave_create(struct dsa_port *port)
 		goto out_phy;
 	}
 
-	ret = sysfs_create_group(&slave_dev->dev.kobj, &dsa_group);
-	if (ret)
-		goto out_unreg;
-
 	return 0;
 
-out_unreg:
-	unregister_netdev(slave_dev);
 out_phy:
 	rtnl_lock();
 	phylink_disconnect_phy(p->dp->pl);
@@ -1405,7 +1378,6 @@ void dsa_slave_destroy(struct net_device *slave_dev)
 	rtnl_unlock();
 
 	dsa_slave_notify(slave_dev, DSA_PORT_UNREGISTER);
-	sysfs_remove_group(&slave_dev->dev.kobj, &dsa_group);
 	unregister_netdev(slave_dev);
 	phylink_destroy(dp->pl);
 	free_percpu(p->stats64);
-- 
2.19.1

