Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC21C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A691721917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4mpw0r69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbfBOJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:21:49 -0500
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:48157
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729087AbfBOJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+YY1qm4FxzSpeDdB8XkHhxKm1bz5Gvo8dGdLQGdfRY=;
 b=4mpw0r695XbNK5iLYT2IBtDkl35bYJdKX9ZFku+LsEzcVGFuq4Ikv/40QD24LG7Pua66olkKPlIERSX9BnSQ2NHp4dF9QB3gyqy/1MAHatTVNyND3nA1iT346cs+yEf30Dp8dOaTp7VvX3lBiQm15aQC5JsokZU6Orl3hNKpYmc=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:21:47 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:21:47 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 4/4] NTB: ntb_hw_amd: set peer limit register
Thread-Topic: [PATCH 4/4] NTB: ntb_hw_amd: set peer limit register
Thread-Index: AQHUxQ/fJIExF4TcCEiIuwfP6t+BqQ==
Date:   Fri, 15 Feb 2019 09:21:46 +0000
Message-ID: <1550222486-30144-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92e9921-6880-4435-cc9f-08d6932701bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3615;
x-ms-traffictypediagnostic: MN2PR12MB3615:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3615;20:u0kU51mulLj/SuqtranceotU1fyTXGoXyXZsnsRZFlNi1CiLHUNbEXhFX3PmVxGv4NWunuzMCCBLkdI4+DT42kLBhUyJjHj/V2bESiXtq4ouwQV95dgKuJaL+I6wiCkoXnIfhVsJIaETIdmDaZK8nTuUTYCyXBrXNiMagmNdUNTG1T7I6533avgZ+QDf6tUgzvOe9EXayP7bvc+0tdF+s0yoSv12G2aB6PqKI4vBfSRP32aFE76tIfy3ozsfreKG
x-microsoft-antispam-prvs: <MN2PR12MB3615DD55225F9FFC27555976E5600@MN2PR12MB3615.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(68736007)(256004)(86362001)(2501003)(14454004)(6486002)(6436002)(97736004)(2201001)(6116002)(3846002)(72206003)(2906002)(66066001)(478600001)(36756003)(2616005)(186003)(476003)(26005)(52116002)(6512007)(486006)(4326008)(25786009)(110136005)(316002)(54906003)(99286004)(50226002)(8936002)(81166006)(81156014)(8676002)(305945005)(7736002)(106356001)(71190400001)(71200400001)(105586002)(53936002)(386003)(102836004)(14444005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3615;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gu0ueULUJBP3Yvgu2TTt+WIXYbTuHq/KTBnotFKvmIEnj5QWOpGFbhfJ3OOO08lI91VQhV/o6owe8anKfu2Di51iJR9KGefmsL73JeyW12r5cFvfYeEZzpWIq/KCYXmP8UM1oqUKduiYTLRhxqesXdw0I07pjnT9dV+wG5i05vz4UCIMbxw1hC69tEQBfgh8bP0/R4lbsrvfnlg21L9aTcpfWCFZMA25mWeb5y0Io1T07L/mOQUQahMD2HhrGD4IbqoFebtMjdZwsEYm9j23SZLj+taYS4BK9iUuTBCqgmm+lXpyXENoCBKo0RtH129pcAeSk+xOruZ03GGTtPt7/+kmzzTZp1FvD+wntHDnF+K0lQrdmtE1pYJ6tlzltGRutrCArsnuH0a/+tB87RMLoe83b40kXXnOD0/ogFThcHo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92e9921-6880-4435-cc9f-08d6932701bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:21:43.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

As per amd ntb spec it says that peer limit register
must be programmed

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index efb214f..cd463e1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -160,8 +160,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, in=
t pidx, int idx,
 		}
=20
 		/* set and verify setting the limit */
-		write64(limit, mmio + limit_reg);
-		reg_val =3D read64(mmio + limit_reg);
+		write64(limit, peer_mmio + limit_reg);
+		reg_val =3D read64(peer_mmio + limit_reg);
 		if (reg_val !=3D limit) {
 			write64(base_addr, mmio + limit_reg);
 			write64(0, peer_mmio + xlat_reg);
@@ -183,8 +183,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, in=
t pidx, int idx,
 		}
=20
 		/* set and verify setting the limit */
-		writel(limit, mmio + limit_reg);
-		reg_val =3D readl(mmio + limit_reg);
+		writel(limit, peer_mmio + limit_reg);
+		reg_val =3D readl(peer_mmio + limit_reg);
 		if (reg_val !=3D limit) {
 			writel(base_addr, mmio + limit_reg);
 			writel(0, peer_mmio + xlat_reg);
--=20
2.7.4

