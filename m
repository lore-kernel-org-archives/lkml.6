Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB2C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LseB9svw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCD82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeJAHWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:22:32 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbeJAHP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAsEEa5LISNM3Bnp/KoK8iiNbVlBLlpHcxESIzHtohc=;
 b=LseB9svwi+fsJmPf9l+DzCiyIVatr2LKBuhleRDE1WzoKkdTGAF4RJVUyzqAlKxdoByMav6VLthCykcnSJRh3+8+4/D9VkVONGk8NNL684BuIi3Fgw/XXkf0ZsTiWQ4sY+GqhIdSssHgrkOszV7xFgqoVEX2C+jBtQRKww3BdcI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 26/37] netfilter: conntrack: timeout interface
 depend on CONFIG_NF_CONNTRACK_TIMEOUT
Thread-Topic: [PATCH AUTOSEL 4.14 26/37] netfilter: conntrack: timeout
 interface depend on CONFIG_NF_CONNTRACK_TIMEOUT
Thread-Index: AQHUWR8qr3F4/qWAfUGc+MPsqbKPmg==
Date:   Mon, 1 Oct 2018 00:39:09 +0000
Message-ID: <20181001003850.147107-26-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:+MD0KddLmjJf4sfqgLlTb9TgWsD5VXjVyFP/TJKa90uCS5zDn1gs7Shhx9pWlt0cLZh3UX4fLkfmlVurkOOsK41Uvid1Msd2TuRjJ0xIaiCSOsjx8H7EpB+WuFRfZY8qgWcIqFUEkVj5TQ4dHx7471vgkLx3TVwwPuqaX1vM0eQMSShhbLu40CJnUgPQ68/7DMbZ+ZlU56/ynp9zjJ+2qu9VR5cqhTiHV425Zk3fzmmpNBMEdkGtelBysE0Hd7CLoWCsBWqkyo6/bp8w2jYQaOfCov+eWarBy4xe5GTplYaXlvJAEHBxmuNHbV2oE9utt+66Vcp9j9zHCtUSgpm8XLDhqEnkTOEgQ4D+8/V3Y6X+yvm0KkPWmtm6iqDhKeRb5TJTQpNEocJdWsq4xCjCcZc4bz0EYqIYHxO9MCrBP7TcFR97fH6iKg6vV2pBp6+eulzFgHAkiPnDwTuhU8WWjQ==;5:fnVuaYiizezhbaeLIO62C+GhUK/VWQ8kKMKUu5rjDLnFX9pdZaLety19oq3NmJwSsAUlvY2G2R4x53fvP50ko++7KUzED2ih9jnJNLtVvwsJpYtPpJiGFSPWcOfWoURl/7B6AMxbBONqNjnkq17QcfxGYI6tneJYLrHAuBrHnCw=;7:QijOnrtScHaCg34MHv6o/UkoZhfsMOMfg5BJT1Dx+HaGr4lVpxCP7p7+JpYJ8nbb43n+EnfAueYOGVLV7wSSEP3NzL2//mLMEtti6KFDfNhHfK9Yuyf6lCscW0Te68/9RvMRj+CBc2/ZKTmb1aocW5EbQ6wMZ+2BQAydBjUZliPuKk88TjeXLUAjcYVdNFRp5Jh2pwEXRe5Kg6XBJrcDoql1Rel6mxn/OWFycM5MjFm+ADzIf+e1NrVMp8Vt2HyI
x-ms-office365-filtering-correlation-id: dbfb1370-d4da-4803-9d44-08d627367553
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08546AC4A442F8272F8D1AD4FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53946003)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +TA6gAA3ckSsei56sOblVV4VZS2gigjtm6zA6A65xRt8xwipIlsNECJGZTa+FFn6TW7B3jhTJY/S46Y6iSgWj62FJcdu3WwtJLnvzm+iNzAXeIbCOwjEMxh1QidR4ZUAU/zcw+I7AosNrxh7gMwPWq8Bvw0u72wHJmH+3UCuBNcBiAo52i3RGoY3DjFc6LPsWwIPaSkJDjSSXOkhC7nyv2vaIO3jX2I3vmioXIWWKnfvJxLhY+nJkpgygqfP/XMtUAIhpcYFHKZHesMR8+mEAxai2dbtu8MiZwmxCKOLUUWxPrOHTfDQou73NfotXyZLW5E3sR7EJTazwOevyfwxfo2rVtnapi7K8dwpFGLoEbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfb1370-d4da-4803-9d44-08d627367553
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:09.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
index a046c298413a..06c986f771f2 100644
--- a/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/nf_conntrack_proto_icmp.c
@@ -265,7 +265,7 @@ static int icmp_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -303,7 +303,7 @@ static const struct nla_policy
 icmp_timeout_nla_policy[CTA_TIMEOUT_ICMP_MAX+1] =3D {
 	[CTA_TIMEOUT_ICMP_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmp_sysctl_table[] =3D {
@@ -365,7 +365,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_icmp _=
_read_mostly =3D
 	.nlattr_to_tuple	=3D icmp_nlattr_to_tuple,
 	.nla_policy		=3D icmp_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D icmp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D icmp_timeout_obj_to_nlattr,
@@ -373,7 +373,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_icmp _=
_read_mostly =3D
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
index a9e1fd1a8536..dcc161b9ea8d 100644
--- a/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
@@ -264,7 +264,7 @@ static int icmpv6_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -302,7 +302,7 @@ static const struct nla_policy
 icmpv6_timeout_nla_policy[CTA_TIMEOUT_ICMPV6_MAX+1] =3D {
 	[CTA_TIMEOUT_ICMPV6_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table icmpv6_sysctl_table[] =3D {
@@ -362,7 +362,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_icmpv6=
 __read_mostly =3D
 	.nlattr_to_tuple	=3D icmpv6_nlattr_to_tuple,
 	.nla_policy		=3D icmpv6_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D icmpv6_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D icmpv6_timeout_obj_to_nlattr,
@@ -370,7 +370,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_icmpv6=
 __read_mostly =3D
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
index 812de5496b37..46f9dd4737c1 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -709,7 +709,7 @@ static int dccp_nlattr_size(void)
=20
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -760,7 +760,7 @@ dccp_timeout_nla_policy[CTA_TIMEOUT_DCCP_MAX+1] =3D {
 	[CTA_TIMEOUT_DCCP_CLOSING]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_DCCP_TIMEWAIT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 /* template, data assigned later */
@@ -893,7 +893,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp4 =
__read_mostly =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D dccp_timeout_obj_to_nlattr,
@@ -901,7 +901,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp4 =
__read_mostly =3D {
 		.obj_size	=3D sizeof(unsigned int) * CT_DCCP_MAX,
 		.nla_policy	=3D dccp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D dccp_init_net,
 	.get_net_proto		=3D dccp_get_net_proto,
 };
@@ -929,7 +929,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp6 =
__read_mostly =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D dccp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D dccp_timeout_obj_to_nlattr,
@@ -937,7 +937,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp6 =
__read_mostly =3D {
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
index 9cd40700842e..f2ad4aebc816 100644
--- a/net/netfilter/nf_conntrack_proto_generic.c
+++ b/net/netfilter/nf_conntrack_proto_generic.c
@@ -80,7 +80,7 @@ static bool generic_new(struct nf_conn *ct, const struct =
sk_buff *skb,
 	return ret;
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -120,7 +120,7 @@ static const struct nla_policy
 generic_timeout_nla_policy[CTA_TIMEOUT_GENERIC_MAX+1] =3D {
 	[CTA_TIMEOUT_GENERIC_TIMEOUT]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table generic_sysctl_table[] =3D {
@@ -173,7 +173,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_generi=
c __read_mostly =3D
 	.packet			=3D generic_packet,
 	.get_timeouts		=3D generic_get_timeouts,
 	.new			=3D generic_new,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D generic_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D generic_timeout_obj_to_nlattr,
@@ -181,7 +181,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_generi=
c __read_mostly =3D
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
index 09a90484c27d..001b746a8e20 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -290,7 +290,7 @@ static void gre_destroy(struct nf_conn *ct)
 		nf_ct_gre_keymap_destroy(master);
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -337,7 +337,7 @@ gre_timeout_nla_policy[CTA_TIMEOUT_GRE_MAX+1] =3D {
 	[CTA_TIMEOUT_GRE_UNREPLIED]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_GRE_REPLIED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 static int gre_init_net(struct net *net, u_int16_t proto)
 {
@@ -372,7 +372,7 @@ static struct nf_conntrack_l4proto nf_conntrack_l4proto=
_gre4 __read_mostly =3D {
 	.nlattr_to_tuple =3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy	 =3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout    =3D {
 		.nlattr_to_obj	=3D gre_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D gre_timeout_obj_to_nlattr,
@@ -380,7 +380,7 @@ static struct nf_conntrack_l4proto nf_conntrack_l4proto=
_gre4 __read_mostly =3D {
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
index 6303a88af12b..bb0e8e1a5996 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -618,7 +618,7 @@ static int sctp_nlattr_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -671,7 +671,7 @@ sctp_timeout_nla_policy[CTA_TIMEOUT_SCTP_MAX+1] =3D {
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_SENT]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_ACKED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
=20
 #ifdef CONFIG_SYSCTL
@@ -803,7 +803,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp4 =
__read_mostly =3D {
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D sctp_timeout_obj_to_nlattr,
@@ -811,7 +811,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp4 =
__read_mostly =3D {
 		.obj_size	=3D sizeof(unsigned int) * SCTP_CONNTRACK_MAX,
 		.nla_policy	=3D sctp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D sctp_init_net,
 	.get_net_proto		=3D sctp_get_net_proto,
 };
@@ -839,7 +839,8 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp6 =
__read_mostly =3D {
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nlattr_to_tuple	=3D nf_ct_port_nlattr_to_tuple,
 	.nla_policy		=3D nf_ct_port_nla_policy,
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#endif
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D sctp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D sctp_timeout_obj_to_nlattr,
@@ -847,8 +848,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp6 =
__read_mostly =3D {
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
index cba1c6ffe51a..bf4f003ce5a3 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1294,7 +1294,7 @@ static int tcp_nlattr_tuple_size(void)
 }
 #endif
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -1404,7 +1404,7 @@ static const struct nla_policy tcp_timeout_nla_policy=
[CTA_TIMEOUT_TCP_MAX+1] =3D {
 	[CTA_TIMEOUT_TCP_RETRANS]	=3D { .type =3D NLA_U32 },
 	[CTA_TIMEOUT_TCP_UNACK]		=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table tcp_sysctl_table[] =3D {
@@ -1567,7 +1567,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_tcp4=
 __read_mostly =3D
 	.nlattr_tuple_size	=3D tcp_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D tcp_timeout_obj_to_nlattr,
@@ -1576,7 +1576,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_tcp4=
 __read_mostly =3D
 					TCP_CONNTRACK_TIMEOUT_MAX,
 		.nla_policy	=3D tcp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D tcp_init_net,
 	.get_net_proto		=3D tcp_get_net_proto,
 };
@@ -1605,7 +1605,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_tcp6=
 __read_mostly =3D
 	.nlattr_tuple_size	=3D tcp_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D tcp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D tcp_timeout_obj_to_nlattr,
@@ -1614,7 +1614,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_tcp6=
 __read_mostly =3D
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
index 8af734cd1a94..47ac535744be 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -195,7 +195,7 @@ static int udp_error(struct net *net, struct nf_conn *t=
mpl, struct sk_buff *skb,
 	return NF_ACCEPT;
 }
=20
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
=20
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_cttimeout.h>
@@ -242,7 +242,7 @@ udp_timeout_nla_policy[CTA_TIMEOUT_UDP_MAX+1] =3D {
        [CTA_TIMEOUT_UDP_UNREPLIED]	=3D { .type =3D NLA_U32 },
        [CTA_TIMEOUT_UDP_REPLIED]	=3D { .type =3D NLA_U32 },
 };
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table udp_sysctl_table[] =3D {
@@ -316,7 +316,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udp4 _=
_read_mostly =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -324,7 +324,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udp4 _=
_read_mostly =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -348,7 +348,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udplit=
e4 __read_mostly =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -356,7 +356,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udplit=
e4 __read_mostly =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -380,7 +380,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udp6 _=
_read_mostly =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -388,7 +388,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udp6 _=
_read_mostly =3D
 		.obj_size	=3D sizeof(unsigned int) * CTA_TIMEOUT_UDP_MAX,
 		.nla_policy	=3D udp_timeout_nla_policy,
 	},
-#endif /* CONFIG_NF_CT_NETLINK_TIMEOUT */
+#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 	.init_net		=3D udp_init_net,
 	.get_net_proto		=3D udp_get_net_proto,
 };
@@ -412,7 +412,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udplit=
e6 __read_mostly =3D
 	.nlattr_tuple_size	=3D nf_ct_port_nlattr_tuple_size,
 	.nla_policy		=3D nf_ct_port_nla_policy,
 #endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
+#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		=3D {
 		.nlattr_to_obj	=3D udp_timeout_nlattr_to_obj,
 		.obj_to_nlattr	=3D udp_timeout_obj_to_nlattr,
@@ -420,7 +420,7 @@ struct nf_conntrack_l4proto nf_conntrack_l4proto_udplit=
e6 __read_mostly =3D
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
