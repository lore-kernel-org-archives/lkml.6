Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9F214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSiskSSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeLSQEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:04:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46988 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbeLSQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:04:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so15393160lfc.13;
        Wed, 19 Dec 2018 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZI8ioWXkc4sq7/+UaHZVn4uYxbM0VQloyZQGuqbwgg=;
        b=JSiskSSCKMdW6SROQWsAN+3PI4AOXKr9SmcP/NJCUlOUJ13ZuYHnccEJQa16U3eRHf
         rN6UIPgmOA+vfs26YoTNj+eLoZCY55M4BVMsot0glgvtKdj2i/b7+qi2oqNZOwEoggkY
         DqbkNX90bI1Q2vHeSUZGhbVSTgcAY7D+VMmjHcKT6ntRlPIGF+T/HlNC8rn32JhK/jls
         dwU7je2wrUvAMXbcIVdhxYMntfFEj2LGn0or0Z8fSSe5H2yiqkszrmvlbq4XelS1f0/g
         grLB7vCyiFAewfzu3/1Fcaau+HD4yd4W7FpihnrBwhrZEnrHoN264E6Wz9AoydQ6xB/C
         SJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZI8ioWXkc4sq7/+UaHZVn4uYxbM0VQloyZQGuqbwgg=;
        b=tlJU7sT807DGtZrtjzrBZ1y38uxJ9dyoJZwNusCaiREGCrAesWddFqcxnfTnDfVXAO
         JL5O/4/UhjYQa/jmmIjDNJO/FZ89SdXCC0X0lCzziy3JJz/baDkPMtGFaZidg4laElRw
         KGF9lNjO71H+KIK9Hf1NhLqBBqNocr3sxmJacH0ooQeDg6bYwBCXlxFEArZzIZQY1bEh
         b8uOF879YRfXUtUB3/fvIJaxuabGlN0ILDsaSLZ2j7mN/Zlolw+iU6A/O8P1otF3XrQR
         CIyMDb7UOqOar5YQB6JEq5mFFL5QKz87O+WSGY3ZQkyz4VE86iioI0z10rRq/hulFdjp
         E31Q==
X-Gm-Message-State: AA+aEWatKReZfxiFu2mTABZVyaUkAFhg5DDmLd5lnq1TYC3aLpat36WN
        2nG/JZMOR+FhkOntjUQxqI0=
X-Google-Smtp-Source: AFSGD/XvQ2nuSqE4wy/SbLlLNPEkqpARqK5tWnC9Ud8eRUmdV0WeVTBjc0PXOds7iOWSNVOByjIIkw==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr1884611lff.59.1545235466806;
        Wed, 19 Dec 2018 08:04:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:253f:4197:555d:bfba])
        by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:04:26 -0800 (PST)
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
Subject: [PATCH 1/3] drm/exynos: rotator: Add support for s5pv210
Date:   Wed, 19 Dec 2018 16:57:02 +0100
Message-Id: <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
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
index a820a68429b9..a822d340ccf6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -357,6 +357,11 @@ static int rotator_runtime_resume(struct device *dev)
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
@@ -372,6 +377,11 @@ static const struct drm_exynos_ipp_limit rotator_5250_rbg888_limits[] = {
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
@@ -382,6 +392,11 @@ static const struct drm_exynos_ipp_limit rotator_4412_yuv_limits[] = {
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
@@ -397,6 +412,11 @@ static const struct exynos_drm_ipp_formats rotator_5250_formats[] = {
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
@@ -414,6 +434,9 @@ static const struct rot_variant rotator_5250_data = {
 
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

