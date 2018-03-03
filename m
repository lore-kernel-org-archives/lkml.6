Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119058-2-1659028438077955141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119057; b=kXCqBjOCpg1iivcxHUMLoozrkmzzsciZKARXCzbtWzzGvt2
    I2QQvmqVSfNrWmS2U3LUL653RipkEtZ6ECQuFZ2P1d+r6c/byiIBgRK9Hc38j7Ux
    gLrkk5LaVNkSSNrs3dOlxUW6+3A0t92AQnON/yRIfFzeZvSAoGiDEBQXw+ar7yy7
    EKc2JYha45p2IZvBmAcMY0GsMnjRuYi3e5ZtypTpz3sV1fqZSfZhi52IXr3ujKaG
    MeUzeUpnaTS0i+ce4bHivz3avkFcNBg7IVQiaM1TEUYVCBWn/+8XtAuf8I7i1a4L
    HNhGYuODbwZw0TVU49rbuIF2SXKLOfpwrDsrPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119057; bh=mmd6uB
    VTK2LUv1wy4WKqRxoNdciDxqEfVbfIe1XNLRk=; b=Mj4+kgdKh4uhc/Zi86uvtX
    6ItcNYuuSEgplOkeoG4PgUTFAos7h5eykaH2EHMTQMK0dFE04ZkasUeXCXNtKQs+
    AORvuOFdGukCwNXctlpsVsmXKfbBW1dXFfvCbj1ctRaiDaSBn2JQTiDA4AWQIf3W
    z2bUUzBIyujEATgGfyim2ZdQele+F8fhuN65BfRQnKrVmvUrsJOLHRIpoqWPrLRu
    YRyHkYJCqrMF/8WHyJuMGz/XU4we1HHNIU5zuzk0DJ0MLH9mU+omL1xILBJWA1Wq
    0xiTXqIpPpAFF2KuYDehv+RHtjJ9qrDnQz0SNAkmul7jW/8V2YNgPhreV5MEhgYg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k9k82LeH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k9k82LeH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeCCXRY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:17:24 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934883AbeCCWiL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrey Vagin <avagin@openvz.org>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Patrick McHardy <kaber@trash.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 020/115] net/8021q: create device with all
 possible features in wanted_features
Thread-Topic: [PATCH AUTOSEL for 4.4 020/115] net/8021q: create device with
 all possible features in wanted_features
Thread-Index: AQHTsz9NJzezMZKepUGwp4cc897VcA==
Date: Sat, 3 Mar 2018 22:30:59 +0000
Message-ID: <20180303223010.27106-20-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:oDyCZUoxp/AZk374tAcn4aW9T/Nsjz9t7eIEyi7LlKC86q9GSoHog9fbyIDkOdX5w+fwSDgY4qx4R92fiPN2Ank5Wt1Z51Pf9JQUX/maESUGYP0sBjpXSlPMepevf3Z2KRaJILzYnaUD5ia23pg88Kefh7W7MV2xNEGNW58+ivZW0nJE0XEo8nW6SDmz9VoBfmWsStwjxnS8UJujJQAv/MZjyM0WhIQ4qT1tXaV0xlM4cDUlHMG68mkKMGTxNwn6Kch6w3U4O1i8+FOcmS69xCEG8AzftYSEeA1FBblU6rPY7FXp8ledk1sE6cIMGnF1FtfqRX1HfYMpITMRY1Oc4lYk3LmZpkMnkcSRdxjw2ID52zDyxDOpCR7CX4aI8+f3;5:Ob6dnQbRGvmXGRgt/9loj4B72xxHCuFVwZCH8Mr5eWecUdEz+8ujJ2sTvBOrvjSzCNTqciRMTcSqiXVNRi+LqyuMiYags86y51oXCS6ZvcCXjBpQvmiAYwRoB5R9XXDoN2H50E9QLn5uSd2UOzcYzPOI2GtJg1Hp8UX3wSfeBYc=;24:oIv3W+Hz8CDxdc57YRk+K8YBk4AAwqr/oMHtEwgY1TtbuJTts0RomQwLlBiamxxdGvPK6YiakObSgBMEjSJ+mG7JuNBsxMpMRh2B+dqCZxI=;7:/txjgO9Y06Y4ptpWNV8KeTi9CuwXpzQSGAzChgVPEuxJ4+XwtmUPZ0jFAfeXo+/8aKLeCSmpLIfg4edqdT3vqxXZWVLs46vshnUz8Pn0OBc7N5z83c/HnXCh8FJ3dRXdtkPu9/78f8AhtZLI1ON/Y6YgFR/LzayncrUCldhFCHjr9GYyEu71pBqb/+e6MtDuOgWBVDOHti5AXrCNwoqEJfDpLs6C5UYohx2aiNpATLgk68CxhPV/FNWI2uvXoD8D
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24eb1d15-7579-4cea-389b-08d581576ebb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10674718198C047FCC30DF9EFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2mNSEN5acu2TS3npIOGkwJe7dWISVbGuCLCPOq6Sx7T33mXDUCIgiJI4FAdTzOCDECmoU8B9iDkGMBjmaxUfdzZEU/ReGuantjn230Uk8Xv42iDlXvWdFc3HDecAVbw15FbmRPP/JmlTWOZYxIHzYamwt1X7O6x4P0/KJdAknug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eb1d15-7579-4cea-389b-08d581576ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:59.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
	dev->hw_features =3D NETIF_F_HW_CSUM | NETIF_F_SG |
		       NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
		       NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
		       NETIF_F_ALL_FCOE;

	dev->features |=3D dev->hw_features;
	...
    dev->wanted_features =3D dev->features & dev->hw_features;
    __netdev_update_features(dev);
        vlan_dev_fix_features
	   ...

Cc: Alexey Kuznetsov <kuznet@virtuozzo.com>
Cc: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/8021q/vlan_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ca4dc9031073..89da689b6433 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -559,8 +559,7 @@ static int vlan_dev_init(struct net_device *dev)
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CSUM |
 			   NETIF_F_ALL_FCOE;
=20
-	dev->features |=3D real_dev->vlan_features | NETIF_F_LLTX |
-			 NETIF_F_GSO_SOFTWARE;
+	dev->features |=3D dev->hw_features | NETIF_F_LLTX;
 	dev->gso_max_size =3D real_dev->gso_max_size;
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q config=
urations may not work correctly.\n");
--=20
2.14.1
