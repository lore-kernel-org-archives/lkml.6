Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483605-2-14244585166994929294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483604; b=LSMuZtQaPm4D2taYttwqgOSQO2VCSkdC2kpdSVeN2S7gB6b
    eYV2OlIl0w+WeqsszYuOYGABvocqrT4+I5DFv0krXA08vtL2BLXWGTAlss6Uuta2
    lA5VLO2iLBqQbrok2OQNOz0OU/ngM2HucNV/vIOxwnQ2XOtel/5Mamhva6EGIwpD
    lmnlPtS/wcZs32IqSEVdzRyGrjlRkirs+9JXMA4FNNBJcvDs7y3Yf29yL49B0sRc
    BaYURFu68WBcmtBhvXCfFySxVRDYi6AOZ8BumoshbjE8RO9IPDXAaSBDTZAR/TKX
    XNsEJjbSDIQv1Y7gFe2dZMucSWToEo7vr9D1mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483604; bh=Czu3otyTjWISn+OKqMq10G1irg
    ilU2r7ck5pMlK9nKM=; b=ZHQ052KxXBIlmoju0fvgPGKijw0Xs0CZxt/s2h0xym
    yhY0SELedwvz/TIFPS4A6Gx2eOVcEudqoWGOJgl3zvPp7FqiRsTb2Ed0VrU0k/M6
    T0ts/hLLoawORQiObF29wlY5HipfFehzxVFdO6oZyOazO8IKZN/ZTSye+dlywB60
    tkW1SiR1lAPNplvgjd05CZOLrRdWvNzDZec/HypggtU9J4cybZMJ9OIRi/m5Nvta
    HwYtig5WF8enyqEIT2h54Y+zxhP/wAmr9X6WbR+tdg3kPSPCFsIDWDHo9CSC2TT7
    qxkd1TvFlBX70CFkuJVRwhDl/itObw3xp1beU7bSRFcQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtddvkeenucevlhhushhtvghrufhiiigvpedufedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtddvkeenucevlhhushhtvghrufhiiigvpedufedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030935AbeCSSTv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:19:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030927AbeCSSTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:19:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Patrick McHardy <kaber@trash.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrei Vagin <avagin@openvz.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 044/241] net/8021q: create device with all possible features in wanted_features
Date: Mon, 19 Mar 2018 19:05:09 +0100
Message-Id: <20180319180753.017795559@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
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

From: Andrey Vagin <avagin@openvz.org>


[ Upstream commit 88997e4208aea117627898e5f6f9801cf3cd42d2 ]

wanted_features is a set of features which have to be enabled if a
hardware allows that.

Currently when a vlan device is created, its wanted_features is set to
current features of its base device.

The problem is that the base device can get new features and they are
not propagated to vlan-s of this device.

If we look at bonding devices, they doesn't have this problem and this
patch suggests to fix this issue by the same way how it works for bonding
devices.

We meet this problem, when we try to create a vlan device over a bonding
device. When a system are booting, real devices require time to be
initialized, so bonding devices created without slaves, then vlan
devices are created and only then ethernet devices are added to the
bonding device. As a result we have vlan devices with disabled
scatter-gather.

* create a bonding device
  $ ip link add bond0 type bond
  $ ethtool -k bond0 | grep scatter
  scatter-gather: off
	tx-scatter-gather: off [requested on]
	tx-scatter-gather-fraglist: off [requested on]

* create a vlan device
  $ ip link add link bond0 name bond0.10 type vlan id 10
  $ ethtool -k bond0.10 | grep scatter
  scatter-gather: off
	tx-scatter-gather: off
	tx-scatter-gather-fraglist: off

* Add a slave device to bond0
  $ ip link set dev eth0 master bond0

And now we can see that the bond0 device has got the scatter-gather
feature, but the bond0.10 hasn't got it.
[root@laptop linux-task-diag]# ethtool -k bond0 | grep scatter
scatter-gather: on
	tx-scatter-gather: on
	tx-scatter-gather-fraglist: on
[root@laptop linux-task-diag]# ethtool -k bond0.10 | grep scatter
scatter-gather: off
	tx-scatter-gather: off
	tx-scatter-gather-fraglist: off

With this patch the vlan device will get all new features from the
bonding device.

Here is a call trace how features which are set in this patch reach
dev->wanted_features.

register_netdevice
   vlan_dev_init
	...
	dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
		       NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
		       NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
		       NETIF_F_ALL_FCOE;

	dev->features |= dev->hw_features;
	...
    dev->wanted_features = dev->features & dev->hw_features;
    __netdev_update_features(dev);
        vlan_dev_fix_features
	   ...

Cc: Alexey Kuznetsov <kuznet@virtuozzo.com>
Cc: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -562,8 +562,7 @@ static int vlan_dev_init(struct net_devi
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
 			   NETIF_F_ALL_FCOE;
 
-	dev->features |= real_dev->vlan_features | NETIF_F_LLTX |
-			 NETIF_F_GSO_SOFTWARE;
+	dev->features |= dev->hw_features | NETIF_F_LLTX;
 	dev->gso_max_size = real_dev->gso_max_size;
 	dev->gso_max_segs = real_dev->gso_max_segs;
 	if (dev->features & NETIF_F_VLAN_FEATURES)
