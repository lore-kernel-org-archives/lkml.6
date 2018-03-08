Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489513-2-16261391188655106232
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
    t=1520489513; b=pcWtR5qEmUgvtFtlFlwb0RMAgTGtXhjcvD+1lkCbziXgpJf
    aY+JwaKtLaO4hANAVR07mU+kt7aydJ4R3C71LfN5oBBOzKmlTEQ+OjOfyfF+hNuW
    L1T0+8ZNSSTrGB/o3Wr8qh+KNy35llDSCIFu7iG12ylkG61AaqaklfWrOw+mFy+v
    ATwuIrAgOeb21Gvcf2d26ssqt5flAY2wpWSkXG3OzQXCJGheID7KYxIsLRj/iJoF
    tk32icy3/oCtU/Z2c89csBU9Z1ILROGFD56m1CEF5grquxDQblE8IDaTdeks4tPX
    vdbwyR3TF/yA6UexDYVEMPZXlvnmdaiC0sSksyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489513; bh=rntZdF
    38CpOVHVcmAbiNmeE2Mo78OX7LobkjCnV3+5g=; b=EtCLrqtjxfsZ84OFKHnPNc
    3c+RaprKoS4Isfbj+lc4H0F+H6I4C6rw5j4FcpgmyZT+mNGRCiGm6pq+2eYtHXO+
    cYM6NbZpZaz674K39wDq/IV8xhsC4jyL9OGsBbbPs6dQ0q2+9J4eMcA6JYFblBUv
    3hIHcgqT9+3Wx8Ax9vR435eQ74O68L5hvMCqtFIN7UZPlW0NXpbAmgxTA0L+YxKd
    efTlp5HcJXiGTIBiLi2uBOZZVWBrZMhAN51EUa+vIuyi44QEhZNqr/DQAGDz69Oa
    uyKceyHyo//7FTTrF1HEOHyAlcEGrb3okdTe3n4YrdJycDMU9uC+FxaBDngP8LHw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTo1fz7a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTo1fz7a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbeCHFBi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:38 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965404AbeCHFBe (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jarno Rajahalme <jarno@ovn.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 076/190] openvswitch: Delete conntrack entry
 clashing with an expectation.
Thread-Topic: [PATCH AUTOSEL for 4.9 076/190] openvswitch: Delete conntrack
 entry clashing with an expectation.
Thread-Index: AQHTtpo6RSYx2AMH8k63KYX8LPqpXg==
Date: Thu, 8 Mar 2018 04:59:25 +0000
Message-ID: <20180308045810.8041-76-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:++0EVtUCWYSCFNLxTeya4iFb4XHUt4QaZNpxuG85XhF0sC2THGcJeNfi7+gXy9G86JfrEsMgXNyg5wMomlYQ3lY/fegRiNoNlvgtu9KZiPPWdkepMOiYiCm216vvpQdtPjVa0I8q07QI3MPLH5YZ6GL6nCidPWAJWohqh8c95IIUlcIqhPfghPrq6i8wlNl5fQYT1n2Lt6QRznG3A7RM031ySN9WrpRf6n6nVI96V1c8U/SqEB4Bv92+S/XEXJlq;20:607N2SvxXxi034Y/OBK/goydXFZre9mYuFXYAAnx8A3WNfMbOyZ3If3o4Y6v2+i4PiPFB69JvrePijtD4Ak9L9ncrWK7p/ifLxhgRU5NhGH0skiHfvkmmqhAPbYIcOcSmCKlJPu9Lbhird35t+gJ23jLgN6eDZVC3B8eoG0iSf4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 752e30d7-9840-4e4c-58f8-08d584b1a584
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090199C2C02A8865B0E5CE98FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2SD0HBBv8g+PRaxijA5Ft8RF7LE5e8HFxHoWXjHsukxYXVETWfDJFR1ZAG1d24Va8q2a8hWeoSOPTZ1ikd6/RcyAoDy13AifiDRdVoNnlz/7dFgU8fgjBVbtFJlG8Of331lLEyGek1XTUyu1+EDXTA+uy7AWMuCgTe93ywSLfzsqomlO1BUkdSzs4YibpecmkCjKj9wJi5aMJVO7i9Ng4TeW6bDxQuZ2chezhU9s8/xtakJGGGybjslSIHu8piThsAFE2GDLQVhiLCOvsa3LeodQJPTCRsBIE+QaU3QSSXl0hcDNOdcJrLOGpOz6/t2cQl7yebhB7eBomzvx5YEIwg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752e30d7-9840-4e4c-58f8-08d584b1a584
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:25.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jarno Rajahalme <jarno@ovn.org>

