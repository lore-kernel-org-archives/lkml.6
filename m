Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66621C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287D3218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfHWcdRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfBRES1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:18:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38113 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfBRES1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:18:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so591827pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 20:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wjdGQCce0Zhl2wUJWGOQB+1Ime4vD5zBY3j+T+IbU4=;
        b=SfHWcdRECNn3XCtU3zIxkF+g4ZjA75RwqEeS3yDKGwIlwTfO5WG621BgcxN5f9Ot6b
         bg3BRFXNhVmiqtTyPImNo0TJXOyhetlegFURdRaqiT1bX0/ylO0bOGB4MwIBWnO+6T31
         9nQaw0xIwjX19z3IKx+C7vRUFFCpZ9wBvtX+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wjdGQCce0Zhl2wUJWGOQB+1Ime4vD5zBY3j+T+IbU4=;
        b=sOLNf5VF4IYeV/0IKg+A/Pe6JcG+hkUYlXpz+S0e3XshuTR9gJ9axbeeqwa1Gc6lmj
         jNJCCw3PXGVckqNFq1n2ST9XVN/0O6Y8edtkugOhugHXrdejqIR/ZTzdhdSXvh9s3Z9C
         DbHSWP7HuLD3OK4YqFpydRwTE+daqwQliR2q/P2HEfb5g3fFon6dawvV4s00s2ux0etn
         /Az2NAbw/rAyeYsnmyfnqJJYbgrZgtxAowHoPyQarccgYvOTMBdRT+3Moo6LEf/pig5H
         Rfubfxl93DTyehOyxbvoISFmhHx5XxVCaTLQReoSRQXnloLvGFgCiDxdR1esHgbWa4H/
         tM+Q==
X-Gm-Message-State: AHQUAuZollaL51GOthtLgi31t+fJ2stTOCQLsXkg1jEfjORkHYJX6c/C
        CkTqbvoIxEoDiVcob9PpXdTtm6JWwDA=
X-Google-Smtp-Source: AHgI3Iax/on7+IAsTOSdc2PNBPwqH6ZreiQzywNoAR1Fc70dmT6z6UmXIzhCdXwGJfDvKJLRCNDgVA==
X-Received: by 2002:a63:535c:: with SMTP id t28mr17223164pgl.128.1550463506015;
        Sun, 17 Feb 2019 20:18:26 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:d3e3:8b64:9238:2823])
        by smtp.gmail.com with ESMTPSA id p20sm25229196pfi.152.2019.02.17.20.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:18:25 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: select dmic for sdm845
Date:   Mon, 18 Feb 2019 12:18:19 +0800
Message-Id: <20190218041819.115729-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdm845 uses dmic on EC so it should select CROS_EC_CODEC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 7948e993adba..8f206cb4fcc0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -103,6 +103,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
+	select SND_SOC_CROS_EC_CODEC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

