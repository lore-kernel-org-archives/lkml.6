Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F629C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A126076
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcsjjiSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7A126076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeF0PgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:36:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40749 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934810AbeF0P2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id l2-v6so1890458wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4VOjPiepSlhJERfbnnBhuea6lSxKsWxYzdpU/r/kD8=;
        b=GcsjjiSAhDkz1YBg8ypo+2npNCcVEJzrmyC/GYt0P0Vu29kwdr7msaAOF5H+vJLn6R
         yFfYLpKjSTYiRgCbw4Kopn9wiTRiRQK6v0M6x95D2tpFAmCTg3PISpXCexM8mRWhkl9N
         tFmTsuNEoviiWutmNKlxdQvIz0aRUu5+hZtaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q4VOjPiepSlhJERfbnnBhuea6lSxKsWxYzdpU/r/kD8=;
        b=njyhV+rL2dosvm58lFTm42MyCL5iqRKK5aGUuHMq1CUOhZPLYYJzexfiW9W3Etc/4f
         AD3VN9u+vweVKx+oAHXGQ3Wgzao4V0nu76S9MyJnpNNoSXS9xB5/m2x9Mz9WxSXAykMh
         HqMTGY0sALMOAqX28Q/yphQSjCn6fo8xH9ctp10O+s9h3zZCRGHNGDpsfhw/RGOUhctE
         03sPSlcqn8T2uVcFuD7YWrktEblZ7LbXyZklj/m4B9Fd++P3yqH842Nqn8D9vNYO0s5a
         OrFzTyoUJKaMHve/J7rHPAEpGH/TDsEIbE1rTQHHVEIR/wFpLLmsEcXh4MI8VJqe55gm
         T73w==
X-Gm-Message-State: APt69E1EBygXw4H9tLPaMCnaFWCFr/Rkpluui3nFjQe+OUSlJahgFGiY
        BF9ljLd0e5eZfD4EYprqiRoFlQ==
X-Google-Smtp-Source: AAOMgpcYC896DQDdru1mbxFhpr9752wCGBRtLv172WQWM5U1IXwRANUJ5eXGSwm41/ytGGV89aXbfQ==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr5853826wrg.20.1530113281244;
        Wed, 27 Jun 2018 08:28:01 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:00 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 03/27] venus: hfi: update sequence event to handle more properties
Date:   Wed, 27 Jun 2018 18:27:01 +0300
Message-Id: <20180627152725.9783-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HFI version 4xx can pass more properties in the sequence change
event, extend the event structure with them.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi.h      | 10 +++++++
 drivers/media/platform/qcom/venus/hfi_msgs.c | 44 ++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
index 5466b7d60dd0..6038d8e0ab22 100644
--- a/drivers/media/platform/qcom/venus/hfi.h
+++ b/drivers/media/platform/qcom/venus/hfi.h
@@ -74,6 +74,16 @@ struct hfi_event_data {
 	u32 tag;
 	u32 profile;
 	u32 level;
+	/* the following properties start appear from v4 onwards */
+	u32 bit_depth;
+	u32 pic_struct;
+	u32 colour_space;
+	u32 entropy_mode;
+	u32 buf_count;
+	struct {
+		u32 left, top;
+		u32 width, height;
+	} input_crop;
 };
 
 /* define core states */
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 589e1a6b36a9..54cd41e5837c 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -25,10 +25,16 @@
 static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 			      struct hfi_msg_event_notify_pkt *pkt)
 {
+	enum hfi_version ver = core->res->hfi_version;
 	struct hfi_event_data event = {0};
 	int num_properties_changed;
 	struct hfi_framesize *frame_sz;
 	struct hfi_profile_level *profile_level;
+	struct hfi_bit_depth *pixel_depth;
+	struct hfi_pic_struct *pic_struct;
+	struct hfi_colour_space *colour_info;
+	struct hfi_buffer_requirements *bufreq;
+	struct hfi_extradata_input_crop *crop;
 	u8 *data_ptr;
 	u32 ptype;
 
@@ -69,6 +75,44 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 			event.level = profile_level->level;
 			data_ptr += sizeof(*profile_level);
 			break;
+		case HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH:
+			data_ptr += sizeof(u32);
+			pixel_depth = (struct hfi_bit_depth *)data_ptr;
+			event.bit_depth = pixel_depth->bit_depth;
+			data_ptr += sizeof(*pixel_depth);
+			break;
+		case HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT:
+			data_ptr += sizeof(u32);
+			pic_struct = (struct hfi_pic_struct *)data_ptr;
+			event.pic_struct = pic_struct->progressive_only;
+			data_ptr += sizeof(*pic_struct);
+			break;
+		case HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE:
+			data_ptr += sizeof(u32);
+			colour_info = (struct hfi_colour_space *)data_ptr;
+			event.colour_space = colour_info->colour_space;
+			data_ptr += sizeof(*colour_info);
+			break;
+		case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
+			data_ptr += sizeof(u32);
+			event.entropy_mode = *(u32 *)data_ptr;
+			data_ptr += sizeof(u32);
+			break;
+		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
+			data_ptr += sizeof(u32);
+			bufreq = (struct hfi_buffer_requirements *)data_ptr;
+			event.buf_count = HFI_BUFREQ_COUNT_MIN(bufreq, ver);
+			data_ptr += sizeof(*bufreq);
+			break;
+		case HFI_INDEX_EXTRADATA_INPUT_CROP:
+			data_ptr += sizeof(u32);
+			crop = (struct hfi_extradata_input_crop *)data_ptr;
+			event.input_crop.left = crop->left;
+			event.input_crop.top = crop->top;
+			event.input_crop.width = crop->width;
+			event.input_crop.height = crop->height;
+			data_ptr += sizeof(*crop);
+			break;
 		default:
 			break;
 		}
-- 
2.14.1

