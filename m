Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233979-2-13138542998085179433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233978; b=lcUg4z1XAdJ/I9LSU4XwsoS/4IfsHvBpZnlXtSHRoe8cQmuXvh
    hV+aOGiQrYdKgx9fWLg7n0bi0PHRHQ+EVASh7YWSuB61k51e04DJlmAnLIc1Vvov
    zDi7aJG7czVmN8QO0j0I+2SHJ8P/KQtbB11tJkeo5ZYANoQnOdKnmrmb0gBZ8Lwg
    as664qNmEphOvWw3dUxiOJPeuWGl7JqNabkdqut5BDmSu8Hq4oWb/BlgerQY9BM2
    6VpgjQS7cTeTR70ryKt1kPAq8+FWtMW26C4W2yoXtkZ45d1nHPPWuAakgUL6068f
    opjosu0y7VL6klWXwuI6HS2fluE9RrTvMl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233978; bh=Gt3UIj1TFL
    VLFW2KYMcSaRUdZYIC9w4YfKeXktJZXV8=; b=pUpD7+wTchW3/ZSLSeSKLf2aIw
    Z9U9iCtsbfUsOSGETZb3b7hrjNLGDF0+lOgiPgaXLv1gPwPObRg/3sYxtdeFMF1X
    nbBMdZDuLovLewF45nJtEu0MffsVaZkBY+Z0PLCLBthuTXSS//7N//a3QYPSNpRY
    GYB+oh6/9MQ19WuseiZFJ9Aki8T91Pr85ynasySOynmyzGAzk7IZbJmKHAmqq0ri
    qKBn+PUGQBM87L7HwH/R2E/eW/XzUN5LiHfHC8sYXj5OcvEWFNKdkjLjIgF5VKjg
    gqrhVhOYbHRJBtpc5dZ2fEmwljL2n3GkbeUfDv6becVXhpdcOUNRl68Xzrcw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XjCoh5w8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XjCoh5w8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9/5N2a9CoFp4RxCH58ZUm5lYr7Rboj16SZbvAiJEtOAHlhIedwYVjHFSnSYrG6lMi2E+16GjgsE5vdvIb5lh1tvxzRvBSG+BCAJ+BOrCLIzC4s3Yvh
    BAip3HH0DSUKe1GC+rJMrmnDyCRlPoUtXcwnrJGPzLT/QeQY1HwvKIjhkhJZsxxIHwclKE6UysNRyl2APhMNrsVfGOA0c8qkDVTs3w8ntOtvmBw3BOoU40GN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=qMv-qn4yAAAA:8 a=3HDBlxybAAAA:8
    a=yMhMjlubAAAA:8 a=izA1NLxABTmRaxt-_GoA:9 a=mEoWeofvHKVP_fee:21
    a=QgpgY2_U_S3bupyR:21 a=wPNLvfGTeEIA:10 a=pioyyrs4ZptJ924tMmac:22
    a=izTqne_Zf0vEa248vB0h:22 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeDIAcx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:53 -0400
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:8059
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756533AbeDIAcv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 216/293] netfilter: ipv6: nf_defrag: Pass on
 packets to stack per RFC2460
Thread-Topic: [PATCH AUTOSEL for 4.9 216/293] netfilter: ipv6: nf_defrag: Pass
 on packets to stack per RFC2460
