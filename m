Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AB521479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdt/3TFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeL1PTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:19:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43576 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbeL1PTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:19:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so14743882lff.10;
        Fri, 28 Dec 2018 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4Ds6Z+OiEaHNaxosbxSSLHIYzs/zje2q5ByzOawEMg=;
        b=qdt/3TFbco4JAUE52thvWvxKRlrkGXp7ZoBgrM7LXx0MT80l2GP0TkqJc0ok81Bc9o
         wqZiSQ66FuddOXR7Sv5pMkN7O2iEE36Dk1ZTR6Lw29ztd7ZDSMZ3fIISy8FjOomCEsGN
         4UH+XueRgezXQn2BXAwcoz1TrVk9+LFnhO7D4OziVHRfeqLCW78rbLZvsvR7brrjZqpV
         oUbTLzHkymHFD6mVfglvXoI/4vLzAjX0x7yE/czYCmwvAVhmwpSAf3emJI18cS7P89xY
         4HQDPgxhRunjsZV3+YzVv9bE8qai+5FRKnyIcXLvGQPrbrlIFGJsJa8a0KqYrT3UlOdQ
         xLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4Ds6Z+OiEaHNaxosbxSSLHIYzs/zje2q5ByzOawEMg=;
        b=Xr34GxGUnvdBw6m+vjuGXfcf9shZUGEFTyUm756i7LvkrZeuSxSOjatO74tsSifGvE
         toi/g/3hbMnb5jPW0EixvZOrpXbACMGtS1sRTZlboR4hSa2RwxS1l74qibkznqIUX2CB
         m/irjVDjl9i5wPaZMm4xzI8xdl3JgZ1jqsgaQtMf1ALURbLGJdGg99D60FD6Cv8bXn3y
         UYwBKCNA3VxYSvucAV4x9VpYTYvUczj5y/ZUgsZeDLhHwm/n/dh6wLChZ8OqedOR8LAK
         TT6xk5AtijIczxW/DcDGJ9h1CvWZdvUt+H1NzTLSrHB8Z27sGAUHB1B2529VQ7RpXX6l
         NYiA==
X-Gm-Message-State: AA+aEWZdFBGvUpmcx766trrCdNiR4pGR9B7FkpoAYXHgHV/NQHvkDI+b
        s6kGgnt7pxgtgd4mu5ou5GQ=
X-Google-Smtp-Source: AFSGD/UMI6f+gpL5kx/yIXHEnON8Ng9rPZDadspSsi43craER40nzg628JPrInJKPsrp+ieJpkIKoA==
X-Received: by 2002:a19:f510:: with SMTP id j16mr13516090lfb.35.1546010371958;
        Fri, 28 Dec 2018 07:19:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:19:31 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/3] drm/exynos: rotator: Add support for s5pv210
Date:   Fri, 28 Dec 2018 16:19:02 +0100
Message-Id: <20181228151904.12079-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for s5pv210.
Currently only NV12 and XRGB8888 formats are supported.
It was tested by using tool from
https://www.spinics.net/lists/linux-samsung-soc/msg60498.html

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 8d67b2a54be3..05abfed6f7f8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -356,6 +356,11 @@ static int rotator_runtime_resume(struct device *dev)
 }
 #endif
 
+static const struct drm_exynos_ipp_limit rotator_s5pv210_rbg888_limits[] = {
+	{ IPP_SIZE_LIMIT(BUFFER, .h = { 8, SZ_16K }, .v = { 8, SZ_16K }) },
+	{ IPP_SIZE_LIMIT(AREA, .h.align = 2, .v.align = 2) },
+};
+
 static const struct drm_exynos_ipp_limit rotator_4210_rbg888_limits[] = {
 	{ IPP_SIZE_LIMIT(BUFFER, .h = { 8, SZ_16K }, .v = { 8, SZ_16K }) },
 	{ IPP_SIZE_LIMIT(AREA, .h.align = 4, .v.align = 4) },
@@ -371,6 +376,11 @@ static const struct drm_exynos_ipp_limit rotator_5250_rbg888_limits[] = {
 	{ IPP_SIZE_LIMIT(AREA, .h.align = 2, .v.align = 2) },
 };
 
+static const struct drm_exynos_ipp_limit rotator_s5pv210_yuv_limits[] = {
+	{ IPP_SIZE_LIMIT(BUFFER, .h = { 32, SZ_64K }, .v = { 32, SZ_64K }) },
+	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
+};
+
 static const struct drm_exynos_ipp_limit rotator_4210_yuv_limits[] = {
 	{ IPP_SIZE_LIMIT(BUFFER, .h = { 32, SZ_64K }, .v = { 32, SZ_64K }) },
 	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
@@ -381,6 +391,11 @@ static const struct drm_exynos_ipp_limit rotator_4412_yuv_limits[] = {
 	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
 };
 
+static const struct exynos_drm_ipp_formats rotator_s5pv210_formats[] = {
+	{ IPP_SRCDST_FORMAT(XRGB8888, rotator_s5pv210_rbg888_limits) },
+	{ IPP_SRCDST_FORMAT(NV12, rotator_s5pv210_yuv_limits) },
+};
+
 static const struct exynos_drm_ipp_formats rotator_4210_formats[] = {
 	{ IPP_SRCDST_FORMAT(XRGB8888, rotator_4210_rbg888_limits) },
 	{ IPP_SRCDST_FORMAT(NV12, rotator_4210_yuv_limits) },
@@ -396,6 +411,11 @@ static const struct exynos_drm_ipp_formats rotator_5250_formats[] = {
 	{ IPP_SRCDST_FORMAT(NV12, rotator_4412_yuv_limits) },
 };
 
+static const struct rot_variant rotator_s5pv210_data = {
+	.formats = rotator_s5pv210_formats,
+	.num_formats = ARRAY_SIZE(rotator_s5pv210_formats),
+};
+
 static const struct rot_variant rotator_4210_data = {
 	.formats = rotator_4210_formats,
 	.num_formats = ARRAY_SIZE(rotator_4210_formats),
@@ -413,6 +433,9 @@ static const struct rot_variant rotator_5250_data = {
 
 static const struct of_device_id exynos_rotator_match[] = {
 	{
+		.compatible = "samsung,s5pv210-rotator",
+		.data = &rotator_s5pv210_data,
+	}, {
 		.compatible = "samsung,exynos4210-rotator",
 		.data = &rotator_4210_data,
 	}, {
-- 
2.17.1

