Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E715C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EA720657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nG7aR61m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANP2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:28:34 -0500
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:37910
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfANP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQ9F+qNQxLPEiGz5fiqihNYRrqM6a5Q2GVAJk8tlDM=;
 b=nG7aR61mOjjlzS6/KzJKBHTCTUcgE5slXwLf1I3FADLjdWLKYAToWykJl0T76riCL0Gx0kw2tBq9M25qxhQfe1W/nrY2/OVWNVk+697D9/sxsLnSs2h9w2F7qGorX0qytFXiGwGue0gMDGuFJU2R7akBz5UfxxXVDipAjPnx5Wo=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3427.eurprd08.prod.outlook.com (20.177.109.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Mon, 14 Jan 2019 15:28:27 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 15:28:27 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Thread-Topic: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Thread-Index: AQHUrB3LrXJMP7k9bUyTQbg+n7XNXg==
Date:   Mon, 14 Jan 2019 15:28:27 +0000
Message-ID: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::28) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3427;6:mJcA6KEG7JteWqE9pvhR2pWbZDfIpcdhDsK0iYQL3qJtOCnqJ+53hGBbMF75vjioEi+TD8VI2/IvdI5dfKhQC8iP9aK6ePr/lORx9eVFnjLd1j3GzH6FZLOIQZU1i7nMekuVxbM4502uxZqQyxu45BhrugvoAmrQD/T6msQFBZ7lGG9tYeSOcrNZHx/F3OWz6qG3RJgtig5VtiZTYqqrAFY92o7DgKcTPqXN4zydp8sdNQuzx2w19JMRboatK2vds1QW3guMAFiwBpjFDxzL98vcAhQnXpjKixi7P8PKifx5PVvhwzY5i0Ev/7AyzvIOjsWfy+07/SyG/szurFQOFyuHE67RN6jOyZMDPM5s/fmCN0H6mgITWtY0Q3olhUIReeJF0TJ2hZYXec101qiYv7b6v6+j4C1iX8e5awPoUONzSrrQREWYA8rI+RqMMmvWjaHKAHSyvKgpkkRveM5umQ==;5:4DRnYIT/hPV/cr09DQfu2M3psORjNjb7y2C/dx0BLPiy6hNIc1iqqQoxlwRbn13Aa6Cg0uY4UceJ5sPBkjTonHk8CNyLV21LfhqxYFCXGAlP0rpVZHSnaWGgat6PGULLGml+cTM4KRTBe/SVzQy/Ok/RcydOmJsMNKgkuneA66+7idbvXbNbKFhNb+p5xmUr5CNG6RfDkAHSWvUzSA5B2w==;7:oowmQdKHVaydNo4hwG8S6SMgSGIXc559L0aEdgyBMMqnniCQ7VXofo7z9IeRO93ipYEdkXMRN8Q2NxPrE1hMF3dvAEmJ2VehYClHF6S2a+zKXUu50gCJbdMVsWOkmxdbFUTy2bKNGzsdlVrvAw+mbQ==
x-ms-office365-filtering-correlation-id: a33536bc-9689-4d1e-60a7-08d67a34ee0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3427;
x-ms-traffictypediagnostic: AM0PR08MB3427:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB34275AA2B26D5C4D9FB66E51E4800@AM0PR08MB3427.eurprd08.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(26005)(102836004)(4326008)(52116002)(2616005)(476003)(14444005)(8936002)(8676002)(186003)(7736002)(305945005)(3846002)(6116002)(68736007)(86362001)(256004)(25786009)(2201001)(36756003)(66066001)(6306002)(6512007)(5660300001)(19627235002)(53936002)(6506007)(386003)(50226002)(99286004)(97736004)(478600001)(2501003)(72206003)(106356001)(105586002)(6486002)(44832011)(81166006)(81156014)(6436002)(486006)(2906002)(71200400001)(71190400001)(14454004)(110136005)(316002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3427;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: glIKih1vlRJdSrPfKSSPKUVe4KNM91CvNhBIdwn+m5e+EF4eSvEr8Vs5I7bYwrh6VaX0UeklB0JzJvaCFwfK2mm2dnoN6kMiRNKwPvVdDQxwKgmK1taHt6SFq7AFaUw70huPRq3QlkDC5Y2XYHYZ0dcd2UV4dPPMfzTlmBkSg+j7BrHQp7L6X6odxLspdLrJMVy0HFzxM271gmGVFJWRXXzRRpj/LKI8anLRs/RIK6Yhpf7/HbuZ1pivwcfjEJwdPijE7N6wuC2RufyZBBY/JhlWM2DUhHnvlyCVFuYDVyj3+i7k5XClWV7rhB+cdTtEfQYY806TC1lhA0L7LkwhzQimrlATdVrEzv5U0psUbzs243TO59W3dqqXLaeBISQOAkSbhTQyMuRIuhkaAgH+dgq1tvxqnbfDjgMMEjHW8TU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33536bc-9689-4d1e-60a7-08d67a34ee0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 15:28:26.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One needs to translate the Gralloc buffer flags for AFBC (eg
MALI_GRALLOC_INTFMT_AFBC_BASIC) to the corresponding linux kernel drm modif=
iers.
This gets passed to libdrm via drmModeAddFB2WithModifiers.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

/-- Note for reviewer
I was able to get this working for Android P on Juno with Mali DP650 and Ma=
li
T860 gpu(with some additional hacks). I have not yet validated this hikey96=
0.

I have used the following components:-
1. Gralloc (from https://android.googlesource.com/device/linaro/hikey/+/mas=
ter/gralloc960)
  - Built with MALI_MMSS=3D1
2. Libdrm (from git://anongit.freedesktop.org/mesa/drm)
  - You would need drm_fourcc.h and gralloc_handle.h
--/
---
 platformdrmgeneric.cpp | 42 ++++++++++++++++++++++++++++++++++++++++++
 platformdrmgeneric.h   |  2 ++
 platformhisi.cpp       | 14 ++++++++++++--
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/platformdrmgeneric.cpp b/platformdrmgeneric.cpp
index 503c04a..a520224 100644
--- a/platformdrmgeneric.cpp
+++ b/platformdrmgeneric.cpp
@@ -18,6 +18,7 @@
=20
 #include "platformdrmgeneric.h"
 #include "drmdevice.h"
+#include "mali_gralloc_formats.h"
 #include "platform.h"
=20
 #include <drm/drm_fourcc.h>
@@ -83,6 +84,31 @@ uint32_t DrmGenericImporter::ConvertHalFormatToDrm(uint3=
2_t hal_format) {
   }
 }
=20
+uint64_t DrmGenericImporter::ConvertGrallocFormatToDrmModifiers(uint64_t f=
lags,
+                                                                bool is_rg=
b) {
+  uint64_t features =3D 0;
+
+  if (flags & MALI_GRALLOC_INTFMT_AFBC_BASIC)
+    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_16x16;
+
+  if (is_rgb)
+    features |=3D AFBC_FORMAT_MOD_YTR;
+
+  if (flags & MALI_GRALLOC_INTFMT_AFBC_SPLITBLK)
+    features |=3D (AFBC_FORMAT_MOD_SPLIT | AFBC_FORMAT_MOD_SPARSE);
+
+  if (flags & MALI_GRALLOC_INTFMT_AFBC_WIDEBLK)
+    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_32x8;
+
+  if (flags & MALI_GRALLOC_INTFMT_AFBC_TILED_HEADERS)
+    features |=3D AFBC_FORMAT_MOD_TILED;
+
+  if (features)
+    return DRM_FORMAT_MOD_ARM_AFBC(features);
+  else
+    return 0;
+}
+
 uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t drm_format) =
{
   switch (drm_format) {
     case DRM_FORMAT_ARGB8888:
@@ -101,6 +127,22 @@ uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(u=
int32_t drm_format) {
   }
 }
=20
+bool DrmGenericImporter::IsDrmFormatRgb(uint32_t drm_format) {
+  switch (drm_format) {
+    case DRM_FORMAT_ARGB8888:
+    case DRM_FORMAT_XBGR8888:
+    case DRM_FORMAT_ABGR8888:
+    case DRM_FORMAT_BGR888:
+    case DRM_FORMAT_BGR565:
+      return true;
+    case DRM_FORMAT_YVU420:
+      return false;
+    default:
+      ALOGE("Unsupported format %u assuming rgb?", drm_format);
+      return true;
+  }
+}
+
 int DrmGenericImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t =
*bo) {
   gralloc_handle_t *gr_handle =3D gralloc_handle(handle);
   if (!gr_handle)
diff --git a/platformdrmgeneric.h b/platformdrmgeneric.h
index 233ba55..43cb618 100644
--- a/platformdrmgeneric.h
+++ b/platformdrmgeneric.h
@@ -36,6 +36,8 @@ class DrmGenericImporter : public Importer {
   bool CanImportBuffer(buffer_handle_t handle) override;
=20
   uint32_t ConvertHalFormatToDrm(uint32_t hal_format);
+  uint64_t ConvertGrallocFormatToDrmModifiers(uint64_t flags, bool is_rgb)=
;
+  bool IsDrmFormatRgb(uint32_t drm_format);
   uint32_t DrmFormatToBitsPerPixel(uint32_t drm_format);
=20
  private:
diff --git a/platformhisi.cpp b/platformhisi.cpp
index 76fe1e7..1cb7e2c 100644
--- a/platformhisi.cpp
+++ b/platformhisi.cpp
@@ -71,6 +71,9 @@ int HisiImporter::Init() {
 }
=20
 int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
+  bool is_rgb;
+  uint64_t modifiers[4] =3D {0};
+
   memset(bo, 0, sizeof(hwc_drm_bo_t));
=20
   private_handle_t const *hnd =3D reinterpret_cast<private_handle_t const =
*>(
@@ -94,6 +97,10 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle, h=
wc_drm_bo_t *bo) {
   if (fmt < 0)
     return fmt;
=20
+  is_rgb =3D IsDrmFormatRgb(fmt);
+  modifiers[0] =3D ConvertGrallocFormatToDrmModifiers(hnd->internal_format=
,
+                                                    is_rgb);
+
   bo->width =3D hnd->width;
   bo->height =3D hnd->height;
   bo->hal_format =3D hnd->req_format;
@@ -129,8 +136,11 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle,=
 hwc_drm_bo_t *bo) {
       break;
   }
=20
-  ret =3D drmModeAddFB2(drm_->fd(), bo->width, bo->height, bo->format,
-                      bo->gem_handles, bo->pitches, bo->offsets, &bo->fb_i=
d, 0);
+  ret =3D drmModeAddFB2WithModifiers(drm_->fd(), bo->width, bo->height,
+                                   bo->format, bo->gem_handles, bo->pitche=
s,
+                                   bo->offsets, modifiers, &bo->fb_id,
+                                   modifiers[0] ? DRM_MODE_FB_MODIFIERS : =
0);
+
   if (ret) {
     ALOGE("could not create drm fb %d", ret);
     return ret;
--=20
2.7.4

