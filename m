Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400184-2-16807298043280312926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400184; b=Lhw7bLqaMsm6T13EJGQRs9Iq+nWPHHp3MX+PoBGxiYy2qfZl/P
    Wbuvdg5H3R/E5zoDDqwHh+IUCoPv0NstfmxZkl+OMJs2x1arR08OSYHzIWjFaSjY
    FlDP1g6Hz88XhWMA8zV2iuuHZprpeFJPGUKqPgxz0XoKqIYwt/JEueqMFet362oy
    J9LyfZG95yGrXW71v5euUPcSJa3bqO3t1zARqWmtFsj1m8/Cf3b8a3LY+7/iWlDL
    OX4z3jnNa5ySlU9h7mHnTPhWUW9r2Ad4Vxj+T04KxDMFbRAmit8B49h3UymrumZ7
    f06KKks+OYguKWVMMZ8xKu3AtURYHCxhlKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400184; bh=uQ49iHr//F61UE9g8obbcIk4g+WSb8
    Ne/4Iyl8TNEGo=; b=m5rY0XxpkhKHs5jFXioNBh1oRzUiCSajb4Qh9IVgnXh9Qo
    h6ydKqY0+N68iUBynYrQ1n2zgXBC1M/P1YgymyhqH/X1wRKJSBQN5uLUTJk7pt2N
    UQT6d4Kj0hfM966jks2bC8TFAK4AXzEgfMreFJCZgUJvOzqfDFjjh5HzDwnVZldW
    1KNfV/VCubCg5fkNAZjukbgYd9szytf9E/nFFxEg+LnkUYuCyVJMZHQdIuPE6E1+
    KG1sPqfN53y+PKiQIKVRLgbFmexic9VADVht6UpHafUoJfPmENsUfdQX84mQDBU/
    zfVY5B4Mq48PNfe8DF0LXWvfR4npZhK5+P2cUQ8w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRwZjlnhCv8iz3/cD5BdKElK35RhtH7DzBB9qUpkqsdKkWekV3ydtxewxEa7zmt3djMKC/NW41wxcFQzAVB1bl/ui3xe5xdzz1TCM5jKSw1dSHihzN7
    JxYsDzKHRe73XfF8rVJEG47eL1tkyZaBlm/qcaaHL268fyqFTAEHQW/xN6rnYeb+cai9R/ABcpm6TiB6Lm/CtShCleZ/8HiKAjzxvaaOqHhBPCKjfK8kxfQ2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=raxXJfwxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=omHJLDsAYeZrb9PF6QAA:9 a=QEXdDO2ut3YA:10
    a=JSjy4Y8GK2L6deCeXoNw:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeDJWnA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:43:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeDJWjy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beniamino Galvani <bgalvani@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 115/138] bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
Date: Wed, 11 Apr 2018 00:25:05 +0200
Message-Id: <20180410212915.534732311@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit ae42cc62a9f07f1f6979054ed92606b9c30f4a2e ]

Beniamino found a crash when adding vlan as slave of bond which is also
the parent link:

  ip link add bond1 type bond
  ip link set bond1 up
  ip link add link bond1 vlan1 type vlan id 80
  ip link set vlan1 master bond1

The call trace is as below:

  [<ffffffffa850842a>] queued_spin_lock_slowpath+0xb/0xf
  [<ffffffffa8515680>] _raw_spin_lock+0x20/0x30
  [<ffffffffa83f6f07>] dev_mc_sync+0x37/0x80
  [<ffffffffc08687dc>] vlan_dev_set_rx_mode+0x1c/0x30 [8021q]
  [<ffffffffa83efd2a>] __dev_set_rx_mode+0x5a/0xa0
  [<ffffffffa83f7138>] dev_mc_sync_multiple+0x78/0x80
  [<ffffffffc084127c>] bond_enslave+0x67c/0x1190 [bonding]
  [<ffffffffa8401909>] do_setlink+0x9c9/0xe50
  [<ffffffffa8403bf2>] rtnl_newlink+0x522/0x880
  [<ffffffffa8403ff7>] rtnetlink_rcv_msg+0xa7/0x260
  [<ffffffffa8424ecb>] netlink_rcv_skb+0xab/0xc0
  [<ffffffffa83fe498>] rtnetlink_rcv+0x28/0x30
  [<ffffffffa8424850>] netlink_unicast+0x170/0x210
  [<ffffffffa8424bf8>] netlink_sendmsg+0x308/0x420
  [<ffffffffa83cc396>] sock_sendmsg+0xb6/0xf0

