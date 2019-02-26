Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEB1206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g74V4vHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfBZSrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:47:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40595 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfBZSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so11706276ljd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqCaCMz7aNNRJKbo/Ni1R7ZUdFl7vBRhYGRNDh7GDoE=;
        b=g74V4vHubFNQ0sIH2cgAg3OSolmgq28k/qm/THOqpIAI6KTyPXD56AgCDHUG/IG+iZ
         iElF+NkHPkd2PpfnVQcMyx1yW/XQFBQX1aVCbXxFx/I5gkEl+jzyVJ01pdcq37zKod39
         zn3FLpqhXkcAt2/6SabTaILQLCYnnoQh0RODjAggspapp0RZXzN4IAxSSU7bLWUbGco4
         Q7ccjuMEBKxGOHYWMvHEl8YeXgy+IQXjxqu4TGOhMZuTbGyAjfJd6SLFxd4J6xp76Ktk
         IbpXp8mXyD4Hqr56uj+XywAeFzBJq60cvxIhGBlzvydsxGUJoiVEsPx4uNDC6ySV0vw2
         6kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqCaCMz7aNNRJKbo/Ni1R7ZUdFl7vBRhYGRNDh7GDoE=;
        b=QNZ1PpJIEXrmPOSAXH2Z/XIW+e+He6rxzgW0SiaHYY39vfLuagNbxhxT79RBduREKs
         l8F9iU5/U8JafwqE66QIEB3kb8+I/41+d9rrAUnJtuxQ93wom3zONNlXQlj1MDkJ34ws
         84TittPo/YELlBsHeZlOFhSm/DZ8VfxGjTqdcv6z5ZvVgIu5oaqvoek42HbyBHCP8Xhf
         Ym1ZVJC5mlu06UTPKK0UDhPxn0EnGAeQ5S8wz8MeYn5cpmpH1D/tZl7KtP6Wrx09O50A
         EltdzsE2RZRuLxEtTAIm8+jJ62PjVGHogkRpY9JhZ6EUvsMn3zrNTu3KXSp7e1dRfXZw
         3AQg==
X-Gm-Message-State: AHQUAuZfZWTvbyYuXtUOz9UmWUuWTM3NWm/YfLW1nzE+Hw9PGGWK+u9V
        jZtpOXMhZPSGlZK3z8G4x8p9Ww==
X-Google-Smtp-Source: AHgI3Ia8IbOoKU+i0fAVsYKh8J9ZiuWgC/o10Ng33KlBakPJ1maBt7N6v/R2AvSQFuf2eg7OE5TIqQ==
X-Received: by 2002:a2e:9c97:: with SMTP id x23mr14201695lji.13.1551206791798;
        Tue, 26 Feb 2019 10:46:31 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:31 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan device own address
Date:   Tue, 26 Feb 2019 20:45:53 +0200
Message-Id: <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vlan device address is held separately from uc/mc lists and
handled differently. The vlan dev address is bound with real device
address only if it's inherited from init, in all other cases it's
separate address entry in uc list. With vid set, the address becomes
not inherited from real device after it's set manually as before, but
is part of uc list any way, with appropriate vid tag set. If vid_len
for real device is 0, the behaviour is the same as before this change,
so shouldn't be any impact on systems w/o individual virtual device
filtering (IVDF) enabled. This allows to control and sync vlan device
address and disable concrete vlan packet income when vlan interface is
down.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/8021q/vlan.c     |  3 ++
 net/8021q/vlan_dev.c | 76 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index dc4411165e43..9c72551a9a1e 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -295,6 +295,9 @@ static void vlan_sync_address(struct net_device *dev,
 	if (vlan_dev_inherit_address(vlandev, dev))
 		goto out;
 
+	if (dev->vid_len)
+		goto out;
+
 	/* vlan address was different from the old address and is equal to
 	 * the new address */
 	if (!ether_addr_equal(vlandev->dev_addr, vlan->real_dev_addr) &&
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 93d20b1f4916..634436e780f1 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -257,12 +257,61 @@ static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
 	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
 }
 
+static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(dev);
+	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
+
+	if (real_dev->vid_len) {
+		memcpy(naddr, addr, dev->addr_len);
+		vlan_dev_set_addr_vid(dev, naddr);
+		return dev_vid_uc_add(real_dev, naddr);
+	}
+
+	if (ether_addr_equal(addr, real_dev->dev_addr))
+		return 0;
+
+	return dev_uc_add(real_dev, addr);
+}
+
+static void vlan_dev_del_addr(struct net_device *dev, u8 *addr)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(dev);
+	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
+
+	if (real_dev->vid_len) {
+		memcpy(naddr, addr, dev->addr_len);
+		vlan_dev_set_addr_vid(dev, naddr);
+		dev_vid_uc_del(real_dev, naddr);
+		return;
+	}
+
+	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
+		dev_uc_del(real_dev, addr);
+}
+
+static int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
+{
+	int err;
+
+	err = vlan_dev_add_addr(dev, addr);
+	if (err < 0)
+		return err;
+
+	vlan_dev_del_addr(dev, dev->dev_addr);
+	return err;
+}
+
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev)
 {
 	if (dev->addr_assign_type != NET_ADDR_STOLEN)
 		return false;
 
+	if (real_dev->vid_len)
+		if (vlan_dev_subs_addr(dev, real_dev->dev_addr))
+			return false;
+
 	ether_addr_copy(dev->dev_addr, real_dev->dev_addr);
 	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	return true;
@@ -278,9 +327,10 @@ static int vlan_dev_open(struct net_device *dev)
 	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
 		return -ENETDOWN;
 
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
-	    !vlan_dev_inherit_address(dev, real_dev)) {
-		err = dev_uc_add(real_dev, dev->dev_addr);
+	if (ether_addr_equal(dev->dev_addr, real_dev->dev_addr) ||
+	    (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
+	     !vlan_dev_inherit_address(dev, real_dev))) {
+		err = vlan_dev_add_addr(dev, dev->dev_addr);
 		if (err < 0)
 			goto out;
 	}
@@ -312,8 +362,7 @@ static int vlan_dev_open(struct net_device *dev)
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, -1);
 del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
+	vlan_dev_del_addr(dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -331,18 +380,14 @@ static int vlan_dev_stop(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		dev_set_promiscuity(real_dev, -1);
 
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
-
+	vlan_dev_del_addr(dev, dev->dev_addr);
 	netif_carrier_off(dev);
 	return 0;
 }
 
 static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 {
-	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 	struct sockaddr *addr = p;
-	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -350,15 +395,8 @@ static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 	if (!(dev->flags & IFF_UP))
 		goto out;
 
-	if (!ether_addr_equal(addr->sa_data, real_dev->dev_addr)) {
-		err = dev_uc_add(real_dev, addr->sa_data);
-		if (err < 0)
-			return err;
-	}
-
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
-
+	if (vlan_dev_subs_addr(dev, addr->sa_data))
+		return true;
 out:
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
 	return 0;
-- 
2.17.1

