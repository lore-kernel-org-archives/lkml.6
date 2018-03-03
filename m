Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123661-2-11565903088103862292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123660; b=FxIwRf8qSb5J23Cmcbey2cmVM25NrU0SBufAVLakOSyvvlZ
    f1vBLJlCCrNxu4l5RpQQu0Ub6R3Q/p2i+0RsATv2hTaq2EKnsS6JWQS18P5gnVaW
    rxeAjd/yDK1IYUhRltZ37SiSTdK+QH3Ffrob43ILC8JWayFPV3oPdL8d9fxgd4F8
    4NFcvVPHwvX4wdxC4/YX8e3sJwsCKRfnivsCz2ddMKuie4v6UD+Y0D7letxovA6K
    ZWe0sPaEHzPzVSf502B5CC0nAzY7OL6XD3qP9P9xwAocbhMjZKoqwURgc/2I0rh8
    8HU0ivjNJQkmZjKD5uIkENoAdLFZ+zMYBY8HZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123660; bh=c++KPK
    wGw1HrsNHJV0EH3avCjxj2E13xvmjCuecjLp4=; b=vuH/BKOTMrc50uwEAqqLto
    vc+ZIThqaT4ChlC3peAr4u+RvqeCf8qFBT21kQBPzc6sKfLZDBUqCfVHi4psLwpt
    kUx0p6siHqxCz761A3TUkyaVwvKereaIX1DrdGXi2qKcZfGL8MKgfqFcS1opHsuV
    i+/OE18dD5z947tjjWWQfkLkRxRoZHpZTH3Ps4D85SbbahOmrRoxuaTXdvrfRB3v
    QNrVP+HphyCDNU8hBbt1rzo2g9l1gNA0bi9BWHVCPnvw0NJuV3b7suxGOUVzhKvF
    WhYSAGxep9khNlhRoGzAsF0FxbqqR1rbD2XEjJNExr6ySzDK+tqtaoZPWiM2GkTw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0XZMl6+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0XZMl6+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932667AbeCDAdo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:33:44 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932849AbeCCW1Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 085/102] veth: set peer GSO values
Thread-Topic: [PATCH AUTOSEL for 4.15 085/102] veth: set peer GSO values
Thread-Index: AQHTsz532SkdqO6eWUGkcCOX0BStFQ==
Date: Sat, 3 Mar 2018 22:24:59 +0000
Message-ID: <20180303222318.26006-85-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:4yQKuyEbV24IxS6fCI858s9voUmCRND6BuBXpaKEFwbHSl/ioU+5O72qM62315iaAlyfA9cQLILQdZwHbcp+Rd6WO1KAiOZeKCdIACnl9OJyghh27ECmajls0UNy6HrY7h3qTC62H1QPs9TDyoNfECbJANStCoGK1z2QezsI1eeudze8af6AnmRAvovZaalxXNY+fQ7/To5oc708U7ulVFM2+oKaM814b0uQaAzLvN5oMR5AYrVxXtKCuEdxcoonKUSFAK+4vEe6+j1FCbuujLYR93SIE6vOWAQX+LLVnRdKwQc9tf2u/zP3Gy2nzPYhvkr/3Kp+rYb1qJ4dT5gGUki5xM/hF3E+lLygM/GN+MIyTVH1hH7iUDsa7Vzm80Q5;5:a74J832wyxvgJiTov86nPRunCXubB6quoQVkrppcRlGhrH2dTOfzTsyB/DCrr7QdmR42NQ0R32ySjcBv9GM1Q4V21zy9Ub8ZY+VXhCRburmsP2HDEcqlPSlDlsiMsRl85X6+qSs3XExdYSvIpI8v4QjtTWuQzrYH6PrF5yEmIwg=;24:IiuJglrdPG9L3gcBwCiHGGll/z4knQcRUFyHV3wLNEiM1lgcbKVA23gBCCdlC4RdPHiDQuHZmhctM5L/JTDgYv5k4B6X1CEwL/rzbYhCAec=;7:30M3GXtRSFKfp5N/8psN6EYdEyN99veMrd3+XFEhYDSUbPEwyJmIZ7hu1WzGqV7lmoxDNRhrYAn/tDrgkgElQZ/WybvN5GLwnlhN3lgAB+e+vIff8BKAIe8SwhYuHAZS4Se5zip5c7h6tGwNiisjstSQGK8R6FHfYhZpOVMXGL3CuZlwxJ2gG30CIHhvU4+bFJS123uy3AadgMGW+0/EueNBIDHWvg13SdW5U/hedgWev7/aZQpCcUe5mKafjhVX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3776e1f9-52ee-4d7b-a207-08d58155e9c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09706AE1464628170D56D8B9FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Kr4lkppVskYXDiorKmIkTQxkaVe33uDeYI9Evuu1ALPTsqsmI+MFXoegsnS9mm2xqRixmJWkJ92komYpYI4HEQD4d6me4O5+cz+aQu2wfEMHJFPSniZuVWs8OTpOLMeiL12jZZ6ynCoWKFe1ToJ4qir+alWUdCJQNuutGvA4VMQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3776e1f9-52ee-4d7b-a207-08d58155e9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:59.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f5438d0978ca..a69ad39ee57e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -410,6 +410,9 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 	if (ifmp && (dev->ifindex !=3D 0))
 		peer->ifindex =3D ifmp->ifi_index;
=20
+	peer->gso_max_size =3D dev->gso_max_size;
+	peer->gso_max_segs =3D dev->gso_max_segs;
+
 	err =3D register_netdevice(peer);
 	put_net(net);
 	net =3D NULL;
--=20
2.14.1
