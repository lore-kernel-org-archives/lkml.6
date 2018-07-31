Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F4420894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcoVTaab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F4420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeGaW1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:27:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42791 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeGaW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:27:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id u202-v6so11721692lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf6qvgC1dItUoa0O5Z6dbVcS0HKi/Z36dkHr+OTOdmY=;
        b=RcoVTaab9hjWPX0XqdqNtVJA8oiED5uQVsvtbqpzOsfaTTjPjCZxBenveJGYKei4l0
         u0wg/d/jJKIoHM6FUsH773SweUSX+nQx4oDLaBwKD3JY5vUuqFOUVN7v8LW1J6cJ90V6
         YbKi5tzH25sLUFWxlVBLJm6R5T2l0dvtaBaew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf6qvgC1dItUoa0O5Z6dbVcS0HKi/Z36dkHr+OTOdmY=;
        b=gD6V3h3g0RXixDoV3vwAolTHmO23fCLBIKLxHUItVC6xQ4F5zPDKkXKPZjMZz0qMBH
         8M++nlwU9GvurFwSp2f8cPijnHzbC0ya73upxJVRBWWuk8v4EHfYubththsA2EfQaT7h
         +57cjHjcQ1dludoovN1pwBcrQNdoMIFvfAI9t4M4ylCNApbQ4wf03YYI52vp+iSDD1eB
         v0IYU287JGod167ivMFpsLaGMNPuPv2bdPpIfQsg59W371K2zVIpy2/CFq+8vyU1knhK
         u9H2DizoiHLwJ0TpD6ptfBiZAVZkffHHH78kWH/YqrXjSA1CXeE3RHWoWShPKtfNMrdv
         TNLA==
X-Gm-Message-State: AOUpUlH5J/mjeGPcwBjBNvMyZVELazqrNCA10eaqgxvlHalD2LTyaPxH
        OA9aqY414li9zw75SHNGoePG0Q==
X-Google-Smtp-Source: AAOMgpfNnjyZDOfYfvtBYlQDsFemWzeh5Jbqv9PU78CU+KZ1vx0bXvyflyVfX7iSwUXQDU6Zts7UqA==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr13642625lfl.78.1533069937219;
        Tue, 31 Jul 2018 13:45:37 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id m129-v6sm2081288lfe.50.2018.07.31.13.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:45:36 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     robdclark@gmail.com, airlied@linux.ie, jcrouse@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/msm/gpu: fix parameters in function msm_gpu_crashstate_capture
Date:   Tue, 31 Jul 2018 22:45:32 +0200
Message-Id: <20180731204532.4808-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEV_COREDUMP isn't defined msm_gpu_crashstate_capture
doesn't pass the correct parameters.
drivers/gpu/drm/msm/msm_gpu.c: In function ‘recover_worker’:
drivers/gpu/drm/msm/msm_gpu.c:479:34: error: passing argument 2 of ‘msm_gpu_crashstate_capture’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
                                  ^~~~~~
drivers/gpu/drm/msm/msm_gpu.c:388:13: note: expected ‘char *’ but argument is of type ‘struct msm_gem_submit *’
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_gpu.c:479:2: error: too many arguments to function ‘msm_gpu_crashstate_capture’
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_gpu.c:388:13: note: declared here
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,

In current code the function msm_gpu_crashstate_capture parameters.

Fixes: cdb95931dea3 ("drm/msm/gpu: Add the buffer objects from the submit to the crash dump")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index f388944c93e2..713a92b516ba 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -385,8 +385,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		msm_gpu_devcoredump_read, msm_gpu_devcoredump_free);
 }
 #else
-static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
-		char *cmd)
+static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
+		struct msm_gem_submit *submit, char *comm, char *cmd)
 {
 }
 #endif
-- 
2.18.0

