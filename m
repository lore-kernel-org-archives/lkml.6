Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ECC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ADF23F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MBNOZ3R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ADF23F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeGFJQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:16:48 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:56144
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753515AbeGFJQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFZXRjusxhGKXj6kV1h/bsBNA8cft4HpqHgA3gnIOgY=;
 b=MBNOZ3R/cVE3ymRaebzNvktKzgBt4cuoBqY6aPxAbV7Z6rKvCt2Ft2salJzfKFnK0V+xT/KOl+4Q3duP3EGUYhnRpa7to1crtdi21Ru7y+DT5TzxWz46a2zx1Klcbb2frzaLmRSyrenPCIlMQxL/B4kiKAe6IKjsAoeXZI28ibI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 VI1PR0801MB1391.eurprd08.prod.outlook.com (2603:10a6:800:3b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 09:16:36 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Ayan Kumar Halder <ayan.halder@arm.com>,
        Rosen Zhelev <rosen.zhelev@arm.com>
Subject: [PATCH 1/4] drm/arm/malidp: Add modifier definitions for describing Arm Framebuffer Compression (AFBC).
Date:   Fri,  6 Jul 2018 10:16:25 +0100
Message-Id: <1530868585-11068-2-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530868585-11068-1-git-send-email-ayan.halder@arm.com>
References: <1530807905-18248-1-git-send-email-ayan.halder@arm.com>
 <1530868585-11068-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::42) To VI1PR0801MB1391.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e3f0ad-2f7c-474b-49e1-08d5e3212d0a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1391;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;3:Pds0m3/Bx9nTheldB247DWhDiv7uIGZWkubp3MYaP2mnfoB5qDPvGcLXJl7CZGePwvQwXrQaqrb9E5O42zLeBLA0He/TNY1OXpsVbn80HgngDyo8tdNxU8tk/ZSwZzd0nkBtIttZo6LvhGkQyFlsav3dXhFvCtHIWIYuNVPZGsP/LOdJqEiUOT80c24FEPy6//uId20/nIzafB4LvSey/l7sYeLfVsdFBC/jYpwSfEowBRnspuYhgeaY3B1cbU61;25:JlF0lpXEkQtIWfHHQZMD17vYDBBrrT3HG+v7RsKMlKGN3UrPnJgfr0FB9tGNnND1l9vnWTtl+FVzN6RqIab8fLm6WaLz9BiVb9/Ghpw4vcjsOBhB5DmDK4XLltkgoEbZwtNJ9Kv0EilAWBdFfpfUKg395Sbuq4/sN03gSW/yEepg0hCCeBDA/qt267+qDO5S1fRsoPKyJ2zI+yRPul3ovlXfs2eBWr5Y0kKMxKDS2VYL2+5HYyGNlP/Dop4fmNuxkH23GgA2WKOLE+KzEzmN5jAGlprmVxaxYCiLZ4LQAuc+WSq1Ff/Jt8KvPHb0f7eGNHkDJGHQs+EtDqEWcYv14w==;31:4fniwplthRXAi8GalbWFW1gBSIBDQz/UlYhjPlgH6doARHFrZ21LnvL/sPQObrjKrwNSGMHEBMbSmLaepMhOA1CVIFhcFIJwxso0GRVr9mTkieFZnLjFK2q3vrGFVhU3NdKlZlvLI+IUjX9irMS00pNwzFE8Y4aGyBZ0Ko8ClGA4jWWL80i26dDS8HGgVH+LL2q+o+Xq4Kd4ve2C9aoK/SS3XCMZ0tny4wQJM8nD8IY=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1391:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;20:SwMNmzxqvf0sIy5dusILS5hhydsQKtSBT0xsEAa+tl7+8vclBVy13A/b87+REX35LxouEta1za9LqO1vApFzahWtP9Q4on3cst1aFfH/hZKFxOcu1SiAhostK1qv855mOKtcPYWEnTvVWgi4kicWns593dII0HEDxt5svlrRtuY=;4:GZVk2jz7qH9ns7+CPbwlfj68Z5c9f0ZlnRo1AMQFmcPs6ciTSRKDu0Aat9byvEUI0rA9AxScMiRt4IRl1XAN2huoo8Q3bCBCmb8gAvIX5vLNqi4BPI0r8LiMqzpFobwKKtL1UJls/hoVaQbZNAD3qpcRMjWn0zfArxLUuiQ5vs3qkGPIKq4hW08NIhj6b9bxuHy7/mintx0/BBtgARy/HneiEhcViN++4Sgnkf9DBi9tqnR7Y86BVBrlfHXmDmIILKiiJiJSZvfJueKfuMbZ6dKPBp3hyW9qNWL1vcLdPbKbEjNr7tIIR4Jt/7PvtJOlLTnmVEmAsAwPYJyTq5q7ehJcN2/2WOLi++Df0ix3JZI=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1391E4F4C4AD1798363FD83BE4470@VI1PR0801MB1391.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231291)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1391;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1391;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(47776003)(66066001)(478600001)(6116002)(72206003)(52116002)(7696005)(51416003)(106356001)(3846002)(105586002)(2906002)(14444005)(6486002)(48376002)(50226002)(68736007)(6666003)(16586007)(316002)(8936002)(54906003)(26005)(16526019)(186003)(81156014)(8676002)(86362001)(97736004)(76176011)(305945005)(386003)(7736002)(5660300001)(11346002)(2616005)(956004)(25786009)(36756003)(476003)(50466002)(81166006)(446003)(486006)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1391;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1391;23:Bg0Ebu/HZzRuqlrodVx56TVxEQvhInob4logWFD?=
 =?us-ascii?Q?oMhXjpkqeCG7kAdB7ZAshfo0WHHJo95j6v/WD9RgTwZ8AUtTcpt7zKf8rPi8?=
 =?us-ascii?Q?+95C65xLQWYDRMNfbF4K1v5KmWU8Bu1YTuXsDxghGtBaOIrhiV/Ip10Sp9mw?=
 =?us-ascii?Q?vC7BarBPjYZgYJZGwCHgWTxVkON01yIRMRuV/1gMioOzwdDsy2HNlPbTnNAE?=
 =?us-ascii?Q?YaU357xrpgFLJwFa9f9vl/W4eGe/NTS5mVaoEhY6r7YzDXgYrDzpPwy4iqPy?=
 =?us-ascii?Q?F3ysOl9xa+LvuuYWqyqbMf6+0pQLL5212pt+ceSGld+4fMZwvcnAqtaPCDii?=
 =?us-ascii?Q?v/C9dQANO88Lj/qQPcctu6ZJI4MhsmktIZmhe63DlQHFKEbQKPQCcqJRUU26?=
 =?us-ascii?Q?x+Cdjfw0SmkhMlx+xKGXh6p2/vKZlvbKz08oagDXHYT9f8kAhd1XE3Jj047N?=
 =?us-ascii?Q?RRLf48JYWghiBnsCFCsQv/RwiA6IWgtTE2AwD9vqWJatlbUBunbL3KO6PWI7?=
 =?us-ascii?Q?P+E/iZWivq+MF73J6PC+SR3WAPQ3GZ6Q9pfwe62FFXXYxzd8Mr6/+hOjDX8t?=
 =?us-ascii?Q?bc0hirzPj9g2z2NRgbrl670JKiJY5mWsJWqBP3RFp4t5qbsZlNKJGrDBARyP?=
 =?us-ascii?Q?15cIz8jIdSIcdIgnKdsWZTlaOBDfhg795lxDa2VojbCz+JDKSKUMEayH+OAd?=
 =?us-ascii?Q?3JX09nXVXG1TxPGkhLDG8mwAaWMZmy0GpY56Hor96WEa3L8OGp1ajieFxpMM?=
 =?us-ascii?Q?Gd+SCKf5mKt8HB0F8cbIReq7o3QIBAnJZcGpLxRjFrFJ8pgpZ87XoGFzMXxy?=
 =?us-ascii?Q?9ewmNvCKK1mdQbBM04vPBrJA47JzCRBqiv6sfaZCexAULaVUCWGL54LRDRw/?=
 =?us-ascii?Q?Gg77ZpaRcMzWWO7mfXwFLvd7aiD6XiwkOPDr2JKij8taSUuBhJPdsy53Qgzr?=
 =?us-ascii?Q?3MOBNpDxeXDSnuA9wVFLFtywjGGeRp8eVJvMKNcfCQAx0FVGjft9h+1aDeA9?=
 =?us-ascii?Q?+cAVkaVOlXhzClcUkFKaS0OW5hInJW4JRMbVhDQFmUdaBPiy7SfE0r7pWfQL?=
 =?us-ascii?Q?mpo0rYK/MTFRUIWveuc57XYxE4CgnKp092yW+lnJqliYMkxNbNUxTfArFsB/?=
 =?us-ascii?Q?wQov4qrrH7Bo2gfMiNa6t1v6b53wvjHu5Ovkg+Bojn8eS51XR/vc+Sin+jht?=
 =?us-ascii?Q?7xXmbr2Br9ITA5tc=3D?=
