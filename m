Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A800C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3C32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oG7XiOkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfANRCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:02:06 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:15087
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbfANRCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfcqabV51XsigtIHDK4gnb3JrT23kyUP3VGDWp1gvjI=;
 b=oG7XiOkz4m5G3LuPOEd08Rw8+DloPXuTjxfuTEzDWlIvPkCmRpsqoC/o6hoGUc6XonSJAoTWZQyd01GYq+eg1WTp0gJjBwD0+mzba29SHoUpwjidXo+h2SLdkmcvQadYg2wgmR7tGKJPP/8pe0OMEPpHORz1vBjc6xprxfcdWxg=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3217.eurprd08.prod.outlook.com (52.134.94.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 17:02:00 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:02:00 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, Matteo Franchin <Matteo.Franchin@arm.com>
Subject: [PATCH] drm/fourcc: Add modifier defininitions for AFBC 1.3
Thread-Topic: [PATCH] drm/fourcc: Add modifier defininitions for AFBC 1.3
Thread-Index: AQHUrCrdfBMOUgu52Eef5RkbU4VOCQ==
Date:   Mon, 14 Jan 2019 17:02:00 +0000
Message-ID: <1547485311-812-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3217;6:B8MhJf5bfabrOKHCDWvlbdMQyy0ypdJ1OCDlvbFFbdbPwukd0lEr7zEbHDGQFA8b+MDJ5Ew7dMW3qaOC4mt2/bHZVetAZE7PwNTyWSAfIlrTgj0E1wbF6uKuuHA0+dT0twItLilCnZYWN4WbHvldeITrlz3iM96ncqogQhafyZBIelMUEEzREJjeQn08UFWb7WUA0DaZGYwYHVWMBNxv+aQjflufyxFN3ZbIlwTgXV23+mJ+bslTMko/wCr4gALcUMjOe0Ce0MjHegvM7iVgUm2VekZwgqPf5uDptiO+//szkKoG2cBH47uE3aVzw14ElzGjtO62XM5FvP2/RlbchPq7fdRwj39aMnq5+FKfM7UwxgQb2LQnzLWaiTH8yOHcOHU6fKlhiXbiFPNVyLOQfS6FDvaDTvtSVNJXc/fgf/tZ2q+MFcIU/8i35Lww4rXZZ2yVCXnqX8xWCIQqVD5Mew==;5:3TuXaVGJHX1YgYCDP43QRx0VuoWdAEmV1BscLOinkfypO8DnGBjlfjFfRiscoir1Q1xWylnU9DdzHkLxIT5nfGKR3ywoxoJe607/uyhuPqc1Iks7xS9YnWvRbjSyjXCildH1j25gMPXXmG7Uydf35qwH7LdoaVShAu2J7M/d88rb6ZZYzx+3aBRlFq2CWWIzRwG1AzUXZqJ8aGqT64uJcQ==;7:up/zZkx1MGxC4g4OjiovE4HqCxOupy3jkPmkM4TkcFPVHJouXguHyFATP4+efuYfjmGNDPZ6coe6E+qn5qzviV5eAG0Np4sI68xTi0gTZYJYORp7I5FZsnG21D2QA7Cr7p+v0Oy+q052bJhsyE9pig==
x-ms-office365-filtering-correlation-id: 17b657f3-a370-426a-c5ac-08d67a41ff9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3217;
x-ms-traffictypediagnostic: AM0PR08MB3217:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3217A7AB2D1F7115AC64BCA2E4800@AM0PR08MB3217.eurprd08.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(6486002)(305945005)(7736002)(6436002)(54906003)(110136005)(6116002)(3846002)(316002)(99286004)(52116002)(6512007)(256004)(478600001)(44832011)(53936002)(486006)(14454004)(81156014)(8676002)(8936002)(50226002)(81166006)(476003)(2616005)(102836004)(6506007)(386003)(72206003)(4326008)(97736004)(26005)(25786009)(186003)(71200400001)(71190400001)(2201001)(68736007)(86362001)(36756003)(2906002)(66066001)(106356001)(2501003)(5660300001)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3217;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 01j1fP6ZMxJd2raMVmnQX0a1TzY4YjibySdnuL0y2bfX+0j0zCnkdBy92OkQcMY75O4ucHgjbIcwWViz5Txjq8hR79BHnQg9QXHd0ggecYt0M0qN2VMZMAXO3gSGyoqklpN/CBpF4KODQzk7iydysri7zps0OZKNMxcMJuXqIqd5gsYVDPwxpQ4IodEwOZeQyr8ctVvEmk4byal8LL7fXhTKJDfH1SkPlqwMhxRtxw8Yic5/KL3Ipv7i4gDUKai98DNaPakF1F8xkMWbdM8XSV0mk3Oo9jz9oTHlYInMrdBanIAbdZs3VxsWlWVfvrcChycNOkTO4WataJE5ewSjmqLollsRLGxRuaw2pnK33hGSP+QEIMfxLIZxkijvt4lWqHlR1gGSPfPHXEkcNeY3WfGwhX9z4IOPQmFdyhBSylY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b657f3-a370-426a-c5ac-08d67a41ff9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:01:59.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Franchin <matteo.franchin@arm.com>

This commit adds definitions of format modifiers for version 1.3 of the
Arm Framebuffer Compression (AFBC).

Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
---
 include/uapi/drm/drm_fourcc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8dd1328..d6a20d4 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -602,10 +602,18 @@ extern "C" {
  * Indicates the superblock size(s) used for the AFBC buffer. The buffer
  * size (in pixels) must be aligned to a multiple of the superblock size.
  * Four lowest significant bits(LSBs) are reserved for block size.
+ *
+ * Where one superblock size is specified, it applies to all planes of the
+ * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specified=
,
+ * the first applies to the Luma plane and the second applies to the Chrom=
a
+ * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
+ * Multiple superblock sizes are only valid for multi-plane YCbCr formats.
  */
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)
=20
 /*
  * AFBC lossless colorspace transform
@@ -665,6 +673,21 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
=20
+/*
+ * AFBC double-buffer
+ *
+ * Indicates that the buffer is allocated in a layout safe for front-buffe=
r
+ * rendering.
+ */
+#define AFBC_FORMAT_MOD_DB      (1ULL << 10)
+
+/*
+ * AFBC buffer content hints
+ *
+ * Indicates that the buffer includes per-superblock content hints.
+ */
+#define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
+
 #if defined(__cplusplus)
 }
 #endif
--=20
2.7.4

