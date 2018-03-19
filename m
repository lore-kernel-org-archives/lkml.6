Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494305-2-12008799035020427060
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
    t=1521494304; b=f2+GmlSP3Ws7tHGXhRcBkVnCPXnGHyNCV2lbxh8WqrYVMLM
    JNyv9N+8XRfXl6ykNoRSAyXBpalIdijXQRtClQe2avbyINFMaYqv7KbSWH85tWG7
    YTprx0PqoC88aW/uuritGTitjSr99O7KEmpIDKF69rScjSsNNNzU7KBDDfIqhTrZ
    GyqSAA3q2+3eQgSnsfVDwuFDwg2/jILDAuYMB4NWH2b7aBd7s6QOTRB5MOyL3XVi
    yj7EBwTKidAx/wogtotLtIOadWwgZX044VLLV8h7gPHF5sMV86/W8yXC7ABDMN6r
    Kv5qzS45BKyWmEoD56QdhoHt6NkMUm53LatNfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494304; bh=6zu3NN
    /yYHhgt0Aq+09FseW2xK600Ng0DUl04icWYtk=; b=TgPP0PhGNjmOJmyoPCR4cu
    YHrFTbJfy4i082a/ZxKAVE1C/sdLUnHmTzTJ3US6yd90AxPBErIUA/UUOflRNOyp
    3VTZHlRBzoK3BXQek9hLiEDHX6XOjzfVceKwsVGpPycG1gPKPnYVuC7zlZfdFGE6
    6YI2laRp1cAU4wvyQjB0ge+6dOgOg5hjj7/wkWXmQhic77KpmKEhAADLp4iYw7Hf
    10bX/HVQYPiUn67mpxIvIutAsNeV78qXO4HIOl/nndjcD5/3tA7qG3VtXqpXLrQ9
    4JWT75WnrPq1Iy4sS8FZsTSOzpFeDG/DvDVKB7l3AkM9TnnBUaVlE3QbRutRflyw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kbBBwrre x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvvdenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kbBBwrre x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvvdenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965313AbeCSVSM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:18:12 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:39043
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965274AbeCSQBC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Kapl <roman.kapl@sysgo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 111/281] net: move somaxconn init from sysctl
 code
Thread-Topic: [PATCH AUTOSEL for 4.9 111/281] net: move somaxconn init from
 sysctl code
Thread-Index: AQHTv5tYqkLUWkAxQkKISYbGxz3j5g==
Date: Mon, 19 Mar 2018 16:00:04 +0000
Message-ID: <20180319155742.13731-111-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:j36z2ri+nSzIkBolr3qoEJFyJM0oilVShHJRKeBb/jnIs+rc++Eo6fiht9I45TZ5nDPEAPKHb42EuEF5nyMLIJ0t0rb79GYU3ZxU7wFYnd7AHdGcAiLguGzAwPi8m9KSznSl8CXI8xMhUiyTmbAYZQeLUIKdJFOQRzxmR/LocXGA31Smhfax4g2anf6vtvMwt8Q/xixLl8dZdhxTNYgr7+b/387zTTaq3bk0mJw5nv0fcsO6Wp22gYgdQkCJzQgE;20:7XtOFuSwaJ09xGOvgL39qizutvEColrFWnc0Xg8bM52w9htpyymHOK28tZV/8ZqnordnP4cgjLeOd306RbUo9xUkgK6Ljw5rtYtOy2deQLyFP9gyjRwCdS9Uf/AdbUkzqwuaY3SHmrW7xylJHiHmn2pq0RDoW3AYsFWZ8IKrKpY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 961d2ed5-f8fa-44fc-c41b-08d58db29992
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D3032FBBD4744776152CFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zsL6t1baK/4DLywfafBksHCqjrIFn1aKmMcY4cupFoYKn2WEE9GykJXMszCXG1Ad0oe6bbCk0lSlwjkXNi6dc2T7Nefz3fVy0EkaUBUQsEr+iv+6oQHxH6C0X1kLPsxb7zs/I3FNqz/6Lz7pW4pHii/PirOfsH5p/7WVHyCxgUO8A8uGWyf+yElOsuZDz3paLm0/ZxLkStTPLcS+Wj35TgPkcIPWgMkaiVGJ+b02QfR6V7aPt0jqWj9TVgS/gVvDndVBLk+BAqj3T7dykiKQJnVrioZBAGmWiFiBMnWooG1JXn7so/TcBgSoI63FaGnRNbKmrKFBPKNhZ03nxJxd8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961d2ed5-f8fa-44fc-c41b-08d58db29992
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:04.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index b7efe2f19f83..04fd04ccaa04 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -312,6 +312,25 @@ static __net_init int setup_net(struct net *net, struc=
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
 static struct ucounts *inc_net_namespaces(struct user_namespace *ns)
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 1b4619008c4e..546ba76b35a5 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -438,8 +438,6 @@ static __net_init int sysctl_core_net_init(struct net *=
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
