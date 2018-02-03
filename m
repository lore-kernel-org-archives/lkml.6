Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683532-2-3678621952395892186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683532; b=Z2PMnSVps4yQNuwWUOLB5xLcxLAUGQ9h1N2Y2jr1KmNO8HD
    Gs5Rxt+GpWnYhbHRv/hSS/vLnych3epThbOJUnJS6K6uv8SjQBX1SBCHsezTQoHD
    b1o7i8EaqHKL38tanYyckx/7iy0u5W6GDVspynnmWPEr3tHX0FZgbPVBTw60P86U
    0dhVoAZTty0PhMuJ1nXHDGHt72B1iGSqDhQs7bSWZlnQhrUsKtAoO5ojHaejHhp8
    qTn51sG/YaElS13BTR12EZh61AJUKoKJJObmra45EW6QPmz6bGCWyjY7+nlF2EjB
    qBVs7k95xGQtJpTg3I2w6tVQ6zB5lLRXiaZoHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683532; bh=vEa1rv
    QHznW4R+3JvVacHgAs5W67ha0KEJ4rmKs8o6A=; b=BdVFJIPBHZCGqBWG6VSgDJ
    2X/6R9YUivm3kTDFSV1SddsRsmBOgrVDj+r/WgpFpzTOxbNRPBX2M0y850DZKQac
    uR3Bmzr0dSsSUyUR/6XBgvr+IfU3IelcygganaGBKKtPlt2VncKl+DDjtZQgPj9v
    oCCfezZIXO/e1DpEUWCjYhNqvRqKcu+3rxa7EQo+gLDRIpiAz7ooBnrDChpUaJnJ
    e0D5QlgL2KtLhu4apUmgvnKRo+JV7GSzDtOxYBD4QQHit0d1NDnRUCdVnys5Ny4j
    rtCmn5CtBncBmfBy2q8aU3+iFzXHbXkgomksKhzWsltAiuJZYxZnh36/BKWGMTiQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JD2ECoiC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JD2ECoiC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755280AbeBCSp0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:26 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753141AbeBCSCo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 035/110] vxlan: update skb dst pmtu on tx
 path
Thread-Topic: [PATCH AUTOSEL for 4.14 035/110] vxlan: update skb dst pmtu on
 tx path
Thread-Index: AQHTnRjqCHINyyzB80OHq6Fi4JEnhw==
Date: Sat, 3 Feb 2018 18:00:45 +0000
Message-ID: <20180203180015.29073-35-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:Kaw4jgDA2lXm2EBIx3hm11VkTIXTIgn/vQb0FAQstFN/o2sIITKUN9d2a281li6zD4aJGs+bmyTfu2R9VTK/EtYyg3RvF5dQEWJLwPlf//Bbq/e5gBi6C/Y8EcW3+r5PX1LuStFrI1W8YSOm+lgGPmc8FWjbtsb9zU7Ap2wAT8gaaeg6e6NM343F8ID3CZ5JO8EfZfVuiLXtiO9+7kQ+5dsL78NLIDSrB1i5xX+k9nWsvJzBjbNROnPicXg+NNB5Q0NXFEFQiz1nSbmqb0s+NO9IBxCQoej8uupglQe4A7Ocgk9gRY81BscV2VdPtWs4HXVRaNu52kpIxYwLXEW/g8eUK2sLHk5qX1GiBwO/5Fe29ENXZ3QFLR6mJYLoYXfU;5:eGEz7sAvFQtpzI7hK2ekTngj2lDXdacFR/KtYjYCS4RujjHvmCXydjNP7042OakyAiS9bZxo1r/9i5rSqX4QOLRpzplXC4fB1HWObuPsRUr7LxmqIUsJP2xih0DQszYez/EjRc17KYWC/N81QsLYusdJ0JE25M3lbO839arRcGk=;24:chUg4PqatG7LlSTZ8ieCrfwsZrwgzA+Qzsgh9pTDuqlyUqnLvXiRO/SfvJdNYg2ieTybajkbBkqW3MrRu2/aiOCCq9+uoKEKGge2foIaSLw=;7:+qni9QUewpsdmcmfrxJdzB50+UfiZCoDbMAw/5rhx6tvhm2soImB3HAynv9khG5WHgAT9XLBmY+28Til47U4guVeNhS08ZMXKbVev19Rd9sehxcdu+XCuvRKQFN0TvLcLxknYAmAP6voENfFZn+NyaPulOUmnDmXvSzxMzDtMC7sLPn0kW6dB2CcU/V4vmPFw+o8bUe0vUkjL8gQ3V6l/ho16XWbUIewyblRcGZPG2YPgaCBRzxSYneHKx6ateHG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efbe8799-cc90-422f-3d54-08d56b30202a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB109060C0215323C8356A0F72FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(39060400002)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(15650500001)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: FAHJAwtdml34k6eteHFpkkpttHnl8SAjnSepz3aEvaI7zh/2GXVawOZaQ4sXGYBfRdRQJFNUi1Vmb3t6CUMvYg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbe8799-cc90-422f-3d54-08d56b30202a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:45.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit a93bf0ff449064e6b7f44e58522e940f88c0d966 ]

Unlike ip tunnels, now vxlan doesn't do any pmtu update for
upper dst pmtu, even if it doesn't match the lower dst pmtu
any more.

The problem can be reproduced when reducing the vxlan lower
dev's pmtu when running netperf. In jianlin's testing, the
performance went to 1/7 of the previous.

This patch is to update the upper dst pmtu to match the lower
dst pmtu on tx path so that packets can be sent out even when
lower dev's pmtu has been changed.

It also works for metadata dst.

Note that this patch doesn't process any pmtu icmp packet.
But even in the future, the support for pmtu icmp packets
process of udp tunnels will also needs this.

The same thing will be done for geneve in another patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 9e9202b50e73..bb44f0c6891f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2155,6 +2155,13 @@ static void vxlan_xmit_one(struct sk_buff *skb, stru=
ct net_device *dev,
 		}
=20
 		ndst =3D &rt->dst;
+		if (skb_dst(skb)) {
+			int mtu =3D dst_mtu(ndst) - VXLAN_HEADROOM;
+
+			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
+						       skb, mtu);
+		}
+
 		tos =3D ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl =3D ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err =3D vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
@@ -2190,6 +2197,13 @@ static void vxlan_xmit_one(struct sk_buff *skb, stru=
ct net_device *dev,
 				goto out_unlock;
 		}
=20
+		if (skb_dst(skb)) {
+			int mtu =3D dst_mtu(ndst) - VXLAN6_HEADROOM;
+
+			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
+						       skb, mtu);
+		}
+
 		tos =3D ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl =3D ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
--=20
2.11.0
