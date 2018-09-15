Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C7B21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gYXqn59R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C7B21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeIOHI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:08:56 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbeIOGrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfWE3GqqLexFqT4BTUbNw/I4BIShY95oSvvwkEyCJf8=;
 b=gYXqn59RSlzGtE/BLw3zkdrsmGxWCXQ/hnQQfjXxGznQyBXETvBghvEBxk4yujBugxCzmEAceySN8T+2SZ7XNoG85ao3RwS8EqFa3i0VIliUPBeJgb6lYPBxVMKTMi30sE4PVilwvlP5J8nzcg+Tw1ESSODATZabzJFGvUuxk4s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/92] mtd: rawnand: fscm: Avoid collision on PC
 def when compiling for MIPS
Thread-Topic: [PATCH AUTOSEL 4.18 10/92] mtd: rawnand: fscm: Avoid collision
 on PC def when compiling for MIPS
Thread-Index: AQHUTJObi/I7gCXaC0WUwfjLl+BWUw==
Date:   Sat, 15 Sep 2018 01:29:55 +0000
Message-ID: <20180915012944.179481-10-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:MovJ5BToeoh4o7GfYF4IvzJpW/XNqIrjqr6gaiv+cdGI/k8AZE2xtAhXVEpKXOTFETsMT9qYocyEMJC105EVunoO224EsaPFdka1LV4iDmbM9ZinVZmjCA1Vr2q22+Q8R2kjffgsuswZZSG1xjmcGsrtZLRCA08LrD9zOSZON98sdA7g+/Jc/aX30ABh7StIFon/vWXyuwTSb6IcskqJcIN9okBsnrs8aC6G0ykf1SeRDrQCx77IXqLw0/UCQfcK3+zOGiVDCDJgVdv6gK/wCLBO/3fbDjx2b0ynGM0EdapjecuZL3F7x/JigftzEUfnlOPzHeCmqyZTv3eni7E+hNrE+i4BNcpJQ+oK/HzYkDfxn3MzdmsI8v0oKKSed6bQHdXKMjZhY1dP0qwow9KN/5dQFNE58jiBjHAFpT3bR4qpcqqSgOIrAo47qw9PZOXBc+gG1f55qebnZjHgjd188w==;5:onfEmm63dH9BZac2HUI7m4hHyCdn00EjJi3CWtBmdBx8yiGBdHuCcjiBENbK97sYbGFycwd5l3kF2BCYNz3F5iN8bRP7u7WnxLZkqGswyR5cOoo8wKoyfo7C4NL9GrHRRrHaPZNcXpUg2cUT27SkNLZlCdYG8BHJt9AV86bIGds=;7:BW37mGxvJBcOuPyGPI4Xn2tf1C03v3qfvgtjcyGLsZCVt6D5MNpJkV87/kcg2NRG2xiZ0pBPA6JWAhRieATAO3jj6bzCve/fiG+vJz5xs0nmyuJ/9ga3aROT/yl/JAJkSSzgCWBiJZQNf+ArB38LRwtgB1vJj0mzuKOi1EnRNtbfer5aJajkoAWiEjj6DndlhyjTlMv6/pmzoq1zPJvXStMTn85ixyTwyDc76iV4ndve0VK+Q7AztWrsR5uHYZPG
x-ms-office365-filtering-correlation-id: 44ce6f11-0ae8-407d-ee25-08d61aaabe62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840948FDE5863483998E2D5FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EfaOD0rVaxRWw6lbxqGCFxZTSClXo0VDm37J4Fy0ZJCUXQ9jKvV5EZ/8hmeZcSLN3dX8+19KNv5QKE5YRm/nuhN8sCt31jLjgIkxL5dG6uMj7FB5bF8am5dABHULQ87i0R92rQ+Ke2BSLUy/tl21YqKQTANCkkrT+n4AHeR2haqByObAX26bpIPScLVJ2HW9//AvRdOE243VWlI6mHaaFXOS5bBxbfIra2pkipK1VXcIqzYMo7Et0iCOWGzXfOvQaqn2s1AirLG4tPmsJ0T57gslPgkpHF0GujMSbr8OzZ1NB2w8xsXeNKL9rTS4PCOrNYLMFkSgXcCMtMweXdYR6g0B68zUEHMBQAJ+TmWTR2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ce6f11-0ae8-407d-ee25-08d61aaabe62
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:55.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit 8f3931ed975e1d775b87ce85d65ecacd54138359 ]

