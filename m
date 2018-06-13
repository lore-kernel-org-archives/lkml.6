Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7A801C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BE2204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZfCkU98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BE2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936132AbeFMPQ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:16:28 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35150 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:09 -0400
Received: by mail-wm0-f51.google.com with SMTP id j15-v6so6157879wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4VOjPiepSlhJERfbnnBhuea6lSxKsWxYzdpU/r/kD8=;
        b=QZfCkU98S1pD2aXixdruDJOauHbv+jvetmIfkZlUmB6xJWjFcdjWU5BvNs6NwgUuhi
         jDapxaI5O50AHYpoyLVdD/WEomCKG72FVEtW+OMvGup5tgoM3AmmmxofThSFMyMc6j8n
         PReTbcF/wGmiQ2yKZBL+0OA6Y/Jjhk+PFKvjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q4VOjPiepSlhJERfbnnBhuea6lSxKsWxYzdpU/r/kD8=;
        b=RgKtfeomCD+MRfImNxcL1gmKs8eV5C2GbpsME5cQ7cnRzyH5wHKIYXnlBXHcqSLHNv
         lDmIiUNgGWXw7s1L0wEuTJlq7BJwOhKzfRKX06+m+RAfACAg6yq3T2H5oc3Mdq18GULW
         9WHzBbo+dtc+IMMluHNqq0oOllyNqM4MfimNeMZ2313HngRgkZyDOBr54L74G0AUYWJf
         71RpC2tOJKMgjYxV7Ju/NpOV8wy3LDsi/pouJ7QAxdU7R96trpIbACLcsD1dsQzg1LtZ
         Al8XV/yfpjmNMYlxsAPvTWl3FQQR8tjQsGVGh1qxZnoILWgOT8eYg0okUgLEStIemOVL
         VkJA==
X-Gm-Message-State: APt69E30X5BjiMoZYDVCKNQ2UILG8n6BM3v433T/4kiKQp1iJf5iXa3+
        OecG/hEGhNgjLqpzmoGpXw1ApA==
X-Google-Smtp-Source: ADUXVKKGPzsEwJVvvnsX+BmTM6d0I0wINRpGl4sDEmV+2a5yjO9KUAuVqN3sz5lztge1JjfA6A0MIw==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186-v6mr3715290wmf.40.1528902547703;
        Wed, 13 Jun 2018 08:09:07 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 03/27] venus: hfi: update sequence event to handle more properties
Date:   Wed, 13 Jun 2018 18:07:37 +0300
Message-Id: <20180613150801.11702-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

