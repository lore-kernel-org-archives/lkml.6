Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4CC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C788A20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R3KEzBo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C788A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeIBRUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:44 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbeIBRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3Zl6jV0/VWv4dZOkfI4PgFiOykC5JnNnMoEzY8KT1s=;
 b=R3KEzBo859pUIMN2yQ74LD4pgJN6QEpaGAtMopjKVz+/AGEoMsUDk/5Z5MjAnFjpu/EQSnnW3ZSr9AoXRDqDyosW28Mx/3wgnPSV8GucBJmpEM2pSOFOGtt5oGVIKyzinvaYUtjI8V2wPbVUbBMhGCghp3KRSy135zbo/XFeX1E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 058/131] mtd: rawnand: make subop helpers return
 unsigned values
Thread-Topic: [PATCH AUTOSEL 4.18 058/131] mtd: rawnand: make subop helpers
 return unsigned values
Thread-Index: AQHUQr1yyc3vR1gYG0mf9TSWuSP/oA==
Date:   Sun, 2 Sep 2018 13:04:14 +0000
Message-ID: <20180902064601.183036-58-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:DLiHf8xL4bkHnvJEwQEstx41jrBYxtWdDlKChW1O/BXYE03fjS2KikvtX0h0Ra/Shcyr4VcYNb1tXcDkFeYs8RGBp1yJY/XniJ3C2R/BpZrYgOBdwIOBNQOyac67n5dA5WHOJSHVcucp4/Saw1Mwo7/r99MW2lqBNaQkNsh29LjFkMez1ztq/u9Hx43+iFWMmOlU3q7fodxiFCIK+sKES2Az7Ob7nHjrTHWt2IlMIDJVPcEJrb9wRToYILHeWPz889iK5TTs39EJ6+2hAH4/ZVYrVF9Lgr3SYyHiMmTcpExWwUgwcc2pY2ky7Jk7946sVFddNiKXAhspLvGefopx1wOAlspAmGDe8KufnCmJbIDJmjaKI7yDyRqzjMuafBXZxnFhTdfgi0yT0MZntd3zH38bf4qy9YiF3Ws+8Ss0OG7Sy3zWQiUPij17SloJW7Y+mOblgUM6I54D7EQnJfgMlw==;5:99aObaMWNpWciMmUnOGZ7zBrswzmZVZqs0yya3y8T0b9OdhtXarQ1YuIBb2WZFgVtTtCiyHH/DYl3oRKP96C4QekgZzsyAgRP82qiL0iXiwv4KBox4rtsvyLM+B2HNJF0X8uU81oFoqI3F8jPdw9JgRQIrqtMNQvlst7Y/aRS20=;7:vZDhanlDoQ5trth97fM07prurXE974Qp0+SLX9mOBuVxDPmY7umFqsFY/PAFzBjnZwKkrvml6F+Ese0hYo0tVt2zYHGGog4aFWFv8Pg/IUy/LdATcx9DdxD85Rnn3Th4GMgo1iBlIBql7P48hh1PNymMoGDpg99+Qy6gfKQdu/a6gUnUkqGxWt7V59BJaJoU88GKV/xEJHBR8X8y8DsUfoDSbfX1OL9tyj6EQaq4HQGElqU8kZsA7j9AUcUMN6qN
x-ms-office365-filtering-correlation-id: 1bcef3a6-f0a6-4e13-7954-08d610d49748
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120DA7D411CDE3B834C55F1FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MomRW1aKvcsq7vtDJgRRfJCoNOO3MwGOMEoEiQIiqIBFYD7x31edmtxmwy6/PNSBgsMq5BFaUsUFHirwWgv387qhk71jznY5OsGoluTmWEIMVRuoLskF6RQJaYFUiaQN64vOwnAWuLiyYhZREUDhBBnWIW2qMqG9wnN6subJz8WlMDLqU/ZWj1oTay4RBdcGjZvmJWkKwL9XWrKqKcMovIpXbuqj+DhFxlC6dnXMkIKW/F7bAUG56SujYOxZcZP7NnSySKE4cmBdEu0w6RBu8NcrKIF+KJAlPMueUnlJNA8Rcixu2Gq352HxaVIslBi9dWzQU2YlWG6SlnBOMhSywpbobvx9MUoCcp42HAv+NuA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcef3a6-f0a6-4e13-7954-08d610d49748
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:14.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 760c435e0f85ed19e48a90d746ce1de2cd02def7 ]

