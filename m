Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6E4215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKVGIWhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6E4215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHRTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33963 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeHRTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so6121315eds.1;
        Sat, 18 Aug 2018 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jla53Xxy8OfetyMufRWhRIiyiCxNIjcbctC1Xlzd4OI=;
        b=AKVGIWhF3jgmHG+mAtyhWOoMh0fOOLW8gF+6kRaNTfEL4SI9+/hwZ3uVwI5arrSCiq
         PVVl1SrB6/IFumVxsMdfB4XO1snl5F9XtVPvmBxRnuU41kuMJ1RRWG46Q/8aRK+C56NP
         Kc9EFd757phkEwBvNF78wDST2fCNLEIErDPfx7PZ+hCc88bitAgUA7BFWy5Fkw9AZBSX
         rY6JFMNBedYJ52k6hF07jvBLYx7fm9IwhNDR1/7GMIxx4ce5k6HgWUoKIphdIjctwWdm
         e2GNnxJWzlGqtrbFzs+COeXndtiauL/WwgU2cGw3r2mGGQQESzRaEUkFg/x8C9aWklij
         n39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jla53Xxy8OfetyMufRWhRIiyiCxNIjcbctC1Xlzd4OI=;
        b=dWa/6u/HDmlv9ZTBsz0YMET+R1hgsD7q7DPhR4EZGKBjeRq6kbWxcqDIdtJ4CDuPob
         XkM63VQzETtp07RILZe4/9nrnaV3ETawRJ4Y9PI5KMQ/3wnTFe5vc9xD9p/8eiKbkP6a
         0++BE3g5QaQULekH+A8Msjm5Rv1ERANbXGt1tnPFICrPYNcBIxq+tAcsmKfO1TOt72aX
         Bn9JAcuXwBM3KHuknZeS41KLrY8L1o0GB+CtCD5uPFpk+r/TMXVIgMv+FsamerxPiaFQ
         G1JLXag/BJ4E+WFScn5YS2GExfmNj6omGoyP5mubFUT3OT/aYzJ6XIx+M12cahZxjfvJ
         o72w==
X-Gm-Message-State: AOUpUlEfWkD/EjimW2EWvIag3Kx5I5/gNRd8Wuo+vEIZA3J5czkaSbFv
        voIlx4cnD1LSOQjRoX5h9tU=
X-Google-Smtp-Source: AA+uWPyfR47VKNx20d3LD8Fx6pTkjwgE7ncHMEZmpVRFzMn4E125QGsJrnkX/m1zgr5+uPVGchrunA==
X-Received: by 2002:a50:8f05:: with SMTP id 5-v6mr46624728edy.192.1534607746623;
        Sat, 18 Aug 2018 08:55:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/19] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Sat, 18 Aug 2018 18:54:19 +0300
Message-Id: <20180818155430.5586-9-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
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
2.18.0

