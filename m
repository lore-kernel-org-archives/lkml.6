Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3082221852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGy464fU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfBZSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:47:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37079 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfBZSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id z196so9744220lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DcDw7IrxqjOxRf2I8tQwrAbV9hm03kKacBat2OiHhV8=;
        b=fGy464fUWN2DY6G0KVw5uTrWDyl77JIUOm4Z9OOb3mluFGnXqneATfRFC2hVcqz9s5
         B8vaorp5AihQbJsjaWf1QjmOeY8m9oYAARRuKhl5uJWsxitjDCw0JVt2rlc0DKp6GYQ1
         gI72LtJlpTOXsk2aVhQPkRDTRVBnCV7B5KxyJJ4Qt1Iz7esmXtsKTHmjz8sA0JldvZcT
         FZjdvxegiVOMmf6WJJ4iia1+0E1m2TxB6nNsWxzBrhxohlMCiix/f/oF5UwdBL7fLp+2
         A+bLACUJJcs+ql6tXaVfUMZ3UeMtORsXS1EuiVfrTkbhcsV+alcuxyPB45zgv5Rp9Ay2
         jQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DcDw7IrxqjOxRf2I8tQwrAbV9hm03kKacBat2OiHhV8=;
        b=K6p+fhsXQ3CxGCgSuTRXkXYrSq4J87UeJqdg5wTu8ip7IdjASAS1/AGfiJwkhQnyE4
         v3DB4t6n1nOqWT2w8hRBZNkQv3jsM6zcq4KKGC7iqmIa16Mp1Kin8XyQEP94j77aXkar
         asIAWq81OIyq1pBiic+wSotvvu/3fEDigS7Ka68suErSxT3t2AOBiq0BqdQPR6IdzW7x
         +eiEJ27X+c2IdUXRMYm+Kb5oOrcJ1lknfksVW5pER1cyK5gGFZbdxcTHR6gOwCZgFIn8
         sigo17rvY5fVP3241ibI/TGu8N/aLlxlaIteSx77b87h5iVTsUrGi/YXjYi5xH/SVLkp
         6tYw==
X-Gm-Message-State: AHQUAua06S1tiGA1fQFLk0iSzDJrC+Z0f/m+bl4+3LDh8qu9gYsP+viI
        WPulnDp/W9Wh+SEbQlIrGNmWhisv5Ag=
X-Google-Smtp-Source: AHgI3IZRH6u20hog848kD7MkLxisz8NPypmeBXl/OAq4QHrMF09jtK7rzIw2Okf3ayAO4NqcvnjaTQ==
X-Received: by 2002:a19:d411:: with SMTP id l17mr1323106lfg.112.1551206789404;
        Tue, 26 Feb 2019 10:46:29 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:28 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/6] net: core: dev_addr_lists: add VID to device address
Date:   Tue, 26 Feb 2019 20:45:51 +0200
Message-Id: <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite this is supposed to be used for Ethernet VLANs, not Ethernet
addresses with space for VID also can reuse this, so VID is considered
as virtual ID extension, not belonging strictly to Ethernet VLAN VIDs,
and overall change can be named individual virtual device filtering
(IVDF).

This patch adds VID tag at the end of each address. The actual
reserved address size is 32 bytes. For Ethernet addresses with 6 bytes
long that's possible to add tag w/o increasing address size. Thus,
each address for the case has 32 - 6 = 26 bytes to hold additional
info, say VID for virtual device addresses.

Therefore, when addresses are synced to the address list of parent
device the address list of latter can contain separate addresses for
virtual devices. It allows to track separate address tables for
virtual devices if they present and the device can be placed on
any place of device tree as the address is propagated to to the end
real device thru *_sync()/ndo_set_rx_mode() APIs. Also it simplifies
handling VID addresses at real device when it supports IVDF.

If parent device doesn't want to have virtual addresses in its address
space the vid_len has to be 0, thus its address space is "shrunk" to
the state as before this patch. For now it's 0 for every device. It
allows two devices with and w/o IVDF to be part of same bond device
for instance.

The end real device supporting IVDF can retrieve VID tag from an
address and set it for a given virtual device only. By default, vid 0
is used for real devices to distinguish it from virtual addresses.

