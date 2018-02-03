Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682265-2-10807564053909452825
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
    t=1517682265; b=U/1FrVBdaMepGcVBqpjYf8oxjdQlm3rVh45bJP8xsHLaQ7f
    eLgpFBV7ucBH9feaf2+0d6h0QuaB4RNp/ZzYRuGtYw3kfm9EQe2uvRAXvpcfTe+x
    W0mDmudqBvTQbZ7KoL3CBxPNK5n29HqIW4IrlbCjt4l48RBOE7zvhCE9s1ZmGvbj
    ABQUK0Z1ntKBb5nBHDByUjO097flAynvpCsgEBqQxLRalxu3yi8njMvUn+LsfMLU
    nrbGHkKCX40ft72CjiFEzTdtFcTAKgJLTfS9udbi9x0Jkb300tOIvA9PiPI6cwXr
    AIwZZnCAphCyi55/OnqQRCedR1zJKeBj62GF2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682265; bh=UysF+/
    311G42Cis6KAc6QujHyoQ45OMqBKy5b2buH7c=; b=puiX+eJmQseUJtjtPPQ6Di
    bPI7mPt6z3cNMb1g7HmB0oIbb8FzaUWsUbzu1Q+RyURyX2urhgztv4dK1j+ZRWuV
    IGOzFxGot3+3m+rpM0xXONhtTYlEKeEBHDPYALMC53Mx7Z5LYDIkqLtbLgRQqzD2
    PwhoEnKNs/9buZB5h0OSFORJFeaGmhZ468x2V3C/LYNyYik7GDFjYrSe+21OFUpW
    h+1DE7RALI2t7ovYXTji7/8DLpUcqw9nj2T+zCN9x6Ke+iSDeB1zRWwj+eLo7yMy
    zoLLPsJkkYlG7BkfIn2DSWTYKqU+n0gG6ORYzCEJQzswhsNWjmfNzC3hj7o2kwsA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I234LmYx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I234LmYx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeBCSYR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:24:17 -0500
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:45412
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753422AbeBCSGI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brendan McGrath <redmcg@redmandi.dyndns.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 02/32] ipv6: icmp6: Allow icmp messages to be
 looped back
Thread-Topic: [PATCH AUTOSEL for 4.4 02/32] ipv6: icmp6: Allow icmp messages
 to be looped back
Thread-Index: AQHTnRls9kRFlZByoUqehAfjLWyUWg==
Date: Sat, 3 Feb 2018 18:04:24 +0000
Message-ID: <20180203180413.7438-2-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:yJAPL72pZbqX3npWXGztOl2etlMzkKpbFF7j4K21BN0t2d8bkRTmOyx5w/p+E/pXPjhApEiS+qQUoTFXlL97oICpiY+2nl0z5GUat5f3/1WJ2qqEtDFs0bnx0arodNiz9H3S3r13epThCnIHsHlIkBXf0SSyaOEwviWIiJF8n9nTC76ERKZl0zeWkLop65Y8y/N2xmL80uPiI+b0wrru0XosfjoJFlzv15rxuu+yssdNfcO9KFNTcn//4e3ZctBE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6892985-d7f5-4a46-c4f7-08d56b30a51e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089D88952975BA8C755D490FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(15650500001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 5wOvAF96N9KRDiFzAzRFujJYN8IfyPinwNLulMriam4w3yxj437qrWimDFAf5CPwa4uBe9i3N4unLwcBMGcS4A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6892985-d7f5-4a46-c4f7-08d56b30a51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:24.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brendan McGrath <redmcg@redmandi.dyndns.org>

[ Upstream commit 588753f1eb18978512b1c9b85fddb457d46f9033 ]

One example of when an ICMPv6 packet is required to be looped back is
when a host acts as both a Multicast Listener and a Multicast Router.

A Multicast Router will listen on address ff02::16 for MLDv2 messages.

Currently, MLDv2 messages originating from a Multicast Listener running
on the same host as the Multicast Router are not being delivered to the
Multicast Router. This is due to dst.input being assigned the default
value of dst_discard.

This results in the packet being looped back but discarded before being
delivered to the Multicast Router.

This patch sets dst.input to ip6_input to ensure a looped back packet
is delivered to the Multicast Router.

Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7336a7311038..48db6f5cec2c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1614,6 +1614,7 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *=
dev,
 	}
=20
 	rt->dst.flags |=3D DST_HOST;
+	rt->dst.input =3D ip6_input;
 	rt->dst.output  =3D ip6_output;
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->rt6i_gateway  =3D fl6->daddr;
--=20
2.11.0
