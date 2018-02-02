Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeBBMwW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:52:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:25942 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeBBMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:13 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180202125012epoutp024588a0a4dedeca7a12170575c10801f1~Pgykd4AK_1140211402epoutp02V
X-AuditID: b6c32a45-3ebff70000001023-36-5a745e8343b0
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 08/12] [media] s5p-mfc: Add support for HEVC decoder
Date: Fri, 02 Feb 2018 17:55:44 +0530
Message-id: <1517574348-22111-9-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmmW5zXEmUwcFbmha31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK+P4zm8sBc26
        FYcuvGJuYNyr1sXIwSEhYCIxb6puFyMXh5DADkaJlVvmMEE43xkltm0+ytzFyAlW1L5oFwtE
        YjejRP/Fo1DOD0aJd4+6WUGq2AR0JL69P80GYosIpEq8WreWFaSIGaTo1rcbLCAJYQF3iYsz
        7jCC2CwCqhK7D/5lB7F5BVwkTuxoZodYpyDx6sZadpD7OAVcJZacNIUIb2GT6H+hDWG7SMy/
        dYoVwhaWeHV8C1SrtMSzVRsZIexyiT1/foIdKiHQwCgx93gjVMJe4sCVOWD3MAvwSXQc/ssO
        CQteiY42IYgSD4kP938wQdiOEn//LwaHhJDADEaJCXuiJzBKLWBkWMUollpQnJueWmxUYKhX
        nJhbXJqXrpecn7uJERzNWq47GGec8znEKMDBqMTDyyFdHCXEmlhWXJl7iFGCg1lJhHebb0mU
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd62AJcoIYH0xJLU7NTUgtQimCwTB6dUAyNHDKPnwntS
        /yqDl808+n92SO2FQ7HmGcwaLRb1pRE27yefE2As+fbP5ZbJtWcG+zLj/O/nr5jrffvfxQKf
        v5ucLslMzhCTMyjP2LDrWCCvfuthi0DlM497RDY8/ng1R/sHY2L3gQ1LRSpMo6VWiC1kjqq8
        EyMVs1i0ROKa/NXuwnBh63l80UosxRmJhlrMRcWJACcSm5viAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t9jAd3muJIog3NH2CxurTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8bxnd9YCpp1
        Kw5deMXcwLhXrYuRk0NCwESifdEuli5GLg4hgZ2MEr+vtTNCOD8YJXbNbWcGqWIT0JH49v40
        G4gtIpAqsXbreVaQImaQoqYDL9lBEsIC7hIXZ9xhBLFZBFQldh/8CxbnFXCROLGjmR1inYLE
        qxtrgWwODk4BV4klJ01BwkJAJSsm3GecwMizgJFhFaNkakFxbnpusVGBUV5quV5xYm5xaV66
        XnJ+7iZGYABuO6zVv4Px8ZL4Q4wCHIxKPLwc0sVRQqyJZcWVuYcYJTiYlUR4t/mWRAnxpiRW
        VqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgZDOZt7lWmfHvCf++
        XzVG2u8kVcWaMjW/Mhv3CuS3vos5lf4k3Fc+PXzTEfkdmXOUtzrOfPnfN9fG5/N+O4kHV0wn
        XvfQuqj46uVKBl+vPx58Ojs5Nzwyud108OuPljdtU2fKh6nd/z9j/8Ss07LCCuczN1uKcb0R
        PvEt57WQtsemjEtLPovXKbEUZyQaajEXFScCAIV2Cgw8AgAA
X-CMS-MailID: 20180202125011epcas2p4d3ebb811e9bb44f761732ea97fc888e2
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180202125011epcas2p4d3ebb811e9bb44f761732ea97fc888e2
X-RootMTR: 20180202125011epcas2p4d3ebb811e9bb44f761732ea97fc888e2
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202125011epcas2p4d3ebb811e9bb44f761732ea97fc888e2@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for codec definition and corresponding buffer
requirements for HEVC decoder.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/s5p-mfc/regs-mfc-v10.h   |  1 +
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c |  3 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  1 +
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c    |  7 +++++++
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 17 +++++++++++++++--
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h |  3 +++
 6 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v10.h b/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
index 7b28313..d905468 100644
--- a/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
+++ b/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
@@ -32,6 +32,7 @@
 #define MFC_NUM_PORTS_V10	1
 
 /* MFCv10 codec defines*/