X-Microsoft-Antispam-Message-Info: j3u81MYo4tWJi+A8qxRO/Xm+4pQt0HHIMkdrai0NROP0agK+wwuXTa6snxBi+qTGScTA+kvrwYrcQk3wio3YAWSuv3ajWcTX5kiikzRpl9GiUwgVTOU2ZcSm8OaxPc6iAg/vlwhb2J1b7SEa8bl8u4PbCWk/kp7a9ppNIHXp65Et6XUsHzj9pWYIBk9wFz5vGA0zTAQUkmB3T7fAqOmf9vTq8sgR7cSl7eA25rwg40+3wALb5WdyLB5vNuquMb9OOLkPaxybKsIAPQ0tefavumkNb0zkUFTXXbz9fL9Npwprg498LAoMtiP+YJrNFoaC+CXdxyhaviVj0VNzBcZo5ORBucNyFROL9v+1Hfg1N4A=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;6:gv/WbbyuKZHDMIp1ZT/5XCiJCBIbInrbJe2W3wR1kUz4sRKviQazqsxOAU0ZpPwY2Ch0IC9oh9KxfVT72HeDbllB0hFRBINYESpDsjitdDWQiUHfyI0gDipi5FOd3J1zcYIwGHDkezBgk8qVMeGaRCXGPlXavpDQoAETrMvVkh9eXc3BlvWP4i2TKZKCtdlCcSWpQcoNqkZnwBzgWKsa9C0tfE9J3efOgoLXkhdVlMUMbjqWMVmgieDTe9MaYcYcAGgJwGR05/lLz1Zet8uEM6WJnxKwEUqdr9l+TWUaTZivxibySdKjK26fOwObApIR17I8jAH7uAsdIdjrf2fT9WXFxaKJAXlQIMUSG4JBiCe1dAhjyya9hHLZl1MMOZceu2TwBmYH/Fcg620bo7DcpgrcPNeYFHAd2pYmPd9P+JM4DMBQtt34f31Pd6Xl3gKA+LHUhakbyfnmNx+nc+I3kQ==;5:Y0LZmpbOevcqoQCjSeeJDtgLBEaM1Hri4xPWkVTUWs6SfNfrT8P8No2PjWri9s+NVVvUJT4Syz7/4M/gema1xD2nt8hnyGqU/yjgjhrHvE585qvdQd8X4vVTZdoKyNXRawXsh8aewSePsJJv3VEaXCGFEPfttC84MakiSCeBpPA=;24:dtcO5p7DKrJro8fKvDSA6paT1h6QntPyu/i/YUX39Kv48q4RJ1JD0s13R9nGgtPMCifH599bkNUtsoAIlS6sC0SyEpY5xMiMXT3ph/kkySw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;7:jmP3+FtdmHT3UYwqVHRhG9dMCXuHkoQjwJXI+59v3wK2IYIrFirvvu1GzRZcAVFKQOWicifahUVwDuSjIBNMhWHaOqioTJkHDonrkTd0zc6ufGMlQgOVHVbp+2ZymvTJMBBU62LbhXeJOhAEXaEA4o9pz7RgpwfnL7Sq5fLdCCcROD/MBCiCO363+/fGJKhD5pJ0UKXFzbmBmOo9Wg1BRH8OU4oCUaiDLaozWfpq1MJHYIezrn/MnUiv5MYXOKYc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 09:16:36.8064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3f0ad-2f7c-474b-49e1-08d5e3212d0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1391
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

