Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681284-2-8594126430763201357
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
    t=1517681283; b=R+DTpaAJChS2vlY73yYD1TAibh04QSK9dfxHOB/ypEcgP8m
    Jahd6Dq1YS39iUEF39W8FO5WqBy2+gMDWepCxiEQ121t4CZC1zle4nm3KZj86Y98
    UJ7lCHwb5JL6adE9AMv89vAqg/2LF+MrN1cewQ3PWs/TWzL18mWHsSsQppdUOftH
    hgFky2TK4npL69QR5hVFJ4S9xCaIpQEDV2yjrniyF5JvvdVq6xzs+21Cihx5AXH8
    uBYE7i97Bt3PfIyt1WePwy/jjEtPpWCj3pCW44tfh5N3fm62yW29mzbII3xjQt1f
    p2L85/J7K4EYU6yTMLxQqrmNej6SksFz12Qow+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681283; bh=n5k1xN
    OXE821P2anQ35CUdN2yJcT69lu6kHJolPOa7g=; b=E9bED2Vh4yKRBv3VFMl9nl
    Lxqmz5hm6eSRxTTsqwGnQ7ADiOJ4LicAEMxdnKGGSVzVPGoksWGFRxPRZ4NEfipL
    pqIIlBR83PL6NkbbxBJDY/Md08cUYhzWi4sOnvvBM3oDNrxrWdjzq5CihLa7V6nH
    +jGFFav8mD3zBF1o3mavvcDXD9sQB8NZ40FFBj/KLfGOYQfC/w0iWIFUBtvSNIrT
    gJ+eaZgM0hnThydbbJ4CezCQAYb4F7lC8BtETLCFel5xS0rnfhPaWU7SBQvL+Wnc
    BSf0TBzmBHnILxU4ckH0QxDAR47l68c1iSTxSZXcL0on7RwewQLEeaksmUqC4Dxw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kl9cy/TW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kl9cy/TW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeBCSH6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:58 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753243AbeBCSF6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brendan McGrath <redmcg@redmandi.dyndns.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 06/52] ipv6: icmp6: Allow icmp messages to be
 looped back
Thread-Topic: [PATCH AUTOSEL for 4.9 06/52] ipv6: icmp6: Allow icmp messages
 to be looped back
Thread-Index: AQHTnRlPfCGhbnDO0UydBZcPEASJog==
Date: Sat, 3 Feb 2018 18:03:35 +0000
Message-ID: <20180203180303.8490-6-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:vXpOyjqjb8ZQKiopNEjPKUSYcbNgetp0XDKvbQ8/BkZmYhUF+ex6q9xgDQnbn3XlnrlrRfOsJn5N+JQrw1+1yEv2MTtfFLDXOdHIjxPnchPdoU3QjezuwH/VdaYrDPIRgAphdvej464NAMN01Oyy6p+Y3RwQVVH/HglvEe8j5SPqbE4aHGHFu2NFvKa7bBUIj4zc9nmrP/PXEt363JI6/iDVpeLyimCOiLQYBwoEMOUejHuitdX4ir0I1H0UB850
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf0e0581-fa90-468f-1d4d-08d56b307207
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099320A2A01F771712C228DDFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(15650500001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vt/BPbluEON3e2yMohY3DuILwLBJ6cF5x2TY/CDDGbtomSguCUrFAywRlOmHCEN7jvKjMZPEHKhc6GHwwyzzHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0e0581-fa90-468f-1d4d-08d56b307207
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:35.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index 6e8bacb0b458..a8f80bd20c55 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1651,6 +1651,7 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *=
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
