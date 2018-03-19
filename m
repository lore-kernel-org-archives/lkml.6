Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496922-5-15038569225406676718
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
    t=1521496921; b=v9siDiBhHxa36SJdlDzgXPE8G+ulWCv3meeXOAZvOtGruwv
    nHNg4M7s+07ztDwD/PiCAoS7zMmBaKZ7HkyGbfmLTvxyDhkXuqvVScNniykAspN+
    gF9nIrAzdnj+dFDBZbHg9vDxa6kqWQMdD9ZcyXE+6QOevTFP2bfiTRvtHc0G8bcT
    A1mJlWTMM0Ew8sZSwDpR82cPgCVrYdX1s0LwOqewev5xcj3oWFnCGfvEjCsyFLmE
    KtQpivUilC1WFF1iB3mZg41lHKSiQgk2muVUmq3iTqQ0AL5l+kdxD6Tx9rrtFx01
    7SVzwkN05g8rsESawAdAdm+14/d0QgnofpC1zDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496921; bh=tMN9ZE
    QKK6ZV1gMMWCycLHI3YxkO8Db84H1NewDiL04=; b=fDvTKCV6APzenrps1tBzFl
    QJj5XTekcPNsiDw//mBKvSW8HqMDNxjfi6vZLMKzfKoYKAc+ueC+UNhyYAYORhNz
    hV5TRniufSnsXzCsbRlCX5MQpdKfGcpF1WejNK3j9zHOD6XkOTVqWG+mf8T8pLpV
    BDbeWsoDlhg9fx9SnGY/YneRThxjSjVvU59KDbmgWSQLOyUeQg/nQLyfkvKl8n07
    8tHh8buW3tcGxyNndG3VH+QSQq5yyjt0jWIrmLukIMhHm8TcM2TLPbNRwAyAyUwL
    jmo+6RiPkiiYp7kZEQFwMvGhLQDXWMg6JwIk2iHsCtBl7QKRz0ESNvHORENr4ETA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kUrLwQKj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudeltdejnecuvehluhhsthgvrhfuihiivgepudel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kUrLwQKj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudeltdejnecuvehluhhsthgvrhfuihiivgepudel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972184AbeCSWBs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:01:48 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:23882
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934434AbeCSPz6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 54/97] netfilter: core: only allow one nat
 hook per hook point
Thread-Topic: [PATCH AUTOSEL for 4.14 54/97] netfilter: core: only allow one
 nat hook per hook point
Thread-Index: AQHTv5q6pya96Qoo6EabYyXX8/FmgA==
Date: Mon, 19 Mar 2018 15:55:41 +0000
Message-ID: <20180319155411.12348-54-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:HMhtW1hxtYV3+Yo7lu3zAiTFMIdkE4G1APi2cse+XYyj0cjooDAEGkQE8odueozNenTs1vZ9iwuABAzucib2Al6X+BSTslVuyAX7zIhbDlsPpEELJd/KK0MbLmP0dXI42ZUUeEcDEnpDCNxltdaYqJDc5Krtmn4OrpTIWhnIwr/oKWBoF6G81KdCSMGeT+ay0M5N92OkHVNkFqP7VnK7P5aLg7AH8TU48L6xbI0BF2bIW0zfYvkAMOZurZLyx255;20:9vQzfZeKm1Kl0WNwk7n0dr2+RbF5nzwLzWa5H6gaBYA6/hcmg42TaWOU3H0bw+e2xKW6bXFD5NCNWcCav1ZgSKOlYKkpq7Zgz4S95GRh1v0Hur1NkydR9gk9eTx0K0tCTgLpE2Y7zoZVO8fJ1zDCLjnDVqt8USDpF1tYIDj/Nr8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0efeffff-27a6-4a81-6a71-08d58db1e6d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103134B006C4DDD3B39A7A1DFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5890100001)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: F+5f6ANuYolXJnhMypnJgiLZ8jSwrLb6iYhlDurFhU3wGhjoaOcxmHGtt7opWgVHoTInFYA0STyRXHAY0/IQVABBhNMW4myzCOt6iX0PG41DeeLn4RerytnC9SWNjdkO8u6YGXyLPXwritNHfo5ZuvDAAHQjLz0+eJWhxhAJli3ek0PXiWrafW3aspAiYSvTTnYST01d6PphLEdfJM8EVallqfx++OzuSSLFrMB/7r5pWI8ZTep40QNRVp2mrkVx5wYf2wYQLbE33/E402/ZF1m6GriG1rnULsuel0eG68PVCnxlcU3WQfAC7O0C1gAzDhmlO67D67sE87luwxcarA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efeffff-27a6-4a81-6a71-08d58db1e6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:41.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 5b504aa653f5..d2168fc61038 100644
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
