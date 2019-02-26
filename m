Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC82C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6D21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A/Iiefpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfBZRZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:25:56 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:56213
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728750AbfBZRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkmxhDJ2rCnniR/gAmtEnDbxY+6Pf5YZYCqzmYR1yys=;
 b=A/Iiefpt70IFV0oLBGj0hjU2Zv18veGwXcu+/PpBku5kQpVloP05Ws49cJ80FO/Nelq1mAfsBEF98wiQdJjDAz/tENZ7dKOf6BY6HNyMOkg9gqpHOAyaVVV65+mq0rOVIMWipRJcdPLFKQ5ZIaus6r3ehAzofuct3SBwk+O84es=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 17:25:49 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:25:49 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 6/6] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Topic: [PATCH v2 6/6] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Index: AQHUzfhQUM2Be6R8v0iQFfvx5yFpVg==
Date:   Tue, 26 Feb 2019 17:25:49 +0000
Message-ID: <20190226172532.12924-6-Yazen.Ghannam@amd.com>
References: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0094.namprd05.prod.outlook.com
 (2603:10b6:803:22::32) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40373dfe-828c-4f15-212b-08d69c0f72fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2800;20:bvuZSbViEqZLnAx+yS9J8MEN4H6m18h250ygBtnKwhWoAgddiHqP5NjAqVNrWO/kT8AegYQC7sua82sYE76tRahzjH6tvE2S9gvsd6PXkDtBs7hl6p52MlnVCIxZalAQBz+aGdYDs7MN6HV5tPr5g0xUcP3w+WhpVO3gRWOmRk0RhUAwmM5e3JFEs90I/yRyF3oN3xML4BmTUaGJGJkz5MUB4ZC2RZ8JtimhCiDS2SFFcvfDmIIjpm5jbOXAzkdC
x-microsoft-antispam-prvs: <SN6PR12MB2800409E8A55D18A783E4167F87B0@SN6PR12MB2800.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(478600001)(26005)(3846002)(50226002)(6116002)(4326008)(5640700003)(2906002)(25786009)(102836004)(68736007)(6506007)(386003)(476003)(486006)(11346002)(2616005)(5660300002)(14454004)(72206003)(446003)(966005)(14444005)(97736004)(6916009)(256004)(66066001)(36756003)(81156014)(81166006)(76176011)(71200400001)(8676002)(86362001)(99286004)(8936002)(2351001)(52116002)(1076003)(305945005)(316002)(6306002)(6436002)(6486002)(105586002)(106356001)(71190400001)(7736002)(54906003)(6512007)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wD+HQ93vur74R3m2wOUiZZ/ygjcUQXsUg9ZiWcDdk/cpdOSTlBeCCX5uVsANfZA+uVfU1YBMzP4TDFiaZI4q4REfUoFC9IMO/xcyLR0p1F+V9Z/4hwaVFrIx4vF43tX0+pMEP4h2N4inGC25oLfTLjQGbH99UNnvUnM/GC+zqcM/nr2MCQxY9wgqEROeYuOxDbt8MExLRuUq3ZOHyAfInWCGq1O3o4SVgLaq+0OCz3gDY5RHZiidXTaE6bh6jzCGt0k1epAIMfe444YeDeVDHUdxZwSRhzACIfVmHwDazw9hVp2UhyQRuVqOUqpKCkb6iChVb62aJIxORMYhrRc5TtQFca20wVdns3Z0m+9QLQoLBYSXftKHrzgQxLrOluUxVgFa2b01XoMBndgQdtBrbz48zvxZCajuWTK6z+P1/PM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40373dfe-828c-4f15-212b-08d69c0f72fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:25:48.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems may support Chip Select interleaving. However, on Fam17h+
this was not taken into account when printing the Chip Select sizes.

Add support to detect if Chip Selects are interleaved on Fam17h+, and
adjust the sizes accordingly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190219202536.15462-5-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 34128e23aae0..eec7692244f0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -784,6 +784,22 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *p=
vt, u32 dclr, int chan)
 		 (dclr & BIT(15)) ?  "yes" : "no");
 }
=20
+/*
+ * The Address Mask should be a contiguous set of bits in the non-interlea=
ved
+ * case. So to check for CS interleaving, find the most- and least-signifi=
cant
+ * bits of the mask, generate a contiguous bitmask, and compare the two.
+ */
+static bool f17_cs_interleaved(struct amd64_pvt *pvt, u8 ctrl, int cs)
+{
+	u32 mask =3D pvt->csels[ctrl].csmasks[cs >> 1];
+	u32 msb =3D fls(mask) - 1, lsb =3D ffs(mask) - 1;
+	u32 test_mask =3D GENMASK(msb, lsb);
+
+	edac_dbg(1, "mask=3D0x%08x test_mask=3D0x%08x\n", mask, test_mask);
+
+	return mask ^ test_mask;
+}
+
 static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 {
 	int dimm, size0, size1, cs0, cs1;
@@ -800,8 +816,19 @@ static void debug_display_dimm_sizes_df(struct amd64_p=
vt *pvt, u8 ctrl)
 		size1 =3D 0;
 		cs1 =3D dimm * 2 + 1;
=20
-		if (csrow_enabled(cs1, ctrl, pvt))
-			size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs1);
+		if (csrow_enabled(cs1, ctrl, pvt)) {
+			/*
+			 * CS interleaving is only supported if both CSes have
+			 * the same amount of memory. Because they are
+			 * interleaved, it will look like both CSes have the
+			 * full amount of memory. Save the size for both as
+			 * half the amount we found on CS0, if interleaved.
+			 */
+			if (f17_cs_interleaved(pvt, ctrl, cs1))
+				size1 =3D size0 =3D (size0 >> 1);
+			else
+				size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs1);
+		}
=20
 		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
 				cs0,	size0,
--=20
2.17.1

