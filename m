Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBBMxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:53:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24693 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeBBMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180202125002epoutp033da99ebc50f514af0c7722aaffcf4daa~PgybXalY40752507525epoutp03I
X-AuditID: b6c32a47-187ff7000000100c-9e-5a745e798360
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 04/12] [media] s5p-mfc: Support MFCv10.10 buffer
 requirements
Date: Fri, 02 Feb 2018 17:55:40 +0530
Message-id: <1517574348-22111-5-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmhW5lXEmUwe8LZha31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK+PR3F7mgtX2
        FT8b97M3MD437mLk5JAQMJGY9WMuSxcjF4eQwA5GiaUn5jFCON8ZJeb/7GWBqXr98guYLSSw
        m1Hi2wMFiKIfjBKfdzWzgyTYBHQkvr0/zQZiiwikSrxat5YVpIgZpOjWtxtg3cICQRJb5/8H
        a2ARUJW4N/MGE4jNK+AicbBhIjvENgWJVzfWAtkcHJwCrhJLTpqCzJEQ2MIm8b7lFhNEjYvE
        9bfvoeqFJV4d3wJlS0s8W7WREcIul9jz5ycLRHMDo8Tc441QCXuJA1fmgB3ELMAn0XH4L9gy
        CQFeiY42IYgSD4ld8/ZD7XKUOPKhlx3i+xmMEusP6E1glFrAyLCKUSy1oDg3PbXYqMBYrzgx
        t7g0L10vOT93EyM4nrXcdzBuO+dziFGAg1GJhzdBtjhKiDWxrLgy9xCjBAezkgjvNt+SKCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8rQEuUUIC6YklqdmpqQWpRTBZJg5OqQbGGNaiGIXAwBlT
        j3LxcDEb6LHZfFrvn/FHd49Z+pxid/9dVbyVSyRF882XVS2JOrPR/sY357MVi1bpm16bIp+/
        fubz9Dp/s59as9Z8O/KwLvJRZ4rntcu9WXc+SBpLf+WIn755V7wMq8u3Ffza0ubHYq46N564
        J3TfmEvNt+Kdi40MO+sHc28lluKMREMt5qLiRADYiKoJ4wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jAd3KuJIogxlPNSxurTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8ajub3MBavt
        K3427mdvYHxu3MXIySEhYCLx+uUXli5GLg4hgZ2MEg/X3WEDSQgJ/GCUmHE6HMRmE9CR+Pb+
        NFhcRCBVYu3W86wgDcwgNU0HXrKDJIQFAiSWPT0HVsQioCpxb+YNJhCbV8BF4mDDRHaIbQoS
        r26sBbI5ODgFXCWWnDSF2OUisWLCfcYJjDwLGBlWMUqmFhTnpucWGxUY5aWW6xUn5haX5qXr
        JefnbmIEht+2w1r9OxgfL4k/xCjAwajEw8shXRwlxJpYVlyZe4hRgoNZSYR3m29JlBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbGOSd+nkoTn/1Wy3BV
        om7LYpuAxps77k265Pvy3VN2gX0BM/7+0GnSFLh1507+jb61r2+Z3QlPfsgTUSDMrhSvfcuj
        YabHbLaae04PAq4q8De2TQppb5Ka+4uFm3vCmjs7O5gDzmvd+pBa+90i/NTyCO2mJave5TZF
        OcfdCt3TvmP1++h7Zfc1lFiKMxINtZiLihMBOnF7ezsCAAA=
X-CMS-MailID: 20180202125001epcas2p26be1dff64a11627b9dbafc3be1a939d8
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180202125001epcas2p26be1dff64a11627b9dbafc3be1a939d8
X-RootMTR: 20180202125001epcas2p26be1dff64a11627b9dbafc3be1a939d8
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202125001epcas2p26be1dff64a11627b9dbafc3be1a939d8@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligning the luma_dpb_size, chroma_dpb_size, mv_size and me_buffer_size
for MFCv10.10.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Kamil Debski <kamil@wypas.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/s5p-mfc/regs-mfc-v10.h   | 19 +++++
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 93 +++++++++++++++++++------
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h |  2 +
 3 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v10.h b/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
index 4422a75..7b28313 100644
--- a/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
+++ b/drivers/media/platform/s5p-mfc/regs-mfc-v10.h
@@ -31,5 +31,24 @@
 #define MFC_VERSION_V10		0xA0
 #define MFC_NUM_PORTS_V10	1
 
+/* MFCv10 codec defines*/
+#define S5P_FIMV_CODEC_HEVC_ENC         26
+
+/* Encoder buffer size for MFC v10.0 */
+#define ENC_V100_BASE_SIZE(x, y) \
+	(((x + 3) * (y + 3) * 8) \
+	+  ((y * 64) + 1280) * DIV_ROUND_UP(x, 8))
+
+#define ENC_V100_H264_ME_SIZE(x, y) \
+	(ENC_V100_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 64) * 32))
+
+#define ENC_V100_MPEG4_ME_SIZE(x, y) \
+	(ENC_V100_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 128) * 16))
+
+#define ENC_V100_VP8_ME_SIZE(x, y) \
+	ENC_V100_BASE_SIZE(x, y)
+
 #endif /*_REGS_MFC_V10_H*/
 
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 7f17857..55ccccb 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -64,6 +64,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	unsigned int mb_width, mb_height;
+	unsigned int lcu_width = 0, lcu_height = 0;
 	int ret;
 
 	mb_width = MB_WIDTH(ctx->img_width);