+#define S5P_FIMV_CODEC_HEVC_DEC		17
 #define S5P_FIMV_CODEC_HEVC_ENC         26
 
 /* Encoder buffer size for MFC v10.0 */
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
index b1b1491..76eca67 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -101,6 +101,9 @@ static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_VP8_DEC:
 		codec_type = S5P_FIMV_CODEC_VP8_DEC_V6;
 		break;
+	case S5P_MFC_CODEC_HEVC_DEC:
+		codec_type = S5P_FIMV_CODEC_HEVC_DEC;
+		break;
 	case S5P_MFC_CODEC_H264_ENC:
 		codec_type = S5P_FIMV_CODEC_H264_ENC_V6;
 		break;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index babc1cc..702e136 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -72,6 +72,7 @@
 #define S5P_MFC_CODEC_H263_DEC		5
 #define S5P_MFC_CODEC_VC1RCV_DEC	6
 #define S5P_MFC_CODEC_VP8_DEC		7
+#define S5P_MFC_CODEC_HEVC_DEC		17
 
 #define S5P_MFC_CODEC_H264_ENC		20
 #define S5P_MFC_CODEC_H264_MVC_ENC	21
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 81de3029..4749355 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -144,6 +144,13 @@ static struct s5p_mfc_fmt formats[] = {
 		.num_planes	= 1,
 		.versions	= MFC_V6PLUS_BITS,
 	},
+	{
+		.fourcc		= V4L2_PIX_FMT_HEVC,
+		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
+		.type		= MFC_FMT_DEC,
+		.num_planes	= 1,
+		.versions	= MFC_V10_BIT,
+	},
 };
 
 #define NUM_FORMATS ARRAY_SIZE(formats)
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 55ccccb..8c47294 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -220,6 +220,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 				S5P_FIMV_SCRATCH_BUFFER_ALIGN_V6);
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
+	case S5P_MFC_CODEC_HEVC_DEC:
+		mfc_debug(2, "Use min scratch buffer size\n");
+		ctx->bank1.size =
+			ctx->scratch_buf_size +
+			(ctx->mv_count * ctx->mv_size);
+		break;
 	case S5P_MFC_CODEC_H264_ENC:
 		if (IS_MFCV10(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
@@ -321,6 +327,7 @@ static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 	switch (ctx->codec_mode) {
 	case S5P_MFC_CODEC_H264_DEC:
 	case S5P_MFC_CODEC_H264_MVC_DEC:
+	case S5P_MFC_CODEC_HEVC_DEC:
 		ctx->ctx.size = buf_size->h264_dec_ctx;
 		break;
 	case S5P_MFC_CODEC_MPEG4_DEC:
@@ -434,6 +441,10 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
 					ctx->img_height);
 		}
+	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
+		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width,
+				ctx->img_height);
+		ctx->mv_size = ALIGN(ctx->mv_size, 32);
 	} else {
 		ctx->mv_size = 0;
 	}
@@ -515,7 +526,8 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
 	buf_size1 -= ctx->scratch_buf_size;
 
 	if (ctx->codec_mode == S5P_FIMV_CODEC_H264_DEC ||
-			ctx->codec_mode == S5P_FIMV_CODEC_H264_MVC_DEC){
+			ctx->codec_mode == S5P_FIMV_CODEC_H264_MVC_DEC ||
+			ctx->codec_mode == S5P_FIMV_CODEC_HEVC_DEC) {
 		writel(ctx->mv_size, mfc_regs->d_mv_buffer_size);
 		writel(ctx->mv_count, mfc_regs->d_num_mv);
 	}
@@ -538,7 +550,8 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
 				mfc_regs->d_second_plane_dpb + i * 4);
 	}
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
-			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
+			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC ||
+			ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
 		for (i = 0; i < ctx->mv_count; i++) {
 			/* To test alignment */
 			align_gap = buf_addr1;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
index b18f5b7..f6cb703 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
@@ -29,6 +29,9 @@
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
+#define s5p_mfc_dec_hevc_mv_size(x, y) \
+	(DIV_ROUND_UP(x, 64) * DIV_ROUND_UP(y, 64) * 256 + 512)
+
 /* Definition */
 #define ENC_MULTI_SLICE_MB_MAX		((1 << 30) - 1)
 #define ENC_MULTI_SLICE_BIT_MIN		2800
-- 
2.7.4
