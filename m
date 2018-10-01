Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6783C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e+H4zG39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D1D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeJAHOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:41 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbeJAHOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVlW6THqzGWK1JggLmW3MFGGLDsDB1LVSIRR+XMl80A=;
 b=e+H4zG39OryPgupOJagK5uk0cwq3Zz0vXS29EOiOJwtkNAOGwk86+cc6HEwJlhbCkYPPb9CnThCV7ju7ZF7FOnEO4KYNp89WR5l3skTO/r29ZqeLiGLZL+G2LmwDkomFsHVD/3NU8yrLe3e6eqZpLtYToHI4WSh4UZVQk8Qi08M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/65] netfilter: conntrack: timeout interface
 depend on CONFIG_NF_CONNTRACK_TIMEOUT
Thread-Topic: [PATCH AUTOSEL 4.18 49/65] netfilter: conntrack: timeout
 interface depend on CONFIG_NF_CONNTRACK_TIMEOUT
Thread-Index: AQHUWR8UKzoo1cwd7UGQ0n1a8kdf5Q==
Date:   Mon, 1 Oct 2018 00:38:32 +0000
Message-ID: <20181001003754.146961-49-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:prkDrO2USccQ+X6JRRkewqyGwiDwB1N5HCCBjBIzWZdyZqMka9In0wrPFFQ/sXRkfLzJ5ceSleh264CfeP3k3RsUqCFtEkfzQsCui6q9ewsvRQDhWr/VMzLiDWKgqO3K3cOw6IRPFNViECwP0ybvfclc902Y/QCXdFEw3Esxl6p1zuCgc26o1N8AxALxZY07dDkqrSthk8f8RpUsPKVIl6C9DOAh0+/dukZ/FQyKDoBRIUI1PzOUuCMHC2OpBd8cJmWgZF1mecKWZM0Ip1+Fw6xeudNlwlY+58ZKFz5tYi7po/gkeYzH8b/cFw6zUAWZKKWcSnBhc+jtGJGxm8sW8JjwWiKEvsPqXz1n7I7a/yvay0bAoc7QmXWh78YaN2cX2MkYla6xoURAE/pzCU9KlTfGl2u9Pg5AkrrrwsNOr4JwPPUNbmTFNwA5XqjNbtWHG3xopZ8AHeDOg2ar7afIMQ==;5:dUHIV1q+ajAnyDnE7xGewo39RCwiqekGpKl7uFHbe/iB1BMmVOsWCx9/4vt8fVZ5VusICGOhobv9WJZ0q0gV/5GTmIdno55PkjzrVRQorbWbHZKxR4OFVHIEzcZoR6mFhsQQH7zM1VR9ESOrAZeolxrcSEioTVnS05av6vK/ZMw=;7:F2J1QW4JD7L7zdhcsUxKXwDJ+4H9pAl0yYos9IbF3SyZYXH5LhutiH5QWkonM3ruyZTWKpelxSCH7fJVlYAz5Mc74r5yainoCBK6X0jL28RnwxKTj13aZCcJ1QneZLuEsPHVwcm/bZ5x9+E8tgI12MKYJqWhP4Yx7x/lCyzr9VXM3JJWaJt72yhI+BwKwnNdvo2J3sXfd1whF+FYjobx1IoT9k3CNtHEc7Z3N3goZQirtWR1wUa3UXSCcbtsajdg
x-ms-office365-filtering-correlation-id: 00517848-9467-4523-57f1-08d62736488f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824EADD22D4A99FC18866DFFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(53946003)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lnV4MFLo3eCUoXij3B9ZpVKMvcNEXGhSALxSwI/dxOW1tsNIc5uTEOfRmj+31SQk3CuCOkbBzSY6wgjpQyJKFJcItdtQsSDXJyET1gHz7oeavHuH15iul3TZP5GZaPgCgR7N3FKNnbMcTfdvoWuNp7YpCQ3cBeblx6alvxhzSKCPrPsopMqyLe1VXAGITpyuITmMB6i2D0VSEkw0F+v6FFS3BHQvuSfcdMbc4YQfPFU2YEIsgy7kr9eQhu777owvHaXe7JKkqUxK8gwAS1Vu2olgRQpJsVzuts5iV/EFIr1wOVXTfbamyQUcS3AljZ9EDFxJhOTJeuDBSaD8ZWGhTmgxgELCGISrl89Bg/O5OfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00517848-9467-4523-57f1-08d62736488f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:32.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a874752a10da113f513980e28f562d946d3f829d ]

Now that cttimeout support for nft_ct is in place, these should depend
on CONFIG_NF_CONNTRACK_TIMEOUT otherwise we can crash when dumping the
policy if this option is not enabled.

