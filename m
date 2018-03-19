Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495191-2-3224792565184642376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495190; b=tf72QT3bgW5HE6Yv/cnKIKIPScrDuTg2rEFUnlzzyXScyo4
    bJnMohkXvDgEQkK7H4NXxcvpUkK8o9di9hrJnqcoJGoAb9TkvrjP8APsuyEO4cUN
    zYbYXDUHCCXVN6iwkIc+w6LPmpaAyARj2kABkPuk6BVkimxwF70dpcbLaDxqHu1O
    UaIVw4NYX27zzEke9FUdUySDwwndeuW2jO9kSsd5Iv44B5Fe8G63olgr/8FIyEHS
    /H0PYxmQnSigdcEjJkSecaa9+k0uZD68BMJFNYxsRTEptgHG8PRIZx7+/+09PinQ
    aL4w5IGd02B3BoA0oqexAkK+c3kJQcPP7stgRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495190; bh=nIC98g
    JvTVGlzQgNP4TRqbY2xt7kmfhgCMMwZejssvs=; b=c/UQhhcgVolSBEymKxxiNX
    8hL+91pPSTuNmnbA4H+vJyH5X2dZOmtxFxC+K9m50xbzuax2wfMR1O1SkMu6VLF+
    U1caKUDCFpd4XfXGOy2lg+r6wA/DDyHOxSzyfvjzJmLZN8qNj7rWwpDRCeC0gb1O
    9k4KXWgtPP8OxJCXH50/bC3JIPkMiE2Iksay4uybqjZTwBh9s3PV541eMTvtufp5
    T5U94meerHftR/peJ0NtWNbN24JoTooC+EDI+5fY4s47AL8TMSF5TtyFpaSLI4ks
    mbv/Zy/VsuEVRLVGzTCcuQS13cw+ZA6bBuJvuei/qj0JjUIaRy+/MDpR6WYc+M+A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPI6ATaq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddvfeenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPI6ATaq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddvfeenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032392AbeCSVcv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:32:51 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:56553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965184AbeCSP75 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 064/281] arp: honour gratuitous ARP _replies_
Thread-Topic: [PATCH AUTOSEL for 4.9 064/281] arp: honour gratuitous ARP
 _replies_
Thread-Index: AQHTv5s0yZMpFRf08ESBKgDK1H+Feg==
Date: Mon, 19 Mar 2018 15:59:04 +0000
Message-ID: <20180319155742.13731-64-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:YLPvn3CR8rOVSIPgzmyM7tt+k3Spn4Sib8qkEq6WFO5JtDFziMdyRIVldxJWHlZ+OlsOVWeHl3zIjTXercOwxFxLKyIWPOmgN7Be4Bz02fnMWQ8cvi9T0TwTLPhXOjiKbT0xUDZVYNEWZQzn4y47ukhXkmKpEhGRxHX2/kX1UQhSvTNjvQkUwq9nImHvZilDM3yXHjugGn9tc2tQ5yUiYs2cOTmqDbjxdQa4dbA9iaf2PPxl51eu1DgCmtidirQf;20:w4aNyJNoE7qQEF6l5WUUMgrRnH8MGToUH4k+Gbz3k4e+yntjq/surc6FDQ7zhJk6dLkfQwZQTWAuQ69J+YzKgbKeOeElt67vrF0ukN7ycKqYiGGhxnVMF6KpjN5ERdpBvYvmEs2Ro4tiE1WF+Pq8VVobgDM+LS4lQtIGrJ49d9Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c584ad1e-e3c6-4750-461f-08d58db27597
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098438BF375FF057B8577D93FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: H0A8wh7UgkPo45Gz31xvWf3T3+CaDsX4ElF0y0dkHCOaPJb2cN2PNiwOsR3dP4yj8jl6cYIhJzv0gOeccKq/+mGg03PGDUwxj4ePt7ZhF292XvkxAoN8Wm+GyBH6WniU0xpO+9eLkDp16fplDT3e0fQCbIMcUnMdjcpkR7nhNcNrIjhvK9QQhwoef/f2MEb0q+s7BdlIt93VYfkgFUVqtW5LTavM8Eu+RSbLhz8qZdvCE4tKsMfaUiqUX1nD+ypvlF42XIAInR5tq25dQTJ2JFVhBUQpoosLqL1xfinjd4MAhOgjBVxeMlpdWv2mpwrrQXptFsrkZ84PQDMWlak9ZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c584ad1e-e3c6-4750-461f-08d58db27597
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:04.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ihar Hrachyshka <ihrachys@redhat.com>