@@ -74,7 +75,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
 		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
 	} else if (ctx->type == MFCINST_ENCODER) {
-		if (IS_MFCV8_PLUS(dev))
+		if (IS_MFCV10(dev)) {
+			ctx->tmv_buffer_size = 0;
+		} else if (IS_MFCV8_PLUS(dev))
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
@@ -82,13 +85,36 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-
-		ctx->luma_dpb_size = ALIGN((mb_width * mb_height) *
-				S5P_FIMV_LUMA_MB_TO_PIXEL_V6,
-				S5P_FIMV_LUMA_DPB_BUFFER_ALIGN_V6);
-		ctx->chroma_dpb_size = ALIGN((mb_width * mb_height) *
-				S5P_FIMV_CHROMA_MB_TO_PIXEL_V6,
-				S5P_FIMV_CHROMA_DPB_BUFFER_ALIGN_V6);
+		if (IS_MFCV10(dev)) {
+			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
+			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
+			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
+				ctx->luma_dpb_size =
+					ALIGN((mb_width * 16), 64)
+					* ALIGN((mb_height * 16), 32)
+						+ 64;
+				ctx->chroma_dpb_size =
+					ALIGN((mb_width * 16), 64)
+							* (mb_height * 8)
+							+ 64;
+			} else {
+				ctx->luma_dpb_size =
+					ALIGN((lcu_width * 32), 64)
+					* ALIGN((lcu_height * 32), 32)
+						+ 64;
+				ctx->chroma_dpb_size =
+					ALIGN((lcu_width * 32), 64)
+							* (lcu_height * 16)
+							+ 64;
+			}
+		} else {
+			ctx->luma_dpb_size = ALIGN((mb_width * mb_height) *
+					S5P_FIMV_LUMA_MB_TO_PIXEL_V6,
+					S5P_FIMV_LUMA_DPB_BUFFER_ALIGN_V6);
+			ctx->chroma_dpb_size = ALIGN((mb_width * mb_height) *
+					S5P_FIMV_CHROMA_MB_TO_PIXEL_V6,
+					S5P_FIMV_CHROMA_DPB_BUFFER_ALIGN_V6);
+		}
 		if (IS_MFCV8_PLUS(dev))
 			ctx->me_buffer_size = ALIGN(S5P_FIMV_ME_BUFFER_SIZE_V8(
 						ctx->img_width, ctx->img_height,
@@ -197,6 +223,8 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_H264_ENC:
 		if (IS_MFCV10(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
 		} else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_H264_ENC_V8(
@@ -219,6 +247,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_H263_ENC:
 		if (IS_MFCV10(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
+							mb_height), 16);
 		} else
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_MPEG4_ENC_V6(
@@ -235,6 +266,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_VP8_ENC:
 		if (IS_MFCV10(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
+						16);
 		} else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_VP8_ENC_V8(
@@ -393,13 +427,13 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10(dev)) {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
 					ctx->img_height);
-		else
+		} else {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
 					ctx->img_height);
-		ctx->mv_size = ALIGN(ctx->mv_size, 16);
+		}
 	} else {
 		ctx->mv_size = 0;
 	}
@@ -596,15 +630,34 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct s5p_mfc_ctx *ctx)
 
 	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
 
-	for (i = 0; i < ctx->pb_count; i++) {
-		writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
-		buf_addr1 += ctx->luma_dpb_size;
-		writel(buf_addr1, mfc_regs->e_chroma_dpb + (4 * i));
-		buf_addr1 += ctx->chroma_dpb_size;
-		writel(buf_addr1, mfc_regs->e_me_buffer + (4 * i));
-		buf_addr1 += ctx->me_buffer_size;
-		buf_size1 -= (ctx->luma_dpb_size + ctx->chroma_dpb_size +
-			ctx->me_buffer_size);
+	if (IS_MFCV10(dev)) {
+		/* start address of per buffer is aligned */
+		for (i = 0; i < ctx->pb_count; i++) {
+			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
+			buf_addr1 += ctx->luma_dpb_size;
+			buf_size1 -= ctx->luma_dpb_size;
+		}
+		for (i = 0; i < ctx->pb_count; i++) {
+			writel(buf_addr1, mfc_regs->e_chroma_dpb + (4 * i));
+			buf_addr1 += ctx->chroma_dpb_size;
+			buf_size1 -= ctx->chroma_dpb_size;
+		}
+		for (i = 0; i < ctx->pb_count; i++) {
+			writel(buf_addr1, mfc_regs->e_me_buffer + (4 * i));
+			buf_addr1 += ctx->me_buffer_size;
+			buf_size1 -= ctx->me_buffer_size;
+		}
+	} else {
+		for (i = 0; i < ctx->pb_count; i++) {
+			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
+			buf_addr1 += ctx->luma_dpb_size;
+			writel(buf_addr1, mfc_regs->e_chroma_dpb + (4 * i));
+			buf_addr1 += ctx->chroma_dpb_size;
+			writel(buf_addr1, mfc_regs->e_me_buffer + (4 * i));
+			buf_addr1 += ctx->me_buffer_size;
+			buf_size1 -= (ctx->luma_dpb_size + ctx->chroma_dpb_size
+					+ ctx->me_buffer_size);
+		}
 	}
 
 	writel(buf_addr1, mfc_regs->e_scratch_buffer_addr);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
index 021b8db..b18f5b7 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
@@ -26,6 +26,8 @@
 					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
 #define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
 					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
+#define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
+#define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
 /* Definition */
 #define ENC_MULTI_SLICE_MB_MAX		((1 << 30) - 1)
-- 
2.7.4
