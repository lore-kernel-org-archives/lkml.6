Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpaLHahm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfBYNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:54:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBYNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:54:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so4545820pgd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghgB5dixrs1Lq9pUkvxI0Pkv0ZaVjPb9YYRaKoGpNfA=;
        b=NpaLHahm9rT0emUOSWhAzZuy8kY2E1eXEQOCYvqzsDpTQXhRVpiL/+aetoryCw+gyr
         Y4Bg/fqZrGCgiQj9ORm0XCkz7X3F5GPBr1ZCZe633L0kbiJHEogv/69PAglsHTx7JB5j
         PEMfiSM1Hn8r67ojWYNWCka5YtfBQGNRBy+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghgB5dixrs1Lq9pUkvxI0Pkv0ZaVjPb9YYRaKoGpNfA=;
        b=fV0Jf+h/RzJwaprxqbTqF5p+pfSJSks2LB83xvuuLsRh+5tfsnChoiN7yLUzc2fEEF
         kfERLKANk7R87zoel9O5xuWhmu7G2GgiebySAodwtZPJd2Hs9GtfM5zR8vPVKCzYFsg8
         sTm2Mj4216FeulBmdyp9Su1wKrKp5y/KmqvZLadaHyf1zYLXwXDjM0cn3MOl7sa1lBsF
         0HsF7TOWkIrBlafhrNq6br/6Pjk4YJrXR6eKVxq+FY1Gat4Jl8qMiLNoX0794Fo3tZvm
         Z3TqBc7ZT4ZT5g5A0S2gzpxzGV8iT3nQyLejw7HKnglVCrilbOSAARnfdb1R63AiHAOR
         8LEA==
X-Gm-Message-State: AHQUAubMXShFxkTc3uZqUBXzPRAm5nTaBwXwBak2TBEM/yadb5qU2vzw
        xaRtr+xvVdKvOeGfvMOluLzjVvru/zM=
X-Google-Smtp-Source: AHgI3IaQu2GxdYKSuE81CRN8I5e54GU56N0lJLQHF0NXPIaayjhvWMxZf7ei27m5Z+2jfpedfpTJ8g==
X-Received: by 2002:a63:4924:: with SMTP id w36mr15451527pga.227.1551102850653;
        Mon, 25 Feb 2019 05:54:10 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:d3e3:8b64:9238:2823])
        by smtp.gmail.com with ESMTPSA id v4sm5115849pff.181.2019.02.25.05.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 05:54:09 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        enric.balletbo@collabora.com, rdunlap@infradead.org,
        ncrews@chromium.org, bleung@chromium.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845
Date:   Mon, 25 Feb 2019 21:54:05 +0800
Message-Id: <20190225135405.108052-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
warning.

Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8f206cb4fcc0..75ceb04d8bf0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR
+	depends on QCOM_APR && MFD_CROS_EC
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.21.0.rc0.258.g878e2cd30e-goog

