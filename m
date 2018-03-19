Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480037-5-1602248182559576720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480036; b=nG5iILU8asYaIBQly+Vg5GBETgb7SMmGSAZrP2A99Jvx/9C
    HIL51ef34THBUwQbUlO9e3LkeYKk2m+KpYBTYDE6HRfMPRBmFa48NYdU5NM1UxXB
    j9BJv7vD5ueY1GhNubnpCIlsu8IlGcV8LHiy89pD1xykLxQl5jh08QAEaDGDRoNo
    3ogVIIQyFnRDT5wNeEbwuWhEw/R2ocsOPQJ49mEV+Rydw2XlQJq4zW1A/90qkndI
    BgFUbRsWmswS8YsaUORsGaditoqb4Pf2P1hQWoSCnkaTq5tFxcvY7/h+i0ZF9IY9
    1437zYho/z9S5SdnKTnQnmUD+I+VIXZfQO0R0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480036; bh=InBfXB
    R3ESWR8bz/7zW8nsQRgnYHQDIIYUR7QhpwYnM=; b=YUZDA0+2i/J8Lscfx5Lxua
    1QX3qFdN+GctnZhWEOgkPS9sZVMSJCIhdCn7yVK/burdGhp6jaBqBCggtaauBUB0
    HNBHOL5qKwAmHXVUcRP0+pHo1PH9fLbzFfarAXJ3fVFXlihMIEmmhGCeYuKzltVM
    XinOxxsZXEx7ErY3G50wxicMGZ0/jtGZmuKk4JfWqD1XqdoYoeO8RcF6BsCVZYBo
    OYa1i21EJuIXFxmmWIVKMj6bx7Sl+ZuzruXBfJt85T7zWd7j1Vmc9pB/k/cFnkcJ
    P0s9pp5ULi85RCN07gV6g3Av6S9tImRcN2gxEf18n/hIgv/UzyOHAAXoDmF2t9ig
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RJw33iPq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdeludenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RJw33iPq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdeludenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967651AbeCSRT3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:19:29 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:49376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966419AbeCSQJO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Kapl <roman.kapl@sysgo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 077/167] net: move somaxconn init from sysctl
 code
Thread-Topic: [PATCH AUTOSEL for 4.4 077/167] net: move somaxconn init from
 sysctl code
Thread-Index: AQHTv5xPu3Rzi3XCHkuqoA0Or7fBzw==
Date: Mon, 19 Mar 2018 16:06:58 +0000
Message-ID: <20180319160513.16384-77-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:Zk36iMV96zC5cwNbg5SWilYO+E8Aczy0qzcJU5qVorGVgoAMx6QtCUSE8wJ8lyRWWF9twf9Vldhu+zRN/8lh1WF3m85zeXOMWX6vjb74tWzduDun5isIsv1yB0sSgpV5iSGt/Lt8RtQxnl/8WMtVuXiNnzH7eDI6z3fwm+1iU3xiJFl2Y1MGq0kl6TohTWMuXaizYHNjCFqCyhwrjSJelCXDgZFlAgnxOomPjlRwGSca8S405aPFZpfUiZQw0fNu;20:TcQ7y7QiO+uzQIXcCuvhhmu4rR9D0WYoBCTukwdud32gn2X2PBPq2fsDsBEr7ZUmuX/LUfwnwsE6Pys1KEKWAI3Ast/Ujj6dvm7h2p6NH1CfGP/g8tF14WNiW9xnqTHMmPx/OxpfBJX6fcUNcDvkFUyTL7Ddzu+8kweMOrfw11Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4550ad2c-a8ce-4fab-6455-08d58db3bb6f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965AF0E68E87FCEB551B173FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5T8DYYqwxK5HQkSsg+aEzyiBfqJhAitU+2KzdLi452ysgeSn3SBoRwApxEmVohWMaLpqnUd4fA6oMt1iIh2gdOkciX+WlyK92aMls9EPwHB9I5sFRwTMSyu5CZUVHdT6jVHNN2gGXtC9vgxe3nh4hICIKYMTAgTHOeoYAUEJI4lR3yJy7MKmS84T8QwRAUVSBfCNH8V1McOHwiXx3CDTLRNA+9LuBXhXQEJTOkTOUGne669tI3Yoa4+l/NV6+AQKwXL4rEfNx0qHVFCzvHjQA+tarAfcUrXsXr4INlzYW+EVkq1WB639/wIiyGY0nYVRn+ag8XXcuRedHz7siyzlOw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4550ad2c-a8ce-4fab-6455-08d58db3bb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:58.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
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
index b5c351d2830b..ccd20669ac00 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -310,6 +310,25 @@ static __net_init int setup_net(struct net *net, struc=
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
index 6578a0a2f708..32898247d8bf 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -429,8 +429,6 @@ static __net_init int sysctl_core_net_init(struct net *=
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
