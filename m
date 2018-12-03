Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008C5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC2F214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+EZwnZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC2F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeLCSkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:40:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37169 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeLCSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so9973103lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRbSa+zIScLn5oBfObhnQYA2lIlslwrx0Wo3p5ZDIKA=;
        b=Q+EZwnZZiafPJrwFa0oh3lW+9Qd0bw6m8FB0BDbO3og20JyPMHU2I95ndlot8anzji
         97jIECbovDwjkX2vcrZxBcTG6iYnUTbIlhpqk8ErEkAVWYl6bGSDRC6QEJ1WIflFb22q
         Eu4fMTAMzPnpYmQMz/iIMFceHrQhbdqYfEFgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRbSa+zIScLn5oBfObhnQYA2lIlslwrx0Wo3p5ZDIKA=;
        b=IY0qfxsl1omgP/Nu1bzEQ4pf1E24OOYyz0fCqqp9WBOvWg7qgPesaHlz9RCW4QdfCi
         qnANTzTNu2MjhqOmUWMY48uwsyhumK64ER0Bml6uPcztlcfJkA4NZmc7l+AT7oqVZLkU
         zZVewnusHm9BK+NqKSVpKhfw5cMHxFWmzP6zDkTFCxm52CB8vaF7d1LYo+kPvbZe4e3M
         AjeoRu1icyGg3Zuwqy1pLAIFSAPdd66abIYt0jqx5un+eIot9Kxunt2GUDKhgYr7oJVJ
         7qOk/fpIK05YH+vjInAGuV4aX1TSVPhOiOcjp53etBxteAavKxr2/x2VM++R230f3eMl
         hG+w==
X-Gm-Message-State: AA+aEWY/Ur0A5r5Rz5+UAXExRbsy27SDsitx1+Sta528R8IZNMlWb0Yw
        H08B8/IrQ1wIidFFhjBiqH+zlw==
X-Google-Smtp-Source: AFSGD/VthoZsaKZ1Wj9igPaBRFAOMxSWzOgzbF9w6Fs9TOpJtl3hWO3Nn2JDOhW7qzkwiJAMXdqdpQ==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr9469772lfb.76.1543862432032;
        Mon, 03 Dec 2018 10:40:32 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:31 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 3/5] net: 8021q: vlan_dev: add vid tag for vlan device mac address
Date:   Mon,  3 Dec 2018 20:40:21 +0200
Message-Id: <20181203184023.3430-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vlan device address is hold separately from uc/mc lists and is
handled differently. With proposed change, the vlan dev address is bind
with real device address only if's inherited, in all other cases it's
separate address entry.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h |  2 ++
 net/8021q/vlan.c          |  3 ++
 net/8021q/vlan_dev.c      | 76 +++++++++++++++++++++++++++++----------
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b0f9c322b01..28c6da3583cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -76,6 +76,8 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
 #define NET_RX_DROP		1	/* packet dropped */
 
+#define NET_802Q_VID_TSIZE	2
+
 /*
  * Transmit return codes: transmit return codes originate from three different
  * namespaces:
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index aef1a977279c..a1eae9d61284 100644
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
index c05b313314b7..f6bcd847509e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -258,12 +258,61 @@ static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
 	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
 }
 
+static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(dev);
+	unsigned char naddr[ETH_ALEN + NET_802Q_VID_TSIZE];
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
+	unsigned char naddr[ETH_ALEN + NET_802Q_VID_TSIZE];
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
+int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
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
@@ -279,9 +328,10 @@ static int vlan_dev_open(struct net_device *dev)
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
@@ -313,8 +363,7 @@ static int vlan_dev_open(struct net_device *dev)
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, -1);
 del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
+	vlan_dev_del_addr(dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -332,18 +381,14 @@ static int vlan_dev_stop(struct net_device *dev)
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
@@ -351,15 +396,8 @@ static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
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

