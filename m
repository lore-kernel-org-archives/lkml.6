Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A17C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CFE2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK1CoxAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CFE2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeHUSFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:05:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeHUSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:05:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17-v6so2330420pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date;
        bh=auNUopE+mBY+w41/CR183ZVpW9njQEbyHrBiCblSbZA=;
        b=gK1CoxAghwgkGaFmq3byGDWxq/fSmvdMqIkJq66+a/DHxFW6Ikw8W7QSNGcoSR65ji
         egK3i6mbAZoHnoZBfxEUXiMYuwqPwuEgkiX0SiVpvn032qeDvF62IF+UoumGSPB6IBZS
         X4LhQ+BwY4SiepY1WCKSX6R6oLlFwdxzPyN6E0VfyjuQXDVVPYTE+gKmnyXtfY4xoi24
         85OfBkOO/0X7NkKigZnTcJH6Kp0ePjRG9kl2759S8M9BVaedSSCj4XMHMEZ9usD2r42n
         zNkheLX4wJW5xWn0+/OO+WUEL8edvznfdDc3XPxOqrvzOzao5DusBTSCewSIkVdags1i
         EFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date;
        bh=auNUopE+mBY+w41/CR183ZVpW9njQEbyHrBiCblSbZA=;
        b=DleEGT4ZmOS1yvTjf8nuy/qyGO/3Dub5fZL4MYbugzhlKaZVo19pVcf0kEQHAn+rcX
         Ki+zERWUS2WWby3SDM7mEk2+IDlOA3VTKD+loYs5d1QXe5Hn7QRiNA2YM+XtWE4R69sz
         Niql70SfpA0bffLnT3Bofxrl+L81sc3nWAzV/S/jMfk8gR9+2PGDwFS5Avjh3mY2DriB
         wxq6KrnMZPH2JdcF4pOKFat+9hdeEWWK68gkjnlOS/nhWDvwPky/Owsio8Ufdul+zRu6
         c38Pfsg1oEg1GAb8Gmsf9pbodtFxyh9wxf35m31cZoXmGxNB1OdTKtLgk+Ms20LJd4eb
         c9xA==
X-Gm-Message-State: AOUpUlHNCXDU3DtY6LO28hKNAYweZxCn0b1XXwms/iBbhvd5o5nThHuM
        PEf2sJe6m0/3U6TPzU7N4WM=
X-Google-Smtp-Source: AA+uWPyuSFrGGV3eyJ4wOa0Ul50EMrHGHvJsqkxjB+7fmUolhkwaVF1qRa7fXPRvOHo3o8HNB+IVjg==
X-Received: by 2002:a63:4e5f:: with SMTP id o31-v6mr45364194pgl.256.1534862724356;
        Tue, 21 Aug 2018 07:45:24 -0700 (PDT)
Received: from bsapthagiri.soct.com (gw4.soctronics.com. [202.153.34.22])
        by smtp.gmail.com with ESMTPSA id u71-v6sm20378965pfk.174.2018.08.21.07.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Aug 2018 07:45:23 -0700 (PDT)
Message-ID: <5b7c2583.1c69fb81.c4b41.086e@mx.google.com>
X-Google-Original-Message-ID: <1534861364-8646-1-git-send-email-bsapthagiri>
From:   sapthagiri.baratam@gmail.com
X-Google-Original-From: bsapthagiri
To:     lee.jones@linaro.org
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Subject: [PATCH v2] mfd: arizona: Correct calling of runtime_put_sync
Date:   Tue, 21 Aug 2018 19:52:44 +0530
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>

Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
as there is no corresponding runtime_get_sync call.

MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
source we need to hold a runtime PM reference to keep the device from
going into low power mode.

fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
---
Changes in v2:
- changed signed-off in commit message to full name

 drivers/mfd/arizona-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index c7c3d72..190f9a4 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -53,8 +53,10 @@ int arizona_clk32k_enable(struct arizona *arizona)
 			if (ret != 0)
 				goto err_ref;
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
-			if (ret != 0)
-				goto err_pm;
+			if (ret != 0) {
+				pm_runtime_put_sync(arizona->dev);
+				goto err_ref;
+			}
 			break;
 		case ARIZONA_32KZ_MCLK2:
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
@@ -68,8 +70,6 @@ int arizona_clk32k_enable(struct arizona *arizona)
 					 ARIZONA_CLK_32K_ENA);
 	}
 
-err_pm:
-	pm_runtime_put_sync(arizona->dev);
 err_ref:
 	if (ret != 0)
 		arizona->clk32k_ref--;
-- 
1.9.1

