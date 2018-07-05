Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ED920C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ex9Ilspi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ED920C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbeGEQ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:28:52 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:28000
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753802AbeGEQZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QC6EDtrvBXkxiQaako2b09na5Xe/Mh1TAyR63+KZxo=;
 b=ex9Ilspiut/GTkcMzzrncx6OtyL1Pz1R1OtXv+qdsH2yO+eUzgYg5DcdK1p9IMGPJz5wMfYsOsQ4EYiyj12xZTuzXK5tvdQFV5IKPBcqZ68zSWoOYoDqc3zmbjlOaLOlXBSIyudgfHyIQ6QJ7nY0bIcPvA3GYTsXgBh8I5LubYY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 5 Jul
 2018 16:25:14 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Ayan Kumar Halder <ayan.halder@arm.com>,
        Rosen Zhelev <rosen.zhelev@arm.com>
Subject: [PATCH 1/4] drm/arm/malidp: Add modifier definitions for describing Arm Framebuffer Compression (AFBC).
Date:   Thu,  5 Jul 2018 17:25:05 +0100
Message-Id: <1530807905-18248-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0132.eurprd07.prod.outlook.com
 (2603:10a6:802:16::19) To AM5PR0801MB1377.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7a2076-3b93-4fe0-0e5d-08d5e293e3f7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:zrU7mNw6UOSiON3Cmqf7s6T98uOTViDuNZydvvUeqYDhRWAqOL4xO5nsrEC34QEF6i2cDrYP4zAumbqVrKELw/lWOSo9rWlL9ZpiOXuHHvQuZ8WewOj5S9Kq5V+lf4jLvwJWtVeaowP2Dlg5KZmkm1rYWYWo/+ZneFS7mU0sHz3xs0QLG2dPJbCz9m7Lh+5aNvEXF9DWbsrxpIbA7UuUjL2PEsyyuxoY11haohEMwRWTBJRJltm2MXwyAXO+G8U1;25:bHt7caX2VI6VxfgtQeKKbX4Jq4DuoRONssKNYhVPco7+YPgZVbcGQpebRKduWlRiTap0hwjGphQzLSiYH9AkrTUz2Gq2Piet6upNpb7RKJwXRXaQnt3lww1te8ih+XTtlazgRhXtb0oMRfo8Anw0H44cncrLAGaHLjXfYbVYqep0hmdu5Vy7f6/BLB4N6PQzflbVLlqUV5oL9HCnEarK0GWe4qzM8JSP1ZsVki/8PcYZIlqIHPEu3ZhjlR1INPTAneWqyrc57Py6iPRbKARuiyEX/qfM463ODBbcz5ARRYP7xcEOdd2XOWpeOMAASyypq00Oz0ARgMWxIxW3I17WpQ==;31:7ZZGTKVBlwu5MDHHnDxxS/ZiKh4d1OO+TP1FlWU+JLy2SD3WGTaXKYFUx34cT6TOUcpg63a3whLsHAZsfUFLfaLyH+A8V4MkdSj5fKQCSZdZEIJJpnaBoU4YspcpOmt32SV/aV0pYAutwx++Y1JRP+a75Ta3gcLoHVH2smV+pek9lXeza1a0tghoUrNLJnGGqH80pcQpZe7pYl529K9duv3MY/SbXQ5ka4rXQpNj9ps=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:houxj5/fLspdzV3jbo8HQwOT1qN5s2VgFHg4pWZDeJ/zd6sh56agO6V1Gw2sD3ipwpfKjfIzPXQdVKb2GA0pdPYKiT9e5TYs8agrvPManT3HEjWndtaG/8roiavWB11cjFbgY/35FpTbpJS9mqKqjwfVJz7umgSZleaFHRF6Pal5y3N8Z8m70wvccVaq+fgOJyWUwp19dB+GURHP1oDZpAi/vGSXkU+RiI2GImntq592IhpD3JhaCCAStTWaGE9DpbDjv0YLJhOWsPAh/ll03SJUTMkjU7URsAz0U4lkKQEvrzMvRwxIUc+FEfcaAXO7sFnUSbsuKv5JxHfvsmbh4qQXTVTpf55PXNdMkpt9KsooI5LFvQQJiGit+FiOGbTL9YzqVaOYRP8uzg5+hc5DcQJ7gotsNaZrhOF7X304xu97Rh9C1gsvD+idKItgVsWa1eeJ1y8FVPuGu9J+sc1KZErbecX6ta+oEdc79KD2YDt8vn/OaxAWC1b1TmQzPtld;4:Q5sJEp7g4kgYIZUzLaiexWI9l4zT/Q+9Z9sV1L59HebMjkVQ8w/VJoHTElTZLaih5SzhUoXxQ7w0MY8cTc1I7D5oBNJsuE7ue8c83DcEinSO2rakK6zUyHzlSTySBZBPsc2/FgSxXktuuJT5y0GagbnoxU+hK4Huo3DSqlRyCrIQdRPtedQzpX5PvPFCwg6AgSWN6+GQ/j9f/rdFozQQe9xu7y878+bC5Qu1DVpW56k8SccqkPxJLOhmgyUpcZIAFREjqFt6PtKoircq2IFxbKhP8Kpktun/mDhi1fGYZu4IUzDElX68NhbkQyYACgpMUsQtaMt9JH2ftBLDJLhzjlUOV+Nbn0hYjmXJg3MZxelIa3hPFKAt662T//w/zNOd
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1377B0F4C7E92255593878B0E4400@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(223705240517415)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(136003)(40434004)(199004)(189003)(68736007)(53936002)(3846002)(6116002)(50226002)(50466002)(48376002)(97736004)(4326008)(25786009)(6486002)(36756003)(26005)(54906003)(305945005)(47776003)(7736002)(316002)(5660300001)(16526019)(186003)(7696005)(51416003)(52116002)(6666003)(105586002)(106356001)(386003)(486006)(8746002)(956004)(478600001)(2616005)(8936002)(476003)(5024004)(66066001)(14444005)(2906002)(72206003)(81156014)(81166006)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:JhTL3LxJ3unmmcQvCqKR/EqSSs6EM66Sm/NZ6gT?=
 =?us-ascii?Q?JnJu3iF/84ie+frd7S8Y+xyVOAPherOcXACheZA5cIJVyrAYo9KmKFc2Ze7/?=
 =?us-ascii?Q?DBT9fLkruBrpwm1zYderGmc46Jh8nZEy1pQZuSiQQBCRDQNl/Iv1qXkrblqt?=
 =?us-ascii?Q?bxflzUPn6HVdfJTRlCsOricRWUX8wmvbgCjaQa3kIAyHAG4yqGP0LgpermTf?=
 =?us-ascii?Q?ql+oj0SrMhkUIyQiVCVB6XfYgyuKh/YdAL4kPFWrT6DK8DlLyv5naGdEHGTn?=
 =?us-ascii?Q?plPlsTK2zsUbvGxsEZiONteMEUOzhHh4EBWMrOLeWjFR0uyY6JfULPWbN/Ms?=
 =?us-ascii?Q?cHnycBR53OEY/929/x+kmeiNYCo8zcIB5HNXJh9pihAGXWlyCnKvOChyQC46?=
 =?us-ascii?Q?N5V/KH+69Cw72+I+pSyw3JTtKV+wsVSv1PGdJQM+ibD0N+PNwP+ZMpAB5XNg?=
 =?us-ascii?Q?OzzHgaT3S1UIDfW82/bJKQ+rPMSDvrpFFN+LCGbkFP8+3FW+mDvtnWJzQa0m?=
 =?us-ascii?Q?L7cADp+kRiGCkNOZvBeiJTj6yBQW4EM1bgyQWaKMOi3tvEsgfjW8SDbJNyc9?=
 =?us-ascii?Q?FTFWv8KEEJ9bLzD0ENUWkOafENw9Pa+tfJ99Nyr+9nVWwDZKGCyNjJBsnTWJ?=
 =?us-ascii?Q?wS8UEPLE+25+gzwuDOlhFnfTZZ0bz4MNXpGivDvCHo2ZCuKSHEvUKPRkxF9t?=
 =?us-ascii?Q?0P92WKvPBcKxQg8lEQ0+EL/kr9OaPOMC5Zv0QUS/bYjwW4ZQiSR6sQYJvEW6?=
 =?us-ascii?Q?I9wdTgQy/r0C0PiWiCtAv316lzy724WjyztwCiHj5Kl/09mqH4evkVfw1lu7?=
 =?us-ascii?Q?y02IgPF7NHjwdRzcxVUcN3gmFjRyiayRl5gWlOXc3pAmO4EwbSMxCqzkPomi?=
 =?us-ascii?Q?0u8L0rkj5YcT43/jF7Kic8c9rW2c559Vgh2BvgX3Gh8qSl7Mqdmq5prWQuRx?=
 =?us-ascii?Q?aPoI5DkoFX3SXHyYAbGPeGxZiaPSR8fP05N0XFMShAxk4XlgXPdrCFPO0myU?=
 =?us-ascii?Q?mQuW9c1ru7KCPYEKIyDPk5z29UP7cn8hW6O5nZSu7WuZUPbuOSesOo2ZwU3X?=
 =?us-ascii?Q?qeG8veGnpUltl6m7X2BLYNiEu0VPHFSKbo+dbEWWwFCkzUKNTyRaKkIDhgYd?=
 =?us-ascii?Q?xTZKv57aAcF4TYoFiNn6dwqG9pAMlLBhTtlSvz/R8gsOIWeVrzHSAZDLYuKk?=
 =?us-ascii?Q?w0SCe63P8HSioNNU=3D?=