We want to allow this driver to be selected when COMPILE_TEST=3Dy, this
means the driver can be compiled for any arch, including MIPS. When
compiling this driver for MIPS, we end up with a collision on the 'PC'
macro definition (also defined in arch/mips/include/asm/ptrace.h).

Prefix the fsmc one with FSMC_ to avoid this problem.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_n=
and.c
index e1086a010b88..1cba8dc2f61e 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -62,7 +62,7 @@
 						reg)
=20
 /* fsmc controller registers for NAND flash */
-#define PC			0x00
+#define FSMC_PC			0x00
 	/* pc register definitions */
 	#define FSMC_RESET		(1 << 0)
 	#define FSMC_WAITON		(1 << 1)
@@ -273,12 +273,13 @@ static void fsmc_nand_setup(struct fsmc_nand_data *ho=
st,
 	tset =3D (tims->tset & FSMC_TSET_MASK) << FSMC_TSET_SHIFT;
=20
 	if (host->nand.options & NAND_BUSWIDTH_16)
-		writel_relaxed(value | FSMC_DEVWID_16, host->regs_va + PC);
+		writel_relaxed(value | FSMC_DEVWID_16,
+			       host->regs_va + FSMC_PC);
 	else
-		writel_relaxed(value | FSMC_DEVWID_8, host->regs_va + PC);
+		writel_relaxed(value | FSMC_DEVWID_8, host->regs_va + FSMC_PC);
=20
-	writel_relaxed(readl(host->regs_va + PC) | tclr | tar,
-		       host->regs_va + PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) | tclr | tar,
+		       host->regs_va + FSMC_PC);
 	writel_relaxed(thiz | thold | twait | tset, host->regs_va + COMM);
 	writel_relaxed(thiz | thold | twait | tset, host->regs_va + ATTRIB);
 }
@@ -371,12 +372,12 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, i=
nt mode)
 {
 	struct fsmc_nand_data *host =3D mtd_to_fsmc(mtd);
=20
-	writel_relaxed(readl(host->regs_va + PC) & ~FSMC_ECCPLEN_256,
-		       host->regs_va + PC);
-	writel_relaxed(readl(host->regs_va + PC) & ~FSMC_ECCEN,
-		       host->regs_va + PC);
-	writel_relaxed(readl(host->regs_va + PC) | FSMC_ECCEN,
-		       host->regs_va + PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) & ~FSMC_ECCPLEN_256,
+		       host->regs_va + FSMC_PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) & ~FSMC_ECCEN,
+		       host->regs_va + FSMC_PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) | FSMC_ECCEN,
+		       host->regs_va + FSMC_PC);
 }
=20
 /*
@@ -618,11 +619,11 @@ static void fsmc_select_chip(struct mtd_info *mtd, in=
t chipnr)
 	if (chipnr > 0)
 		return;
=20
-	pc =3D readl(host->regs_va + PC);
+	pc =3D readl(host->regs_va + FSMC_PC);
 	if (chipnr < 0)
-		writel_relaxed(pc & ~FSMC_ENABLE, host->regs_va + PC);
+		writel_relaxed(pc & ~FSMC_ENABLE, host->regs_va + FSMC_PC);
 	else
-		writel_relaxed(pc | FSMC_ENABLE, host->regs_va + PC);
+		writel_relaxed(pc | FSMC_ENABLE, host->regs_va + FSMC_PC);
=20
 	/* nCE line must be asserted before starting any operation */
 	mb();
--=20
2.17.1
