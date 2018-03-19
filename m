Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474558-2-18019989416576513068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474557; b=n/xM+I1KJiBpLNEx37KO4PSCfHxEAHL4H29oIwYvJGUnxf5
    JGpsi6FF/flKHm15yoJf3/Bek4LUClKpzgonnkdAAE70pyh79KeF517IhGmyHPAL
    NulojEErulaW7bYRANXmwjzuO4mb7Gd2uDQjPzhZm7AGGbqfKOvPvcSf5NgshcRJ
    PDcKEIKIWUOtCBGx8RiaBGUTgMnBiKxSvmMbKN9j1VOwDIU0v3Uglt8Eh2sWY+u9
    tvcvd4jFNzpctNumChmuF2S5ClE2AAAXrQ056OXxANtu3DxGgAgoCk4wRHfR0uAN
    uNwaJVx7gIHqE3DItuZ/M6ERShLeGYfN0os8/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474557; bh=GA7yoa
    HKdtbFFDDm5rodQg4i+hErLIHWlU569medxro=; b=asuoPlhG5jWE0akvmsxuAc
    1OmRr1nzI5OS4C+/z0f184p3CpNVf2HTl+6iLBj2/fIH3IutYl+Imv7LVmEE+uSw
    5x9Wvr0IQH5bQozrsirZi9R61M6zsYpPqwzgV+g19uqYBs38DNaz2Vg1i2/b5apv
    1Y3muT8W0n+rY2s+S6ErK11fS/bh3nbmj8V2x1GPfOwLrXq6WPbzFG/Ro7N4/3sM
    ESOwDaeilwK4y7G4UjxPKwbC3iCBSMK6BCe0BRoORLYf10nVBQFjPWBL46NEWJzX
    ZHW2T9sSs9uek/yXMjShMgRAs7EbBiNHJeGvf+yJhQ6whwaIu1QFNIczMHOE7q+w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oj/La/UM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduledugeenucevlhhushhtvghrufhiiigvpeejtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oj/La/UM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduledugeenucevlhhushhtvghrufhiiigvpeejtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933765AbeCSPtM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:12 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933861AbeCSPs6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one nat
 hook per hook point
Thread-Topic: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Thread-Index: AQHTv5myu58aptvIyEaP7WYFhKi18w==
Date: Mon, 19 Mar 2018 15:48:16 +0000
Message-ID: <20180319154645.11350-70-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:sdi+E8RaQTaPi5O1WndotuplVI3hLJiaNorAKi8IUbshaubzj/rUMoH/RA3/M6dSKdLDo1QnHeI/K+adbbIVKvKVy+dDlqkXJm+SSHtVMYuge1FBbWbc1IWuLOPiVNpXnjeUg/w7YP6qu9CLM8KLLeS7aKp6D0C6A4Y1xZzAt1OUGTGfzF+DGTL3uYM/HK7aiyCIrReWu0vpYFKIwQ9Ck+t6Z8uKr0P5S7nrUYg42SIWmDJ6F3gJ/qrIgE1JYeTa;20:OF669nVCCbZIGrdhPMKgoxpf2owaaDPLA88N7KlazKSK9RPl6ci76BoUUeY2GiRZ2tDQOBZl5uYexPdOlgy/f+G8ywsly0zcEUX/Jkk3mODdypuuJCH3GTNOyx0waa86uaFevNo0tmQxrv+EzL127pp5aliIpdDk9VdXBNu4TBo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab4f33d0-c517-4c5e-d411-08d58db0eb49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091953DF573A61A47B9EED41FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(5890100001)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dntGGAbEZQ1oLZrIm7sojpTG+gd49HMebCANFgCn0CmxGKKcCy0YaQH5RTA2xNNDKSGQ9kZRBQmaQBiyaSrKacGyEbVZqzoc313Ivi75pFLvWkY/YYWGvku8nVZGIsGsaAtL4sHY3ptYPZInl/pQ4f9XFDSW1oDce+bZc1E9C9YIQ65A8QLI0OJoVSm5yGXk8zL8FNZsvfr1VpszoCJBLGTdDXSzE3x/r3mLKqivDndWmfraGoLTcJCq0KTJQCPkXwyr8opHGWB//Xuh6/n7XNkuTa12NmwulME0LHiDCQkvKHEF6wkjsbnqWhk4BKNQDH+36bNEXwFHZ6In6YyHcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f33d0-c517-4c5e-d411-08d58db0eb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:16.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f92b40a8b2645af38bd6814651c59c1e690db53d ]

The netfilter NAT core cannot deal with more than one NAT hook per hook
location (prerouting, input ...), because the NAT hooks install a NAT null
binding in case the iptables nat table (iptable_nat hooks) or the
corresponding nftables chain (nft nat hooks) doesn't specify a nat
transformation.

Null bindings are needed to detect port collsisions between NAT-ed and
non-NAT-ed connections.

This causes nftables NAT rules to not work when iptable_nat module is
loaded, and vice versa because nat binding has already been attached
when the second nat hook is consulted.

The netfilter core is not really the correct location to handle this
(hooks are just hooks, the core has no notion of what kinds of side
 effects a hook implements), but its the only place where we can check