This is actually a dead lock caused by sync slave hwaddr from master when
the master is the slave's 'slave'. This dead loop check is actually done
by netdev_master_upper_dev_link. However, Commit 1f718f0f4f97 ("bonding:
populate neighbour's private on enslave") moved it after dev_mc_sync.

This patch is to fix it by moving dev_mc_sync after master_upper_dev_link,
so that this loop check would be earlier than dev_mc_sync. It also moves
if (mode == BOND_MODE_8023AD) into if (!bond_uses_primary) clause as an
improvement.

Note team driver also has this issue, I will fix it in another patch.

Fixes: 1f718f0f4f97 ("bonding: populate neighbour's private on enslave")
Reported-by: Beniamino Galvani <bgalvani@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   73 +++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1524,44 +1524,11 @@ int bond_enslave(struct net_device *bond
 			goto err_close;
 	}
 
-	/* If the mode uses primary, then the following is handled by
-	 * bond_change_active_slave().
-	 */
-	if (!bond_uses_primary(bond)) {
-		/* set promiscuity level to new slave */
-		if (bond_dev->flags & IFF_PROMISC) {
-			res = dev_set_promiscuity(slave_dev, 1);
-			if (res)
-				goto err_close;
-		}
-
-		/* set allmulti level to new slave */
-		if (bond_dev->flags & IFF_ALLMULTI) {
-			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
-				goto err_close;
-		}
-
-		netif_addr_lock_bh(bond_dev);
-
-		dev_mc_sync_multiple(slave_dev, bond_dev);
-		dev_uc_sync_multiple(slave_dev, bond_dev);
-
-		netif_addr_unlock_bh(bond_dev);
-	}
-
-	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
-		/* add lacpdu mc addr to mc list */
-		u8 lacpdu_multicast[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
-
-		dev_mc_add(slave_dev, lacpdu_multicast);
-	}
-
 	res = vlan_vids_add_by_dev(slave_dev, bond_dev);
 	if (res) {
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_hwaddr_unsync;
+		goto err_close;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1721,6 +1688,37 @@ int bond_enslave(struct net_device *bond
 		goto err_upper_unlink;
 	}
 
+	/* If the mode uses primary, then the following is handled by
+	 * bond_change_active_slave().
+	 */
+	if (!bond_uses_primary(bond)) {
+		/* set promiscuity level to new slave */
+		if (bond_dev->flags & IFF_PROMISC) {
+			res = dev_set_promiscuity(slave_dev, 1);
+			if (res)
+				goto err_sysfs_del;
+		}
+
+		/* set allmulti level to new slave */
+		if (bond_dev->flags & IFF_ALLMULTI) {
+			res = dev_set_allmulti(slave_dev, 1);
+			if (res)
+				goto err_sysfs_del;
+		}
+
+		netif_addr_lock_bh(bond_dev);
+		dev_mc_sync_multiple(slave_dev, bond_dev);
+		dev_uc_sync_multiple(slave_dev, bond_dev);
+		netif_addr_unlock_bh(bond_dev);
+
+		if (BOND_MODE(bond) == BOND_MODE_8023AD) {
+			/* add lacpdu mc addr to mc list */
+			u8 lacpdu_multicast[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
+
+			dev_mc_add(slave_dev, lacpdu_multicast);
+		}
+	}
+
 	bond->slave_cnt++;
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
@@ -1744,6 +1742,9 @@ int bond_enslave(struct net_device *bond
 	return 0;
 
 /* Undo stages on error */
+err_sysfs_del:
+	bond_sysfs_slave_del(new_slave);
+
 err_upper_unlink:
 	bond_upper_dev_unlink(bond, new_slave);
 
@@ -1764,10 +1765,6 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
-err_hwaddr_unsync:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
