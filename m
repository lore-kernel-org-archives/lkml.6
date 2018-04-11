Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473693-2-7560904896949876137
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
    1523473692; b=fIHK46qfk2MwCM6RIsxemGc6ibL17dBTHK7iKDGj4bJ+zcEVYh
    nqyXSPc14zuZMTWchpPrb5m9O8eLyKrpQVVeS6FmDUzq/UBEazj21ky6u3f4+YUn
    EONxtYZ4T+Ao2LW9slkI3hRLPi6+LbRKb3NftW3SbhY04wz4mQSwW5eAh2Uhu6+5
    IqbYqL6uO2JBjdEElfQMAqz/96mQstFV3WZ++hZEFyf7ygPKa8xbQFvADzT4TT5a
    yUrBMSZomhW/yfF3y8/0woRLjsk3taklatmTWgX3/2VcVs1G8ZUa/YpbqOXzWLoP
    GR5P05zBOWOdAud5FhQktc12DoHDxupOZ7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473692; bh=PPehruSK8lFf/4Eq1JwatnEBIQ2HvF
    RChmcGEfQMA5E=; b=EoQvtU2JUsQP+xwptuKCImrgcq9XQm9UobmP45Ru3Mxo4R
    oGNb6yjKUuFmcwQuzNET8jHr7Brfvpxh8R1us1GJnuYyfmAxuVgzJCxAbSo/3bIT
    mcmAEjim2aQltHFKXNERTHaYcz7CJvYw/4fyUvYzx0NrZxp4muxepRrvef34mv49
    D/Ev3K7xvC5wL7zVF0I3O+QAgtc75mEOf5V3NcCiNK9TFU5Ay8qqtACyWZsYzUmY
    SJ3gFmeksO9mCDiwKPNkblU0BCTY8x27okHsTq5GF0cfMpDcFSm1RoKu5gFDW9T8
    lBb7doFanq0qtU/zvHJ0YDsiPUHHEJDh34s4iOMA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfATIYnXybGYBzcDAs7VdMFSF2eA5kqkmE0d+pT6TkaDBk1Bg2r60wo2GmlEJU6kIffPGDTXJee1mx5G5L+7w1ICN2UTvf40farcRzLNEICxx1V5D74Eq
    s93CPvEeffQaqOQRSQQJRZ3/gSg6UchCj0dDY7bqB1TSpBXebLLzSZI+j3YPndmhrO6vBl7DluDt6wGE4xpG93j58sw/UiO0JpBK3e8yLuRiihBKDUlrr8Yt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=raxXJfwxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=omHJLDsAYeZrb9PF6QAA:9 a=QEXdDO2ut3YA:10
    a=JSjy4Y8GK2L6deCeXoNw:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935360AbeDKTHH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:07:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935357AbeDKTHG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:07:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beniamino Galvani <bgalvani@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 291/310] bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
Date: Wed, 11 Apr 2018 20:37:10 +0200
Message-Id: <20180411183635.117100560@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1719,6 +1686,37 @@ int bond_enslave(struct net_device *bond
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
@@ -1742,6 +1740,9 @@ int bond_enslave(struct net_device *bond
 	return 0;
 
 /* Undo stages on error */
+err_sysfs_del:
+	bond_sysfs_slave_del(new_slave);
+
 err_upper_unlink:
 	bond_upper_dev_unlink(bond, new_slave);
 
@@ -1762,10 +1763,6 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
-err_hwaddr_unsync:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