Thread-Index: AQHTz5lLjvOOBpUI00SuEFLHBjsZfQ==
Date: Mon, 9 Apr 2018 00:25:42 +0000
Message-ID: <20180409002239.163177-216-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:3d8BOTHoFsaipBAldrVNe2wChhd0J2rpGFasorUeloUf+2dBXMXrsHCpf4U4XE79iR3AJVJNcc+B6HreIMBoUrbT8VwP05stSTXeBPePIAHpVnocym0LV2QlGxR83ZrIOFrz6PmgudyNFp5l32+3GdLwsqP0H9J90wPrtTY7qqxPBEvUKtn8mBwKzKg869f2UkNw2M42tf9LJ5Pbxio7o1H/bZSOa5DJ7HnNQ57SN2q2c+muI2Dwut1eGGpDB4ob;20:ztiiJki5SoBliuwRKEAw8qgdUuEBRfSCgpy3h6rt68YX+jS1r13p9ekfHW8VY6Wg2xvFOaQvlw/u3G14ubJpsAQyr/b/Ow6H5P2r3hrmD6H0peqQf09QQ2vHA51094iFAUbWeKxdlHo6h597qDrby1R7j7rhCUttdTRSfpfufGY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36e99630-428e-4dde-de88-08d59db16c0f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998AFD0F4D08CCEDCA1F5BCFBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aKyUCRNAT19blUVtPGxcvHB7YUpva1C4NSlaO4JbwzHtVkh3xsAjlTAtwPPHAKovqZlav7OAG9j395P0koazdD0teHxpy1GuN9qSUk4XGChIVqDw97b2DCjBu4/RH+DV44tyo/YD5qDnR47fxeGfmr1afPOJLAdkKHdkeQ6TVDEb8Fx5T4VWQ3iwnsmCpJ6OMQc0H+V5wJRgDuMD4kjDhIqcv7o3E0/aPHgSlAYfvfhZnYJ+gH28Q5rkNTpRPf5I0u5HdHGHUMQ+meRYUJlBDF9e4gvjaDN0JRCwZyS2IKBy189VhOFr4C2B3+vvI2RWV21PILuw4walLNCuLyo3i8NJbaUFvl3s9Kqf/yXqfGDBvSVCK+HQ/uGPWR2gU8D2uqT23q6I5RHHxKbn6xo5bPrX7kEdtayemrrqfG2IlWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e99630-428e-4dde-de88-08d59db16c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:42.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 83f1999caeb14e15df205e80d210699951733287 ]

ipv6_defrag pulls network headers before fragment header. In case of
an error, the netfilter layer is currently dropping these packets.
This results in failure of some IPv6 standards tests which passed on
older kernels due to the netfilter framework using cloning.

The test case run here is a check for ICMPv6 error message replies
when some invalid IPv6 fragments are sent. This specific test case is
listed in https://www.ipv6ready.org/docs/Core_Conformance_Latest.pdf
in the Extension Header Processing Order section.

A packet with unrecognized option Type 11 is sent and the test expects
an ICMP error in line with RFC2460 section 4.2 -

11 - discard the packet and, only if the packet's Destination
     Address was not a multicast address, send an ICMP Parameter
     Problem, Code 2, message to the packet's Source Address,
     pointing to the unrecognized Option Type.

Since netfilter layer now drops all invalid IPv6 frag packets, we no
longer see the ICMP error message and fail the test case.

To fix this, save the transport header. If defrag is unable to process
the packet due to RFC2460, restore the transport header and allow packet
to be processed by stack. There is no change for other packet
processing paths.

Tested by confirming that stack sends an ICMP error when it receives
these packets. Also tested that fragmented ICMP pings succeed.

v1->v2: Instead of cloning always, save the transport_header and
restore it in case of this specific error. Update the title and
commit message accordingly.

Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/n=
f_conntrack_reasm.c
index b263bf3a19f7..5edfe66a3d7a 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -230,7 +230,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
=20
 	if ((unsigned int)end > IPV6_MAXPLEN) {
 		pr_debug("offset is too large.\n");
-		return -1;
+		return -EINVAL;
 	}
=20
 	ecn =3D ip6_frag_ecn(ipv6_hdr(skb));
@@ -263,7 +263,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
-			return -1;
+			return -EPROTO;
 		}
 		if (end > fq->q.len) {
 			/* Some bits beyond end -> corruption. */
@@ -357,7 +357,7 @@ found:
 discard_fq:
 	inet_frag_kill(&fq->q, &nf_frags);
 err:
-	return -1;
+	return -EINVAL;
 }
=20
 /*
@@ -566,6 +566,7 @@ find_prev_fhdr(struct sk_buff *skb, u8 *prevhdrp, int *=
prevhoff, int *fhoff)
=20
 int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 {
+	u16 savethdr =3D skb->transport_header;
 	struct net_device *dev =3D skb->dev;
 	int fhoff, nhoff, ret;
 	struct frag_hdr *fhdr;
@@ -599,8 +600,12 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff=
 *skb, u32 user)
=20
 	spin_lock_bh(&fq->q.lock);
=20
-	if (nf_ct_frag6_queue(fq, skb, fhdr, nhoff) < 0) {
-		ret =3D -EINVAL;
+	ret =3D nf_ct_frag6_queue(fq, skb, fhdr, nhoff);
+	if (ret < 0) {
+		if (ret =3D=3D -EPROTO) {
+			skb->transport_header =3D savethdr;
+			ret =3D 0;
+		}
 		goto out_unlock;
 	}
=20
--=20
2.15.1
