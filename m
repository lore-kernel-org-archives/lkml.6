Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714A421848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0gEJRmED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfBZRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:25:47 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:56213
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfBZRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asNFH/L2//LpP0Rzor842kU0ZbitS5l1lPvbGWiBSXw=;
 b=0gEJRmEDsg/jg6blIXWgTHJUlN2c95KRsxlOopHHIDEdIVgl25NYllAaL1C2k2f2YS74c7RQEhsUEzaRvhKK59qJXVzezO3CimIxCmxxLehZdxPYLiX4yfxHjduB/woKxF9TL9nK4NtswX+pNryzhc67M4X2AMeekFbaOOAHiLo=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 17:25:45 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:25:45 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Topic: [PATCH v2 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Index: AQHUzfhOOWpgoksakkaRBY3QMB/cBA==
Date:   Tue, 26 Feb 2019 17:25:44 +0000
Message-ID: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 7181589d-73dc-4d60-a692-08d69c0f708d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2800;20:nJDeoavgTtBMz27G2jMDOlVBfYMTH7MYgOG6iSjxGIWBypofwmufMMSmALmNveUiAUqERZBlafWcjI1oWpzgsk4EZpGYZPk9V2fzF9SU//xLbnBntO3yOqqN4Q6a2g37O4tOakm7GoDunBJ4Sai5rTCx3YhCjVNdRsW/CptE2jHlHtDyEpPX5lYdTllyTAiU8s0loMsHzriFeicUl2VNlm5B2Wkz1tRpRv7R9Lm9i9SK5vJPrz0+vlEoY3HQLLxU
x-microsoft-antispam-prvs: <SN6PR12MB280061C91710CF3324B1825AF87B0@SN6PR12MB2800.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(478600001)(26005)(3846002)(50226002)(6116002)(4326008)(5640700003)(2906002)(25786009)(102836004)(68736007)(6506007)(386003)(476003)(486006)(2616005)(5660300002)(14454004)(72206003)(966005)(14444005)(97736004)(6916009)(256004)(66066001)(36756003)(81156014)(81166006)(71200400001)(8676002)(86362001)(99286004)(8936002)(2351001)(52116002)(1076003)(305945005)(316002)(6306002)(6436002)(6486002)(105586002)(106356001)(71190400001)(7736002)(54906003)(6512007)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hfRftDnEYt+C1TcP7jynsxhyVXXK6+tRYwrJczHrmUEZwq3k5vz61ruZMGJ7yiU9KtJqRlsRlEAg4bwbDS5qSyRfKMRzNnNIouY+kSVbRqZOlvbeIRorHzcjAUaH0y1d3vGpHlBVNBwsIN9V+36oX9Nv41rEcAOmHPxYHVRBS02+VGrEwZgF08iVSO2Bs7tzmK3zUB5yh+XAyco4YXSS/JoUoPYUCldodiPDz1dNUonHdl93vTL1uQ8QFoz0+eUqGCNCD/PEkNI26oO7Fke7iNc9LAMZWKduGUWzIi9O/0K9MP4qyUyJ17jzARjVdN0er4IHJ7jCxoCdjCEKFjzhMnSLHCxePRiLWhjKnmM0nhuk8PGcF7duJ/yXLM3FId8lnunh9XG2nl8goRlMQ5AWPCD69mzcikjgQhsQfhcGqm4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7181589d-73dc-4d60-a692-08d69c0f708d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:25:43.7581
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

Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.

This also fixes a probe failure that appeared when some other PCI IDs
for Family 17h Model 30h were added to the AMD NB code.

Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, model 3=
0h)
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190219202536.15462-1-Yazen.Ghannam@amd.com

v1->v2:
* Write out "Family" and "Model" in commit message.
* Sort model checks in increasing order.

 drivers/edac/amd64_edac.c | 13 +++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6ea98575a402..98e8da9d9f5b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] =3D {
 			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M30H_CPUS] =3D {
+		.ctl_name =3D "F17h_M30h",
+		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
+		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
+		.ops =3D {
+			.early_channel_count	=3D f17_early_channel_count,
+			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+		}
+	},
 };
=20
 /*
@@ -3203,6 +3212,10 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
 			fam_type =3D &family_types[F17_M10H_CPUS];
 			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
 			break;
+		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
+			fam_type =3D &family_types[F17_M30H_CPUS];
+			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
+			break;
 		}
 		/* fall through */
 	case 0x18:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4242f8e39c18..de8dbb0b42b5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -117,6 +117,8 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
=20
 /*
  * Function 1 - Address Map
@@ -284,6 +286,7 @@ enum amd_families {
 	F16_M30H_CPUS,
 	F17_CPUS,
 	F17_M10H_CPUS,
+	F17_M30H_CPUS,
 	NUM_FAMILIES,
 };
=20
--=20
2.17.1

