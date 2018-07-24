Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848BEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2DC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/4SUTKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2DC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbeGXRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:30:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35516 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbeGXRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:30:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so3252917pgv.2;
        Tue, 24 Jul 2018 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=benJ/ENVez+KpVhaYf+UXQYiDZfC70UybXBfKPlK24Q=;
        b=f/4SUTKY4730Y7q+x5d6S5YBv604eu2lv7K4LJ4AFrk37I6/70cZUDycsJp/sXJaz0
         qg410TYTt8RGjuNdii5/LHyfGvD7DZRrh/fk+Ir+wnZlqPwTzTPMHl44gMpO8WVMaLJe
         gaJigNez1KR6kPRxYnqpb/pm5zck3lVk6lkPyDKn1s+Rpsx11vNF9vIQUXrQ9zAoboJt
         8ul3HsiexYm8GDGkHHXID+FLO8OMUs9DcEayl8jR7q/Ht8TtGnSu1ixFThOEOcleZrN5
         gqeJ1bPMcXMGaFXcfg1fHWtrW73rY9CIuToUGjgrq8EzOaWCaqg0ytujuepckOT8NRIn
         ZFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=benJ/ENVez+KpVhaYf+UXQYiDZfC70UybXBfKPlK24Q=;
        b=IDZGFam5G8EOtGEyNbtON5DIWYCtrZ6KBjdUTVI+DiTT3+p/fhxJl9DPv68w5TNYQL
         IQTs8TfJW21Nfm4vwUjoVN/9xNsedG2cW/lXahWwKFEKAzy8w18WSjto2Lw4pqOhZHLW
         tOs+BCa+CNxzW3nVUCoDHWE/OoqDR1w0jWew7zH5MCLdrwvZBe4uTF9DkUBhFALY/m/f
         t3lj+fnMK670O/2IpD3TzqRXg1dx28uj6nPQDLya/35eeN0N2/CHmxsZPO2YF0kdACzV
         ycS5yBDDgtzJr3D/vHbvkTWQleNP5w7TmT31zuPHLay94kEt/eGrLRkq043UWU8oeTq1
         bXCQ==
X-Gm-Message-State: AOUpUlGnJzS4UWXxKGwm+Ljvx/SGutUZc4gvy32TBoHKh0aMDVX5MyLa
        Yzn9X8spvESmn6d87IM2q/k4v3xH
X-Google-Smtp-Source: AAOMgpdrl9qqcPUdM9zoELcvYq9XUmnN96dQfiTSqK86/WfwpJBFjfZewtQyU7EG9aaUbfVRcGx2Yg==
X-Received: by 2002:a62:1f06:: with SMTP id f6-v6mr18492673pff.140.1532449379671;
        Tue, 24 Jul 2018 09:22:59 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j71-v6sm18075884pgd.23.2018.07.24.09.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:22:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Tue, 24 Jul 2018 19:22:08 +0300
Message-Id: <20180724162208.683-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
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

Changelog:

v2:
	- Added "fixes:" tag as was suggested by Jon Hunter.

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
2.18.0

