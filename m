Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99191C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACD121532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBf0dIWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACD121532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbeIVCv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:51:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37013 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbeIVCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:51:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id n11-v6so4616220wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XS6nk/K8/ILhnPOmEe3KYBFW8ubwsYuiH108d+DXuQc=;
        b=HBf0dIWJXMwf0g23DnD3QAMC4W1I2MTLPWf6BINW9p7WTvI+I05pwhUNujhPiWOOfF
         RE/Uxz4fBDBY/rOToyzsw2sutOCXzXEmbeNpGwWQ2vFt+jZkZRg/x4czdgoRnidS+Ut9
         dO+Mn1NpC2Dxk8t47+sxN5cFqnaar5AXwhop3bqjGMFTw5PgOKojHmTj+nZtYs1MyLHe
         SOygMpYy6kkbUEpEeIybW/6iXoEUxx1hVv+o7BBqH281QJBpCgPcPu3AebA7zS6K0c8g
         wfx+9OEB2mjbMeo6uOrnLf9uFb6+VjfJHgsuoRo3Mg4vCVorS0Z/u/ro5OK7Jkml/oe8
         m1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XS6nk/K8/ILhnPOmEe3KYBFW8ubwsYuiH108d+DXuQc=;
        b=VaGWI1l+NOOk9/gDJTrhNmBWjl1jdyOY3xyRvXrwQhil+EVbQaiJZd3QUP8/PQT/V1
         freclVTyJTye7Vs6EM8zVsqc+jf/XcgI4l8nPajMAxc1elYVCeIPxW7/DIfmjntLZesY
         cD4+SpUMpVBBm0bnZd62q28MTXYRfcF2rWTRyCH90K1XX73+01YeI2UWq5M0/prYD5zT
         XNtgZ4ute6nlWHwqJfnysFy0AFA58hh0kkOFUV9P+6v+MDvvW7Zd21bXuo13kb3kpcwR
         gQeJ3DypBYaKLPVrLS8BPmfIPTrXg11/5azhAtfRtSZEYBZqd1DqPj3BYdVmEy01hJdS
         vbCw==
X-Gm-Message-State: APzg51AxM/K7k+y8SKroZrhX8/LW4jTCxgh9UfnSWm828AFUMTLMnCL1
        pc1d3iLFWHBIWF824P4M45g=
X-Google-Smtp-Source: ANB0Vdb7qMvcI8u6a8sYGcx1+3sUAUiiVrxtjAUqtEzyXZvBjK7bfJeF/UjZxAsLrqhdGHDafBqSTA==
X-Received: by 2002:a1c:be14:: with SMTP id o20-v6mr8509750wmf.73.1537563678379;
        Fri, 21 Sep 2018 14:01:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u127-v6sm4268909wmf.48.2018.09.21.14.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:01:17 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Change id parameter type in pp_atomfwctrl_get_clk_information_by_clkid
Date:   Fri, 21 Sep 2018 14:01:06 -0700
Message-Id: <20180921210106.24310-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang generates warnings when one enumerated type is implicitly
converted to another.

drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomfwctrl.c:532:57:
warning: implicit conversion from enumeration type 'enum
atom_smu11_syspll0_clock_id' to different enumeration type 'BIOS_CLKID'
      (aka 'enum atom_smu9_syspll0_clock_id') [-Wenum-conversion]
        if (!pp_atomfwctrl_get_clk_information_by_clkid(hwmgr,
SMU11_SYSPLL0_SOCCLK_ID, &frequency))

In this case, that is expected behavior. To make that clear to Clang
without explicitly casting these values, change id's type to uint8_t
in pp_atomfwctrl_get_clk_information_by_clkid so no conversion happens.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c | 3 ++-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
index d27c1c9df286..4588bddf8b33 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
@@ -488,7 +488,8 @@ int pp_atomfwctrl_get_gpio_information(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr, BIOS_CLKID id, uint32_t *frequency)
+int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
+					       uint8_t id, uint32_t *frequency)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
 	struct atom_get_smu_clock_info_parameters_v3_1   parameters;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
index 22e21668c93a..fe9e8ceef50e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
@@ -236,7 +236,7 @@ int pp_atomfwctrl_get_vbios_bootup_values(struct pp_hwmgr *hwmgr,
 int pp_atomfwctrl_get_smc_dpm_information(struct pp_hwmgr *hwmgr,
 			struct pp_atomfwctrl_smc_dpm_parameters *param);
 int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
-					BIOS_CLKID id, uint32_t *frequency);
+					uint8_t id, uint32_t *frequency);
 
 #endif
 
-- 
2.19.0

