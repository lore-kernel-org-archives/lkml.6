Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2632C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823232147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qeorDd2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfBSU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:26:16 -0500
Received: from mail-eopbgr750041.outbound.protection.outlook.com ([40.107.75.41]:46400
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729391AbfBSU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VksHgkHWMcOrlJXk+KkAzJ1QgECMAEP/evl/0WEeco=;
 b=qeorDd2Shf8DchC3YxG1SRCS2kLlx+c2ermY/+c49FfqgfUgIpWrQ90jA+T6euGAwY/LA1Dhf5ynScPyVmmYZmb0Dsf91wLzSwObBXitznmDXZKNRptjywRes57AFhjK3bRl3yTSuELncxZmyrBKwlhvRZ8xhv+NvkQZ3zxWAAk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2623.namprd12.prod.outlook.com (52.135.103.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 20:26:11 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:26:11 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 5/5] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Topic: [PATCH 5/5] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Index: AQHUyJFZaKRxVZaOeEikQzVyaK26KA==
Date:   Tue, 19 Feb 2019 20:26:10 +0000
Message-ID: <20190219202536.15462-5-Yazen.Ghannam@amd.com>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99c81b86-b5a9-40c6-50ef-08d696a87c0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2623;
x-ms-traffictypediagnostic: SN6PR12MB2623:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2623;20:wlCWEVeNrng7kLsxK8Qct7w0TWD/kcrWySOp3WX61nWowCmB9L0w5Vi2wR7poNhwphnbjXPjifjKVb9lJmK6ot2fjZV6rOuaiNwtUrH9SuyJM4Al4TUs95qUOJKxey/XK2tm3M137TE+wpQaV0hGR94kAmJLpt/gy2yte8hdBcncLhEuQvAYvZf9gCUzatb0RrKYe0Kq+28vzfzrWo4VzGhSeet+q7/SyXUtZZJTLncBRFaWy8giSLrSEQfBcQyr
x-microsoft-antispam-prvs: <SN6PR12MB26231CD1B8FAA28A0ADCC017F87C0@SN6PR12MB2623.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(2501003)(1076003)(5660300002)(99286004)(52116002)(8936002)(2906002)(36756003)(256004)(14444005)(186003)(76176011)(72206003)(8676002)(3846002)(6116002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(54906003)(2351001)(7736002)(6486002)(106356001)(6512007)(26005)(25786009)(305945005)(446003)(66066001)(386003)(6436002)(6506007)(5640700003)(86362001)(316002)(68736007)(11346002)(102836004)(97736004)(486006)(14454004)(4326008)(478600001)(105586002)(2616005)(476003)(6916009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2623;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PQmGvcmnZ8Kb3nEraSOg5Bmt0040jFpNGvboa5HqpXAJhSYgPYsmPOTxYBskHwq/6gM6Zn0OHDeOpJs7ag2cNJnuxNiojq5QR6LUXE+u4q0WnktwKcd+RYBqucKUgepmyMJrsi5lV3TrVB5XKHyaNtQPer2HAuhrqKfWqZLCsade/w08aumzmk8jSfKgRXG8RAgZK7buB19qgi+8nBhSnXKLrDZJGvagA4msmCnmlEF7wNzt82BWkS9Miy88/dJmuRy3dmvMTqBfxhTz91IUbCoLehA84+BTJT//XcsKSZtPxNwwVm3wJKf5XJxkzQW9Iu6HLXToUBW7F1L8++uVxDcwRigu4/EL+hhyzMuKzX2rhhPnv+jjOcoOBeursXP3aIvLmelbcFkuFYcKWlmYX9wVd22uDOLVcyNBzN/rewo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c81b86-b5a9-40c6-50ef-08d696a87c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:26:09.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
 drivers/edac/amd64_edac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 656788699c64..073bfd112c44 100644
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