for conflicts between both iptables hooks and nftables hooks without
adding dependencies.

So add nat annotation to hook_ops to describe those hooks that will
add NAT bindings and then make core reject if such a hook already exists.
The annotation fills a padding hole, in case further restrictions appar
we might change this to a 'u8 type' instead of bool.

iptables error if nft nat hook active:
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables v1.4.21: can't initialize iptables table `nat': File exists
Perhaps iptables or your kernel needs to be upgraded.

nftables error if iptables nat table present:
nft -f /etc/nftables/ipv4-nat
/usr/etc/nftables/ipv4-nat:3:1-2: Error: Could not process rule: File exist=
s
table nat {
^^

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/netfilter.h         | 1 +
 net/ipv4/netfilter/iptable_nat.c  | 4 ++++
 net/ipv6/netfilter/ip6table_nat.c | 4 ++++
 net/netfilter/core.c              | 6 ++++++
 net/netfilter/nf_tables_api.c     | 2 ++
 5 files changed, 17 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index b24e9b101651..267954bca56f 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -67,6 +67,7 @@ struct nf_hook_ops {
 	struct net_device	*dev;
 	void			*priv;
 	u_int8_t		pf;
+	bool			nat_hook;
 	unsigned int		hooknum;
 	/* Hooks are ordered in ascending priority. */
 	int			priority;
diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_=
nat.c
index a1a07b338ccf..0f7255cc65ee 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -72,6 +72,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] =3D {
 	{
 		.hook		=3D iptable_nat_ipv4_in,
 		.pf		=3D NFPROTO_IPV4,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_PRE_ROUTING,
 		.priority	=3D NF_IP_PRI_NAT_DST,
 	},
@@ -79,6 +80,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] =3D {
 	{
 		.hook		=3D iptable_nat_ipv4_out,
 		.pf		=3D NFPROTO_IPV4,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_POST_ROUTING,
 		.priority	=3D NF_IP_PRI_NAT_SRC,
 	},
@@ -86,6 +88,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] =3D {
 	{
 		.hook		=3D iptable_nat_ipv4_local_fn,
 		.pf		=3D NFPROTO_IPV4,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_LOCAL_OUT,
 		.priority	=3D NF_IP_PRI_NAT_DST,
 	},
@@ -93,6 +96,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] =3D {
 	{
 		.hook		=3D iptable_nat_ipv4_fn,
 		.pf		=3D NFPROTO_IPV4,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_LOCAL_IN,
 		.priority	=3D NF_IP_PRI_NAT_SRC,
 	},
diff --git a/net/ipv6/netfilter/ip6table_nat.c b/net/ipv6/netfilter/ip6tabl=
e_nat.c
index 991512576c8c..47306e45a80a 100644
--- a/net/ipv6/netfilter/ip6table_nat.c
+++ b/net/ipv6/netfilter/ip6table_nat.c
@@ -74,6 +74,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] =3D {
 	{
 		.hook		=3D ip6table_nat_in,
 		.pf		=3D NFPROTO_IPV6,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_PRE_ROUTING,
 		.priority	=3D NF_IP6_PRI_NAT_DST,
 	},
@@ -81,6 +82,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] =3D {
 	{
 		.hook		=3D ip6table_nat_out,
 		.pf		=3D NFPROTO_IPV6,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_POST_ROUTING,
 		.priority	=3D NF_IP6_PRI_NAT_SRC,
 	},
@@ -88,12 +90,14 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] =3D {
 	{
 		.hook		=3D ip6table_nat_local_fn,
 		.pf		=3D NFPROTO_IPV6,
+		.nat_hook	=3D true,
 		.hooknum	=3D NF_INET_LOCAL_OUT,
 		.priority	=3D NF_IP6_PRI_NAT_DST,
 	},
 	/* After packet filtering, change source */
 	{
 		.hook		=3D ip6table_nat_fn,
+		.nat_hook	=3D true,
 		.pf		=3D NFPROTO_IPV6,
 		.hooknum	=3D NF_INET_LOCAL_IN,
 		.priority	=3D NF_IP6_PRI_NAT_SRC,
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 52cd2901a097..11e39cb19441 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -135,6 +135,12 @@ nf_hook_entries_grow(const struct nf_hook_entries *old=
,
 			++i;
 			continue;
 		}
+
+		if (reg->nat_hook && orig_ops[i]->nat_hook) {
+			kvfree(new);
+			return ERR_PTR(-EEXIST);
+		}
+
 		if (inserted || reg->priority > orig_ops[i]->priority) {
 			new_ops[nhooks] =3D (void *)orig_ops[i];
 			new->hooks[nhooks] =3D old->hooks[i];
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 07bd4138c84e..5d6e3193723a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1400,6 +1400,8 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8=
 family, u8 genmask,
 				ops->hook =3D hookfn;
 			if (afi->hook_ops_init)
 				afi->hook_ops_init(ops, i);
+			if (basechain->type->type =3D=3D NFT_CHAIN_T_NAT)
+				ops->nat_hook =3D true;
 		}
=20
 		chain->flags |=3D NFT_BASE_CHAIN;
--=20
2.14.1
