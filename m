Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475983-2-6477778548129566635
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
    t=1521475982; b=CFY42uJPDvFew+KffL2dV+F8io+Cpl8AIbe7BuOdOKu7tFe
    PG4JxsEEcZaAsYHhwdQlRfigCYndbJdqwHf31ezFST/UdTrXV326Y0jHj5kPvMtl
    0FsOWjX2BJWw1Yl07iksZtbbo+5VPRhx9tyxv6tq0TdI+I3pDONG3VwppmTYrUuo
    ioyATU4FkD2Bx/joHEyh9L02V4jwFrsjd7nEOW5vYzXBDLJgHiKef68XQnAtlYda
    vJldfKNkJh8peTcpjaO0iez9OZIHvj/b84Vdij0MX1GbRVEZUvtAnddP/QAQ5AF9
    c2xTzhBZPdeWXBOvhAvUMjsnKuU9c9Pf+uT3pPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475982; bh=4duMKo
    pG6pl7CNLbC6+8qZ2vqbYYmWBoo96+MnN+fM8=; b=d4Qo8xsDNvZXsIaGggqpBc
    erXYentbosHNAZbZuu4Rn5E1KKhPNFH5zkwGOi5gmbqWBthTM6+3GoypiQpLc05L
    cazpDf3oD2FA0j9LjUtlcfUE6EJZUURUPtVJJz+FlOb3syM2bzVRcpnwtmN7yz7m
    OKn8vhgDSl8PY3EYejHF4T1AlJOQ46jMFzWMHyVSiJqCcOApSCZ3Qyza22BaI7yU
    vFGemqPuw37DPwiYGBy+tK13RYhkbJFx2H9XlRJNb23rU+pFcXCx8h6nTwDbPiZx
    daoNmDGx3UIIoP89FT37QpF8gqZ/7BnAJ8SziZxm/C16ztapUsdeP+TWbYoiHafQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IdOtBRbQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvledtnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IdOtBRbQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvledtnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966843AbeCSQM7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:12:59 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:57888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966835AbeCSQMz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Kapl <roman.kapl@sysgo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 046/102] net: move somaxconn init from sysctl
 code
Thread-Topic: [PATCH AUTOSEL for 3.18 046/102] net: move somaxconn init from
 sysctl code
Thread-Index: AQHTv50TUVeoGTuGMU6NOM7N5/fMRw==
Date: Mon, 19 Mar 2018 16:12:28 +0000
Message-ID: <20180319161117.17833-46-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:EJ4abe0+NkoE6YQK5EY/mPNWg52OpNwI9zorwzuNoNasZPnjCJ9DDD9W+GRWaQ4CA/5q1wH943yD/CgvdCBxfFa4la6Co+dRR4Ik1MhsiwikOQzNhYq9895iFaP6CiyJbVh1Y2XPt2AOFyxZXHBt2VRZKiI0x0AfK5uTCLc5sueIsxUdcAoltpk5gU6/7qsNolhkuUq4Q7bw/2qw18wIq2S6tKBSNCY0wtdHwECzWV3h1JFEzEiFb47Nk4Ay3fJg;20:QcTmM5cK1Ff9Bpt0vsKjZPtxUJwtzS+RTHuhNK7XwIHrMHAt1QKeS9whr7raFdO/9HOId9aOVbeK5vX8g8YWojxiTYGO9yApD9CYgPWq8+Ds2bIK5ekL0LE4VUS5UoMYz9TB4xISjwfbIsvqYCkUGT76YTviSI7yCnn/Gn0ieDY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b903a2c3-c662-4a4a-7f83-08d58db44584
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032FE4F25C468F87ADA2219FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ucK5wilFo/lwjhqlSFg37dRQZoWw5nZ6s3Mv1QZMN/yqvk009P7u6UIf6Gs2uQMKX2RhCTPL5Q/bZoGo5D/ULBiEe6mW/7kG0M5PMWTOzbrBfSCrQIGn48wcLp4RP3bO6q9Ac+6lFf48luGEH0yx/0NodtmZIUlvicxV8wrodQoTW52JuM7QQC84ZhHDHn0bhd+YPqh/H1IwXc5hArB6GNCR2Rp70Y5FKEC/uMLFBPVKsW9S3bzgB9qqtpGRbmH/303TBglfm27NMicoQVebs4jZfkudKUxBYsp2Rhs7qvw2Mux18kBT/ZhtS7ghORCoJktRgpaN3eeLL6lbgTOvbQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b903a2c3-c662-4a4a-7f83-08d58db44584
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:29.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roman Kapl <roman.kapl@sysgo.com>

[ Upstream commit 7c3f1875c66fbc19762760097cabc91849ea0bbb ]

The default value for somaxconn is set in sysctl_core_net_init(), but this
function is not called when kernel is configured without CONFIG_SYSCTL.

This results in the kernel not being able to accept TCP connections,
because the backlog has zero size. Usually, the user ends up with:
"TCP: request_sock_TCP: Possible SYN flooding on port 7. Dropping request. =
 Check SNMP counters."
If SYN cookies are not enabled the connection is rejected.

Before ef547f2ac16 (tcp: remove max_qlen_log), the effects were less
severe, because the backlog was always at least eight slots long.

Signed-off-by: Roman Kapl <roman.kapl@sysgo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/net_namespace.c   | 19 +++++++++++++++++++
 net/core/sysctl_net_core.c |  2 --
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 7f155175bba8..a81693f9753c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -188,6 +188,25 @@ static __net_init int setup_net(struct net *net, struc=
t user_namespace *user_ns)
 	goto out;
 }
=20
+static int __net_init net_defaults_init_net(struct net *net)
+{
+	net->core.sysctl_somaxconn =3D SOMAXCONN;
+	return 0;
+}
+
+static struct pernet_operations net_defaults_ops =3D {
+	.init =3D net_defaults_init_net,
+};
+
+static __init int net_defaults_init(void)
+{
+	if (register_pernet_subsys(&net_defaults_ops))
+		panic("Cannot initialize net default settings");
+
+	return 0;
+}
+
+core_initcall(net_defaults_init);
=20
 #ifdef CONFIG_NET_NS
 static struct kmem_cache *net_cachep;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 4f00a8eaf704..c49a159c7b8a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -395,8 +395,6 @@ static __net_init int sysctl_core_net_init(struct net *=
net)
 {
 	struct ctl_table *tbl;
=20
-	net->core.sysctl_somaxconn =3D SOMAXCONN;
-
 	tbl =3D netns_core_table;
 	if (!net_eq(net, &init_net)) {
 		tbl =3D kmemdup(tbl, sizeof(netns_core_table), GFP_KERNEL);
--=20
2.14.1
