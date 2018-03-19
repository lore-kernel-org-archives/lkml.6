Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495054-2-4352175295830592388
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
    t=1521495054; b=atJTblAsbFbF9B7jvUyzXtrrHbaEl/u26hW7t3p0YIT+GaR
    qwNFBd5FWINTcf6oFjPUY2ooIcNn5g+tux6m7YAFMEYzHhDsbpb1voIzhGwSN88V
    i2jpgqs0eEvMq3BJtNb5gCttX4vDJsUVaaH8FjvNRS3j/yPad1/ZrJ9eqj7ClQci
    X/WK+MyrYGknfTxaPiiE755JtJ5JCdFtoBjKNZ0XHcFiTc8NUwnA+KKvSwgZ3Csb
    7KyDRMnvDsHwe3+kPMrBagfh9Z5ysuAQKOgQxB9osTQ0+gLHZa0eu7DjrrW2jTxG
    Yg/a596XIaa98+lySSCk8Lig+U9kkVeuUiREZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495054; bh=PCHfx1
    B0/UJPWdIFwrUxbkkp7bLdtrYJP4FgAkAaEsQ=; b=Lt/0oEDAsVfQoeqlQtR43Q
    E82enahivxztPJvBWmd/2zcymcsdH90wLZqYROWsUwbJfg0Ret9IZyVhat4jIYCU
    ozNy8/TMwtoinPjeZC17JYYBpXlSX29UsNU3+0+Xs0jbFG6tTvmjfSP5Gh0JCVhK
    R09T8moK1E1K4PD2clNuYcIoCzxNEvEM8gFM8Rs2IBW0suWCJe16UTaUmh6nGIRM
    q0KO2aGMuE0aoo3T43Famtvzll7R45KSTb6zcbyX9PZHZxFBY4pwGDMOw/yHXgMi
    MopOIbwSQelzugZYVsIvYbmUJa6NYzaEAm1ovpKWHUTw0WBaeH3OZW4Dz3Qv3MMw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZLfAwdss x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddtgeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZLfAwdss x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddtgeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965116AbeCSVaW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:30:22 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:56553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965221AbeCSQAF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 069/281] net: x25: fix one potential
 use-after-free issue
Thread-Topic: [PATCH AUTOSEL for 4.9 069/281] net: x25: fix one potential
 use-after-free issue
Thread-Index: AQHTv5s3GWOnlDXpbEqZIpwu2spMwQ==
Date: Mon, 19 Mar 2018 15:59:10 +0000
Message-ID: <20180319155742.13731-69-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:Zos8aPxWybcvtHwgW5EOZaXXQg+wau+Ls1z9ONaxtdr6mwbG+iTC02VZxN/U7UC5CpYiDg1Js2mV/QVuNXg83vJ8jT9xk/RjSAevLqZ1iXEyvbhA2QUL9sWV3JuNTbAl5GHE8bHGe7aouK0Qg4xVj8wTKgbEzAhLtLxE59wMcGEN5AqYr+OIiANkFwm8OeLeE8CF5ZPXfmoFo1mMr1NBNYR3sBL4ExKxN75jbJhiivmB5aD3vk2tqYo7JSDL1SGP;20:Q44uPf/Q+vRNzA9Iqw0v6ItWHu0r75nsIb3qwcn3zyi6vKl+5wTot+bNlt4DCBHfAMEeUVIuCVBsPKZlvB2XBLjVhAfRKvbLtmpYP0Z63nVGwmq11iO1DzdTz22aGtodrgk/8aMv92j8/CUVyEyEvhOp4jFvkVhWXY62x+gewfU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 260df9e9-3b72-4b38-5437-08d58db27729
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984FF4B5365798355563248FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(39060400002)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: MEGJGgBBgalu10iAF1zDk9xPMcEsdYVOjktB3qIRfklNfpMiTLxPjiotoWSg84R1/oE9rgtuLRMXzkVTPkOmSNI9uabiSgRNMTM2M+zuBPHNah0DkWuQvgxqHDOhKUkHjtg0F3DIh6w20bGDcKIfV4Y3baLfX3WNEDF20LspswRPl60DauFXeZZlDmdBhsy6+E6FlgObKN0qMkD5/6ES4yf1hYGAd4LB4j7ZMTJHgbg89IQf0XycYRNjQrDi6Re4U5eDoUjWY9/rIFji4tZYuMkFqk2x0IRmWimhrQSoHNybEbqIRXyoXzb4yLIsvlgZTWyFHAjsrg7DQZBMNUdhCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260df9e9-3b72-4b38-5437-08d58db27729
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:10.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: linzhang <xiaolou4617@gmail.com>

[ Upstream commit 64df6d525fcff1630098db9238bfd2b3e092d5c1 ]

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add properly unregister call on error handler.

Also, i adjust the coding style and make x25_register_sysctl properly
return failure.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/x25.h        |  4 ++--
 net/x25/af_x25.c         | 24 ++++++++++++++++--------
 net/x25/sysctl_net_x25.c |  5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index c383aa4edbf0..6d30a01d281d 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -298,10 +298,10 @@ void x25_check_rbuf(struct sock *);
=20
 /* sysctl_net_x25.c */
 #ifdef CONFIG_SYSCTL
-void x25_register_sysctl(void);
+int x25_register_sysctl(void);
 void x25_unregister_sysctl(void);
 #else
-static inline void x25_register_sysctl(void) {};
+static inline int x25_register_sysctl(void) { return 0; };
 static inline void x25_unregister_sysctl(void) {};
 #endif /* CONFIG_SYSCTL */
=20
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f83b74d3e2ac..007721632b07 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1790,32 +1790,40 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
=20
 static int __init x25_init(void)
 {
-	int rc =3D proto_register(&x25_proto, 0);
+	int rc;
=20
-	if (rc !=3D 0)
+	rc =3D proto_register(&x25_proto, 0);
+	if (rc)
 		goto out;
=20
 	rc =3D sock_register(&x25_family_ops);
-	if (rc !=3D 0)
+	if (rc)
 		goto out_proto;
=20
 	dev_add_pack(&x25_packet_type);
=20
 	rc =3D register_netdevice_notifier(&x25_dev_notifier);
-	if (rc !=3D 0)
+	if (rc)
 		goto out_sock;
=20
-	pr_info("Linux Version 0.2\n");
+	rc =3D x25_register_sysctl();
+	if (rc)
+		goto out_dev;
=20
-	x25_register_sysctl();
 	rc =3D x25_proc_init();
-	if (rc !=3D 0)
-		goto out_dev;
+	if (rc)
+		goto out_sysctl;
+
+	pr_info("Linux Version 0.2\n");
+
 out:
 	return rc;
+out_sysctl:
+	x25_unregister_sysctl();
 out_dev:
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index 43239527a205..703d46aae7a2 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -73,9 +73,12 @@ static struct ctl_table x25_table[] =3D {
 	{ 0, },
 };
=20
-void __init x25_register_sysctl(void)
+int __init x25_register_sysctl(void)
 {
 	x25_table_header =3D register_net_sysctl(&init_net, "net/x25", x25_table)=
;
+	if (!x25_table_header)
+		return -ENOMEM;
+	return 0;
 }
=20
 void x25_unregister_sysctl(void)
--=20
2.14.1
