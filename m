Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475721-2-14826402981061714414
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
    t=1521475718; b=IM5QUoOVD6JVFYYcPD40CvHhD6pABwScFW2mWHk9S5lZjuU
    BpxGztZ0lqCt6OY+9yLRk5l4pljtUpvlbBEtEJoYLTIrli1U2SI1nwMQxoukl4Bc
    YG6mArJE4Yr35aPP3+MzgLioV+DpLy26/vqX4ONAZi8n3lOb4HYHmZ8jGyVeW1gs
    Bg6r6bnGs+oJH/b+ug2y/FFJonzyK71Jt2kAFPK+QXg8BC/D3CKxJl/tuZ8EttEo
    y560nfjgCzGocmTcaqmVYDBxgJ70swFVol55ROHh0dRwT4m45izUPuf7N50MOGdK
    EbU9JD5foC63gZGz8K7PEkm6m89K5soIEBwOqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475718; bh=vudxyK
    YzBK9mBknP4OcJMclTmBxtAgQlnY2V6UgP+Nw=; b=YroZHDWkwQqA3I78FeUbTw
    seOUB4UtLp8gLhwIDMA1m9HLX1ABlJiP/BY2z2BoeF8LQIdKxKsYWJWUQA4I2xEt
    YimxcuHn0+pUd46OS2X6XsDpRtjX5bXBvzwOTyJvGZjsG3MfCfMgg3p7n4vQuUTm
    H9bqVRO2h693+1KvD950u3vAtGOiFhUf01MexIEKLU/Cx3g0XaKkoBG9C/o31WdD
    ZqtrOTVhxUhwfD7axJoAPG3sPaQiJMD8GcYRVEmU2Sws2w2m/hACJaGtYZqD2ZHT
    hb0Po6DVnuYxFjA0BHeR+Uq/RvDOX3ZF51uSJ3Anr5Hqc7rX9bV/2aid308QTiCw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XiVfLRQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelleeinecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XiVfLRQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelleeinecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965944AbeCSQIc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:32 -0400
Received: from mail-dm3nam03on0131.outbound.protection.outlook.com ([104.47.41.131]:49502
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966279AbeCSQIS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 046/167] net: x25: fix one potential
 use-after-free issue
Thread-Topic: [PATCH AUTOSEL for 4.4 046/167] net: x25: fix one potential
 use-after-free issue
Thread-Index: AQHTv5w33Ri4WjXE30O/EDm2CG76/g==
Date: Mon, 19 Mar 2018 16:06:18 +0000
Message-ID: <20180319160513.16384-46-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:q8ZCEjUHlG7i3OGx29Tf2XvOxBcBvvygqBfpIdmCR3sQZz5yqv8TjZk+S78KTraCerjC1eRZ/Rffl91flFSR+HrDnGwWRd9CwO28xFusaoVK7g9kYJECu6QlesVycS+SROPzfPmqSgDCP/TKrLIbbHflfiij13QDMMJ7gHYnAuvRO1JGnYhS6gB7IYRXuKHJLbg29/PGtb2X3RhVeckIU7STd3QGogG9CluIfVypD19ruKjIIQOXrC04ggdSLCpG;20:rhV7dUC87gwFDBbfhP3C4cUez569McaiwRF9mKKdFKri+X3634i+LhHUGVIJGiZoK0Z8p14lHtQ8nMCReb25m9fpMPi0B6DjcHEGLPIai3utgCHVQCaYVq10W/55iDhxsADkyiHFjKR4znsPrfx0dyWeTITpGv69KUJyhGRIZmk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5dfefdec-3288-42ef-be75-08d58db39db0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805CE841D9ED820EAEB4653FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(39060400002)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hx325I1+53FemepzzqkjAk/zdMqu2qcTgQB5ZVXRFgTYd+m6eM0cUSBIwHznT1Xda6kRStzmBUbQJh+rnwQucvm+UCg6L7chNdLYjFBki+vqViQL/Fsr2jva+RONZz8V5paVdNAqDzLDlUvVOW/2/LWkKSR+lsBCPJxwy2Gs3FMqfxcYX1Krd+juP9LGaBT9Tbwh26RqqmvjXsS7+sDkW25WjlDVFKyH12pJXmwqMc8f8QWiPBW2bT1KR4EOFc7TFeDJylyiFFtfrC5tGCpF3kKYosT9MOD701Tai2WRTG9qgAT7tE87cvOdcqp0HI3okUm+1ahsuvQV5qUxJwTnMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfefdec-3288-42ef-be75-08d58db39db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:18.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index a750f330b8dd..c6ab4da4b8e2 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1794,32 +1794,40 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
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
