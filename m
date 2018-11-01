Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15335C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo3X0g3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9B420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeKAVyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:54:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42566 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeKAVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:54:39 -0400
Received: by mail-io1-f68.google.com with SMTP id h19-v6so3420258iog.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5WQ1hSo3np2tPwANMDqnL/rsemlc9/lTFotMEVOW7CU=;
        b=qo3X0g3cQtuT907xiE1xuPJwPtG8Q5cVSWM4hnWIl9XggVB76SpoP6CbP/ow2u4R9L
         eZuaxTxYzlvQmmhYPc5FcbVo9GZX7vfeKR56T9hYO5nKk5Bu+uFyMpQKhNpwbifFC2bq
         RernGfW1X7JawV+5se4u+GCwgCrmAYIj10KEtlK1P07KP/CGp9XU9V7q7BqQDLHB4SwD
         lI3ULNVrJ+xDyDZUyEkuVIwbuYaSrLjew9dU1vx0PbvENES1XtMx4pCz9+j4FSMhXTeB
         m9lmxD3KrEyXiPGIBv/JJHu4k1Yhntb5QP1dOgRaohE9qX/s/t3o3YePdKjazwMGAbxK
         o4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5WQ1hSo3np2tPwANMDqnL/rsemlc9/lTFotMEVOW7CU=;
        b=Zd9lrPJRdzKaPJxc6IzhvaVTFWLrLUozr8AplGdWTho8Pxqq9Nk7zC0txYq8+7Q63j
         xQaYK/r2rRwjjk1uJeTJO795NXSFjFIynb+49lH2hghfu2v6S3/p7noSIzR3VoQh3cMy
         w83OKbj7jUStn4DQMN6yjXNveNLTMOhj7S60psP1g4rvH0qcH7P2w33MPFJfRkMyFAnT
         4etSOIDeUx1ihz7hCbCIa5N9NsSHydzpssPZGCwvJtJmPK4dIjRJUNq3yW00ZcU+mvv/
         MG6pxGONLIP7IIxEC4+7vu/dCp0ZCRrQBP8gg83EsanIHnOsTGyrG/WSo35GWIVw5IGB
         Iofw==
X-Gm-Message-State: AGRZ1gLQYRe1ztvF91U8at6xD5eJJOv6oDp7dfEC968dYNkVP38fLdkr
        DfkGfaiBxqcVVY04ilsKA4Vdkk+u
X-Google-Smtp-Source: AJdET5ffr1Zbp7ysSn6yiV1dCwgNxpq7D5g5/LvDqAht4b7bEtRLTM0s+Hu2hKczgAMTkmGZOoleEA==
X-Received: by 2002:a6b:3e87:: with SMTP id l129-v6mr4713644ioa.269.1541076707515;
        Thu, 01 Nov 2018 05:51:47 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13008128itb.40.2018.11.01.05.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:51:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, adam.ford@logicpd.com,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH] drm/panel: simple: Add Ampire am800480b3tmqw
Date:   Thu,  1 Nov 2018 07:51:38 -0500
Message-Id: <20181101125138.27848-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Ampire am800480b3tmqw display,
a 7" 24-bit RGB panel wtih 800x480 resolution.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..71e878f63c5b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -436,6 +436,31 @@ static const struct panel_desc ampire_am800480r3tmqwa1h = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode ampire_am800480b3tmqw_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 46,
+	.htotal = 800 + 210 + 46 + 0,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 23,
+	.vtotal = 480 + 22 + 23 + 0,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc ampire_am800480b3tmqw = {
+	.modes = &ampire_am800480b3tmqw_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RBG888_1X24,
+};
+
 static const struct drm_display_mode auo_b101aw03_mode = {
 	.clock = 51450,
 	.hdisplay = 1024,
@@ -2330,6 +2355,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
+	}, {
+		.compatible = "ampire,am800480b3tmqw",
+		.data = &ampire_am800480b3tmqw,
 	}, {
 		.compatible = "auo,b101aw03",
 		.data = &auo_b101aw03,
-- 
2.17.1

