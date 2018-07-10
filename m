Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC0208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AyDyGXEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC0208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeGJNUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:20:01 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933169AbeGJNT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nASkEuvDfzoNfHa9wKZvbqeQ6iNHNMyPjZkY+PvxmXo=;
 b=AyDyGXEhumqJl8y8xD3WHLyJCNXUorj1EBa9RhzmiRgLaPQKEOymi3ApQbtBhlJOZupHOzTTJHoOwy4v2iAXCjt5fCGv8zsFZdmK4YPtlAEYyvDgURLu20T2iO1F8i/Eu6Ik43AwKSGHv7biV+us+dba/tvQKzJg8Q8JFHwNXtc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 13:19:25 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Rosen Zhelev <rosen.zhelev@arm.com>
Subject: [PATCH v2 1/4] drm/arm/malidp: Add modifier definitions for describing Arm Framebuffer Compression (AFBC).
Date:   Tue, 10 Jul 2018 14:18:54 +0100
Message-Id: <1531228737-5450-2-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB7PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::14) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79d1a4f-7167-4d37-4556-08d5e667c232
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:Eg0Zp+/TeTy7+9hPpEszZdLmaCtzLqYqRtrXPh9PQHAX9V7IyT/kpu1MB5HVeME+cGdMkvYKVxwugAKmdLW5VMjnzaCEcn79vX9vABPIFMCiLywqV/RQom+VnUGusDxjhEIoEXsxs9xeZdtV9E5lw61N2TtpxSkh+/pINf7hvqcnXDthVZoDAp7Ngz2yNCy3i4KxshDE91x+asToZ4twNXmDQEHHjIbJrb1CFdHDIHhOUFHTbtwG69Lh2UxXOw2R;25:nH8YL3zYx5DjZ5mRdEFF/61nXsu/EJ0qlQ5saidK3QgXi1d7y3SuVPZZ+AHub3g8p8sOWAKkpexfN/W00Z2uc3WjlESi/eVG4iQ+TqHgWPlsIAwbYiSE88Y6ftHZntb7lki07QHapOWuUnvh5XxBFpBx7prtwsWpngDco6I7PvSsoWDn8TfCzGK8B7JsW5xrTp3fNNnbrFHfA3Eq35YZLFmFKgY4ixzXhOgrkS/4gcJV6mYmtre7XLK440byNDj24z+qKXyp6Lx11pxk/qn6K/0om/LoncMZWperMC6IVi3VozWiiVi/Sz2Ho90cIuB8+JEveKb05Qq1o6fGeTrjMQ==;31:tw/vmAa0PP/5NNIfxg4Qh9I2i+uJy+XmDDI4DG27fdxEdSOZ4PTRLU97aszHp7krmA+hSma7zgzuevtAEaJ+nvnRNdI6YaSNa8PBQs3H0OBXHTGz3gZ8RbHlv7Vyscu6ChD8YrhcXuqnrpRo1l6U72OTIMbRiXfoHL0dsjKdfx1AWj961LL9gCsUNWgM1HcAgsm47scDUIip6b38kMw8B3YpDwwmdFEyH0GKwmBchoY=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:ZgKiKbfGtPa96BrX2nZJ59cIClpGebvh+9gaeqM2p+X96rCStLkiNDIMQA2G3pLdgXH3eZvoEhmupK340c5nOxJUQ35hlArpmLI9vgssb12GHCaoY84hnWVQ9lzQJ8W1Tp6uqxm59eHBrxpWmYk3mv1eyYeRU4oJu7moh1IIWUM=;4:lQmnwclUl0kG4mJeLy8lQ0gwW8J2kPt9+BGVw505MT5p2WbodBSa7OXujcxi3kB9e8MjE2qh2ogzNQ6IjVRCo/EiuiPZ+dUz5y5k956MFsuD7k84zDM4F+pWU6kF9BdXCVUnhxeiN2My3v8/MI6YFG0xhct3G60pn+stdAFRwm/bDeC9uVqvWCxvT3B/3tPB2mSUQfi3NWABqsfFyKg0Y37jA3N0IUfMNL48R3OayQe4nHCEdqFM3GjsA95FM6kLlQagg3MY7DxvNCGwixhUuyMoXeiXHTkioaM1KU0HPSHUZjBbIXDEkMojW1umQ3cFgEORldRVuOPt+JID6KYq2wt0XUP6Ka7pT99bhFn1PBkk9xPKBv03f/Hys9mlpug3
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13844D40BD7250E5BCCB32AFE45B0@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(228905959029699)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(51416003)(7696005)(52116002)(5660300001)(26005)(386003)(36756003)(7736002)(305945005)(6666003)(68736007)(16526019)(76176011)(8676002)(106356001)(446003)(50466002)(97736004)(14444005)(2616005)(486006)(11346002)(956004)(476003)(72206003)(48376002)(3846002)(105586002)(4326008)(25786009)(2906002)(6116002)(53936002)(50226002)(81166006)(81156014)(66066001)(8936002)(47776003)(16586007)(86362001)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:dp+rEUomwmfXoz+X3ZGikMH6I6hh78xKOnIJ1wZ?=
 =?us-ascii?Q?FbRp2tKwbyTzWFPkWmaOzWFVoDAkrwExKB1PFxEoge0qbZketoMjZVJWo8G0?=
 =?us-ascii?Q?zxP5+A3k6gLmibeofjO2EB8V9Nsb6zmKgGvlhRBn510UE2UEfE1pjW7i/M9N?=
 =?us-ascii?Q?B9pw2CGHnPeBM+ZKGooifxuZRXiX8LhWwEr7n85yc4gtE7BPT7IQKzofeUcP?=
 =?us-ascii?Q?6Uyk4UBvS8PuFbOW1lF7TpYcEeW3fL4F2EK3OwJZLL4Blz8KcD7TqeysPdHl?=
 =?us-ascii?Q?MBQL9JL+N1glWWA8v+LA3+amX/dWaqA/ZHC7jIe3nyW49Q3zAdInBh1demnz?=
 =?us-ascii?Q?KtUvDdrDPIJxrQhhtlJSbV+eqU/ETAhG8jIbY4OgItGqRCFENeLprKvdv+Tv?=
 =?us-ascii?Q?2cg2ebc8vctfEcTC9YCzpi//eOOW0qPZAaNZ4vENp0ioSA8fsdqB206h/vgO?=
 =?us-ascii?Q?JoU9/o95eoR34U2F4QaTNQ8hoT+uDNaQFXiK8KXKZ2+6ayWP1BEq2qwAjl/U?=
 =?us-ascii?Q?wyQxQll9fl//tXLMZvBj/Rx3k/EAO6VMwKzpMOByWJzYyD+HhBhVrRDdCyqQ?=
 =?us-ascii?Q?asO3S+e8agXU3Pg4/mVdQrn4U4g0y+5zVNRdRgBEKCH6GCj0nObUoLVFtsmL?=
 =?us-ascii?Q?dX9qgSStHlQwF7hrLn/q06C+TepPT7gjmFBdc0jsG/nsecdWMlwCmOlrHPnv?=
 =?us-ascii?Q?PA+kgPH4ninlpWDP0DTPV2dew6CMnWEouH/pxPJCO3jB9A9xA8Ic4LF0raC1?=
 =?us-ascii?Q?XqUpcv9GoHAquv8A7TjjOMOwa1/M5xVJfwJ5MqzVJumFIip/gFPF/VFIcsia?=
 =?us-ascii?Q?s7ek6PQhf4fJFYa3s4MVXred1Tl7plh1QTseaKJ2lkWhXvu2pHcQjsvPFWxa?=
 =?us-ascii?Q?lBYmy0R4jvnxpZXl4X9UP4s+su0D+jdLs4NcJOnCivqvoWh2m9xCHSA4C3jY?=
 =?us-ascii?Q?vvYnzbFdzVbUXQSmaIz8bganIvK9rjebOFaeS3T8XqDNWkzQEWfBm6BV0Oxr?=
 =?us-ascii?Q?2j129k1VfWAJonwmeyYR1gVYeypN9W2l7oNx5FjBxpOO33Z/cuZKNk0R6u8M?=
 =?us-ascii?Q?vfkxjgpC5l+FscTXo7eWYeck1iD3fk/XYb3e9JuvDHa2HWA6AyTF5qRVSJh7?=
 =?us-ascii?Q?tP+l9/gzjYeQbiwJRX/zcOTiSQcOFCZV+a+tfGKzq1LkIM0rnVPR+4A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: jpmuzUk10nXIGt3wvmoD6K4I1sErmridNpy0JTiWWFMRGpoa/pfSWhR9jnTHSvUUVOJZj1BhLFV8UxffUZG+poNM1lgRpSotIu8ooT3HoVzHY4Npk7B/2UrwtYniypch1MSXgCxzbnp+4M3SzZp+h5Wm50QacOkhkiJZ8i4v2YLISLeW03uAkMviIoRyVsqvIv537PxblgGvpyWxiR16m0QvIoIq43jw0aNOGf+IODyxBCMsPWPFEDLCRK+sN4ftoH8KBl5XmEf6eqDyKiJEu1f8jUWXpsVCJyvMEvAzo5oM55EiwFGYPAK/angRXHMjih+2eVYqRbOaMVnqUALnlwwxE7r34YJg4ULXsBqokBQ=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:ib1X/4uPkgYswOszvZq/ovg6vH/Ht6/ugvjqCu/bZKU34Xe3pq629i/WRCBJX0FQjF3VEuUbI9mxWzZ3sn4I+NhS+xcMrZsld3MlWjW+wzSXRlSZC/CpOksnAB3R0rcirfw0cKLmr4B9ZDfgfg1bCZTmXeaHRMj22NXMmDLOi6GTrHw2d79zH9Qj1wyv8rrIwNKWwk+ZoXRHQZpz9obXnCo8MSICcTgVQnm7MCLgcM5uyutU6vJ88nnNnIydapKLM89QaIRzJJdmD3SfVY29Nl4my1HMgiPzAFGXt28FyNpVJgCtdSHKuEzPUunAxSYbvdawbvoDKVCyYfrp8guHzL2Qz97S0pgwc6TQr59KNJ3cf/+PRk9UEttJQ9WQzTd4RRJ0NhLWuaBbdi98p6S8QUowtTx2iVBvDpAJpnIvldVkEw8dtj3OlSdPuCXCDJDjGf8jVjFcPRdHPuRUD4t2uw==;5:zzGWFGRROrUeUvhSIq62dMpo511D4jLq1abeZzM+Q2fABdA3ICNLdlI5wHzcj0qAr68NTt3Se4fmSGDKDFVzAiEEsP1torBAfoIKvnEUWs1VEaOZuj2xepPiMNO8ho7Wini4JJ+pIkOMn2kK7hbc08EsOGY79UlhoRicl9+UGFo=;24:9B9CjlzR7ObUyOc33kMq0EMwQuRaPF3lcRvqIHxC2tREZLha/P61kGhFtCfbV0bnxurZjDs7pKJ3EmY1ZvH/7RuZW5hs3drA7gso5+xZtgw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:vUOZUNYiFFOgZ04TqhNFXsEyeI/fGwuSPO1PlO4BADbdjP2F9V7yrbYFbFfYBqxNQ4w+/vBeIEtwzey/eWoeiivO70X7Y2zVuCAHMWDyhR/MJLZhq9pfCG6WiXi0Z1RuenjE9cAFkPjn98id0zuAkTIDV1J+PRfFLaDCqQoXsQTIP2sniUTIGbN4iDltEEAMiOaWuiVK92jduAz2jvli/x5UVPzw8hGDdQa5PD/h73D+Szd6wF6uUIyA80dZm1UO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 13:19:25.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79d1a4f-7167-4d37-4556-08d5e667c232
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
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

Changes from v2:-
- Added ack by Maarten Lankhorst

Signed-off-by: Rosen Zhelev <rosen.zhelev@arm.com>
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: James (Qian) Wang <james.qian.wang@arm.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 include/uapi/drm/drm_fourcc.h | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index d5e5235..d43949b 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -183,6 +183,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
+#define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -485,6 +486,88 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_BROADCOM_UIF fourcc_mod_code(BROADCOM, 6)
 
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

