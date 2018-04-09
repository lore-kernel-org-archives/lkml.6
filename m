Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244517-2-8420218310415722754
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
    1523244516; b=X+vVbMfNfmMCU2ySlYsEOVGQjhMcpSso4kTRqn5o197iP+X0Vs
    XFPbqzYitVQG1zC/8yR6Vx4/VyzWeUQOZ+PWD/ARzwVdh9xR1UFkEodN7aCvI4GK
    s/jiCK+wnTGYIsNMg/1i3zPJsoTe5fBp7LjP7YcpBciNpMuf38YDxI6vXQm9x/ar
    rcUx3AzCfY9SI2+l6ADoshe11EZmoKx7YgDJLZTPWnioE0McZYcms4APk7/UpQ+l
    tMcBZyOSvPJ61gqEltjqUYrifeb05roZhrpBJd4eYSOhAIkn08oRdOFXdCv9UBtn
    dlhVYoIXYMQRIlCmb1Y80HJFLE9uZxLy8ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244516; bh=Gt3UIj1TFL
    VLFW2KYMcSaRUdZYIC9w4YfKeXktJZXV8=; b=oo4lipGsQo68KTbDtQZrzIFhZg
    /uESpQ+RrsBinh6PFVtSigS/Ry/aumoZ7LFrxUWMFJuIdxLJSnhPJ7VjtwSDUnhX
    ZOpqBdAdrJxzIX3+H5BnJ0B3lWlBzfq+3VZpTrS1wue2FAkQdHa36Ek5ve1B/wWk
    oxEwVmBVdh3PZY9n0tRDqezhiX6UcIOkI7QzSWFEGSRphV58J4jZqAIQWZ6KYA2K
    HrotBv3OBCJm84ljZl9NG1+NBL/DL/TNDeTMG1f5IZmSV9sujKksRba7We7CPNfG
    KvtNHrIPPRUuUAR/1iWrAAemZcvQ7+xV73bYwdwfRtIR6g5pH/EmLMk8TBkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jf6JkNuG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jf6JkNuG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBakXEMH0xC+vDTcxy6Ljx7D6O6Z82N3IL/fymLZnYrRRBXXr4PiXrXQmQ1cJVmnfN7zK7Lyb0NFkW+AyWKa0ZgAoSKqkEOuxQXgTKrgM0sXKPUNtfJC
    uCNbcuY9LgS049gEnwe4YHC9pxHHSLNVbu3izsz2/hT0h8P5nsfXaeT5D0eQnUIDgHv7O/HNW8IZBLOM0RGIWmwRwg7BfPT8HSTVh4q0yMziipszibMl/J9/
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
        id S1751929AbeDID2b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:28:31 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:3548
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754612AbeDIAWG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 010/161] netfilter: ipv6: nf_defrag: Pass on
 packets to stack per RFC2460
Thread-Topic: [PATCH AUTOSEL for 4.14 010/161] netfilter: ipv6: nf_defrag:
 Pass on packets to stack per RFC2460
Thread-Index: AQHTz5h4EFEzG6ns70ueeapQAGxZBg==
Date: Mon, 9 Apr 2018 00:19:48 +0000
Message-ID: <20180409001936.162706-10-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:4K9aPsg6Zv+c9lJY80EoFlSteH4bswFjrf6GTxV66Gq/oTox8cWqrmfUqV2i/vdoxCAxomQLIhuYkdBJr/ZZ6INBx8qFwr5xq6NPWxHX4p6RvrV1zl8RdZyyfNNCvYeTYfvB8hv5t9NGFuAJ7z5YzS4b0cNINJBV9V60BVxvbLswEQbMNcS6g8NV8lJgCL7nJ7zDw3Pq/WGKfXH+ZTfK0VnQBufgMSoYyT6PqoOtEMOC18h5B4dlrnvEEsIouG+8;20:RM69iohd5ua0/ek5phkwE1ZgyDbXd94C1r/laN8ETEK+9iYX28HTY4ES7DgjlcNRgdz4qMVAYDYUux2nFNzsWBOWzgXvfCxb0mjkbFKQWavwPsKHhXVpc5fTE/rkSmVFbBO/7XBJ89PE5v3oB/qG4JBsLSRcJZL2BEPTwQlC77E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0e00b0b-650c-4947-676a-08d59dafe8e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936D99035A1F414F84A0737FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eVvMfg+5+1KiSZLxwlOpX46zJqlBDXX4t5cQ24ycMtXKV5KkAlO8qciYWGjTF+lb/tjP+ow9CXxLr8K/drCSn2L4A9VwpBX9lK3P4b6mZX1iz6Po0oVTF8qJNJoV52Sscw+KGihVWgCbgBToCxVhuofpJ0zUSUU0rfTOWUNhJXdaTVI+ePFXPNZJ6oZOHfHvCIx9Xq0xZrVM7l8i5hcANtb14tHc9fV2KEImEaFjmQcsqMp6JLXNQ343jm1P/G3WQwcbySz4UTP7WWdqvQNJpn2O9ti4f8LVF35s56YOv2rPX2As+XEongd5S1TLSq5zeLMRjqrmL67THNI3+r9WuWH/a6VfxvV2ujahqSoqHkJPXkMSSwUxiZc4ftKrN406WzoWFB86HjNyO5hjfXw72PHJ+Drrc48PT77k30d6lZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e00b0b-650c-4947-676a-08d59dafe8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:48.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
