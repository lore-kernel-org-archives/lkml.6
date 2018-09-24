Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45988C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E807E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QvN+jnuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E807E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeIXVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:28 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:46976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387754AbeIXUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+WuEv/2oeZmMDGbnJeLnZGuJHIiRq5jbTxRkjcNKFM=;
 b=QvN+jnuGbg8ofyIsMtsZfD6PNQg5r0PIl27Ha/WVgCj+fZBMXEbxoFrooeC2rQdQ8eUii/BQoqyisZP+6vK2LcuiKMX6pWas/d0C7BJOVvOvJGv4DV5Xrvp6yM8FbskbvJDuLAzSh16CaMrXaFapkLL82AoFSeb9t3R8HHVP8Jw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 73/76] nds32: linker script: GCOV kernel may
 refers data in __exit
Thread-Topic: [PATCH AUTOSEL 4.18 73/76] nds32: linker script: GCOV kernel may
 refers data in __exit
Thread-Index: AQHUVBWxx1hQ6/mie0i6X87IkTSvIg==
Date:   Mon, 24 Sep 2018 14:48:44 +0000
Message-ID: <20180924144751.164410-72-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:yalE2rb2kfe9+l7yNW5ENQ2TJFeEpEMnzpeQZOb7Cbi9fLZh6DfJQuaarQo6kTtNF76A3ymoscWOFSDdk1sH8Yb3vqlzq8EgG2BRaZaQjB82PRTX8HTxObLuh0ataG62vOqqAZ/Bi5VcB2AMOAZ5dwP3mHROUuoihzYextPjq+OYvZd6HFCFhLj3zoYL/qeOzatEi+py7rGWy/8kfyupnX6mbq2lpD9iXOZXzKwzzYCoLl3P3Hc6/uOdFqih4tS1u32t1s+rVRppm2Jn3WMqQ3nCfgSLfSiKFcouAzICu429vyyOBcA2Bp5uK5qzcpYyibak5eyi9n+yCZP9W9qqUi3gXo/EkubTIaybFbWstYGL4hnxvp00Gzsr28zFkV3jyXWQ+i2WFcB8QLzJr7Rr3+S5Ni3tPFIcLu0sTh/zbLCjpcsLfZD7SmA9wzvclOtVUNQAVdrv6nZaoHzrVtkSPg==;5:6T/Hh3O+vqLx0tbkZPLYja/R+Hsvk/jD+/Us4OHbSbyOQi3RT5Ipih26vra5qMoogeCVC1Wj/EweNBhe7LByZ3cUAtMnHahm8n23A/RQb7StKOm2JJxccAmMAr0K3S+OQPJhXcW3uUQJN2t/+ST0NsOU8Q+Yw22iIHUGGBP8rr4=;7:FkjpbIZUjTwIdJDkmoMKaocx18XyaPOSdGaLBQVEasZlYbzw/iih+LHALZ4tKUj4MgN3oyolTlIWCLQYCq3bxaL6RAi4KL2Kr49zCHi2j0QAkOafJgDJkAzfRGRSYNuqbxXlNTjyqwOzbP6XgiHHw3u5fFehPXFS3MXE1usjDVPZ/VZAWJZBjfTOeKBL3dDxef57yDgQAaQUI2RbN7W0n2aAbw8e+IjyyrN2uH++6eP1udbtPDHN2WyZTwG9QaPR
x-ms-office365-filtering-correlation-id: 7d8ed0b8-49fe-4d71-1b73-08d6222cf38b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047109AB25E94BD201ECB2DDFB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(966005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(6306002)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E9ORQn7MEutn6nBBPe1wGOc97RnYv9WPw6y+hSgD3BpRFh/dJeUqcsJpJULCnEbYKE2ErgO+FyHtbTpXuzJFcvKplByndjBaZw7StObrMpy8LTECEsXXSZRBr/w/0YFDIR8FQsmNbrKvaa1YRQDUF/9EXGn3ZdAZiqR3L7ylD0GdW8e5rcwB/FD8Xf5jeBMYDNHhQP/k4AHaMBVgiWFgqTTDXLPHtv4EcNPPLXcp4KuTrKHJSJzHYZ2L6ceXEp1FQQ0wzHfQpaJqTLg8z1Pc12nguwnqN3U6OELKIHtLTGLJwxwv62+pLUC3etzqXA7jJnS4XwnWk1MpWIsESTkJMkIYZmGZb+FyweR6oTHxfzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ed0b8-49fe-4d71-1b73-08d6222cf38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:44.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit 3350139c0ff3c95724b784f7109987d533cb3ecd ]

This patch is used to fix nds32 allmodconfig/allyesconfig build error
because GCOV kernel embeds counters in the kernel for each line
and a part of that embed in __exit text. So we need to keep the
EXIT_TEXT and EXIT_DATA  if CONFIG_GCOV_KERNEL=3Dy.

Link: https://lkml.org/lkml/2018/9/1/125
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/kernel/vmlinux.lds.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.ld=
s.S
index 288313b886ef..9e90f30a181d 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -13,14 +13,26 @@ OUTPUT_ARCH(nds32)
 ENTRY(_stext_lma)
 jiffies =3D jiffies_64;
=20
+#if defined(CONFIG_GCOV_KERNEL)
+#define NDS32_EXIT_KEEP(x)	x
+#else
+#define NDS32_EXIT_KEEP(x)
+#endif
+
 SECTIONS
 {
 	_stext_lma =3D TEXTADDR - LOAD_OFFSET;
 	. =3D TEXTADDR;
 	__init_begin =3D .;
 	HEAD_TEXT_SECTION
+	.exit.text : {
+		NDS32_EXIT_KEEP(EXIT_TEXT)
+	}
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
+	.exit.data : {
+		NDS32_EXIT_KEEP(EXIT_DATA)
+	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	__init_end =3D .;
=20
--=20
2.17.1