X-Microsoft-Antispam-Message-Info: 0nH3YFh0td7R+65IUDYOy5g/tyAQTWdJB5pFRNAXTYVwu/1ydALmFH31zz/yMOdrhNaUQf7kxKCZSXWXzDro5dXGxllaf7+jfZI4ajKoYi7juftEja4u7ZDOmygHjrWAzMfOtRmqSPkZuyIxWGxad6IV+NjvoYqB5OJK/no+lBbhbeG5gAVEwABEnQbQvDIXMt+83z2X7L4ErJDfrTyTVN3I4PIGQPE8rIce9e4hfolFc8NQhhDx06o0bgngCjnGmAEPGdG5lWhsS+k4czADrc8ANJuZvcqPK9kPZIs+70xA0ov+pi1NrtNXY/PwNJLZ+5ZImeWqFqXmZ6veeHZwrT95lYUU/R98rOrT83rx0Fg=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:FTTEtunQPvjMPW4XB8rFL7Zn51Z9l3oci2CEWNWJeDBz/6DETkHQi+8vjp5Vowq191+9Dw9Ik77UOEtirgAdHDjL9GHtMFb3sYUwIOE9sPC03ov7xoSVnGKIHsQeBqGAvF0KSFPPCiMLU+WfV3Kvh2QWrwVXlt+8S1R4UIDPC9nJH8vfocBRNvhUMlDvVej0lVWExasFXWMLifiGmGr1r5o9GY8x+489yKRJFjrvliFzqYa8SrftGlLVuM12mW0RlAaMFseBCbAxd14ZAY22ta2jdDOamGeZTkWISV+cx6Z20ZSRPAGkLZzLqkMKqsYbMRVsLJ3mQL3j1pbJi/ne+jQxY37S2Q9icF+IGsald+RniHyMFHRHDZrOIT0iSI8xIfuccyNfk38XXkx6eCRx4dZuM6BezCjOtRnUgkvGVXEDaUPmvLsC/0EVSHYkkVxYqHH/yoG+aUKDEYl64hJKow==;5:Rp1479BXCRjH6cCtiFDq+3DlUm92GnX1nO8E6NxHOp5Tklb1SFiktH6ld39+RKXfSB0WIY/sX9TmfIDMSWotH0pEqXFFKf9RwKwFCfMeqCnw69ZWxGnK26GS8D0RNHigiN4hkUHdmMkV9yECszAjReK/y/Du7Zw31LApfnFHllU=;24:0Z5qOv40cnjn0hAITyqqJrvhRfBCpR9N8ev+w5mfqIAiL3NWVdl7Xq8CRk3D02drFragZoSLC+E5ZC9cX+f2EJdW6sCze5fsqt0afCLjFhw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:jS8uOdt0x3bXjY9LT8Xkibr1AKKQlOVmOaQOEdZYyf6kIjhlDLzkejmJdlsAIoxetGWxKoU2ygSNOY/ryhIT5RmD1N8S1DxPf7woB2dSfMNdDcZKl5OUg+Udxw51dDkcacC/2U3sMV0w81TU3nqD8mYl59Mcq6zMRvk2X+M70rquPhoDCLX4jJVL83BXZbS45I6kYpkX0PsA+epbQCMtilPiAxYt9Lwbn4+6bUuYV6Is1BR8FdrFAoiMR6n9UQBh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 16:25:14.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7a2076-3b93-4fe0-0e5d-08d5e293e3f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1377
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
 include/uapi/drm/drm_fourcc.h | 83 +++++++++++++++++++++++++++++++++++++++=
