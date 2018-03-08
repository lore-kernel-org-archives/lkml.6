Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487344-2-13999360201549361280
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
    t=1520487343; b=NV+3yw+AISgZ16D/46XHU47hqs9LkW8vAHyhdWa9owxPau7
    VO9nWXIqHN7UTn2PfaWKC7//2O44h2DqR1lhhZq1DEQc7vedo7y6qa+KzRH2BLzt
    SDZDqqxF4IkYXMoDXoGw3Wtl6zDFVvFzYW8jXyaOrvICG2hIrlhbBn4ojGuf57K0
    rnAiI0mHgWFg78/dy1Cj12twvUjUV5LkFsSzBESO6/VrXyxHOTU765GUXOh/HWqZ
    zK0VcQPAGjic6itjgPRtAudD6ZBbnuDEEo/rxPo4tmwEGV6Yce/eCIXoUhYo0CkY
    pcnBAV9/9dCyOv2Pxls9AM3V7f66D2NFkzJnvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487343; bh=jeDo70
    YhDJ4y+WugEX+DGGkC/2us0/FYENMsizM+ubg=; b=ZQRTOhM7hGJf3CcaP4GtN9
    o5KOmsNRqoO6voZ/41D6VzTRdUbc7R8Fy7eQXADV0cfcAjON0CZecR387Yank4DK
    +cma/JyjqW6EmrGGrqKMb/8ESaETZh8MKK5g+uaKyAwvnebrG/Z8W4yCKnPfP5HJ
    pO0uk4FYBvutPKASuM4/v0VlfUwZJ/3/HfAjIz9GQf1LOfcdQ0OTEqVt2JsauBm2
    jIJD880/WQ/zBturSsTHH5JwGDxp0ajMPfI7xWlDk6rDLDJPHt7rtzU6UjvrXipt
    KDBTQMlyZUwmuxGBm3fkmIcnWMTjwFMiv6luKnMHk7iwJ8qTXwTA18bKX160HZcA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WS31C9b3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WS31C9b3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966355AbeCHFf2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:35:28 -0500
Received: from mail-by2nam03on0134.outbound.protection.outlook.com ([104.47.42.134]:6641
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966326AbeCHFGB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jarno Rajahalme <jarno@ovn.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 044/101] openvswitch: Delete conntrack entry
 clashing with an expectation.
Thread-Topic: [PATCH AUTOSEL for 4.4 044/101] openvswitch: Delete conntrack
 entry clashing with an expectation.
Thread-Index: AQHTtpqNxgBJXpp6ik6f/t59D2Gipg==
Date: Thu, 8 Mar 2018 05:01:43 +0000
Message-ID: <20180308050023.8548-44-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:dHQ0llp6jvv80MTkFKKTJ17sje7EIzgnD9x0OmkYT52llrFGVpL99tC8CBvQ25Wu6wuhsY6XzPI7FqhI2742S7vmTCKPHY7tId3JjCcr7k0e4pHga8236hg4yKLCsHLjHynBA7HWUxy9bNfutfjLax2GQyWCdTen7loXVB3nUi472cYV/n4v0KTwKv1YaCo+J/TtshTQ6cQamz8ol0luvWv7dHfHbQlloNt6UlMfAgenvVKJPCvDbtupmihViF8X;20:dKaL2EUzwFBM2gbBDTVi5rjEvqLL9EerDTRgbqx7pwtRqjzedoa0SAu2a6kwe2enFbYO0JsDDLhmAqrxKr0GgLPAh40Pc1rVqaqyusU54nnnwpAsXO4cLGZaegF2/o1/N/Ju1NEY0qqFyrCuf8Am4xEYX2kZcefPTYPtRcXbRCU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca8a2f4e-5e93-4030-dfbd-08d584b24818
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917B11288187238382571C2FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: XpFkGG0v9LDCJG3sXH4MeoqzQXeq5X1yN1i2ZelpRbQE1cZNTdJgCS/rLpSZtrGaP0gK25FM3rcwIZpeSXUmkQfjHq3Qe/G/vsgIKEKs9++1v2OlCzePauIXubtGGZGb1G0Cn9wfv+3ASpMLffPr6TcUvF9JlnL8h+RlyFBvK91a3zEIv5Xf5Pa28F6SyiB68ex8uNeWh71newoYWOPCUAvhSHY4qNbMcwFdM0YuZ/bJwTv92mGf/1WRs9+hbZ+i9Iy2n2olhsS4sJlzmi4vXGJmmlESCpOIWrwEsBukZwD2V2nMtYG5aznZtz3tu/XWb1cqi1l3c84BCqU1CBdpzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8a2f4e-5e93-4030-dfbd-08d584b24818
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:43.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 6a2507f24b0f..1829adb23505 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -361,10 +361,38 @@ ovs_ct_expect_find(struct net *net, const struct nf_c=
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
 /* Determine whether skb->nfct is equal to the result of conntrack lookup.=
 */
--=20
2.14.1
