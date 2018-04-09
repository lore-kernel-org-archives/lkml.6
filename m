Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239374-2-7043724220497544302
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
    1523239374; b=Qj0aMRUoqmWbCB6soE1GpJl5fOoJ/7GIdpilsjLSynFb4xd9Uz
    0Rg0G1qnlzJet9TjFnow+hYBt9Qh+vNHR0vRAKp1B0grK61usfZ3GawzfAcDbJ7Z
    KMUP18D6yZyA4c3xCYYNgR9d9TFzkTn2NqUzbJwnV1w/JDwlve44u0Nrtq+s8ka9
    x3znlJK0SNQ66wYAzxustfPdb7l6QnqgD8gt7EhTu5J4+TDK1j2N7yUkswg8eJIo
    B1uP2WUI5/WSQA8QJ9CujITIiotCHCvbH98VYI+qjWWJwkuU+dr1P8CohsGT34/D
    Tah89wpwUhFpmt9Q/tKuK1esdDvDvL8Jk71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239374; bh=e/ycNec9WR
    78R6m2BR7mOkHDCtpJ9ibZhqF/dABRlEw=; b=dGon+ZyHxzN9m7tDFmk3LTUTMM
    jdettIP+EaVKhnBP7yb2h95wT8gbiZYYabdLVnMqAayaODgQtOzGu+ZUmorwoy50
    4J7phnraWnA7kSeEtnG8OOg09fS1f0HZb4UitJDbG9oJeF3WesA2DA58txCPA8Si
    gRSJlgETIuDc8RgvJ0C+Kg5YlvcOb3G1w5uOP3rteIjVal/ri3CP6YOye8frrpA1
    4uxn6+GNGEB3nR+F2anLUMTcxeJI/7C1pX4tJfMVMtW5t8MfBtpXC5rqHTA1mLKR
    +y7JLoU929vVtWGsEt0HnxwHQQDaiKlUVkW9gDnA5yVoMuCcq4hY4jd9h0DQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KcKxNHE3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KcKxNHE3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI3VGsrgXRcm8pUkJ6LyNnWlnU/26useZ2pX5EILoed2dyGUVGyCriOaAW/PBSOhfsMIKNgK/wAeg0XApgmC5VrRIj213T12AH/a7U7izSXIVp+h+sLm
    H8LO3HNIhQ4fCsvXc/vO0fjiSY8nauTY8SQXYZNbRN+u5s3qFZJ/6tJUlS35/3Z2SE1GKJdHfsmwMqaq0oT2HCiAfo/xdCD/Kr9ueB23SfpJobqlZ5cZtTGM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=P8mRVJMrAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=LAiccvwT9aQOw6fLfhAA:9 a=wPNLvfGTeEIA:10
    a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756422AbeDIAcJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:09 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756399AbeDIAcF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 193/293] datapath: Avoid using stack larger
 than 1024.
Thread-Topic: [PATCH AUTOSEL for 4.9 193/293] datapath: Avoid using stack
 larger than 1024.
Thread-Index: AQHTz5lAVgk+Bjjoc0a99Wq/wyO3+g==
Date: Mon, 9 Apr 2018 00:25:25 +0000
Message-ID: <20180409002239.163177-193-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:4odaGhUN8gUHzCkxYRfn2TaioL1RbPistvfCTrAYPyr+GlHcVCY6RuJLlJYX5lq9k9MMs5+9XOUjpTpnBpTK/o9k997f/K/W08umtZEftTy0M9LZuU6789C2go0nbiUAhUkj/NxXS6m876RY4ZdsMT70Cb+Ur3Z4z71MPV59ztGM4SVvBzlIuFwcG+VvhYcezOqad8Y6t/1Aq8XScvYdzFlxRChPTKHE3euSlnnYUX1k6T5tQ+f6H6rUH0g3PhxA;20:b5t2yjP6ISAY4HcN+u0XItthRCiLFuuZ23lnyPcBNLHdtl6hHJENLBBNDXsvSse5cKNDOiIOops22QjSFbogQ+Zbt6fm1e+RPoduidMVlwALo2V1BfoyMjLW8OEVxs6gj5+74RTCqNFxHK9Y709zJ0nBv84kHGFODHBZB/8dDw8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e5b63e7-0f04-4084-9723-08d59db150fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870C98A2C1C77D876729FD8FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(39060400002)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TrC8bClFJdX5kzBWKrqCQR7hO4Gr/ndzhv4zlfB4h0ikkJwQJXwf1yP+fAS+LSvpgHnhv7PH812kCIG/npIWpoDlHGfXEiVGFqIkoJxJwbP3SCWnLymrGvXMUq+GTeyiq1zDUyWShMsaPdCoC1fuNIyQR0DKDoPw00u4WhE7Gzcd2ZW8pe6RB+iEjy8rr8hwdGe7uGsodi7vLQhkDZoLivbio5ZHBHHi4wzZ8/ykPbQPS/x/vHONfSv+2XJYJUjxo80ExytKBqIYss+IDgkagq2qniCFIC5/Wmjp6SNN6vkRlPqqpWQC/yTMQMmjiIeaUBBwixiWeZJ3sVivEZl2+LXiDcOz7jgM1hcyxvhrQ2XJon9aDesgsKvYfefonmtnYSHo+7vWKHs9GjEyYOxmSAoAxeL2wp4bVAVIyIZyJ8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5b63e7-0f04-4084-9723-08d59db150fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:25.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

