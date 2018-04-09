Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235385-2-18281102048809272782
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
    1523235384; b=FbwLmQEkvTcfkiwFGgAmI6lD3WBF+1sA2DkLrdA4r6zV6Omq+c
    BCnuKkPMZDqmRWPEb2z89bFDI10wtTv03/s4/HPcmycwHg6BAZGZsHAEer5rpir+
    mBAA/ZUSGXsf6HxSuXc+GXdq7VVT2+/rdM5Yj9maLw6vg5noNVlKwvjZFnRBp1Ft
    fGwMreofE4o9CHlwcEBJa8FaBiACa423CWLcGa1PGualK8qzqtREO9AWixkqe/40
    /IWGxHSGH5+FHrk37wU7zRHiRGBVg10zDt/CgnO8L6YGlRDxJ5LIGHvv9kMN9Q9a
    RX+NiDnZajcnCB69ixySH//PwWfOFA+2aaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235384; bh=bC9ZUsdW2H
    OkJWolBK/qt/b1ney/eZSbFt2TeBU2tTQ=; b=A2II7ihk0Kdoi3RzHovvcB+BVf
    KaR/BTAnw6mlYVCgjsg+GBRXiTxmORQGQCWyicf7TsVtaowWcDVl3LbKTaDe6PaW
    OsiwKL3jNS0mikEi/BXApCNnOPYnAbGsTdP3aHksN2srrzqMQ+v7GW4jYjZUTRJY
    U1GZMrWzqevS6s3T+9ARyqOquoqbIQW+/vBvuxRNVJM3odiuvvP1qtufdcdVQQel
    rx9v2xLUB/CxfkFRfTT2fSyBdaXmGpATTZIT2+vSLB/kFjOhBmNIBUB5Uabub87o
    T47YW4VY3SeUyY2np8iqeGML2Nf4Ra4M1QPwkAUgOX4XxBcRjuSzLUBR7mwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mbahB62H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mbahB62H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ12V4ax3yf35G+XZbTJDutmp9pURoL/jNegYNPXlwM5hPv1WQMx9bYnZPk9v8wICjzx3IjTQsG/R6VBH97eruaQTfvKZssaPdK9fot+cGwHNBdnZNST
    dXXzTd+O+TS6AXTtOukhQxMVYeVdK9rtnqyaXOXYC1aq/SraFezfbxk1gLwuj+d5UDCsBWduSNXMpEFOUV5kH8IE/t10FuGs7hP3KPLpegwlQ86JZ7HZBf+Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=omCcO2MVZWPOL_TLC6UA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933474AbeDIAz7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:55:59 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933287AbeDIAkY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 041/101] fib_rules: Resolve goto rules target
 on delete
Thread-Topic: [PATCH AUTOSEL for 3.18 041/101] fib_rules: Resolve goto rules
 target on delete
Thread-Index: AQHTz5q1Gs9ConrExUKVZ2/SnfqjpA==
Date: Mon, 9 Apr 2018 00:35:50 +0000
Message-ID: <20180409003505.164715-41-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:24ehQzUCKU4j3oGRSN6CXKJn1tUJTVvqwlNGniJPUNOu0arZo3Jb1rY1NEJquPu+9ZQZOeslQ6Lwrk8GEZ2WvvSY5Vbvl+tnIJXdaoRbQeoUT5K7HPf7G2brh6dMGvsh5ldQFkB9g2GHd+O7H2d+YJ4IHQ1qZWS3mxjDGABgV+js+ks5AwH1Ru1ip9fXrh2cSsmPs3XvynIvtJuTMBscEiehgPGpckNeDKdv4lvPfqsKcBVk9j3ujOVtjFGUIoS5;20:inJMqRAC93oeGV5OLtjcOAgVTRunFTXw/vDlmBATmJ/V/fEmSH6NTus2lTw/RkEBBC/iq/FVFvxcgNlPJQDjkeulrIoju2Dp8rRErP749u2woSx8LnCzJ4cUvbbF75af65qt24PqTDxaHnfl167tdrj1zB5zva1QY8OSl2ME1o4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87c11d7b-c93d-4ec1-ac3a-08d59db27946
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870B1FB4BE5FF9126BD9E02FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7jIxF3ilRSz7cZ3XOUgI6E3GSMqIWlAIzmxOI0sw9+3bsOxr43MU2l2q/+7JhmjJyf37r+uYNMcD8YmHatAJf+fhH8OujjWKayUdjbAO7wHsT0dj1xGW/GTraDn6TpDRPK7mtPo2/KbCdyI20ZXPiSrwsDGHzYEnQd+yMzK4ExEI1noJwZZEH10sH8StrUooFy67uT97ihP9MDiwhumJCX3al4gOcTFNMG6ahX5enxt82YfDIS8SDxZtoMrcBUP/zuxrEdPyt1g6YaM/QxKIJ7v9ES+S/ERVzEmv+ZRvoyUE6ahMgzPYnQz3oNz8edtMYivodwqVlYUpPVaIvco8F3iy6KPoFr9OoHrr8qWFTingFOCm4BA7MQVGq60w1qVNr2Hm0zPG210g68JrTuGX4RDZ8cTQ4yuySl4nyjDQDbA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c11d7b-c93d-4ec1-ac3a-08d59db27946
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:50.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Serhey Popovych <serhe.popovych@gmail.com>

