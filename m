Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480526-2-17070628360314687470
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
    t=1521480525; b=oOnVBrsovSzl+JXq+/gDu5pEuLHnWU0hcvJSq5wSctD++n7
    eSnyc67sxCk8rnzlisYorLC493SI8YCT9itCU8ldRDMVkVGgQruv+SUJUZ5d09VI
    jxHeA1X4SZfsg1Z8B5UCVdp1pX8TU8oF4ll+MX2L/J17oH7uDSQGT+aVtTq6vnPP
    uP5a4hqbHc9nRPpsO+80tgE4mj5iEayf8+tHZAGecCvSa8cRRGNu5JV0rsUwIH1m
    wgKKiN+oJpDTeRSB+X2p+qeSZqcCo8so51kRfsrXIGoDhITeOm63SAgl8VQlf3Ir
    ENvtTptAmApk97V+GEuBT+/bmlNob6TzfNuxNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480525; bh=dwI/VI
    EAeuVGqHQ3nPDLeHp5zsfMcoUoItzeYd7xKo0=; b=kAxrKBV7Rg4W87XXwfXUeH
    C99UanWO3NgmBewelBmocXMbta7RXmfq7PklO1fwu4hsyYCepuRsYsA6/BFvlv+D
    bPgNLkAvXDNmwiafafATp5Da4Lmgp9lOdTtshEsbi8LScI5T/Ntu2xTCf3b5rfaD
    j+ZWRvmH9r4+6IUNafxuq0jDgq2zwas9guwRCn5dqHeDPUyv6EeGBArAN+ImlTeJ
    TfxNk7MAMAJqzDFhrdPqI+Lx1DDToPRWt9A1HKsZXuf1Bpoa7yK8eWy9dUuDt20T
    SammvVa0qqQkG9gfHr8JKRyUB3klQWOBLpg1zHIVgrbq/MoAPCFa8AYHADBPq9Zg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDNFak4v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddufeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDNFak4v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeluddufeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965881AbeCSQIU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:20 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:60247
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966265AbeCSQIN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 043/167] arp: honour gratuitous ARP _replies_
Thread-Topic: [PATCH AUTOSEL for 4.4 043/167] arp: honour gratuitous ARP
 _replies_
Thread-Index: AQHTv5w1LqYMGGVo7Uuu/7kXASgtfg==
Date: Mon, 19 Mar 2018 16:06:15 +0000
Message-ID: <20180319160513.16384-43-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:Su630mhZjNVA3U4hSY6yC8he4o1FWlZvD9ZaLLyYxZBouuSN3kHsNw8G29Iy4zMfHv8X83ZjpuMgxSHqsyTD5UnaW8ag9ZUzyb09MwlHRyhNpcmPE3hpD7y7Zk2ZaJ1lM5AghpA0tVg3tvgto/Mb4oaRTBuDvFd4bOMwSN2DYwdNJimYMTbCU8/QWxYhNiV0AxGYtNxTId4KkYEXVTRSZQIIOHobg/VaLHnm2OBFHYOhUkn7rlh0HwtbAzA2WNjz;20:FZFelZUUo5VdDyV5A3aRF+1l3rc/SnqpivNEuHeWNNDuMP5/HZoF/jYvyFxs/Nxk08XMbVpOoHrdpes5+HniynddpXph42TrPr4BdYko2OgrMLrYWVU+/cFuPwPGt5YLiDsz7IJAtHd8Jl/InyDOI0Tbommx9Q5FWZYKTNXe9OU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0563b5ad-a8ef-4839-7270-08d58db39c35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805BF77D1B7FBFF8D9B5904FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tE12QSHlDe/X/aUliShYnThVny2DMDlmDzWzSU59wIF9nSb+k9P0V1HvoZQS204DpANiReW5g8CvmN/8tB6P34i8dE9f8cu6VCNR8dXDS+Q2Uu5oRe/MVEI5Yp8OHz71On7AUPXk0cF6OmozMhcEJ5YcXRy+J08gv07dAHiZmDtduIGjN1EO+Csx83YPo0r1DEp+UUuukwzir4L8/yFleNglamzlIfcajtY2znyFufr0GqOcitTQOQ7JEAdJcY4C7vLgg5vR2PtmzTbLmdGLfKKUikEsOrjXkXgdxHX9dgwmF0UEa2yePUiSfaXu+fYxqMRHqIXtsg6fN0dn8Rq1wA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0563b5ad-a8ef-4839-7270-08d58db39c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:15.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index cb5eb649ad5f..6bc16a01f1ee 100644
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
@@ -839,8 +841,18 @@ static int arp_process(struct net *net, struct sock *s=
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
