Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A44B20861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRajoN/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfAOLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:03:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35249 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfAOLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:03:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1117767pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hUzHvMduusbviHq9ihlVyR2HDLafhXOUk/aePcd5tMo=;
        b=ZRajoN/jqguT7NsgVIo5E0J8ykkbn6KrjUAxsJ/ZLbbFkQeeLZg/jbrYedBglOTe/o
         nlCTVvNlif3rAIOO3WTGpYe8Bp13La29mEolo0Ag/sGXytm4QlNBFx9NE/q1mbq1Whjr
         a9KEt+PnUL0RJKpb84qxauStOVk94waBlEcY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hUzHvMduusbviHq9ihlVyR2HDLafhXOUk/aePcd5tMo=;
        b=jujYTJ7zoM4eGnJMuGwNkJE5c6n/ykcPR64221+NloodCQdjkhgMML5rUGcj57TkhP
         dJrStYpvclriASNMstgQPWsJJLF6zHVVY6nebrhnOr72bNsdJKVHQ2y8R4KiuAWLPK/D
         tWILlQXfMLPG41ya5aouMRiB4xHiDwaCfzmt24q3Tebqf4P2gAmC5HJAC2inR7I+RZyW
         jy9yv1sh8k/zzPeEYaGBNA1sir7cHRXFlcKbV5MTdZCKdjRhCT6DV+UBAVRlZI50mhE0
         JN9iUK6/Wb62d1UnRD8fyMGSlUVi5nVnNUuzBJtkDWHU7Etqvd7VjN1w9ZSDd8Qwf6UM
         fvEg==
X-Gm-Message-State: AJcUukeArWH4BQ1JQ7cSCdh1u4dlLy1LrCm4zFFVfVLpz1HHRs6StJlb
        V7wRWYFSrOPLPYoC+8QYOAV2GTF9Czo=
X-Google-Smtp-Source: ALg8bN75pY61x7586eG+tqV/+gj6hc1faRP4XsfIibCC8rmpyLtQExI1sdhXeMmIAwWlyW8sz2iI/w==
X-Received: by 2002:a62:3adc:: with SMTP id v89mr3348578pfj.109.1547550190885;
        Tue, 15 Jan 2019 03:03:10 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:d3e3:8b64:9238:2823])
        by smtp.gmail.com with ESMTPSA id 196sm9877368pfc.77.2019.01.15.03.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 03:03:09 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: select max98927 for sdm845
Date:   Tue, 15 Jan 2019 19:02:53 +0800
Message-Id: <20190115110253.261596-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select SND_SOC_MAX98927 for SND_SOC_SDM845.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 This is part of the patch https://patchwork.kernel.org/patch/10696507/
 RT5663 part was added in the patch

 e9dc919043c5 ("ASoC: sdm845: add rt5663 codec select")

 This patch adds max98927.
 Thanks!

 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 804ae0d93058..7948e993adba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -102,6 +102,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.1.97.g81188d93c3-goog