[ Upstream commit bdaf32c3ced3d111b692f0af585f880f82d686c5 ]

We should avoid marking goto rules unresolved when their
target is actually reachable after rule deletion.

Consolder following sample scenario:

  # ip -4 ru sh
  0:      from all lookup local
  32000:  from all goto 32100
  32100:  from all lookup main
  32100:  from all lookup default
  32766:  from all lookup main
  32767:  from all lookup default

  # ip -4 ru del pref 32100 table main
  # ip -4 ru sh
  0:      from all lookup local
  32000:  from all goto 32100 [unresolved]
  32100:  from all lookup default
  32766:  from all lookup main
  32767:  from all lookup default

After removal of first rule with preference 32100 we
mark all goto rules as unreachable, even when rule with
same preference as removed one still present.

Check if next rule with same preference is available
and make all rules with goto action pointing to it.

Signed-off-by: Serhey Popovych <serhe.popovych@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/fib_rules.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 99ae718b79be..cd92c96aa8de 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -435,7 +435,7 @@ static int fib_nl_delrule(struct sk_buff *skb, struct n=
lmsghdr* nlh)
 	struct net *net =3D sock_net(skb->sk);
 	struct fib_rule_hdr *frh =3D nlmsg_data(nlh);
 	struct fib_rules_ops *ops =3D NULL;
-	struct fib_rule *rule, *tmp;
+	struct fib_rule *rule, *r;
 	struct nlattr *tb[FRA_MAX+1];
 	int err =3D -EINVAL;
=20
@@ -502,16 +502,23 @@ static int fib_nl_delrule(struct sk_buff *skb, struct=
 nlmsghdr* nlh)
=20
 		/*
 		 * Check if this rule is a target to any of them. If so,
+		 * adjust to the next one with the same preference or
 		 * disable them. As this operation is eventually very
-		 * expensive, it is only performed if goto rules have
-		 * actually been added.
+		 * expensive, it is only performed if goto rules, except
+		 * current if it is goto rule, have actually been added.
 		 */
 		if (ops->nr_goto_rules > 0) {
-			list_for_each_entry(tmp, &ops->rules_list, list) {
-				if (rtnl_dereference(tmp->ctarget) =3D=3D rule) {
-					RCU_INIT_POINTER(tmp->ctarget, NULL);
+			struct fib_rule *n;
+
+			n =3D list_next_entry(rule, list);
+			if (&n->list =3D=3D &ops->rules_list || n->pref !=3D rule->pref)
+				n =3D NULL;
+			list_for_each_entry(r, &ops->rules_list, list) {
+				if (rtnl_dereference(r->ctarget) !=3D rule)
+					continue;
+				rcu_assign_pointer(r->ctarget, n);
+				if (!n)
 					ops->unresolved_rules++;
-				}
 			}
 		}
=20
--=20
2.15.1
