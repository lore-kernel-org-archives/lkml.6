Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247117-2-14571042798368863609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247117; b=LGM4QszlE8vVipRI0YSIzcMDG12YCQ/uWcc1w0ahMPDj0DCbez
    vicM0xcfopZYwhkIckjp2z+Cx8iN5fB5VZxYDXBGlO0gRmuOPvRzSWyYq+NDK974
    pJWJ3dRLgcBGhm0/y2OvVR15ATbjWwMagEsTYDewAJfkXJo7Wr5gBSibHzJIBGdt
    dnPUQurBuPvL/qU5adlWxj+mqhEkRCMsTztB4nmYH1qUB5VkBbuO5TyJ/QxwUR6L
    M3V4XfXcJ906XWgRRPifan0srKKCIE8n4O8M4zYE3GRdGa6oveOnsm3vbpEuPkVf
    +xhebEDrfJF65QUpgQA0VEfqN+TSOulQvMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247117; bh=UXgtw3eHGd
    leAb6gOz6h4O88NQ7JUNffH6CySdEa/js=; b=moqIhtqGgh/HeK3ZTcpAvTxIA3
    2Lc0Xa4CrePYWtd0p/HR9NlEBHQpkEGsiKRnZRUGWp9JwIQuOaxVJ3QAyaOhUOwD
    WDHJePKMasGNjsmM14JMGVyXAKzcqkkGoI2KfCF+wb0Bm+qxyrUzIcYuK1v/waHL
    JsxpwfUN8FyxiTiK0VKRdBeoiiUtGlyI2leDFn9BA/VzmvE3dNdyKzygh0R4Yrdr
    ENsgcmieQzhEnDZMoeeHxwuNsJA6/XAchG9owp6eHNzuDwDp9hhCNtVYniwk6b0x
    8T21poKpz/BWeMcTK0ruez8gIhtK/K3rJ8HwHFXeQX3k9weRTC3sdSMFspFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gbY4u5PW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gbY4u5PW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNN7Cm6L4rS6wD69TCr8ATsrgK4x2IBwb4KeYyyK5DVN+hEoxM+KhrvjQdqY8OgwdnCoWLIPD6+Z12FG3hYH0dLcwaJX94zNDZyRmcRA9I/pqhJurEGQ
    3D9fFCn/nm0hyBvDGy6qkTbcsw/vvFMWUuc1k/8LWwA8edo0R7TDWyfgbnh7HxefAgiKaRd1QD0KTRuC1FLlLTeymq6yQ3bqR6zbF/hZugNOVurAQnQZo+u1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=qMv-qn4yAAAA:8 a=3HDBlxybAAAA:8
    a=yMhMjlubAAAA:8 a=izA1NLxABTmRaxt-_GoA:9 a=mEoWeofvHKVP_fee:21
    a=QgpgY2_U_S3bupyR:21 a=wPNLvfGTeEIA:10 a=pioyyrs4ZptJ924tMmac:22
    a=izTqne_Zf0vEa248vB0h:22 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDIELo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:11:44 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752943AbeDIARA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 013/189] netfilter: ipv6: nf_defrag: Pass on
 packets to stack per RFC2460
Thread-Topic: [PATCH AUTOSEL for 4.15 013/189] netfilter: ipv6: nf_defrag:
 Pass on packets to stack per RFC2460
Thread-Index: AQHTz5gQ/CSsyyy2QkaeZjLbUbysqQ==
Date: Mon, 9 Apr 2018 00:16:54 +0000
Message-ID: <20180409001637.162453-13-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:XCMG/Tb+8uJIlW2tPcI5immKbIQyVfTpUhks5cUsc8ZSsEKu8rC2fOoBjce80iujJ0ZXEyQbjDIPXDjg27xM9EowpZ8vN2oPYioQuIARcmvW4WCbw3TgNM/4Ph2RGZxD21s0bCnFcmCzgbw5SGm7tcW4sjPvLJQNfckvJQLqaxTCvtz2ZjVc7JOToJ6x7sDQZmjjeKvuRUbo0whwFTbw4H07jkuH4XyGEbAuvv+vVMjjzbbhUJ2YdZc+TDHH3aJZ;20:XsHNk0VhSzimgo2Lp6icasTKohyWUv8M7KZ5hpIGARAPc9sDBEA92qiso9owozfiUzMM7GSEiqJrpGiqMOzq3gWILElPbX0BGBh3aBuqYhnIkRuHDXLpSjkFzQHLvKPsyMQqWnYsro+3XxeF1oSYSvx0gMZGpcqrqQMcxtnYil0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 027761fd-b392-4b24-f125-08d59daf3319
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11271CF86752D36325B1E5D9FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: S4XJ1HKflInpBWSvWWdtcjKDPtp7MMTjp7HrxtFvly2uA7uuHmQ4hqG10bACmuekDJMeB8fAC2DcIs8tFSK+I5hD2CEM+BQyu9nl6pERpySRVs13Hq7Mmv9EhjV0jExIznPBYAe4szJVYyKiwDW9EbXmWT1wSpUrL2AGhDmToF+YRgpVN9WMXGOKKqfH7z2Ge3sHW6D/FdM+intrfckyy11EuDv0HhU/ce5ZfjARLFO6EUUBy+hNTruNMibmtEc8cTDEYazEm7SsWH3i+V3X6txLU+sJAmkPuJp3TfgruMS+t0I5umV5nWCalwi9x3KHedo0Mj9VjVSRUkXchxVBY9vHQ6R8iRGbQmgcmfpEYScBlvfHMKv5jq/7Ujs+ga1F6CI+Ijk9UVoSr9TleNCN5uyoTbEph07HtBLLr0UAfpU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027761fd-b392-4b24-f125-08d59daf3319
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:54.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
index 977d8900cfd1..ce53dcfda88a 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -231,7 +231,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
=20
 	if ((unsigned int)end > IPV6_MAXPLEN) {
 		pr_debug("offset is too large.\n");
-		return -1;
+		return -EINVAL;
 	}
=20
 	ecn =3D ip6_frag_ecn(ipv6_hdr(skb));
@@ -264,7 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
-			return -1;
+			return -EPROTO;
 		}
 		if (end > fq->q.len) {
 			/* Some bits beyond end -> corruption. */
@@ -358,7 +358,7 @@ found:
 discard_fq:
 	inet_frag_kill(&fq->q, &nf_frags);
 err:
-	return -1;
+	return -EINVAL;
 }
=20
 /*
@@ -567,6 +567,7 @@ find_prev_fhdr(struct sk_buff *skb, u8 *prevhdrp, int *=
prevhoff, int *fhoff)
=20
 int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 {
+	u16 savethdr =3D skb->transport_header;
 	struct net_device *dev =3D skb->dev;
 	int fhoff, nhoff, ret;
 	struct frag_hdr *fhdr;
@@ -600,8 +601,12 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff=
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