[   71.600121] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000000
[...]
[   71.600141] CPU: 3 PID: 7612 Comm: nft Not tainted 4.18.0+ #246
[...]
[   71.600188] Call Trace:
[   71.600201]  ? nft_ct_timeout_obj_dump+0xc6/0xf0 [nft_ct]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/netfilter/nf_conntrack_proto_icmp.c  |  8 ++++----
 .../netfilter/nf_conntrack_proto_icmpv6.c     |  8 ++++----
 net/netfilter/nf_conntrack_proto_dccp.c       | 12 +++++------
 net/netfilter/nf_conntrack_proto_generic.c    |  8 ++++----
 net/netfilter/nf_conntrack_proto_gre.c        |  8 ++++----
 net/netfilter/nf_conntrack_proto_sctp.c       | 14 ++++++-------
 net/netfilter/nf_conntrack_proto_tcp.c        | 12 +++++------
 net/netfilter/nf_conntrack_proto_udp.c        | 20 +++++++++----------
 8 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/net/ipv4/netfilter/nf_conntrack_proto_icmp.c b/net/ipv4/netfil=
ter/nf_conntrack_proto_icmp.c
index 5c15beafa711..fe70f6290aa4 100644
--- a/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
@@ -269,7 +269,7 @@ static unsigned int icmp_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -307,7 +307,7 @@ static const struct nla_policy
 icmp_timeout_nla_policy[CTA_TIMEOUT_ICMP_MAX+1] =3D {
 	[CTA_TIMEOUT_ICMP_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmp_sysctl_table[] =3D {
@@ -369,7 +369,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
icmp =3D
 	.nlattr_to_tuple	=3D icmp_nlattr_to_tuple,
 	.nla_policy		=3D icmp_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D icmp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D icmp_timeout_obj_to_nlattr,
@@ -377,7 +377,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
icmp =3D
 		.obj_size	=3D sizeof(unsigned int),
 		.nla_policy	=3D icmp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D icmp_init_net,
 	.get_net_proto		=3D icmp_get_net_proto,
 };
diff --git a/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c b/net/ipv6/netf=
ilter/nf_conntrack_proto_icmpv6.c
index 2548e2c8aedd..992019082b1f 100644
--- a/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
@@ -270,7 +270,7 @@ static unsigned int icmpv6_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -308,7 +308,7 @@ static const struct nla_policy
 icmpv6_timeout_nla_policy[CTA_TIMEOUT_ICMPV6_MAX+1] =3D {
 	[CTA_TIMEOUT_ICMPV6_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmpv6_sysctl_table[] =3D {
@@ -368,7 +368,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
icmpv6 =3D
 	.nlattr_to_tuple	=3D icmpv6_nlattr_to_tuple,
 	.nla_policy		=3D icmpv6_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D icmpv6_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D icmpv6_timeout_obj_to_nlattr,
@@ -376,7 +376,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
icmpv6 =3D
 		.obj_size	=3D sizeof(unsigned int),
 		.nla_policy	=3D icmpv6_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D icmpv6_init_net,
 	.get_net_proto		=3D icmpv6_get_net_proto,
 };
diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_con=
ntrack_proto_dccp.c
index 9ce6336d1e55..02ed43f93656 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -699,7 +699,7 @@ static int nlattr_to_dccp(struct nlattr *cda[], struct =
nf_conn *ct)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -750,7 +750,7 @@ dccp_timeout_nla_policy[CTA_TIMEOUT_DCCP_MAX+1] =3D {
 	[CTA_TIMEOUT_DCCP_CLOSING]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_DCCP_TIMEWAIT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 /* template, data assigned later */
@@ -883,7 +883,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
dccp4 =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D dccp_timeout_obj_to_nlattr,
@@ -891,7 +891,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
dccp4 =3D {
 		.obj_size	=3D sizeof(unsigned int) * CT_DCCP_MAX,
 		.nla_policy	=3D dccp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D dccp_init_net,
 	.get_net_proto		=3D dccp_get_net_proto,
 };
@@ -919,7 +919,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
dccp6 =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D dccp_timeout_obj_to_nlattr,
@@ -927,7 +927,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
dccp6 =3D {
 		.obj_size	=3D sizeof(unsigned int) * CT_DCCP_MAX,
 		.nla_policy	=3D dccp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D dccp_init_net,
 	.get_net_proto		=3D dccp_get_net_proto,
 };
diff --git a/net/netfilter/nf_conntrack_proto_generic.c b/net/netfilter/nf_=
conntrack_proto_generic.c
index 6c6896d21cd7..bc5e95b9a2e5 100644
--- a/net/netfilter/nf_conntrack_proto_generic.c
+++ b/net/netfilter/nf_conntrack_proto_generic.c
@@ -79,7 +79,7 @@ static bool generic_new(struct nf_conn *ct, const struct =
sk_buff *skb,
 	return ret;
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -119,7 +119,7 @@ static const struct nla_policy
 generic_timeout_nla_policy[CTA_TIMEOUT_GENERIC_MAX+1] =3D {
 	[CTA_TIMEOUT_GENERIC_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table generic_sysctl_table[] =3D {
@@ -172,7 +172,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
generic =3D
 	.packet			=3D generic_packet,
 	.get_timeouts		=3D generic_get_timeouts,
 	.new			=3D generic_new,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D generic_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D generic_timeout_obj_to_nlattr,
@@ -180,7 +180,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
generic =3D
 		.obj_size	=3D sizeof(unsigned int),
 		.nla_policy	=3D generic_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D generic_init_net,
 	.get_net_proto		=3D generic_get_net_proto,
 };
diff --git a/net/netfilter/nf_conntrack_proto_gre.c b/net/netfilter/nf_conn=
track_proto_gre.c
index d049ea5a3770..d3ffdb5e96fe 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -289,7 +289,7 @@ static void gre_destroy(struct nf_conn *ct)
 		nf_ct_gre_keymap_destroy(master);
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -336,7 +336,7 @@ gre_timeout_nla_policy[CTA_TIMEOUT_GRE_MAX+1] =3D {
 	[CTA_TIMEOUT_GRE_UNREPLIED]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_GRE_REPLIED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 static int gre_init_net(struct net *net, u_int16_t proto)
 {
@@ -371,7 +371,7 @@ static const struct nf_conntrack_l4proto nf_conntrack_l=
4proto_gre4 =3D {
 	.nlattr_to_tuple =3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy	 =3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout    =3D {
 		.nlattr_to_obj	=3D gre_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D gre_timeout_obj_to_nlattr,
@@ -379,7 +379,7 @@ static const struct nf_conntrack_l4proto nf_conntrack_l=
4proto_gre4 =3D {
 		.obj_size	=3D sizeof(unsigned int) * GRE_CT_MAX,
 		.nla_policy	=3D gre_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.net_id		=3D &proto_gre_net_id,
 	.init_net	=3D gre_init_net,
 };
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_con=
ntrack_proto_sctp.c
index fb9a35d16069..3b825b51e206 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -615,7 +615,7 @@ static int nlattr_to_sctp(struct nlattr *cda[], struct =
nf_conn *ct)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -668,7 +668,7 @@ sctp_timeout_nla_policy[CTA_TIMEOUT_SCTP_MAX+1] =3D {
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_SENT]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_ACKED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
=20
 #ifdef CONFIG_SYSCTL
@@ -800,7 +800,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
sctp4 =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D sctp_timeout_obj_to_nlattr,
@@ -808,7 +808,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
sctp4 =3D {
 		.obj_size	=3D sizeof(unsigned int) * SCTP_CONNTRACK_MAX,
 		.nla_policy	=3D sctp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D sctp_init_net,
 	.get_net_proto		=3D sctp_get_net_proto,
 };
@@ -836,7 +836,8 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
sctp6 =3D {
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#endif
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D sctp_timeout_obj_to_nlattr,
@@ -844,8 +845,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
sctp6 =3D {
 		.obj_size	=3D sizeof(unsigned int) * SCTP_CONNTRACK_MAX,
 		.nla_policy	=3D sctp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
-#endif
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D sctp_init_net,
 	.get_net_proto		=3D sctp_get_net_proto,
 };
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conn=
track_proto_tcp.c
index 8e67910185a0..8b3594f13be2 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1305,7 +1305,7 @@ static unsigned int tcp_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -1415,7 +1415,7 @@ static const struct nla_policy tcp_timeout_nla_policy=
[CTA_TIMEOUT_TCP_MAX+1] =3D {
 	[CTA_TIMEOUT_TCP_RETRANS]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_TCP_UNACK]		=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table tcp_sysctl_table[] =3D {
@@ -1578,7 +1578,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4prot=
o_tcp4 =3D
 	.nlattr_size		=3D TCP_NLATTR_SIZE,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D tcp_timeout_obj_to_nlattr,
@@ -1587,7 +1587,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4prot=
o_tcp4 =3D
 					TCP_CONNTRACK_TIMEOUT_MAX,
 		.nla_policy	=3D tcp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D tcp_init_net,
 	.get_net_proto		=3D tcp_get_net_proto,
 };
@@ -1616,7 +1616,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4prot=
o_tcp6 =3D
 	.nlattr_tuple_size	=3D tcp_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D tcp_timeout_obj_to_nlattr,
@@ -1625,7 +1625,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4prot=
o_tcp6 =3D
 					TCP_CONNTRACK_TIMEOUT_MAX,
 		.nla_policy	=3D tcp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D tcp_init_net,
 	.get_net_proto		=3D tcp_get_net_proto,
 };
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conn=
track_proto_udp.c
index fe7243970aa4..1ac65859166a 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -192,7 +192,7 @@ static int udp_error(struct net *net, struct nf_conn *t=
mpl, struct sk_buff *skb,
 	return NF_ACCEPT;
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -239,7 +239,7 @@ udp_timeout_nla_policy[CTA_TIMEOUT_UDP_MAX+1] =3D {
        [CTA_TIMEOUT_UDP_UNREPLIED]	=3D { .type =3D NLA_U32 },
        [CTA_TIMEOUT_UDP_REPLIED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table udp_sysctl_table[] =3D {
@@ -313,7 +313,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udp4 =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -321,7 +321,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udp4 =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -345,7 +345,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udplite4 =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -353,7 +353,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udplite4 =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -377,7 +377,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udp6 =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -385,7 +385,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udp6 =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -409,7 +409,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udplite6 =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -417,7 +417,7 @@ const struct nf_conntrack_l4proto nf_conntrack_l4proto_=
udplite6 =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
--=20
2.17.1