[ Upstream commit 23d268eb240954e6e78f7cfab04f2b1e79f84489 ]

When arp_accept is 1, gratuitous ARPs are supposed to override matching
entries irrespective of whether they arrive during locktime. This was
implemented in commit 56022a8fdd87 ("ipv4: arp: update neighbour address
when a gratuitous arp is received and arp_accept is set")

There is a glitch in the patch though. RFC 2002, section 4.6, "ARP,
Proxy ARP, and Gratuitous ARP", defines gratuitous ARPs so that they can
be either of Request or Reply type. Those Reply gratuitous ARPs can be
triggered with standard tooling, for example, arping -A option does just
that.

This patch fixes the glitch, making both Request and Reply flavours of
gratuitous ARPs to behave identically.

As per RFC, if gratuitous ARPs are of Reply type, their Target Hardware
Address field should also be set to the link-layer address to which this
cache entry should be updated. The field is present in ARP over Ethernet
but not in IEEE 1394. In this patch, I don't consider any broadcasted
ARP replies as gratuitous if the field is not present, to conform the
standard. It's not clear whether there is such a thing for IEEE 1394 as
a gratuitous ARP reply; until it's cleared up, we will ignore such
broadcasts. Note that they will still update existing ARP cache entries,
assuming they arrive out of locktime time interval.

Signed-off-by: Ihar Hrachyshka <ihrachys@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/arp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index e60517eb1c3a..43bacf65dbab 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -658,6 +658,7 @@ static int arp_process(struct net *net, struct sock *sk=
, struct sk_buff *skb)
 	unsigned char *arp_ptr;
 	struct rtable *rt;
 	unsigned char *sha;
+	unsigned char *tha =3D NULL;
 	__be32 sip, tip;
 	u16 dev_type =3D dev->type;
 	int addr_type;
@@ -729,6 +730,7 @@ static int arp_process(struct net *net, struct sock *sk=
, struct sk_buff *skb)
 		break;
 #endif
 	default:
+		tha =3D arp_ptr;
 		arp_ptr +=3D dev->addr_len;
 	}
 	memcpy(&tip, arp_ptr, 4);
@@ -847,8 +849,18 @@ static int arp_process(struct net *net, struct sock *s=
k, struct sk_buff *skb)
 		   It is possible, that this option should be enabled for some
 		   devices (strip is candidate)
 		 */
-		is_garp =3D arp->ar_op =3D=3D htons(ARPOP_REQUEST) && tip =3D=3D sip &&
-			  addr_type =3D=3D RTN_UNICAST;
+		is_garp =3D tip =3D=3D sip && addr_type =3D=3D RTN_UNICAST;
+
+		/* Unsolicited ARP _replies_ also require target hwaddr to be
+		 * the same as source.
+		 */
+		if (is_garp && arp->ar_op =3D=3D htons(ARPOP_REPLY))
+			is_garp =3D
+				/* IPv4 over IEEE 1394 doesn't provide target
+				 * hardware address field in its ARP payload.
+				 */
+				tha &&
+				!memcmp(tha, sha, dev->addr_len);
=20
 		if (!n &&
 		    ((arp->ar_op =3D=3D htons(ARPOP_REPLY)  &&
--=20
2.14.1
