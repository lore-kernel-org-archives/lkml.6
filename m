Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2750C64EB2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FF9206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8iTa5u9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FF9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJAFXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJAFXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so10372536ljc.5;
        Sun, 30 Sep 2018 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgvd47ntIDWOVMFx52mLZxwC1YUjcA5K/VrZts78hGo=;
        b=X8iTa5u92SdDsf7UVWhGjgLRjB+QFp6P9TwFKGEx2BIkTPBC5VC9F70GYX4BOiccYI
         n4WOft+2l3tmd1gfwXpNqD7Pw0ejDoOUF1swVN8yw3Dd4zLJvNSbEG1zg7j37cZbzq+Y
         XgaZHlrIB9DEl5jO9g/vGwVUOjOP+v4a9yuchdYJDYzia6YYKOwjQa9U0BLjMFp1dlHd
         j8O8lir9sxnwWPJSdzF+/e+cNEApt3cj1E9tka2a9qzroF+spRtISPraTga6jy8tfy+6
         sqCWSZtUTs1aRrGacoSoj+8wWvvl6V8ozKcFRppbswj3WPV6a3bD+V0cWIin/x5TR/05
         Bmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgvd47ntIDWOVMFx52mLZxwC1YUjcA5K/VrZts78hGo=;
        b=kpBFZt//kWHQnnwMGnNv3mGdf8I//oFW8NAE+e54/eXZdOv15m56jXcLWJhoUhtE7b
         jw5W2/z6r9s9M44C3N1oFYfdk8v8m6rKgZwc8An2EcvMgqGTsf2TuyCPdGUynVF5g6Jc
         P7OuZdd2zOqKR7wMK1dn0jadIxqRdhViYtQB2K5trrvjU1Fe6sDEXjp3QYOnOuF8t+pH
         My7QqB6NW6k86c4K5drPG5cbsyCSLdx3pp4Wg6q38xcaTMQxupCK/CfYFBeT087mpJuV
         QjRgAE+2WLs467JsplVb+2GoR/vOWt7KYUnEDQa1w4VBuQT8Tr21Dtc1Sfwd5VUXGk43
         eXXQ==
X-Gm-Message-State: ABuFfoibE1sxPH3zjWQDtIQCEwlONAlKqxp+TJBD+/B+rmrvZVDPcB8j
        8ILiU300xnxk8G4dJ5cnxbA=
X-Google-Smtp-Source: ACcGV63xK3x+dMOmo+fvIb9Sj/16ezGZdu2/4oneL1pOanZEJY/tL6+8ZR8VdXB2ReZ5wuZG1ebANg==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr4635560ljj.30.1538347741643;
        Sun, 30 Sep 2018 15:49:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/21] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Mon,  1 Oct 2018 01:48:20 +0300
Message-Id: <20180930224833.28809-9-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
timings for RAM code 0 registered" warning message during of kernels
boot-up on Tegra20.

Fixes: a8d502fd3348 ("memory: tegra: Squash tegra20-mc into common tegra-mc driver")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/memory/tegra/mc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd25faf6d13d..e56862495f36 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -664,12 +664,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 
 		isr = tegra_mc_irq;
-	}
 
-	err = tegra_mc_setup_timings(mc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to setup timings: %d\n", err);
-		return err;
+		err = tegra_mc_setup_timings(mc);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to setup timings: %d\n",
+				err);
+			return err;
+		}
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-- 
2.19.0