++++
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

 #define DRM_FORMAT_RESERVED          ((1ULL << 56) - 1)
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
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)   fourcc_mod_code(ARM, __afbc=
_mode)
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
+ * This flag indicates that the payload of each superblock must be stored =
at a
+ * predefined position relative to the other superblocks in the same AFBC
+ * buffer. This order is the same order used by the header buffer. In this=
 mode
+ * each superblock is given the same amount of space as an uncompressed
+ * superblock of the particular format would require, rounding up to the n=
ext
+ * multiple of 128 bytes in size.
+ */
+#define AFBC_FORMAT_MOD_SPARSE  (1ULL <<  6)
+
+/*
+ * AFBC copy-block restrict
+ *
+ * Buffers with this flag must obey the copy-block restriction. The restri=
ction
+ * is such that there are no copy-blocks referring across the border of 8x=
8
+ * blocks. For the subsampled data the 8x8 limitation is also subsampled.
+ */
+#define AFBC_FORMAT_MOD_CBR     (1ULL <<  7)
+
+/*
+ * AFBC tiled layout
+ *
+ * The tiled layout groups superblocks in 8x8 or 4x4 tiles, where all
+ * superblocks inside a tile are stored together in memory. 8x8 tiles are =
used
+ * for pixel formats up to and including 32 bpp while 4x4 tiles are used f=
or
+ * larger bpp formats. The order between the tiles is scan line.
+ * When the tiled layout is used, the buffer size (in pixels) must be alig=
ned
+ * to the tile size.
+ */
+#define AFBC_FORMAT_MOD_TILED   (1ULL <<  8)
+
+/*
+ * AFBC solid color blocks
+ *
+ * Indicates that the buffer makes use of solid-color blocks, whereby band=
width
+ * can be reduced if a whole superblock is a single color.
+ */
+#define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
+
 #if defined(__cplusplus)
 }
 #endif
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
