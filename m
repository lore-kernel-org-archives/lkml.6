Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADABEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3E20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="An0uSsOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB3E20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756200AbeFONvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:51:53 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:24662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755827AbeFONvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFZXRjusxhGKXj6kV1h/bsBNA8cft4HpqHgA3gnIOgY=;
 b=An0uSsOkrlGsd/gsuY0sYfd+A0jg0EPkSij8XZ3TOWubICwhgsJDlS/UVAIICb2W8PiApGFgHYuuUmS0oCRhx+2uK9+9zwfhqzh+5p/CPvJ8IEggM8rUWQp/wfmvB78be0ql2a7I6zah8DJ+O4UlZxDYC6L7MSP53nosvz0R/h8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 15 Jun
 2018 13:51:44 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Rosen Zhelev <rosen.zhelev@arm.com>
Subject: [RFC PATCH 1/4] drm/arm/malidp: Add modifier definitions for describing Arm Framebuffer Compression (AFBC).
Date:   Fri, 15 Jun 2018 14:51:31 +0100
Message-Id: <1529070694-21088-2-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To AM5PR0801MB1378.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a9ffc3-6b08-499f-13a3-08d5d2c72175
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:TQzJ8nOM5pkW43mgifHsLp4NIWKcP/i9lw5r/6gdX3zGDhiY8fyetTioLpEtNS4OCDZwpgf+IhT7ulbNv23pmsj6ECOySyh5m8D8NWc+26xjRvtM9xZc1p8A5I15VqbCq2a4Jct4TfSvSzG3moHG+L0rm1y5JywTwG4q64/zCt9QgcSe7crDmBI/JzcKzcYTathd0dZ3u7JHLiebVi9dpJhXVEe1MrdPXc1sUKwjJ6VbVF4ORK2V8clQAEV4kKWI;25:jnEnQEa1Xoo4FCc9JN+HK/sZ650uW+LWGUlTKhWc7k1/t2U0NywUk/fvM8pA2ekf8VtOFPm149ojhPgiMqMt8+yi4O5kBc7Jr64hnAVkXIHm4TkysGRWU4f+v9prLBx2kH6GDubksOpPLgxLJtR0KOpVGDbBMGl1gXywYmAHk96Yfv9cSeTQzg42gTFrfL0Pt9n2G0zX8atzKRPgyprun62QhishaM5gRMG6SIDnRDy8vanRs2nvgVC8jEgJljK6us8rtPpGpzTxVMYC59o4IWey8w6l4epjwJDkPMF/MDREMx3ghdTD6nz2ursIcUaavSzwSZ6cvQPDq+R5RhHjrQ==;31:rxYSyUNBCTgSwnhkLs59ZY75zu/cFjxJz0D464WC1w8bw4WzEbZBj5P9FAn0OX1vGFBDmcP88qeU9sfrf6AJqwa6A7hbiirZg1z6nppfbjpVfmgjFMcXy30TdPqjLJfItpV9/Gj0NmEnEP8JyB+FNDFTWfaWli241WxXJCSgCMrA+YRCVERpto0eEyd0plFLDh364BbO5CIyW0m4kxMgNAq2iavBVKyi1IZOcJj5U0c=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:4kZZ/xSV481bu9SCOW5F8nWibQunDgYv3piRztSPVyYJKU40VHM6hqxRbEXDvv7iXqeZ7mEG8h/cJ4XRh0+yvLHpB7wQY9iGkmPbV2GFlXgYkmb3/h5+C+I0u8b4nDfuhEOKJaUTX3fti2fNV5LsE/xAUnc4ZjFqdxpjLenHiowp52DroT34sTW0+KVy7v/JYWu072tyTKMaJ3V1sPbCEefLzmCCVz5Vx4QERCW6r5mkaJH9TNqhtPDumhStbfGg;4:F8RAysX8BtXxbLkLTlxwfmSRs3xVDozFLyT/nLc9Xg7GcsL7nhakWgGNfX7S+GK0IVzIEJM7fJ/3xItPZV1y8Yznv9SLm4VtrtS9gl1DEQ3NXrSPb3mjem74NTXQZsfm1tEcZIUSgr4ug0ePZ8LXh6K/R7J1IdCWvL0PqYruAB028tJGmmc3NX59OLEDmOTT9p5h16/mi6FHKXjdhqcERAxB9y/4S2uETbQ8B0jf83fchkNQHRQKJziho3adSvjlwSM2SzwkR496PZtVqy8RZM/9QWa/1YnCyoZ+5ixptp6r6zNmY0KhnkimXO4Ahfa+G05HmdmIVJPmAHBZBfE++9fLia6u9OcvaeoaXCy8cDI=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13783E74A1C904D3601C1E80E47C0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(2616005)(2906002)(476003)(5660300001)(47776003)(8936002)(76176011)(97736004)(7696005)(52116002)(11346002)(51416003)(7736002)(53936002)(59450400001)(386003)(446003)(486006)(66066001)(956004)(305945005)(26005)(3846002)(6116002)(50466002)(16526019)(6486002)(478600001)(16586007)(68736007)(48376002)(81166006)(81156014)(36756003)(50226002)(4326008)(106356001)(72206003)(8676002)(25786009)(86362001)(105586002)(316002)(6666003)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:4JEloy1fiJZIBEg2Njit+xKMUQPKNf2PeC9adZL?=
 =?us-ascii?Q?nIOleMBNtTt64fQEH5ozMKTgAOmMMu7mttdoDuQs1stLeAsXMZsI7b0WuFKS?=
 =?us-ascii?Q?Nf/yFve88AFVkiLfkZkr51LZ/uzmYwLjUToGfoZYSa46N90hRlkvGq6Yojyh?=
 =?us-ascii?Q?UwGx9nN5zKys6cffs95lFeL3QsfDfDl1HiRryPNO+dYEjda3RhTUsl+vqONL?=
 =?us-ascii?Q?SPHWe4Hqcl2V+lWOy5U2NHK5UBbTC+mGPcaFs5Wd4W3YyeujTvvEBm0bh9FB?=
 =?us-ascii?Q?q0wxPpJDZ/3kEBfj7RZXrDIIVgoVbfowrZVp5rcK/VYUVMRRB1Meuz+ISZF8?=
 =?us-ascii?Q?CwJFr6EA/vGIkf3BK1jrKGbofsCuzxeerAfRMuHCdjZIWWvSp23SZWAE1QbM?=
 =?us-ascii?Q?/zlpF3r4qldlUstfpFLK2eEOmIjtmOusKTj7Q0Bb0bxulqRdEo1FxAUM+Y6F?=
 =?us-ascii?Q?zJjxPLG3wHhDEx87XTL8llYi+LfANrgmKWgi8Czlq6XY14tqU+0QKrAuOKjL?=
 =?us-ascii?Q?tE+UztRP2TtAGFOK+cb6kohAbbak4SIJThDtGvVwgfm/l3l60S6oIPWkC96v?=
 =?us-ascii?Q?O2NoCy54jvXR2CbHsdCeQlwPChwIK3NIFV0RSJKIAoSS4z//L1xH8VncA/sl?=
 =?us-ascii?Q?BjCtzl7V1AtrkmkJ8rB7iPnQZD122hGeXE5UjMixKa52udzKdneLtnBa+EiG?=
 =?us-ascii?Q?EC6eSEVpg5VFX7O3rrXo872NlIvBaSdgF59Kt484v4VwYUC6NdTp2ZpGWNRj?=
 =?us-ascii?Q?YNIjuaCs4vmPShpGwcbrl8FicXzun3WiMujkcoMMGOE4+AAZ3dzVP9/fpKcb?=
 =?us-ascii?Q?IYjvXDOo/YdjIukTUJXwEyrw5MP0PMEy3pZ4Ma1eyoFeJ8xlpzXfH6N/Dzht?=
 =?us-ascii?Q?lxB5MyNuD6E2c0SVIH0zasTG8hE/ico47i6G71pmyMZyj7oCV7UUrO1Y8sCM?=
 =?us-ascii?Q?HsZVjZHErpbKDUr9HO5oarad+rW7S1ZC3gJfnMEYFc7H/oWJ2hMAtda0eL52?=
 =?us-ascii?Q?FVWbBC6xXh78sSaP8vSC7n4ABAr3akBVBkOpYH+v6DYk2q575PRWPfUkEvIr?=
 =?us-ascii?Q?QwZ9+8J8wppfd/Go+7D7fZ+lU+HUUkEHAQQSWiBJgwoMeQum4g+9WGIiT1SE?=
 =?us-ascii?Q?Mt+sBR6AAuRZWwA2PXp+fLYDsUJFlvvttk5VBkLRu4DTE3by3nfIq7q5rs9D?=
 =?us-ascii?Q?yRjIS8Qn8LME+7qVC2T3JafLx7f0dcWPmCozVjbWnbCx2tX6AfjYQ9KJqHiU?=
 =?us-ascii?Q?RKnLcTsTPkULPRYvxQHIU6tY7YByC7PrYhlXlMn31/H695ivDqg92Oe1D17u?=
 =?us-ascii?Q?MKg=3D=3D?=
