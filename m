Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D93C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C126620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIx7horZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C126620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeGSOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:08:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35424 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGSOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:08:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so7482449ljg.2;
        Thu, 19 Jul 2018 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xHxrh6ocbuK0A9VCmu0L0DMXQrYzN5Yuo2qXyBA7P58=;
        b=KIx7horZxdyujZS+Q4FSpIXPJWPMq8Z5LG24q8CRuVtOtmuYRY6ta954hHDiNasphi
         KtEweUmdFudTg5Lgl0XGBry8543+Ly0buDkGfdWYBIvbuuqC2nuUxekl89q99uWJU1Cc
         D3yEw0BBYjHLIj2+nnqGfcuchQNfjuv+SEMh2U10g8tH7eYHYs/42pf1WadqkrQ2I12M
         JPm4mVn6iUfgwSrgOzroFKwgEwO2nxai8SR6qvQfVrA7rvAA/xefjK0pnBylk3P7qLaL
         Je7dvosEOxQ2TQrRf0h/7WMyqD65haEGmV/d8d5iHEHI09JKY1k+ycPVNn0Zrcgs2JVP
         DO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHxrh6ocbuK0A9VCmu0L0DMXQrYzN5Yuo2qXyBA7P58=;
        b=L0Gr9sK6T/LW0HeOtFE6jDhnZbl2ZOu5A1e0jPD0BKU/yrQZm6RMpD8P+dpzV+hrBa
         o89XIxCEeVdXOeSNWWKRqO3XTpwOmVscq8c5qkY/KnObMkAYNkBXYId3xbQT26AmBt4G
         D6MD8dHbiJlONotvAPHYZMT9fBpY0S/D9RlgDMB4PEkZR086kWOr/HBo+kPmYPxGCvTU
         NNQgtzerCwizcsQqKo3aWjdMs9Bcmp0Wm//0M9Dz7h2AkoFFHD7ofJYKGFhWJK3PYCyF
         QDr/J0dZ/bJej7Te9qMD108gJ79Vg3jkP4JV4v9JbkAZefzbZiQwYvF72nLI6ebYqVaL
         cnrQ==
X-Gm-Message-State: AOUpUlEe3N/lutKuL9SJfyvdQClmI8bIUj6utyBaBltUYKrT1jIG7/Ym
        u9ik4BK/WhIIVSG7fmPgDrw=
X-Google-Smtp-Source: AAOMgpfF5Jrh9pVoA2L4bffB2jrusMdmz/WluSZLeEXTLQKXLrL2P+EW1MU3QlYVZrS+ya45YMZxtQ==
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr6420826lfk.132.1532006726107;
        Thu, 19 Jul 2018 06:25:26 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id 93-v6sm960114lfy.64.2018.07.19.06.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:25:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Thu, 19 Jul 2018 16:24:53 +0300
Message-Id: <20180719132453.16860-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
timings for RAM code 0 registered" warning message during of kernels
boot-up on Tegra20.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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
2.18.0

