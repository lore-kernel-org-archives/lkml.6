Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237290-2-9405737767700762694
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
    1523237290; b=IgyDBPsZrbz40FufTn+IiYSHmF9i/5ESTz9CBa450SGXDKfApd
    s8QOwzA2nf4qdplRYNxgf/6LdIoc2JiKpYnrvT/+MHtPlvEz34A4mc/QsLihhXwu
    OlOIf16B40DzCLcbjXmE3+Z5H18L5qeUlGmarvUy1/uYAeSPaAQplSwRWGIpu5NA
    gJnAFu8j0Dvu/4m43Uqb7O998oHA0YCOHkxTEOpD4Dn1ZV5upwgZB5hehkdokLpX
    VRdOyjAxnDc3KRv/Mc5wtErkY/N0qQrvDcvzcjAfzFJh0mkyMl9i8g+m0A2nt9t0
    XAGaYgK9TdfY6CSEpJxTIbojDMOyMTm+0c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237290; bh=hDs0OgGEOJ
    TE87JIpEkn7zg3nnsqXVgeZkibDWOvlUg=; b=jFRNwebOBWY5eG7IvMc4bFGO66
    av1OlAJuoLS0CYenY3LC1+uYkA3qbCYfyyR82fWiGkGDsnkJV0cDiYWUwmO/7WN1
    421flYO3okLPqOXYVZj5MNQ1i7wf/mgQFoaz7PHbZlEEgraR4VwgPQMdY451wD2U
    bAo/8wFiynjHaz3OZwacCjxDG3K9TjRknB6zaeahTBGVb0iex45BFOjb7ah1ZUdx
    dux0Us+7Lfnn5P8h0wydyxyXhkehoQNR+1Cb9e8nw8gyJyeZnv6bmMzGD71aaVVY
    OOgP1XyUc9jCW14cpR+u2kd2h8AqlMXQATrIofksIDZVy3It5/hsqc4Lu7GA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LeGcHIS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LeGcHIS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE0h5VTtI305JCEKb+6dqPZP8tFxz+NkVzN+QSMyisaf/bYCOZgFfi9WNySxobhu9cnoZuShS9drowDoffCNVVNx0QWDVmA3YhGmmvHu7nweoqTZM/8G
    iDxCCHA280nMFtCzSD6ArIyDtaZG8E31+fYdMwmxhwj8RCKWEwrBlewFVaA7KBsIs8IY/zOAWl7lopHACbKRFMsnMwYqj09CkX6CjELaoEOWO1PzjUvfjeGk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=omCcO2MVZWPOL_TLC6UA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756828AbeDIB1r (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:27:47 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754855AbeDIAgN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 055/162] fib_rules: Resolve goto rules target
 on delete
Thread-Topic: [PATCH AUTOSEL for 4.4 055/162] fib_rules: Resolve goto rules
 target on delete
Thread-Index: AQHTz5mq9Yz/+ANMjUKoSDsoFnx5Pw==
Date: Mon, 9 Apr 2018 00:28:22 +0000
Message-ID: <20180409002738.163941-55-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:fbZ+bEwJjWFDWQFQHMVnJ9V3gpflcVwRx8XS4hGX8y4F3UP9pyWNhFnaPt8dq8Eeac30oNDespFZcrTaRkZTjf05ffroicZtBAz+hcYzIaFFkyp0Xf7FH2nIaiZQczUexxfwmEJ+Mp1D+X1mv79naLfeq3t/0En0+gADCi+9uQMyxhEKSjQR0SQNN+1RsIt2hAaAFedSky9OL1gme9T+NmlrNACKUzkgbWdll5OVuSrQQck+WWhLBQ8KSiUtLTSx;20:VmlyjzLyFT1tdXhUcBwpCInhFhnQFpeo7vB6jcBzI7FoWHCAqXn/7MLbueelhpkIFMKyDLNYx+PX1tFA5hO+asA4gOxuIfCH/s84p36VYcdnj+gZmbGuThvslMcz+y9hhPl5Qr5Wp6+yG3lWO08C2Nv+qC8yUyvMvaiyp50/nXk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56f97239-102d-457b-f57a-08d59db1e3d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10152FE5221294E61027AF3AFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zN721oP0DMvRPe1+jqb4olnPw2A/gU0PzjzhYuah1wqIY6AoaXkG+FmbeeZLFrR8/q3MJCEnvFSXLetj4hNsUVMcUHsSgJ7zTTjPiMZeP4hvaTtLkD4+gWx3s4sxpNzLSJpK1DMn+qpsz9Chgn24BJ6RBJdj1gxi8QfQNGtybBm7aC08yTSoapjWa9DKsP0ZunwEHLaGu8JeQ/+MyHTOaZVve34fOau9aXgkFjZpRVxRbJ5ckr2vKeYcpqEyU1ZnFbebNRgUTnH8tQzYXh1vQvE782/AzYv6jx13++54PxZu7THCm0duu9SFSttHYgQiIsp9Ko1MNCCdUJm6LeYnzUnVfmlF5OnKW/7o8OWvNtVm7IZ6IPHOZNOXa61ZxsW/CYgK4iTMB29v+UOMurtA+X/CqCp6k0zVO9AmFRyusEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f97239-102d-457b-f57a-08d59db1e3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:22.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 365de66436ac..8df55176c9b8 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -430,7 +430,7 @@ static int fib_nl_delrule(struct sk_buff *skb, struct n=
lmsghdr* nlh)
 	struct net *net =3D sock_net(skb->sk);
 	struct fib_rule_hdr *frh =3D nlmsg_data(nlh);
 	struct fib_rules_ops *ops =3D NULL;
-	struct fib_rule *rule, *tmp;
+	struct fib_rule *rule, *r;
 	struct nlattr *tb[FRA_MAX+1];
 	int err =3D -EINVAL;
=20
@@ -510,16 +510,23 @@ static int fib_nl_delrule(struct sk_buff *skb, struct=
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