[ Upstream commit 9cc9a5cb176ccb4f2cda5ac34da5a659926f125f ]

When compiling OvS-master on 4.4.0-81 kernel,
there is a warning:

    CC [M]  /root/ovs/datapath/linux/datapath.o
    /root/ovs/datapath/linux/datapath.c: In function
    'ovs_flow_cmd_set':
    /root/ovs/datapath/linux/datapath.c:1221:1: warning:
    the frame size of 1040 bytes is larger than 1024 bytes
    [-Wframe-larger-than=3D]

This patch factors out match-init and action-copy to avoid
"Wframe-larger-than=3D1024" warning. Because mask is only
used to get actions, we new a function to save some
stack space.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/openvswitch/datapath.c | 81 +++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 453f806afe6e..0f594140c5ff 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1105,6 +1105,58 @@ static struct sw_flow_actions *get_flow_actions(stru=
ct net *net,
 	return acts;
 }
=20
+/* Factor out match-init and action-copy to avoid
+ * "Wframe-larger-than=3D1024" warning. Because mask is only
+ * used to get actions, we new a function to save some
+ * stack space.
+ *
+ * If there are not key and action attrs, we return 0
+ * directly. In the case, the caller will also not use the
+ * match as before. If there is action attr, we try to get
+ * actions and save them to *acts. Before returning from
+ * the function, we reset the match->mask pointer. Because
+ * we should not to return match object with dangling reference
+ * to mask.
+ * */
+static int ovs_nla_init_match_and_action(struct net *net,
+					 struct sw_flow_match *match,
+					 struct sw_flow_key *key,
+					 struct nlattr **a,
+					 struct sw_flow_actions **acts,
+					 bool log)
+{
+	struct sw_flow_mask mask;
+	int error =3D 0;
+
+	if (a[OVS_FLOW_ATTR_KEY]) {
+		ovs_match_init(match, key, true, &mask);
+		error =3D ovs_nla_get_match(net, match, a[OVS_FLOW_ATTR_KEY],
+					  a[OVS_FLOW_ATTR_MASK], log);
+		if (error)
+			goto error;
+	}
+
+	if (a[OVS_FLOW_ATTR_ACTIONS]) {
+		if (!a[OVS_FLOW_ATTR_KEY]) {
+			OVS_NLERR(log,
+				  "Flow key attribute not present in set flow.");
+			return -EINVAL;
+		}
+
+		*acts =3D get_flow_actions(net, a[OVS_FLOW_ATTR_ACTIONS], key,
+					 &mask, log);
+		if (IS_ERR(*acts)) {
+			error =3D PTR_ERR(*acts);
+			goto error;
+		}
+	}
+
+	/* On success, error is 0. */
+error:
+	match->mask =3D NULL;
+	return error;
+}
+
 static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net =3D sock_net(skb->sk);
@@ -1112,7 +1164,6 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, stru=
ct genl_info *info)
 	struct ovs_header *ovs_header =3D info->userhdr;
 	struct sw_flow_key key;
 	struct sw_flow *flow;
-	struct sw_flow_mask mask;
 	struct sk_buff *reply =3D NULL;
 	struct datapath *dp;
 	struct sw_flow_actions *old_acts =3D NULL, *acts =3D NULL;
@@ -1124,34 +1175,18 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, st=
ruct genl_info *info)
 	bool ufid_present;
=20
 	ufid_present =3D ovs_nla_get_ufid(&sfid, a[OVS_FLOW_ATTR_UFID], log);
-	if (a[OVS_FLOW_ATTR_KEY]) {
-		ovs_match_init(&match, &key, true, &mask);
-		error =3D ovs_nla_get_match(net, &match, a[OVS_FLOW_ATTR_KEY],
-					  a[OVS_FLOW_ATTR_MASK], log);
-	} else if (!ufid_present) {
+	if (!a[OVS_FLOW_ATTR_KEY] && !ufid_present) {
 		OVS_NLERR(log,
 			  "Flow set message rejected, Key attribute missing.");
-		error =3D -EINVAL;
+		return -EINVAL;
 	}
+
+	error =3D ovs_nla_init_match_and_action(net, &match, &key, a,
+					      &acts, log);
 	if (error)
 		goto error;
=20
-	/* Validate actions. */
-	if (a[OVS_FLOW_ATTR_ACTIONS]) {
-		if (!a[OVS_FLOW_ATTR_KEY]) {
-			OVS_NLERR(log,
-				  "Flow key attribute not present in set flow.");
-			error =3D -EINVAL;
-			goto error;
-		}
-
-		acts =3D get_flow_actions(net, a[OVS_FLOW_ATTR_ACTIONS], &key,
-					&mask, log);
-		if (IS_ERR(acts)) {
-			error =3D PTR_ERR(acts);
-			goto error;
-		}
-
+	if (acts) {
 		/* Can allocate before locking if have acts. */
 		reply =3D ovs_flow_cmd_alloc_info(acts, &sfid, info, false,
 						ufid_flags);
--=20
2.15.1
