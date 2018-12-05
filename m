Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA31C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDF72054F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDF72054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeLEDlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:41:44 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:27908
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbeLEDlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/Z5AEfAp7LtQDbRqSV/nKb4KKZL4TReirBD+RbET68=;
 b=cG28Nb12DcN4io8ge870aHp+cYmWzisoHGQWOtqQ9gYe/HParcKcrjh4mowftj/ElG7sHAh0aSffHaufC/p8BseK/WQD33CY1IKB3WD7W3+BM7o1mdu86IHeZTOOrDrwtUYFTE0rchWcO0oq/WpGdAXKXk3DpQ0HwJcJgKgbSP0=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0675.eurprd08.prod.outlook.com (10.163.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 03:41:35 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 03:41:35 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1] drm/arm: Delete redundant CONFIG_DRM_ARM
Thread-Topic: [PATCH v1] drm/arm: Delete redundant CONFIG_DRM_ARM
Thread-Index: AQHUjExrupzxTQVxfESmoukk40rkGA==
Date:   Wed, 5 Dec 2018 03:41:35 +0000
Message-ID: <20181205034011.29103-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0145.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::30) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0675;6:pZ4lmay5lB+eIEbuQA2sVJ7M5sA5sWCbwXkO5/7gWcRTi1UGusBQEUqq/uKaMvEPDymGIaJQGxATZikZX3dSTYYZzbC5WyzQMg5fwJkaF9nVS4JGpYElJqxr3dmJePMG77HpKoPHD8d4ClyCvFMT15CxPn6X5J2tmP7dbS7BaAijiVfOutDJ1i4YBQomHxKEd4hKm6Eje9IqZmly8YeaRpJovCFOWUCbxXxdI/7fCPdhO0+uoRguuW4UfVhiX48+YODldmR7S5brv5RBkHQ8obMaanJ79K3aJyboNy2s+s+meJ+xQdmQqzhZ16SCTV4BzDK9h5KAxByEjwMbYnH5WpG+nhIL4FSL0sISvDoaAzQEV81mzWEJQFeaGqVt48MG/zq3A83vChxM9Q2zBduRU6nV1d4Lb5+cY9HjrDlDImhHy0QewKNDrN6vR16fDeVD4choAu0yCKMJXmHw8QaSqA==;5:kX86aSefYSszslnqeGQn45u3FhFwxk0pxH8J4vJl31Lip3bsp79zpfv4RfDm8tfb9yExtNN0bvS5Wg4ROu3DkpaOPXtvqQgnKvy18M9qQH2UDGTtpxiXhtgxb6YcCcNfWcVvYrTiELGvt9qWcH2REiiMEtHus6KhyfMxd5kIydc=;7:27K9notrYTVOQQbULl+t7yfL6VxfAOScgmQJDTkED5Qjk+ELC1t6zo2rwUgEVfhQbnFu5ixse8WiOu9RqMIF2iL/xOxZKG+lxAVGsaVIcFM3coUpr0xVQuGmshJjnt9JIRChge+xx16CXZKStSFD2A==
x-ms-office365-filtering-correlation-id: 23c7c16d-2dd1-45f5-0155-08d65a638e07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0675;
x-ms-traffictypediagnostic: AM3PR08MB0675:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB067510802827E7F26C4FB03DB3A80@AM3PR08MB0675.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0675;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0675;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(346002)(136003)(199004)(189003)(316002)(54906003)(37006003)(53936002)(81166006)(81156014)(6862004)(8676002)(4326008)(8936002)(6512007)(2616005)(486006)(476003)(6436002)(386003)(6506007)(6636002)(105586002)(2906002)(106356001)(68736007)(26005)(55236004)(102836004)(66066001)(99286004)(25786009)(6486002)(52116002)(478600001)(103116003)(36756003)(1076002)(186003)(3846002)(6116002)(305945005)(7736002)(86362001)(256004)(14444005)(71200400001)(71190400001)(5660300001)(14454004)(97736004)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0675;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VLwVHtjtCPh5pwPdJRLntOeZhQckjcKrgJ7W6pFQi7GmQNmNekezuhd2vtqa+x+eQbxMO+uHToJz28E41UPGeVNrR8TlZx9OWzRlmPUbLWoE6nkshhBmd8zHiChakl7jh/z2wC8T8otRKWX14u9EfRCdK4TEFUnuenX+4c0SE1QZI+Lz7Vt+EHkvJBrtWkW02yZWfYHsOYOisTd8e9T1JyXfHMrm43wESFTcqTGMSKIO6et5b2Y4zPNQEILAwFvGdbr2Qx09ohsX47j1FtY5Tc8lA1uei0CURJ0ee1l29W3IzkxsApDNCRrWAcGo+7z4lSVa5ls+1S6XX9q0n+eVGEGQlWvQ7rWkUEjoaMX6+EA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c7c16d-2dd1-45f5-0155-08d65a638e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 03:41:35.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete redundant CONFIG_DRM_ARM, and add a menu "ARM devices" to subclass
ARM device drivers.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/Makefile    |  2 +-
 drivers/gpu/drm/arm/Kconfig | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1fafc2f8e8f9..0df0a5a4cc82 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_DRM_DEBUG_SELFTEST) +=3D selftests/
 obj-$(CONFIG_DRM)	+=3D drm.o
 obj-$(CONFIG_DRM_MIPI_DSI) +=3D drm_mipi_dsi.o
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) +=3D drm_panel_orientation_quir=
ks.o
-obj-$(CONFIG_DRM_ARM)	+=3D arm/
+obj-y			+=3D arm/
 obj-$(CONFIG_DRM_TTM)	+=3D ttm/
 obj-$(CONFIG_DRM_SCHED)	+=3D scheduler/
 obj-$(CONFIG_DRM_TDFX)	+=3D tdfx/
diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index 9a18e1bd57b4..f9f7761cb2f4 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -1,13 +1,10 @@
-config DRM_ARM
-	bool
-	help
-	  Choose this option to select drivers for ARM's devices
+# SPDX-License-Identifier: GPL-2.0
+menu "ARM devices"
=20
 config DRM_HDLCD
 	tristate "ARM HDLCD"
 	depends on DRM && OF && (ARM || ARM64)
 	depends on COMMON_CLK
-	select DRM_ARM
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	help
@@ -29,7 +26,6 @@ config DRM_MALI_DISPLAY
 	tristate "ARM Mali Display Processor"
 	depends on DRM && OF && (ARM || ARM64)
 	depends on COMMON_CLK
-	select DRM_ARM
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -40,3 +36,5 @@ config DRM_MALI_DISPLAY
 	  of the hardware.
=20
 	  If compiled as a module it will be called mali-dp.
+
+endmenu
--=20
2.17.1