A report from Colin Ian King pointed a CoverityScan issue where error
values on these helpers where not checked in the drivers. These
helpers can error out only in case of a software bug in driver code,
not because of a runtime/hardware error. Hence, let's WARN_ON() in this
case and return 0 which is harmless anyway.

Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/raw/nand_base.c | 44 ++++++++++++++++----------------
 include/linux/mtd/rawnand.h      | 16 ++++++------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index b01d15ec4c56..3e3e6a8f1abc 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2668,8 +2668,8 @@ static bool nand_subop_instr_is_valid(const struct na=
nd_subop *subop,
 	return subop && instr_idx < subop->ninstrs;
 }
=20
-static int nand_subop_get_start_off(const struct nand_subop *subop,
-				    unsigned int instr_idx)
+static unsigned int nand_subop_get_start_off(const struct nand_subop *subo=
p,
+					     unsigned int instr_idx)
 {
 	if (instr_idx)
 		return 0;
@@ -2688,12 +2688,12 @@ static int nand_subop_get_start_off(const struct na=
nd_subop *subop,
  *
  * Given an address instruction, returns the offset of the first cycle to =
issue.
  */
-int nand_subop_get_addr_start_off(const struct nand_subop *subop,
-				  unsigned int instr_idx)
+unsigned int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+					   unsigned int instr_idx)
 {
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    subop->instrs[instr_idx].type !=3D NAND_OP_ADDR_INSTR)
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    subop->instrs[instr_idx].type !=3D NAND_OP_ADDR_INSTR))
+		return 0;
=20
 	return nand_subop_get_start_off(subop, instr_idx);
 }
@@ -2710,14 +2710,14 @@ EXPORT_SYMBOL_GPL(nand_subop_get_addr_start_off);
  *
  * Given an address instruction, returns the number of address cycle to is=
sue.
  */
-int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
-				unsigned int instr_idx)
+unsigned int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+					 unsigned int instr_idx)
 {
 	int start_off, end_off;
=20
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    subop->instrs[instr_idx].type !=3D NAND_OP_ADDR_INSTR)
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    subop->instrs[instr_idx].type !=3D NAND_OP_ADDR_INSTR))
+		return 0;
=20
 	start_off =3D nand_subop_get_addr_start_off(subop, instr_idx);
=20
@@ -2742,12 +2742,12 @@ EXPORT_SYMBOL_GPL(nand_subop_get_num_addr_cyc);
  *
  * Given a data instruction, returns the offset to start from.
  */
-int nand_subop_get_data_start_off(const struct nand_subop *subop,
-				  unsigned int instr_idx)
+unsigned int nand_subop_get_data_start_off(const struct nand_subop *subop,
+					   unsigned int instr_idx)
 {
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    !nand_instr_is_data(&subop->instrs[instr_idx]))
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    !nand_instr_is_data(&subop->instrs[instr_idx])))
+		return 0;
=20
 	return nand_subop_get_start_off(subop, instr_idx);
 }
@@ -2764,14 +2764,14 @@ EXPORT_SYMBOL_GPL(nand_subop_get_data_start_off);
  *
  * Returns the length of the chunk of data to send/receive.
  */
-int nand_subop_get_data_len(const struct nand_subop *subop,
-			    unsigned int instr_idx)
+unsigned int nand_subop_get_data_len(const struct nand_subop *subop,
+				     unsigned int instr_idx)
 {
 	int start_off =3D 0, end_off;
=20
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    !nand_instr_is_data(&subop->instrs[instr_idx]))
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    !nand_instr_is_data(&subop->instrs[instr_idx])))
+		return 0;
=20
 	start_off =3D nand_subop_get_data_start_off(subop, instr_idx);
=20
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3e8ec3b8a39c..87c635d6c773 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -986,14 +986,14 @@ struct nand_subop {
 	unsigned int last_instr_end_off;
 };
=20
-int nand_subop_get_addr_start_off(const struct nand_subop *subop,
-				  unsigned int op_id);
-int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
-				unsigned int op_id);
-int nand_subop_get_data_start_off(const struct nand_subop *subop,
-				  unsigned int op_id);
-int nand_subop_get_data_len(const struct nand_subop *subop,
-			    unsigned int op_id);
+unsigned int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+					   unsigned int op_id);
+unsigned int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+					 unsigned int op_id);
+unsigned int nand_subop_get_data_start_off(const struct nand_subop *subop,
+					   unsigned int op_id);
+unsigned int nand_subop_get_data_len(const struct nand_subop *subop,
+				     unsigned int op_id);
=20
 /**
  * struct nand_op_parser_addr_constraints - Constraints for address instru=
ctions
--=20
2.17.1
