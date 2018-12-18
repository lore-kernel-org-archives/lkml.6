Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E72C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA95217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRNGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:06:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58218 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:05:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gZF4M-0004q8-Is; Tue, 18 Dec 2018 13:05:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] amdgpu/dc: remove various variables that are defined but never used
Date:   Tue, 18 Dec 2018 13:05:54 +0000
Message-Id: <20181218130554.28992-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several variables that are defined and never used and hence can
be removed. Remove them. Cleans up clang -Wunused-const-variable warnings:

warning: ‘dvi_hdmi_dongle_signature_str’ defined but not used
warning: ‘dce11_one_lpt_channel_max_resolution’ defined but not used
warning: ‘ddc_hw_status_addr’ defined but not used

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c      |  1 -
 .../gpu/drm/amd/display/dc/dce110/dce110_compressor.c  |  2 --
 .../amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c  | 10 ----------
 3 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 506a97e16956..99a314b79850 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -42,7 +42,6 @@
 #define CV_SMART_DONGLE_ADDRESS 0x20
 /* DVI-HDMI dongle slave address for retrieving dongle signature*/
 #define DVI_HDMI_DONGLE_ADDRESS 0x68
-static const int8_t dvi_hdmi_dongle_signature_str[] = "6140063500G";
 struct dvi_hdmi_dongle_signature_data {
 	int8_t vendor[3];/* "AMD" */
 	uint8_t version[2];
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 52d50e24a995..7b23239d33fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -62,8 +62,6 @@ static const struct dce110_compressor_reg_offsets reg_offsets[] = {
 }
 };
 
-static const uint32_t dce11_one_lpt_channel_max_resolution = 2560 * 1600;
-
 static uint32_t align_to_chunks_number_per_line(uint32_t pixels)
 {
 	return 256 * ((pixels + 255) / 256);
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
index 4853ee26096a..c9d6cf08e8ab 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
@@ -50,16 +50,6 @@
  * This unit
  */
 
-static const uint32_t ddc_hw_status_addr[] = {
-	mmDC_I2C_DDC1_HW_STATUS,
-	mmDC_I2C_DDC2_HW_STATUS,
-	mmDC_I2C_DDC3_HW_STATUS,
-	mmDC_I2C_DDC4_HW_STATUS,
-	mmDC_I2C_DDC5_HW_STATUS,
-	mmDC_I2C_DDC6_HW_STATUS,
-	mmDC_I2C_DDCVGA_HW_STATUS
-};
-
 /*
  * @brief
  * Cast 'struct i2c_sw_engine *'
-- 
2.19.1

