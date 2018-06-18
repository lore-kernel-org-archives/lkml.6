Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E921208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E921208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeFRPhK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:37:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeFRPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:37:06 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MBCPl-1fKnjt2bAr-00AIhq; Mon, 18 Jun 2018 17:36:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Dave Airlie <airlied@redhat.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] amdgpu: display: use modern ktime accessors
Date:   Mon, 18 Jun 2018 17:35:10 +0200
Message-Id: <20180618153649.2015346-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:umsIqZTYk65nIOAMmpzwLpWL5u8ImQJ5rWj9gtL+ZRvrmMMC8xm
 Aw7nhgvySm0hxF74R58WsTbwxPV9hnwSh6Q+l9hfmDwZY2MyzMUCv4an74skto9qtYOSNi3
 7mmePBstEtb40MigtaBIT4e2sNsM62nxLj4VXbUYzM43uP5jTLyf2BKtUeEpSI9TaV44GgE
 Ajvji/GbHsbU6cChgRzgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NEAG4fL1p+g=:cKodtql/M4riIKlQ8m1QVU
 03qz6tEq65SMrszdHGIZ2I6K1Wmk432P+kCf3nTtABUCDr02L/R7pXC28sb1ZF1jpjn5JecDw
 2oUBr31b/WS1EMTZFVP5OpQbGkndfdAwAC942cCgFGndMz+K0P79G6F6h6/8NlyC3zIEbpVyR
 baurbEy+0NJu1VLbjbg5h/tOFO+l+ywMaGVNWofZJkE/Rzb73vNJoi6T2x/Lp8G1Q4CNWtSFJ
 Mi6Jmwp2Y77FffingxZtK9DwzL61xOm946fGCKKojQzmDeHvMAh5ksSmzf7+MZSSYDGl1/rDc
 dywLqw2V+qHcvfzi7z6ZDkAnIuiKiseCkG8Oz3tinlgLZvgukxzWvKEEZc1/nin/jCC0uIonb
 FtZ4uh539V1WqTLtzHqQLYyqMemQk+uheEYHHcwMdb2cF+BDJxGrmg8FZOHj7eX0JeunuVGcK
 7KsO4WrL6BgMSmXdZeX7IL4IIXraLm+o443irddYYTuPHjv+Ehy6Y9tvDV5KKhMLPKDu2Vf64
 FODrXj5tur55J891p8orxrgyuRbEhz84SrdCfnomAABMg4qrdKD8Guo+lQfNEy1VSdU93Ex3J
 PMCGRuGPdX4shF/xy5PadlEgLMrT7QeSGByeh73Plce+NaMyWn5DeNY2HL3plW0xS4d4a8KpB
 +Y+ivFKxLCn+gQwvnwUe3qT34itFt0zHIw76AxecyEArrAduFStXSJw+2BMAg7ZU3uJA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getrawmonotonic64() is deprecated because of the nonstandard naming.

The replacement functions ktime_get_raw_ns() also simplifies the callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 8 --------
 drivers/gpu/drm/amd/display/dc/dm_services.h               | 5 ++++-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 5a3346124a01..e861929dd981 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -35,14 +35,6 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 
-unsigned long long dm_get_timestamp(struct dc_context *ctx)
-{
-	struct timespec64 time;
-
-	getrawmonotonic64(&time);
-	return timespec64_to_ns(&time);
-}
-
 unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
 		unsigned long long current_time_stamp,
 		unsigned long long last_time_stamp)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 4ff9b2bba178..eb5ab3978e84 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -339,7 +339,10 @@ bool dm_dmcu_set_pipe(struct dc_context *ctx, unsigned int controller_id);
 #define dm_log_to_buffer(buffer, size, fmt, args)\
 	vsnprintf(buffer, size, fmt, args)
 
-unsigned long long dm_get_timestamp(struct dc_context *ctx);
+static inline unsigned long long dm_get_timestamp(struct dc_context *ctx)
+{
+	return ktime_get_raw_ns();
+}
 
 unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
 		unsigned long long current_time_stamp,
-- 
2.9.0

