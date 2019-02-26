Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03231C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84B921848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HIcI5lZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfBZRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:25:53 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:56213
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728689AbfBZRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL+Yn4zCUYaGiQEoVbvcik6lCWN7Ba/7+rAzQLk3C0o=;
 b=HIcI5lZoVaM2sMmA/L5p6znEBpDh/lUkX4xnET52QlL4RLPRcNH7bQryLjGa1SG7DHw99ovCgpn8LqgEs7EFqietcaKbeFpEwlPuzCwOXWA95jWrxqnMHi5uu5GgjqJ1VDXhpLviTLToYqei8wX9EzNM8dLtfgVdDswsZ26Rk1k=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 17:25:47 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:25:47 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 4/6] EDAC/amd64: Recognize x16 Symbol Size
Thread-Topic: [PATCH v2 4/6] EDAC/amd64: Recognize x16 Symbol Size
Thread-Index: AQHUzfhPcmfYqU2pLEWh5oRAOe0cLw==
Date:   Tue, 26 Feb 2019 17:25:47 +0000
Message-ID: <20190226172532.12924-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 6acfad6e-30ab-42ea-de13-08d69c0f7209
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2800;20:YLfJdxvhG7+SX9OTcF4nlLxIvglexL40JHUZmK/UqrTUAHCJrRV1B0IVqxwelHzUQz0dkdDKAShbQaVyx71ZTOz5uP/ISIW4lzaNFhkJ0SOaqkPxAQLVhDTI2GrX5VTSUpmqLxwDTonY/jhzKZg/HC6mOMJG1De2BQPwJR80WXvbGhCLVENJTyfuRxT9s9wrewVN6flf0T8EpXfrFuLuwh7Y5PuKYbC4hrwpXsKNRDdhaursO8ZN5Som2Mjkipd+
x-microsoft-antispam-prvs: <SN6PR12MB2800BC9C01AC50E4162A6FF5F87B0@SN6PR12MB2800.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(478600001)(26005)(3846002)(50226002)(6116002)(4326008)(5640700003)(2906002)(25786009)(102836004)(68736007)(6506007)(386003)(476003)(486006)(11346002)(2616005)(5660300002)(14454004)(72206003)(446003)(966005)(97736004)(6916009)(256004)(66066001)(36756003)(81156014)(81166006)(76176011)(71200400001)(8676002)(86362001)(99286004)(8936002)(2351001)(52116002)(1076003)(305945005)(316002)(6306002)(6436002)(6486002)(105586002)(106356001)(71190400001)(7736002)(54906003)(6512007)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +dD4SRfB08DZSeFbj8m4UGc+E9gc5WcH/3DgJRFQ04doFfUrSpPpu0bPCPjwppWdagfPWwoYj0hKzPtJoTDqGKS316p9xsrL6va4iPtdJthKoN/NHsg/Y82GZYyhMutUso/SJt1l0E7066FUYIqVOnqXjkh2gYS+J+OQ/O/li/tBy4mld5iaKpWn6Bty5My95arUJokBVFW+GuhWwkZ0D+kBsas0QBpmwR4znWX99YTqyKNrw4H4nKQo7QaSr0neSbE+HtqgmnxGGnrpGJbPvNHMUdk2Lqgb2V8RKCnHVU53eF8N4MqTFYESSa5AudEUOFUdABA8Id4aADoMVABcbriKyKGZbLc4KNnLoFKsHiwbtctH3zwKcLImyixMwc0ZoM8OgCWFtVO35Kx8a14BOnQ1PGgrzhmqQGlmXEJdG2w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acfad6e-30ab-42ea-de13-08d69c0f7209
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:25:46.6562
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

Future AMD systems may support x16 symbol sizes.

Recognize if a system is using x16 symbol size. Also, simplify the print
statement.

Note that a x16 syndrome vector table is not necessary like with x4 or
x8. This is because systems that support x16 symbol sizes will be SMCA
systems. In which case, the syndrome can be directly extracted from the
MCA_SYND[Syndrome] field.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190219202536.15462-3-Yazen.Ghannam@amd.com

v1->v2:
* Apply Boris' fixup.

 drivers/edac/amd64_edac.c | 21 ++++++++++-----------
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c82aafb7246a..810345572808 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -897,8 +897,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
=20
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
=20
-	amd64_info("using %s syndromes.\n",
-			((pvt->ecc_sym_sz =3D=3D 8) ? "x8" : "x4"));
+	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
=20
 /*
@@ -2609,17 +2608,17 @@ static void determine_ecc_sym_sz(struct amd64_pvt *=
pvt)
=20
 		for_each_umc(i) {
 			/* Check enabled channels only: */
-			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
-			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
-				pvt->ecc_sym_sz =3D 8;
-				break;
+			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
+				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
+					pvt->ecc_sym_sz =3D 16;
+					return;
+				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
+					pvt->ecc_sym_sz =3D 8;
+					return;
+				}
 			}
 		}
-
-		return;
-	}
-
-	if (pvt->fam >=3D 0x10) {
+	} else if (pvt->fam >=3D 0x10) {
 		u32 tmp;
=20
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 40e63cea2d81..44d81eccfe0a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -370,7 +370,7 @@ struct amd64_pvt {
 	u32 dct_sel_hi;		/* DRAM Controller Select High */
 	u32 online_spare;	/* On-Line spare Reg */
=20
-	/* x4 or x8 syndromes in use */
+	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
=20
 	/* place to store error injection parameters prior to issue */
--=20
2.17.1

