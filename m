Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473692-2-4165390326419507616
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
    1523473691; b=w/qAj31eNRdLtCjsge8WRXyeWpUR/EBVEHqlXvd+XhzOBlJQvv
    uyoKWGwT4nczh9ibgWNw+6wg/rGF/KzH1i4viwCEPSaZulKFcW00RK7SdZ4/eBdV
    vyS6p7gfknUgQAus01XaWknNwXS7HeiJ9MGDvHeT3sMTkSWL9/MFXmaIVhPzSCgX
    koekevhSUAtxDdVbseM3vJUpcxsMVGlXLiPQTYAlwkvniPf/JAAa4vz2hWpXADoQ
    XqTI4ev78r8iA1lSlariPBlINeACFwMdezalwuIfNPCFAqMZPefWLibKq0ZKaKvx
    5xkxWlguauQfBf5iZa/9XyUdkm3HxKldjIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473691; bh=CIj/qxwq+qgjMwR/lP1mbJBMJLO49c
    miMvhO/Iw//rY=; b=vIuVu1pZocSmMB8sx+0mBgk655sVNhr9p795/Qd4gwDCVk
    PEkMnQGi2hkt8N81qzAFPRReoHXPY0kHVEVWnKxawHY9XPDhISvVMHgMLD5duXRI
    ZSx2iyuZtxd4iWJNyMGwSijPlrAdftxrX5+KfQ4WPJhUEzg48nnc7LStv9hOth8h
    CRs9GeV3pMOa4On7qBVno4VWxWcNTaHfj4xamOUrFy3/VyGS5rcCsXbExHwgi1Bb
    7CfMI6+kYmZTTv1znYpa8eGJAeRSEdVcUbR/G9Lh47svWzG+ygA7yN3+HOj129i1
    8D5ey2EIf8kXsi9ml5NpDi/Cue51kEi0QOcqjg/g==
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
X-CM-Envelope: MS4wfLpivHIfzb+iGYoNEX0FD9p4ENsSutypquekKg6FMZRQDUtPOOmdl9GaVl2vUDpnV+NeQRC+R924VIyGyUUBctFxwRJSwdgjXE+NMXleD7Bzbo92lXPc
    EjoPRMNqxAPo6rW/51zFvm47fl9AiZ5WtpR3X+JVCp0n9ZEHb5ETT/jH1wJoXb8cqI/mZAPKc5BYwkhstlAxvN6Qu0QKgkg6ymZnUpbhfYp93iVSpH+xXIXx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=CDq0vqnqAAAA:8 a=raxXJfwxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=-K2Uu799WqL-7LDaqrwA:9 a=QEXdDO2ut3YA:10
    a=Xn7iXEen_xUG9zZOO_Hb:22 a=JSjy4Y8GK2L6deCeXoNw:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935364AbeDKTHI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:07:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935324AbeDKTHD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:07:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 290/310] bonding: fix the err path for dev hwaddr sync in bond_enslave
Date: Wed, 11 Apr 2018 20:37:09 +0200
Message-Id: <20180411183635.078576406@linuxfoundation.org>
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


[ Upstream commit 5c78f6bfae2b10ff70e21d343e64584ea6280c26 ]

vlan_vids_add_by_dev is called right after dev hwaddr sync, so on
the err path it should unsync dev hwaddr. Otherwise, the slave
dev's hwaddr will never be unsync when this err happens.

Fixes: 1ff412ad7714 ("bonding: change the bond's vlan syncing functions with the standard ones")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1561,7 +1561,7 @@ int bond_enslave(struct net_device *bond
 	if (res) {
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_close;
+		goto err_hwaddr_unsync;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1749,9 +1749,6 @@ err_unregister:
 	netdev_rx_handler_unregister(slave_dev);
 
 err_detach:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
 	if (rcu_access_pointer(bond->primary_slave) == new_slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
@@ -1765,6 +1762,10 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
+err_hwaddr_unsync:
+	if (!bond_uses_primary(bond))
+		bond_hw_addr_flush(bond_dev, slave_dev);
+
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
