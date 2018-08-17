Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC661C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22512188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22512188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeHRCzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:55:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33124 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeHRCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:55:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id r64-v6so3044294pgr.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 16:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZVwzXGvzDc6xEYFuStk/aq+CdIfDi9Eim5zmoodMc7U=;
        b=f5V46P7E+eZEL1tpMq0BIGB1yULI067RTC7nO3P85XK010zLwashH6ogrGJd2Xitfc
         tejrqcI/ce1iEtYx74/X+ASu5Ew28YtItSvzJ7aqSvtCAZhB8HR5pIqunzat6kPju4gd
         E6u5wyT1apqiaSdz4Fs6J3NNIuzoIdPcdE1rHFf5IqVImOevwl/za+e+qI4P6NmzqSLX
         qXTyrIxnEO2AZj0Dkp580fPcHOwuZKhQRJbzGherAHqKhmuVxWo1GYNhMcRLdS80mcXS
         bIQoGJsdDkdWAcvJP2Ql8jzGe5Tw4uj7JQ6t9bW9IgGTM9DR9Lz8cZV59+Pd64aPxauV
         j6/Q==
X-Gm-Message-State: AOUpUlF11JxYzMsPjmCOmKtsUfBWzcollZVx/63hpoNmh5kYRpzvzsRH
        BeEVWsgRKwZyFo93HWNWExgD9Q==
X-Google-Smtp-Source: AA+uWPw3nkcbQeqX9fSkPHQTjNAn08ykIe6kc/0Yt/yuP2eq5QvWBFYcIa280Kk28NX/oqrBFGqkXA==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr34224095pgz.192.1534549783643;
        Fri, 17 Aug 2018 16:49:43 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id p66-v6sm4817445pfd.65.2018.08.17.16.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 16:49:42 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     hao.wu@intel.com
Cc:     atull@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: dfl: region: Restory symmetry in probe()/remove()
Date:   Fri, 17 Aug 2018 16:40:49 -0700
Message-Id: <20180817234049.9624-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dev_get_drvdata() with platform_get_drvdata() to
match the platform_set_drvdata() in the probe function of
the platform driver.

Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for
FME")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c27c6d..ce7ebe4b3212 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(&pdev->dev);
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
-- 
2.18.0