X-Microsoft-Antispam-Message-Info: zc1+0o7GvwF+AwCRpgD3j2htMmg7Y6I16bTAN+JW4feKQaaGIGeNumXO9n24r4m+h3kLUPHXQrHNVKLVWrkPE7KORku+JEpeaz/z2CDdtgV4FwE6l/eF0CJU2DyPIdCMB9L+dhebVCARVPI/xrMZLQkz6lB3W3O27TTbOjqXG85klU2cwkourQPjeTxvhypq
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:9i1ToUsy2PsvZhY0GiMpa+1lmHUA30sd4Zk8QQ/fVD1JJG78bKn/hMvXre4DUTaBm2jdZMd+a87PJMjemH0+BiK4yGb7AymFRAj6ccJwE15XXk3x1FuFM+wZCnkZaYJzFUbIrMVn+/NBkFx73IC0zJ2PPOffH6/2h10jVX/VKv02TRiXZ7LMacNdykL4kkXobxuPkpxgFJK9CqOgathuKnnvw76+LuD1aHnW+c7XPL3/k2+GCw2zNUuNC20dnz8F2UXyxP9F+drkODLsiyQQHu8L7UW5d61gRM7DHJRG6sYnvXBJtDaWrkU3H4x/UCraxxSCwhRYr6CMJOgRsigiip49bjRs52Ogc2LuM7J9zntjXPM8GqGP1GYbRJk94HssReZT7oeWNh203qo12NBU+42k0j30YT6eVwsGLk4ypKIKi8lD0Fnl28p5kB+Sf6x8UAQglEQ/FsrVf3tWnbqh8g==;5:MV3ZuwAy9bnn+QdpQf8Pgx+4IrIclZiRmW+WGqMhAWBRO6d2LiCmEAkOfRKKfy6qjnX0SNqcxdAvg7vXAZMm2qzLakRBaafmkr5Yl4VZVexboQAUGeUMHb/egqkc+SYDgQ4dCcpuEbcRcH05j0IZucfMYtJOv4qahNaNec8Ixo0=;24:Pkkb8BGtqalg4I/Z1BEzEsZwXGidJTQFjD3Ynl2gTCs9tUbCQvxTmSKSHYQlKAfWWULjY+E5jmRbMOaN76D5K5SySQs90ZFxdL8mmR22TCQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:9d+5RqtoX9hzt97Ie0yXXk/yCTzIro9Bl7FtbiekS/fDqG/pjmVovsmrz+aWhmamFd93wKDN5Bdywm1NRxWod7Ml2hxIeeRqEYcVkQrBQq/AS5Ck2lCB6NECoDr5b0H1SvLSnHviBMwvtOKBo/IIVzA3kr+Rlv4KfGHU7O403fLJHKXDY+FyuZDpyX6RUiaVxBJnyeMmmw1jJCa7VUPP+3gX3pE7wPQ4QjrHKTKFT5H9l4WQPVYjyRd7bLPn8BF7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 13:51:44.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a9ffc3-6b08-499f-13a3-08d5d2c72175
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFBC is a proprietary lossless image compression protocol and format.
It provides fine-grained random access and minimizes the amount of data
transferred between IP blocks.
AFBC has several features which may be supported and/or used, which are
represented using bits in the modifier. Not all combinations are valid,
and different devices or use-cases may support different combinations.