See next patches to see how it's used.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h |   4 ++
 net/core/dev_addr_lists.c | 124 +++++++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 58e83bd7a861..74fef35b6bec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1660,6 +1660,7 @@ enum netdev_priv_flags {
  * 	@perm_addr:		Permanent hw address
  * 	@addr_assign_type:	Hw address assignment type
  * 	@addr_len:		Hardware address length
+ *	@vid_len:		Virtual ID length, set in case of IVDF
  *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
@@ -1889,6 +1890,7 @@ struct net_device {
 	unsigned char		perm_addr[MAX_ADDR_LEN];
 	unsigned char		addr_assign_type;
 	unsigned char		addr_len;
+	unsigned char		vid_len;
 	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;
 	unsigned short          dev_port;
@@ -4141,8 +4143,10 @@ int dev_addr_init(struct net_device *dev);
 
 /* Functions used for unicast addresses handling */
 int dev_uc_add(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
 int dev_uc_del(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
 int dev_uc_sync(struct net_device *to, struct net_device *from);
 int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
 void dev_uc_unsync(struct net_device *to, struct net_device *from);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index a6723b306717..e3c80e044b8c 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -545,6 +545,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
 }
 EXPORT_SYMBOL(dev_addr_del);
 
+static int get_addr_len(struct net_device *dev)
+{
+	return dev->addr_len + dev->vid_len;
+}
+
+static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
+			unsigned char *naddr)
+{
+	int i;
+
+	if (!dev->vid_len)
+		return dev->addr_len;
+
+	memcpy(naddr, addr, dev->addr_len);
+	for (i = 0; i < dev->vid_len; i++)
+		naddr[dev->addr_len + i] = 0;
+
+	return get_addr_len(dev);
+}
+
 /*
  * Unicast list handling functions
  */
@@ -556,18 +576,22 @@ EXPORT_SYMBOL(dev_addr_del);
  */
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->uc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_UNICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->uc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_UNICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -578,47 +602,89 @@ int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 EXPORT_SYMBOL(dev_uc_add_excl);
 
 /**
- *	dev_uc_add - Add a secondary unicast address
+ *	dev_vid_uc_add - Add a secondary unicast address with tag
  *	@dev: device
- *	@addr: address to add
+ *	@addr: address to add, includes vid tag already
  *
  *	Add a secondary unicast address to the device or increase
  *	the reference count if it already exists.
  */
-int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_add(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_add);
+
+/**
+ *	dev_uc_add - Add a secondary unicast address
+ *	@dev: device
+ *	@addr: address to add
+ *
+ *	Add a secondary unicast address to the device or increase
+ *	the reference count if it already exists.
+ */
+int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_add(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_add);
 
 /**
  *	dev_uc_del - Release secondary unicast address.
  *	@dev: device
- *	@addr: address to delete
+ *	@addr: address to delete, includes vid tag already
  *
  *	Release reference to a secondary unicast address and remove it
  *	from the device if the reference count drops to zero.
  */
-int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_del(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_del);
+
+/**
+ *	dev_uc_del - Release secondary unicast address.
+ *	@dev: device
+ *	@addr: address to delete
+ *
+ *	Release reference to a secondary unicast address and remove it
+ *	from the device if the reference count drops to zero.
+ */
+int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_del(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_del);
 
 /**
@@ -642,7 +708,7 @@ int dev_uc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -672,7 +738,7 @@ int dev_uc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -696,7 +762,7 @@ void dev_uc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->uc, &from->uc, to->addr_len);
+	__hw_addr_unsync(&to->uc, &from->uc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
@@ -740,18 +806,22 @@ EXPORT_SYMBOL(dev_uc_init);
  */
 int dev_mc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->mc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_MULTICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->mc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_MULTICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -764,10 +834,14 @@ EXPORT_SYMBOL(dev_mc_add_excl);
 static int __dev_mc_add(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_add_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false, 0);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -804,10 +878,14 @@ EXPORT_SYMBOL(dev_mc_add_global);
 static int __dev_mc_del(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_del_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -863,7 +941,7 @@ int dev_mc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -893,7 +971,7 @@ int dev_mc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -917,7 +995,7 @@ void dev_mc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->mc, &from->mc, to->addr_len);
+	__hw_addr_unsync(&to->mc, &from->mc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
-- 
2.17.1

