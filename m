Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121617-2-9497762289088083283
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
    t=1520121617; b=qRcx+pBAtz7D4CKtmOKimaidAaynGqU3SnqgOlevGUD1UWF
    F03CngXWoChaB2eY3vA6hGSJXh1eXJzHYI1qn4coCoWplv45LyBMKhGQfZYyr5+k
    b8hIaL+3xjNpuCyqbdqcbKs7x4otnlrUKLFL2W867TNfUJrI/zrwFurU9pnSKfs4
    CfJhdRujoRNttj9kLLmC9wSO7WmnhKxXf0oFrGHrN6/ts/IHFc4AvfialxFjCmv3
    l4EqVz35/yArsXbCk5nKNP7n2sMe0H/x+vqsek4KZnNGM6aVAZb762w/uLHVeYqw
    ZeUDFEKYfO3YFgcv6TldMceSSwq9pGSeRowmBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121617; bh=ERE9Pn
    q+UkgSznftqWZk2g586kzP1wVWrCY16ocgTV8=; b=FAFkN60DdX8kvsO5NThP3/
    qWhwtw/MSDDaj/UmCKomlDnsta93FL1GSonr71GKC3hd5YT7Jxm9KCynh2pgqxeL
    ffoXlwPjufroU1il2ZJwbrT54yMr8FwEUqhCyCo2KlsXQgiA1ynhNy7s6VBxC3Q/
    9YJ+EMV4JacdIH5QFyfzSpTmJvTqoxasUAXqRKRSfng+Q8I1kJLOc8+zTk8ArBpY
    D3KipAs7c+bo8wSgma333fOyOLKxyjCglUbPE6XLCMz7rcOZN2Wdk8pvSRPLxFoQ
    I93iq/J7nTJPqKtUj6wmvTBsztf/quNxxSLTOwF0OTQBdabl4ghTnc/1Rd9qPPUg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqF9JXEM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqF9JXEM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeCDAAK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:00:10 -0500
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:12928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933379AbeCCWcJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrey Vagin <avagin@openvz.org>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Patrick McHardy <kaber@trash.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 046/219] net/8021q: create device with all
 possible features in wanted_features
Thread-Topic: [PATCH AUTOSEL for 4.9 046/219] net/8021q: create device with
 all possible features in wanted_features
Thread-Index: AQHTsz7wpqU0iSxCwUS1LvAVnJB7qA==
Date: Sat, 3 Mar 2018 22:28:22 +0000
Message-ID: <20180303222716.26640-46-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:qepBWM3xZ9pgmTJnvNwVKWrcM6ZY7Y+aGl563qlNk0+TDptwYxYHGuOlTMeR30r2vNNmtYMCGXjxr0GygRhLU5E8RMvWschy3bqfq1HKqYog+v6c9VQ/zfdWUBcILO8z7LhbDRYQc/oxOXVAnIQ7J7Fj5K3W1ZfZL33mc5N6RwEVL+/z0PGqoXai9jpvlEZ6N8ut6MZdj7k2PbWn62epSA77L5IRgv/Ej7wT/WqU/TzAvnpelB1YFuJSQ2mpkaSV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fd2cf3b-4492-4914-b474-08d58156975b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1098F9B81F3FA6BB897B48AAFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PlkfxSGUl2YJsO4Aa5LBixhIPSRKKRGKZr/nNt7wqcAXiNv+7GAVaDsNGDyGN//OhKFbnxVT3M1ucHObKUHvaTMJ7iyIml7ErmyTyZcxEbGCRDzMdTiZNI5NsEJicPN3Y/yhQZLSVSftdli9ERpKegVXhtsbsmP1vuu/HlK+5xY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd2cf3b-4492-4914-b474-08d58156975b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:22.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
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
index fbfacd51aa34..767144128b95 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -562,8 +562,7 @@ static int vlan_dev_init(struct net_device *dev)
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
 			   NETIF_F_ALL_FCOE;
=20
-	dev->features |=3D real_dev->vlan_features | NETIF_F_LLTX |
-			 NETIF_F_GSO_SOFTWARE;
+	dev->features |=3D dev->hw_features | NETIF_F_LLTX;
 	dev->gso_max_size =3D real_dev->gso_max_size;
 	dev->gso_max_segs =3D real_dev->gso_max_segs;
 	if (dev->features & NETIF_F_VLAN_FEATURES)
--=20
2.14.1
