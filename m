Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26796C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A07208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKaStwU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A07208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936104AbeFMPKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:10:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40341 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936081AbeFMPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so6069688wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jaIrs4Hlkn8/hSfPKZPaW9B0la4YriBdsqxKyEKBPSU=;
        b=FKaStwU6gRwmZ3HUd7N0XNz1roaYRpObvAtYy3LLmbwiwv7F0Nu56yncW5kpbSqnLF
         8iAXTerKjhOFrYqphSzXcHHFgtagdGrC0nhJ/U3gkPRzia4keCmRD7to0CsuaaRrzWad
         zes1Jjp9G0W76uOiKblEEPvZPF6K4pnHbegL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jaIrs4Hlkn8/hSfPKZPaW9B0la4YriBdsqxKyEKBPSU=;
        b=CSicAI0WOX1ANVi4mrtw9sbc34OBcK62mzT5G2Uj27UQSg3KyywpzMYt0mqJ+g9o57
         6yCbnZ3wgf2JFXLReowv8CCGwBD3vWU2TkR/KDhayWP1deicbYo8SP8/i+iva3FGleCe
         vXjJakszWi3+H7944ar4AEL9WbqUIkgRY/2Gh4F5ooj8tOL6b5eLqw7yWwQiC8NR3x7Z
         DdEVt9Ga3Rv9cXAxW45UMc3VQo/ZEmHF8DMH8vlhwxpXQbPx5AvJJwiCgBPKff3a38qp
         oQcCIpuHy00AsheUpd6egquiKI6+N0hlIJ4LAE6LR6XwFsw7+F7uMKR7GvN7kAkqcQ7P
         iBKg==
X-Gm-Message-State: APt69E2X1nZ6DSX8dzXZo93mwJqdOeaFj0MXauVQXUMD0Mlgajnmj0UM
        FNG5dNdXLjJ0fHieSEfL5wLiEA==
X-Google-Smtp-Source: ADUXVKLEeNmeuIAxPrz7xqK4Fqr10sOULDK+CQ1FYiGhKoh2B2APgl6+LIC2FlxROCFkGrqlxxFbew==
X-Received: by 2002:a1c:9bd0:: with SMTP id d199-v6mr3845405wme.16.1528902584439;
        Wed, 13 Jun 2018 08:09:44 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:43 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 27/27] venus: add HEVC codec support
Date:   Wed, 13 Jun 2018 18:08:01 +0300
Message-Id: <20180613150801.11702-28-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add HEVC codec support for venus versions 3xx and 4xx.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h    |  2 ++
 drivers/media/platform/qcom/venus/helpers.c |  3 ++
 drivers/media/platform/qcom/venus/hfi.c     |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    |  4 +++
 drivers/media/platform/qcom/venus/venc.c    | 49 +++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 8cc49f30a363..2f02365f4818 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -190,10 +190,12 @@ struct venc_controls {
 		u32 mpeg4;
 		u32 h264;
 		u32 vpx;
+		u32 hevc;
 	} profile;
 	struct {
 		u32 mpeg4;
 		u32 h264;
+		u32 hevc;
 	} level;
 };
 
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a0c7ef5f9125..2da88aec5a21 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -71,6 +71,9 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
 	case V4L2_PIX_FMT_XVID:
 		codec = HFI_VIDEO_CODEC_DIVX;
 		break;
+	case V4L2_PIX_FMT_HEVC:
+		codec = HFI_VIDEO_CODEC_HEVC;
+		break;
 	default:
 		return false;
 	}
diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 94ca27b0bb99..24207829982f 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -49,6 +49,8 @@ static u32 to_codec_type(u32 pixfmt)
 		return HFI_VIDEO_CODEC_VP9;
 	case V4L2_PIX_FMT_XVID:
 		return HFI_VIDEO_CODEC_DIVX;
+	case V4L2_PIX_FMT_HEVC:
+		return HFI_VIDEO_CODEC_HEVC;
 	default:
 		return 0;
 	}
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 9d509b3c1c7a..d079aebff550 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -77,6 +77,10 @@ static const struct venus_format vdec_formats[] = {
 		.pixfmt = V4L2_PIX_FMT_XVID,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	}, {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 	},
 };
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index be5dc3a2eb28..a2c6a4b7ac43 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -59,6 +59,10 @@ static const struct venus_format venc_formats[] = {
 		.pixfmt = V4L2_PIX_FMT_VP8,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	}, {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
 };
 
@@ -220,6 +224,46 @@ static int venc_v4l2_to_hfi(int id, int value)
 		case V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY:
 			return HFI_H264_DB_MODE_SKIP_SLICE_BOUNDARY;
 		}
+	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
+		switch (value) {
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN:
+		default:
+			return HFI_HEVC_PROFILE_MAIN;
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE:
+			return HFI_HEVC_PROFILE_MAIN_STILL_PIC;
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10:
+			return HFI_HEVC_PROFILE_MAIN10;
+		}
+	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
+		switch (value) {
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_1:
+		default:
+			return HFI_HEVC_LEVEL_1;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2:
+			return HFI_HEVC_LEVEL_2;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1:
+			return HFI_HEVC_LEVEL_21;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3:
+			return HFI_HEVC_LEVEL_3;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1:
+			return HFI_HEVC_LEVEL_31;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4:
+			return HFI_HEVC_LEVEL_4;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1:
+			return HFI_HEVC_LEVEL_41;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5:
+			return HFI_HEVC_LEVEL_5;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1:
+			return HFI_HEVC_LEVEL_51;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2:
+			return HFI_HEVC_LEVEL_52;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_6:
+			return HFI_HEVC_LEVEL_6;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1:
+			return HFI_HEVC_LEVEL_61;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2:
+			return HFI_HEVC_LEVEL_62;
+		}
 	}
 
 	return 0;
@@ -744,6 +788,11 @@ static int venc_set_properties(struct venus_inst *inst)
 	} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H263) {
 		profile = 0;
 		level = 0;
+	} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
+		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
+					   ctr->profile.hevc);
+		level = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
+					 ctr->level.hevc);
 	}
 
 	ptype = HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT;
-- 
2.14.1