Signed-off-by: Rosen Zhelev <rosen.zhelev@arm.com>
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 include/uapi/drm/drm_fourcc.h | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e04613d..af7e9ab 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -183,6 +183,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
+#define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -405,6 +406,88 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED fourcc_mod_code(BROADCOM, 1)
 
+/*
+ * Arm Framebuffer Compression (AFBC) modifiers
+ *
+ * AFBC is a proprietary lossless image compression protocol and format.
+ * It provides fine-grained random access and minimizes the amount of data
+ * transferred between IP blocks.
+ *
+ * AFBC has several features which may be supported and/or used, which are
+ * represented using bits in the modifier. Not all combinations are valid,
+ * and different devices or use-cases may support different combinations.
+ */
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
+
+/*
+ * AFBC superblock size
+ *
+ * Indicates the superblock size(s) used for the AFBC buffer. The buffer
+ * size (in pixels) must be aligned to a multiple of the superblock size.
+ * Four lowest significant bits(LSBs) are reserved for block size.
+ */
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+
+/*
+ * AFBC lossless colorspace transform
+ *
+ * Indicates that the buffer makes use of the AFBC lossless colorspace
+ * transform.
+ */
+#define AFBC_FORMAT_MOD_YTR     (1ULL <<  4)
+
+/*
+ * AFBC block-split
+ *
+ * Indicates that the payload of each superblock is split. The second
+ * half of the payload is positioned at a predefined offset from the start
+ * of the superblock payload.
+ */
+#define AFBC_FORMAT_MOD_SPLIT   (1ULL <<  5)
+
+/*
+ * AFBC sparse layout
+ *
+ * This flag indicates that the payload of each superblock must be stored at a
+ * predefined position relative to the other superblocks in the same AFBC
+ * buffer. This order is the same order used by the header buffer. In this mode
+ * each superblock is given the same amount of space as an uncompressed
+ * superblock of the particular format would require, rounding up to the next
+ * multiple of 128 bytes in size.
+ */
+#define AFBC_FORMAT_MOD_SPARSE  (1ULL <<  6)
+
+/*
+ * AFBC copy-block restrict
+ *
+ * Buffers with this flag must obey the copy-block restriction. The restriction
+ * is such that there are no copy-blocks referring across the border of 8x8
+ * blocks. For the subsampled data the 8x8 limitation is also subsampled.
+ */
+#define AFBC_FORMAT_MOD_CBR     (1ULL <<  7)
+
+/*
+ * AFBC tiled layout
+ *
+ * The tiled layout groups superblocks in 8x8 or 4x4 tiles, where all
+ * superblocks inside a tile are stored together in memory. 8x8 tiles are used
+ * for pixel formats up to and including 32 bpp while 4x4 tiles are used for
+ * larger bpp formats. The order between the tiles is scan line.
+ * When the tiled layout is used, the buffer size (in pixels) must be aligned
+ * to the tile size.
+ */
+#define AFBC_FORMAT_MOD_TILED   (1ULL <<  8)
+
+/*
+ * AFBC solid color blocks
+ *
+ * Indicates that the buffer makes use of solid-color blocks, whereby bandwidth
+ * can be reduced if a whole superblock is a single color.
+ */
+#define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.7.4

