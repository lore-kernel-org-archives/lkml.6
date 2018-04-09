Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240666-2-6287296494198370253
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
    1523240665; b=iIMwiQkHBvbAmanBeIcxPpWvzjVO4AXur79AwgC7Ly6guK2Pmt
    rKGqf9N4Go36GVwCqVhgvFx12gab4441W6E15PbbK3Si5sBWFJI60VF9i2TEX8cP
    KqIKWtLSdylWdzUjPSUOlxB9N5uisX6GK6D1G3RhBCNqZO+TofZFbLqQMkHh+NVC
    CdKDN3juk6QBkTaLkt7TVX0YP54O8QJJ0YMqXB94zaRgth64w/YMED1bOfuhWJlz
    1NJQeJeq8UJ/GKDw1j0IZAnaIy/ysVoc1JBhjabhL3BSrBQm/QcPyITDzhQTH9OW
    wfNySmNqXBmDX8mNrTY28vIWweYj9fhHTHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240665; bh=cmx2D6I9z9
    57SIdpCmAL/M2PubD7JYt9vCMfHSulPLQ=; b=etdGwtLj3pJ2dYBOdmnSxJrolN
    7bBd60oXdITajQLA7zWWG1TV9t8OOlb4CYcqLdODepCKzhafQib8E3laurEp+ZN8
    JxfCF0uWa7zUiTlpoCNK1C8cW0BwqvVrSON4mlYikdnGWT2a8cMHgW2sGsYHetTa
    Px0q5zk/cmJAiEhTZLt/ObNarVcUCcX1TFPWjdwTK0iKo+a30d9KI5/VjXeQC8Di
    9hNt7fc2DR1xxtS3LvbkgNg1eN5YOSadDb63pH1WIZIsRiioBVGUQoG7JN7Wz8Yu
    pk1i3ob+PXc/o7m9D8n3pqvau1xT0MC7esGNSy4Tv4dL9PVoSijmNK9R8gHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CH5saQqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CH5saQqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMjpi/cw8hbPvX2GOLrgrzZ+7THX7ky2HdCT5i+C9dWqVyrQDvPpvkci1eToztWMGdScilJxhtobWfaUWQe9cImFubAXszJpCS+cRbwZv2SbRIhWMWO1
    KdNj7+BxI59MJ/SNDuAfdug4KnDm5JCxUxx3d0PyLA+eE0snuiki2rp+WnB0nnYU8sSNoQudlU37xgJjwjf643grJ1ywINTzmMWJXZI/BtrOODi7utlv5eKE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=omCcO2MVZWPOL_TLC6UA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeDICYJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:24:09 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754987AbeDIA3f (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 105/293] fib_rules: Resolve goto rules target
 on delete
Thread-Topic: [PATCH AUTOSEL for 4.9 105/293] fib_rules: Resolve goto rules
 target on delete
Thread-Index: AQHTz5kXvtbgERsx7Ees68HC9pKd4Q==
Date: Mon, 9 Apr 2018 00:24:15 +0000
Message-ID: <20180409002239.163177-105-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:DQuZp2/mRWcDBrPQ4AGA9mnQRgevhpgKVD9xUD8PXuEQD1kHKqQ7BeCHsCrdycHpzqG4aDuJ0QfXHE4rs0953er51wP4YzSI5hgb4s3tcirc4yI7K134uagcGebCcm7zkmKCHYPxpcKJnXXiy/o5iIrWe+lFXnKjZbCY0js01kcat/kf+u6CzTERSc/w9WKFgC7bPLOxvmJABdIQ1PhdkS3oGKcCfYJoZnCym+AjkZVFMICFjZCQMAupzqTahy/E;20:6q5y2/LMkCadTFa9eE5P55+MVT11oR1bo/DvDxuOcKMij/j38dcDDDdy9pKs1Jojc8z5uCL/K7tcA5qs8B+omvNeoZUlHio80CDQkfL9wcZOwWsRm1FSVEhFSbWumUs/84zZBURdzXlamdNi8QP6RtrVWQj/2FSdwgzAfYo9lZw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d6ec2d0-e328-40e5-c182-08d59db0f6e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967D62568E19DB327630365FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TneFZb5nXgtL5WU+woU2Xv0svtezJu676ah1QlrpxymMRXjYBg5ZBlaq4S44OuUeRsz/tuwGNb3+Bv0yUfZ0EoOmnOvgS8cOWuNXgiTD3fHXvv1LKNpuDJ5MP1ITMmyypoScwA9q95uuXh324beCU5d01bdKiggOlsOtLN/Ip+7uhRV5+Be4+zmxv4LO8txKE9RT1IlQnK+oYQv4mbqBj58ZVEEY1rYzRC2ysN9OXcayOqDswRC0KZIZJTkkUUr9JuHFpUEZJ+x4ZX/d1g2jyJ/yFzUBGtn9rCLt7d9iq0XBB6UrKrDsQ+h8zFfW6nb/dqTmzdjl9lv6R1a+GX2xEBvrgFezFD+S3bMZzS3Wd+LsIQGOnTQTwSrfPFzjmoVDq6eEyfYDENwqkneoMQkkHguikOoH23bIgvAtOVUBWTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6ec2d0-e328-40e5-c182-08d59db0f6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:15.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index be4629c344a6..4524bfe7230b 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -495,7 +495,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr=
 *nlh)
 	struct net *net =3D sock_net(skb->sk);
 	struct fib_rule_hdr *frh =3D nlmsg_data(nlh);
 	struct fib_rules_ops *ops =3D NULL;
-	struct fib_rule *rule, *tmp;
+	struct fib_rule *rule, *r;
 	struct nlattr *tb[FRA_MAX+1];
 	int err =3D -EINVAL;
=20
@@ -579,16 +579,23 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsgh=
dr *nlh)
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