[ Upstream commit cf5d70918877c6a6655dc1e92e2ebb661ce904fd ]

Conntrack helpers do not check for a potentially clashing conntrack
entry when creating a new expectation.  Also, nf_conntrack_in() will
check expectations (via init_conntrack()) only if a conntrack entry
can not be found.  The expectation for a packet which also matches an
existing conntrack entry will not be removed by conntrack, and is
currently handled inconsistently by OVS, as OVS expects the
expectation to be removed when the connection tracking entry matching
that expectation is confirmed.

It should be noted that normally an IP stack would not allow reuse of
a 5-tuple of an old (possibly lingering) connection for a new data
connection, so this is somewhat unlikely corner case.  However, it is
possible that a misbehaving source could cause conntrack entries be
created that could then interfere with new related connections.

Fix this in the OVS module by deleting the clashing conntrack entry
after an expectation has been matched.  This causes the following
nf_conntrack_in() call also find the expectation and remove it when
creating the new conntrack entry, as well as the forthcoming reply
direction packets to match the new related connection instead of the
old clashing conntrack entry.

Fixes: 7f8a436eaa2c ("openvswitch: Add conntrack action")
Reported-by: Yang Song <yangsong@vmware.com>
Signed-off-by: Jarno Rajahalme <jarno@ovn.org>
Acked-by: Joe Stringer <joe@ovn.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/openvswitch/conntrack.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index b28e45b691de..466393936db9 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -396,10 +396,38 @@ ovs_ct_expect_find(struct net *net, const struct nf_c=
onntrack_zone *zone,
 		   u16 proto, const struct sk_buff *skb)
 {
 	struct nf_conntrack_tuple tuple;
+	struct nf_conntrack_expect *exp;
=20
 	if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, net, &tuple))
 		return NULL;
-	return __nf_ct_expect_find(net, zone, &tuple);
+
+	exp =3D __nf_ct_expect_find(net, zone, &tuple);
+	if (exp) {
+		struct nf_conntrack_tuple_hash *h;
+
+		/* Delete existing conntrack entry, if it clashes with the
+		 * expectation.  This can happen since conntrack ALGs do not
+		 * check for clashes between (new) expectations and existing
+		 * conntrack entries.  nf_conntrack_in() will check the
+		 * expectations only if a conntrack entry can not be found,
+		 * which can lead to OVS finding the expectation (here) in the
+		 * init direction, but which will not be removed by the
+		 * nf_conntrack_in() call, if a matching conntrack entry is
+		 * found instead.  In this case all init direction packets
+		 * would be reported as new related packets, while reply
+		 * direction packets would be reported as un-related
+		 * established packets.
+		 */
+		h =3D nf_conntrack_find_get(net, zone, &tuple);
+		if (h) {
+			struct nf_conn *ct =3D nf_ct_tuplehash_to_ctrack(h);
+
+			nf_ct_delete(ct, 0, 0);
+			nf_conntrack_put(&ct->ct_general);
+		}
+	}
+
+	return exp;
 }
=20
 /* This replicates logic from nf_conntrack_core.c that is not exported. */
--=20
2.14.1
