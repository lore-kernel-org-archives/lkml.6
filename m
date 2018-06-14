Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31F2BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41B208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6dl6BF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC41B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755387AbeFNTje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:39:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51005 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeFNTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:39:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so12417418wmd.0;
        Thu, 14 Jun 2018 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7/VwfvDOIgbM1idBc27xHY6hWSKZkVGC47yrwOMenOQ=;
        b=s6dl6BF3vZL3wmnGb588DsRoR6Zwn4/3Xa5X4vrwGnKFsSGcPdJ2Vs3uSMvUbOUwsO
         xRRxIe0fszMctlVWxRb5qSWECsj5Nm8bgtZJwb47shcwrYE0fuMOI6oRdLol4hXYxWo/
         1XsxB1HYrm4vyXKq6SRcxBmx3jV36q4iv3o7Nx+ZXgtDIyBngiXzqG+IRKKUqLPzx2EG
         66aUJbiw9+SsKFqf/kcVF/rBje40/mLtrTSGuIV9pr287pjLQ8kNb9EPEW/6mZlzJyrG
         LYIjXcm2DlyaFfwiCoUiw3eSx5B5zqqcRKuiy7D2wVV5q3CpAFIdPHURbOGMFqjDpLHA
         dAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/VwfvDOIgbM1idBc27xHY6hWSKZkVGC47yrwOMenOQ=;
        b=D+RThd6FoKDWLJ57G+nSD67OkE0QBKi22gZ6YNZRDiVhGqYJ426C6JvN45ty0Rrusl
         mBhfT8cgM/UNztMKoVNutoBb36D/wEBUktCXJ9FnGq6xozQo//mXi1udwsvFfUl3av8S
         YTZzBQZRDjBTId0WRojCgRjZd30gy9nCJNtRT5JzB9buMoUaMxfz8LUhrIpLuKBnPr53
         qRLNq2mlUXG/E9RE69EiImqHPf+d1ndPP8E/T1wghTmGta+nQP63/tSUP3geadRdocvW
         glnyMFMqDxIFhES24GMi170ZdDGf8Jf2EQi5w1AJV8+QP8epK5rWpYK7R/pE0FQkEQVd
         4Xqw==
X-Gm-Message-State: APt69E1dbuLl7ByD/Drvx7VTtWhuxmyE+TSuXRq/6MiMwWaucjVCTk+9
        0ElbbFIZajBJ/RXIYaIq+2U=
X-Google-Smtp-Source: ADUXVKIn79+SeVB6/BhmEgZB06JeR38h08UmDnqtiLnk3m+0zyZ2bghHCRuh9GrLpY+S7NPRLs5cPw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr3095203wmh.139.1529005170994;
        Thu, 14 Jun 2018 12:39:30 -0700 (PDT)
Received: from Red.localdomain (LFbn-NIC-1-240-64.w2-15.abo.wanadoo.fr. [2.15.84.64])
        by smtp.googlemail.com with ESMTPSA id p196-v6sm7974367wmb.20.2018.06.14.12.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:39:30 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] crypto: sun4i-ss: prevent deadlock on emulated hardware
Date:   Thu, 14 Jun 2018 21:36:59 +0200
Message-Id: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a qemu emulated cubieboard with sun4i-ss driver enabled led to a never
ending boot.
This is due to sun4i-ss deadlocked and taking all cpu in an infinite loop.
Since the crypto hardware is not implemented, all registers are read as 0.
So sun4i-ss will never progress in any operations. (TX_CNT being always 0)

The first idea is to add a "TX_CNT always zero timeout" but this made cipher/hash loops
more complex and prevent a case that never happen on real hardware.

The best way to fix is to check at probe time if we run on a virtual
machine with hardware emulated but non-implemented and prevent
sun4i-ss to be loaded in that case.
Letting sun4i-ss to load is useless anyway since all crypto algorithm will be
disabled since they will fail crypto selftests.

Tested-on: qemu-cubieboard
Tested-on: cubieboard2

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index a81d89b3b7d8..a178e80adcf3 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -341,9 +341,18 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 	 * I expect to be a sort of Security System Revision number.
 	 * Since the A80 seems to have an other version of SS
 	 * this info could be useful
+	 * Detect virtual machine with non-implemented hardware
+	 * (qemu-cubieboard) by checking the register value after a write to it.
+	 * On non-implemented hardware, all registers are read as 0.
+	 * On real hardware we should have a value > 0.
 	 */
 	writel(SS_ENABLED, ss->base + SS_CTL);
 	v = readl(ss->base + SS_CTL);
+	if (!v) {
+		dev_err(&pdev->dev, "Qemu with non-implemented SS detected.\n");
+		err = -ENODEV;
+		goto error_rst;
+	}
 	v >>= 16;
 	v &= 0x07;
 	dev_info(&pdev->dev, "Die ID %d\n", v);
@@ -398,6 +407,7 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 			break;
 		}
 	}
+error_rst:
 	if (ss->reset)
 		reset_control_assert(ss->reset);
 error_clk:
-- 
2.16.4

