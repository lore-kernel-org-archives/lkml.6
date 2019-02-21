Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8166C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B152084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGM/tt4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfBUP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42998 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfBUP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so17638032wrg.9;
        Thu, 21 Feb 2019 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sjfQnYXYiI3H9SALD+ZGbevOhgIf9me4QKE275k6Zw=;
        b=dGM/tt4A9aNQooAojyjRDirO2w5BTcsIzSabfvoja8JYUALg60Or5hATl4pKLSyW51
         laJhSQ8lUcVIYDXL3J1yclcLSxWbx0ISozv9IFuVov6Bz3SmH48kapTrZ+QeCpx281tA
         CZiIIdiOPFWBCMZZviSq6MUviVf6CmHzP6yFRzA1/8gWd3orHkrdp3RnTriDePv0bMmP
         Vef7XbR7/IhqFTwepVPzh2HKZhlBqZ9bp357HqDp4mWdWw1WPiNHgfi1VMjjYpi/OFN2
         zU9WyIHfoyB4kRj58mqJrLrErFacJeBXlE6nKPa04QBFLUdNsMHWaalxKtKleCGnI+yf
         Gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sjfQnYXYiI3H9SALD+ZGbevOhgIf9me4QKE275k6Zw=;
        b=LJ1gYwlTeYn71tGrlTV3tZ1wvrNUcM74Rl5dsOs5AJf4iQbB/54gREEtN3XSf5hBZw
         VADedBqZbrAs/gJt4Mfl8KuS0eunNcWG0Qew/7BmVXDNTcuxqudDaTm2tpU6YMDv1y91
         ptEOZI4jtieIusucGNB5SE20JEc2ScOWRu4bLY+S281tdLDGQRQvQQ3plbRrCQEExOin
         GsuFtgrQvHZ/MZlq7ASE7FeIsfPno5K4prbgsaJGEgbknU2oQ649Vzb4sTAxAAy1nn+L
         htcCev775eldY7RfGLFhVG966mY9OTlwjqFJnGLErJGBo/iMzZitzSGV6Xc3MDTmr+oa
         eYSw==
X-Gm-Message-State: AHQUAuY+pyxwjruv3j4FBRAJBjrGyEjyF7iM2xsQAR3tI0Iydxg41H67
        svK3MMcyp+/qYkcMs6uvn64=
X-Google-Smtp-Source: AHgI3IbMBw1yJWZsmd3MINZVKFgIEAi/Dst1YBn9771LtrCDtHIRn6nlCigmF9KOgbQ1G2xR3FMExQ==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr11081630wmd.103.1550762763649;
        Thu, 21 Feb 2019 07:26:03 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id u134sm9154227wmf.21.2019.02.21.07.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:26:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] soc/tegra: pmc: Implement acquire/release for resets
Date:   Thu, 21 Feb 2019 16:25:56 +0100
Message-Id: <20190221152557.8534-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221152557.8534-1-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

By implementing the acquire/release protocol, the resets can be shared
with other drivers that also adhere to this protocol. This will be used
for example by the SOR driver to put hardware into a known good state,
irrespective of whether or not the power domain can be reset.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 0df258518693..0c5f79528e5f 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -656,10 +656,15 @@ static int tegra_genpd_power_on(struct generic_pm_domain *domain)
 	int err;
 
 	err = tegra_powergate_power_up(pg, true);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to turn on PM domain %s: %d\n",
 			pg->genpd.name, err);
+		goto out;
+	}
 
+	reset_control_release(pg->reset);
+
+out:
 	return err;
 }
 
@@ -669,10 +674,18 @@ static int tegra_genpd_power_off(struct generic_pm_domain *domain)
 	struct device *dev = pg->pmc->dev;
 	int err;
 
+	err = reset_control_acquire(pg->reset);
+	if (err < 0) {
+		pr_err("failed to acquire resets: %d\n", err);
+		return err;
+	}
+
 	err = tegra_powergate_power_down(pg);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to turn off PM domain %s: %d\n",
 			pg->genpd.name, err);
+		reset_control_release(pg->reset);
+	}
 
 	return err;
 }
@@ -937,20 +950,34 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 	struct device *dev = pg->pmc->dev;
 	int err;
 
-	pg->reset = of_reset_control_array_get_exclusive(np);
+	pg->reset = of_reset_control_array_get_exclusive_released(np);
 	if (IS_ERR(pg->reset)) {
 		err = PTR_ERR(pg->reset);
 		dev_err(dev, "failed to get device resets: %d\n", err);
 		return err;
 	}
 
-	if (off)
+	err = reset_control_acquire(pg->reset);
+	if (err < 0) {
+		pr_err("failed to acquire resets: %d\n", err);
+		goto out;
+	}
+
+	if (off) {
 		err = reset_control_assert(pg->reset);
-	else
+	} else {
 		err = reset_control_deassert(pg->reset);
+		if (err < 0)
+			goto out;
 
-	if (err)
+		reset_control_release(pg->reset);
+	}
+
+out:
+	if (err) {
+		reset_control_release(pg->reset);
 		reset_control_put(pg->reset);
+	}
 
 	return err;
 }
-- 
2.20.1

