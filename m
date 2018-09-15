Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E01208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Otc7uTn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E01208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeIOGzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:12 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729835AbeIOGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1nriX5cy+lMJq3WoWgKyWRupivAM/Vrys0aAYZIDrg=;
 b=Otc7uTn0upj9Ct6V4f4QO28XmFMUO6w8rMf+PHV+XVW0loGQpohbzPpSjnmLHlye39OLenMqqJM1jfbPoSRvc82CsEb76YvYQpUwp02KQ7qgSbdWGRzTrJd9dIlDedK6Fu42SzpNmAWU2hqJ00bQeEERraC+Wg78iiwtL5j87qk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/20] mtd: rawnand: sunxi: Add an U suffix to
 NFC_PAGE_OP definition
Thread-Topic: [PATCH AUTOSEL 4.4 04/20] mtd: rawnand: sunxi: Add an U suffix
 to NFC_PAGE_OP definition
Thread-Index: AQHUTJRV3m4teylj3E69tu0gFAhiDw==
Date:   Sat, 15 Sep 2018 01:35:07 +0000
Message-ID: <20180915013502.180110-4-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:L89NotfONHrveNXHZfa7eAlAaPyBvlbde94u37jZVe2eFVBqihgvKL0qP9GxuqBxPUMqZQboipYtq8HAwuG2NI843S02lkO+YRDpOG+RF5Vs2dg9Nh3mvIaL6IHkJNu9Dq4rSYwyj1RRd4G7J415HxIoNFffX1GnegJpjQ8Q6M5fIvf8KTfOHDkD3pvW8mBifVWOGztZfjJVSTbL3ZyB663UR/Vv4jAwbcwa7V4kBAWgmp9c8tepZhkEEsQHeUuPQH7f6ZpF6crtPCzTA/Vwe8gbbDtDM4CFuG0hP+RVIcfh2/3H8Swe+AIHHBKNdcfTPu9WAX+KF4VJAO3ukIp8Ay3+d09jM522zTO2BPxC37G0OfI5dje3F/RPiAN3pvfHAwafHZrUITqwRNg6Fda6iMzHiKNRqN27opKaBNULRkBRUHNVdt3/68w20WV/pgRmtfkYI1OSSIl6gpSxlU/HPg==;5:tWFMCgRpcs+giVy6SRhY+lgbMTWuTeZmAQR9ACca1pcyIlELIZXxgyecRrRyw/mBbl9/Lm+4yHjIJcaByk2OBpLU4LvfKilhFuvcVl0RsZFQ5Wng8B1vOqYkOXlrCnGgcDD0Q5HP+UKkVI//lFID50bgNPBV9dXp75CSpjXMSHA=;7:wj5PdvbONYPIUH2vANzapz3u59cPwZsCOx0Ye/AdZ5ivyV2pUe4OH6cv9Stp3vdfNgG05yPgtnsI0ZE8y6krX4L2i8b+V5HgCSF5T5cAylK7ghLj5tgQB23W2ivN0mid6XFYyyVXXzwuD2IZXrXHiUCw8oKuggQY/gJs8AuB9VoFy5Qg9B81buVTqbghW8UGTyF27o5Acb4koBPR4XqlAL0y84UMS+wRzuN6GE9SZ1BZpJRwYD6KFfLOZuCNfNSp
x-ms-office365-filtering-correlation-id: f6725777-415c-420a-b41c-08d61aab7e77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181C61A0061767E4820BD88FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4uCouN5hGcPWWaojU5CVVg7ScL88NOMmjmQGOa7yoE/EXHyehK1pggcGbkylyaCq4S3vkCgZeTPex+mhPfhByjB2xkiFsHLfePlai/2ElHjAcjgBN0yzeqEHeBkggbuDPxTsoRh/4Yc+LY0O1YEg6L1wbZAj+2pnzr7yUPysvJLsLofy9jQC29LfqdDwzefYx7vIE+QFWi9oWMuC0syNPW3Ng05+6TOFHOHqmBrxL8LrSYiTTpOkt/PdmKp0DlPMBeGXgu65R/JFWMa4EGP4gNfAq76B1l2Z06CU+WrEGC8x/n5UMBXPPwt9BCbDndwpRkdo26ZLocdcb25uyXUFMBnAY90e5XDlaC7LIzBA2rw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6725777-415c-420a-b41c-08d61aab7e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:07.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit cf3e3fd2e94f4648f17fbd5e0e26409d5d1face9 ]

Fixes the "warning: large integer implicitly truncated to unsigned type
[-Woverflow]" warning when compiled for x86.

This is needed in order to allow compiling this driver when
COMPILE_TEST=3Dy.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 3bb9b34d9e77..db914f2f1054 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -126,7 +126,7 @@
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
 #define NFC_NORMAL_OP		(0 << 30)
 #define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_PAGE_OP		(2U << 30)
=20
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
--=20
2.17.1
