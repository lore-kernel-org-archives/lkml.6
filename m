Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE1C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753812083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NnxH/7MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753812083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeJAHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:26 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728618AbeJAHNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvvDCFOEBQF+voixF+Kii1fp8F5eGZeno9po0W4Ql2c=;
 b=NnxH/7MQ/DkZa76ZAkbOc4KzuWPsrge6gLu5VMTZivsWv4dK8un2AIPjFL7HUhvKOzgt1YG3OCw70HcR4gLkayBc8Np2YOjlN5v11SES4biGun+kWKVbCN+43Klx/0/RyfrqdVshVQ/38YKg5NDP67x9/voWftoGgr5H7dRNMv0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/65] netfilter: kconfig: nat related expression
 depend on nftables core
Thread-Topic: [PATCH AUTOSEL 4.18 16/65] netfilter: kconfig: nat related
 expression depend on nftables core
Thread-Index: AQHUWR8I2F9mUgE8WUaWTgsatL2XhA==
Date:   Mon, 1 Oct 2018 00:38:12 +0000
Message-ID: <20181001003754.146961-16-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:1JRt3NQ3vQO4M4Cp3hty/cQP5XHJ1HpGm2+ayBKxsyl8U0eUCgB1wixnqNk8GrIp50w8zvOkwudRkGGvxZ+zEhPe8OIqsEf/FO9559nwvYkm4jeWpbtcjbTmgXSIquDYumhUNWr0pY4e3gZw+EOT4gC3vxqjp7V3uaF+LW47lsgLAxnKohTt8pgmxQJRNUL7/pR24lkdd/o31/MbEcZwm1TgwLPz6QPefwO8kxRxvEOAyMEstPTsTLmuz824+SOc0Lxa7jZvtNtKRIE59JglNC/XaBV8caizCmFfNTLldmNCZvtQyQpJLlPnk4mm1I5xXCONEhO7lz3038ztEzq8Q0S7dYVhL9s5XT3Hr4YalGl38uMONbxGirOC8gH/cPNgUaeE65UZneGnu5EheVl7UIXrCLsMYAUSDtBVXc//6o7g+FD763HdmJAfIeCcZAeQIpzAnESiSlp4zkKCWDTbUw==;5:afCWnH/a9qfqA+ldbe/LSJqIaK0FtVG0ildT+Y8tKcNoO+PQhJWfvni+xnW9h/BGaW89KhKi2rmjJmEMieRtM7PIKq//eqi3uHeImWnTdHpKJixhQP5DoI55G++YehvWElJ9xUWwDhSKGNQNphD3Htkec0d5zU/EzAtsDagr/TE=;7:ZAE05HfSgzfBGknb4+pJXOCQ27jW/7O2MiaaFgryUvlNs5Ds1gUPJ2vNuah6jgTk0fcxQzXkUVCou69bdIAA3W7i4qufC/a3g0R8WGMY4ahqO8HQKC9bY/6q64OThCb2OKt37VFQPlU9lyreWZt+Ae5jjXZ2e7Boaoc8JmlBkVjtaTA7nxiVsY7mEyPPaUCip82GCEHlk3bZ3laLujbiLOEPIkRgw6vsiLAPyEa0m0iAvdJDjqF7HfjdIeYeBgys
x-ms-office365-filtering-correlation-id: 7b2bd8b4-f953-405f-8c0d-08d627362b76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB047270608B1195929C8ABB9CFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aHYCsLOCppsyVgMDwBFEM/9rKQb6PltyKVFN/6+M6Mc0FxlgrB16WbyDjRRyYwlxuHsRH5PN4TtZCY0thPdqe/CJQVhWOitkRkjuY+XHNmSV2O8qgv/E6v1AJjzNc+G71QrHBZYGYpjLL2M8vcQGwFapPLQj8bCNIcjFzEeyM6tC5Lnc2cZcOVtK/QXTPRShmj//y9aDNjK/8A9jhi/FR5OIG2mSVN4hThqsIEmGf6lOBpbipHTVWl3ay8uCjhuSmGkX9yKdONQIa5qMAnArbEXhZ63Ei3kF/q7g+48RwCGSQKUvBIHji7UXO3vNYmOws8raOGSUYWCHVbVO5UCZntcaIokj0POKWsfHnmg1F3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2bd8b4-f953-405f-8c0d-08d627362b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:12.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit e0758412208960be9de11e6d2350c81ffd88410f ]

NF_TABLES_IPV4 is now boolean so it is possible to set

NF_TABLES=3Dm
NF_TABLES_IPV4=3Dy
NFT_CHAIN_NAT_IPV4=3Dy

which causes:
nft_chain_nat_ipv4.c:(.text+0x6d): undefined reference to `nft_do_chain'

Wrap NFT_CHAIN_NAT_IPV4 and related nat expressions with NF_TABLES to
restore the dependency.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 02c7b25e5f54 ("netfilter: nf_tables: build-in filter chain type")
Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/netfilter/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index bbfc356cb1b5..d7ecae5e93ea 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -122,6 +122,10 @@ config NF_NAT_IPV4
=20
 if NF_NAT_IPV4
=20
+config NF_NAT_MASQUERADE_IPV4
+	bool
+
+if NF_TABLES
 config NFT_CHAIN_NAT_IPV4
 	depends on NF_TABLES_IPV4
 	tristate "IPv4 nf_tables nat chain support"
@@ -131,9 +135,6 @@ config NFT_CHAIN_NAT_IPV4
 	  packet transformations such as the source, destination address and
 	  source and destination ports.
=20
-config NF_NAT_MASQUERADE_IPV4
-	bool
-
 config NFT_MASQ_IPV4
 	tristate "IPv4 masquerading support for nf_tables"
 	depends on NF_TABLES_IPV4
@@ -151,6 +152,7 @@ config NFT_REDIR_IPV4
 	help
 	  This is the expression that provides IPv4 redirect support for
 	  nf_tables.
+endif # NF_TABLES
=20
 config NF_NAT_SNMP_BASIC
 	tristate "Basic SNMP-ALG support"
--=20
2.17.1
