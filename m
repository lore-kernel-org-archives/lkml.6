Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683904-2-6601482193456014758
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
    t=1517683903; b=OKDilAtOfARQ+Gmv45Ej5g/ixVGJ9POGh7m/HkRC4eCrob7
    CSIkpr9pRC2r0hE3MKjTnE77Mw1gXZyXHQpId9pLnltcGoYEF6ZXFKpQK2WlDSy7
    7Puz6Fw6wBj+rtG97eO07K9ghWK+1SYjIhXhoZlNlirIr8tywz+7zaLjZtTfnMby
    rzsNxLsNLTHgKXJwo0LAsdgYRwvWnqAHVL2At1T9J71ghwEDrOVjTI4lK+23Dyoa
    er3LnyoyFjJnsEqJBNjKgel1QwSIG81QslESc3CdP+02SDdce9BYAESzoXHy/ERi
    Xn3eSs+p+eOWcW+025K7LQfDluXbafkJncbGyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683903; bh=5rQmnd
    WgFF1alHt3zaHtcwqpWddl2wyrwxebBnp/GiE=; b=C5qP8LErkpI9VQCgVnLR9/
    QAtqNgBXHttahns0RT/Cx2c9eh/J1GgkFKh/X+9jfThPctwr1S3A2v+D82HIRbOU
    cP/orNVUDnMDqTHGD6akBC4ghgyOR+kQt4ypxlCjny6vEN/8aaCBea9g/wunGfrR
    NjlhimdOJVCFZJrtCTlOXd2YUHHYssTiohQgC/CKKHT4w4nOTbsI1C6AGoUvj4kg
    ebGulHe4QcNwnHDedSn0GTz91Zbcg8FSmeoJZnJlva6gMSm1XZqxKSPdB/y93lMS
    K6HHdauV3mer5In87K4sI/2JAhBMOouJ0bpkpUyOL1UfevkQLgEwVf/y4lmLNQoA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eSby5e+q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eSby5e+q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeBCSve (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:34 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752885AbeBCSBX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brendan McGrath <redmcg@redmandi.dyndns.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 015/110] ipv6: icmp6: Allow icmp messages to
 be looped back
Thread-Topic: [PATCH AUTOSEL for 4.14 015/110] ipv6: icmp6: Allow icmp
 messages to be looped back
Thread-Index: AQHTnRjiO4q3wfYenUW9lqtwKlQyMg==
Date: Sat, 3 Feb 2018 18:00:33 +0000
Message-ID: <20180203180015.29073-15-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:kRx2/PDmcAYuu8qeeejLoM6MXfXc1eMdXkOWYeGphV8Ltps/hPYtbpg6yMhEQnyvpNbq+YFAm9RgaS9K20S2IfQy9yzYJeGg08lHaKFicc8C9YB/aWJQMWhGEqwhl+zf/306H2zR3oumaY1BNEhMZlTSKDLjVU06o7vdyDvpAQDvnAuJhJtIGkuPCdrCIpeGSzcvbNqYMvOJLzT3A8ZdPucrgOeew7oM+BaGsVY6GqT+qODXIO9eYB3MoipmfuVD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7899f9a-9abf-41bc-7807-08d56b30070e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043C517B70F385754C5D8F0FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(6666003)(2950100002)(2906002)(5660300001)(4326008)(106356001)(15650500001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: zYaLQXa3qqpYusM5ihb5IV7G7cDEETNNNKMaExDvUD+uldeIJbrpMWqKV5Rgfjlj/zB0MaE+5tql2P5UQWzh6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7899f9a-9abf-41bc-7807-08d56b30070e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:33.7065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
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
index ca8d3266e92e..a4a865c8a23c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1755,6 +1755,7 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *=
dev,
 	}
=20
 	rt->dst.flags |=3D DST_HOST;
+	rt->dst.input =3D ip6_input;
 	rt->dst.output  =3D ip6_output;
 	rt->rt6i_gateway  =3D fl6->daddr;
 	rt->rt6i_dst.addr =3D fl6->daddr;
--=20
2.11.0
