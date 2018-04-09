Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233237-2-1999120111632180219
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
    1523233237; b=kEJD3BHz5M4S0cYo+Rm35Mtj2wWD0HL4TZm0IDTtH9jaqByAWU
    JSuvGhQz+fcF8HG3KNH5nnGCxDXBvX9jg/6Wm3ir+MZFYM1GYt14GMmIX6QtiPQM
    hN6XVnjXf2W7YqG/6/c3KYBc2ElVUyP4jJK2QS8dp/9Hyu6G/SqZmCTYgRq8d5zb
    wtUbYzn++SXbi0OzxHyFyuu20l1lwlpjqvBxgrCL7Ifj6PDwCqYYJy6TOAgUvJhC
    couABF4LAWuZ97Xj9P4riJEsKvoYiBYvjleQqyHbhyv9O383qdx48fwJAV+t1+un
    fbSUrlY4rhwVgc6ptU02GsRaOMDPNi32+Sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233237; bh=IgJZWeeM0K
    MzhzvORsLO0cXFd9I+5mqcItz8aCFHL5c=; b=lXEmmme/VVqvS/iWNFbVtat6S8
    mU5/gGKBJbEqOPKljITNnpPCpt6pw29J6oEhnRnyJzv2SmweAxBXNeX+aBMZBwtu
    sGAGiBoKzjSW+j8/RLkQqRQrCfeJKTKzEaMAo9dHGj1jkwV+DS677cKwEJSNDXAA
    cF3L9T2RBl6HAOLkE7rOYh+y0QFJ52ZhowUnmyHl4qeQ9eowFLsLrBXy48K4g0af
    6+zi9G41iEjmOEl4pGqL46L/HzlM6/IG0QTmpNGSRXzrMqKQ2U6PXN7zoPMlHlic
    l+dEj58bgkSdYCkDpWodMitCnRPiG3uB+8Fiay9nJ+aGqwbY491+5OYxwYjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SKN8nFyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SKN8nFyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKVq4DW1/q4YFELD85Pk1SeCfM3aioOF6A2lB8cVYJ9rdRq2VqhU3We3GthO1Cs1RXoh+iq/Sk3wM0xvTEDZzvYpo5j8sWeb7ZA8VjwJlswOXVnsVItV
    PpmZnqZSLIZLKVx5nd2AJr9vaJyyJOyHERU62aiBNuh6U3vBsmXjMo25NCba2Lp2gfjNslQeVf3axPN64ThA9ps5VYssBlFzosoZVdE3OG3FfKDtQjeEn5Ym
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8
    a=xUU9fX4g5_KzQUx6nhQA:9 a=wPNLvfGTeEIA:10 a=pioyyrs4ZptJ924tMmac:22
    a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDIAUe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:34 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754230AbeDIAUa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 138/189] netfilter: ipv6: nf_defrag: Kill
 frag queue on RFC2460 failure
Thread-Topic: [PATCH AUTOSEL for 4.15 138/189] netfilter: ipv6: nf_defrag:
 Kill frag queue on RFC2460 failure
Thread-Index: AQHTz5hOKfUXpWAQlkC3GPtCp6HoPg==
Date: Mon, 9 Apr 2018 00:18:38 +0000
Message-ID: <20180409001637.162453-138-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:x03UMo3z/AWoBIsVnhA64fiWUaokpyW+WEJx0KiZRvKDkHqQHqmZPgTMt/+wiKX4adCNagiHrOastyjjHFNb3Rxki2wgxmeMrG22x2BAZqhFM6bocYRD4OeIMREeQLqqn1/BnlyshUjUnIRcKMUbcA4wX0Kx7fkKM1FjNHdUps7PdF5/V5x+AD3HXixx9MjimkY2RnkXM6/Xm9QGUAiKaeujnMy542Q8LLXHwE4ZEvnIWcw6Yj71Ba8XNgFVR3TQ;20:coGW0cIB6/CtxojLL6brdg8dPQ8i/vnifRuUPxeexCWCkPz8YP613TaRKZCAz4GE511XnmSDSFxoEGuk7E9l4c4mPeyMFPm1WkmNiH2P21/C0Eo3s8EqlCaGIaRupLJ9DgrGooUb6O1RJeLWe5i7CBM91UUr9FZBoh2Bywfr/34=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 468d81de-6790-4272-d9d2-08d59dafab75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11100DDCD53737D352A5E8AAFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Ud99WMmCuQjpZRgnEo5xJ/TSYWFbpaHxbo2X0w/S0tA7FBDbAOoUoxjfmX0P1/GBB3dax9H8xpWAvoiq8C7V9tA+zFXjAdqwed3jTaguEmsedhVRR0s0cIz31C/ccm/i5Q/+DloIjQSFz1UgvwPz2WlpY+I8Et3rJIvmDDs4rOn6nDhJ1R56zOOGxloG0kH6LyIOTTT5C/I8eAmli8gKu28HixKlMfYyjanHeSQWtn4pcHYwnyMnmt3ARfTHN9B6DwMthEt+GGX8JK1A05L1NYf39a2DaShui84ypr0Yby7nw2ixDsbqFn2Rsjx3pgtkslCABlhccGBDn1HmAYd5u2yXfUdGu/n6YEOtGzsrqwcMkGjsKJM2qWOl+ksTavpsj6qjqrHPKO/yHShJfaGTzNN6K+VzrNfZI5pQFehCaQw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468d81de-6790-4272-d9d2-08d59dafab75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:38.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit ea23d5e3bf340e413b8e05c13da233c99c64142b ]

Failures were seen in ICMPv6 fragmentation timeout tests if they were
run after the RFC2460 failure tests. Kernel was not sending out the
ICMPv6 fragment reassembly time exceeded packet after the fragmentation
reassembly timeout of 1 minute had elapsed.

This happened because the frag queue was not released if an error in
IPv6 fragmentation header was detected by RFC2460.

Fixes: 83f1999caeb1 ("netfilter: ipv6: nf_defrag: Pass on packets to stack =
per RFC2460")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/n=
f_conntrack_reasm.c
index ce53dcfda88a..b84ce3e6d728 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -264,6 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, str=
uct sk_buff *skb,
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
+			inet_frag_kill(&fq->q, &nf_frags);
 			return -EPROTO;
 		}
 		if (end > fq->q.len) {
--=20
2.15.1
