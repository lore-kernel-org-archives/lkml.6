Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263B2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7263B2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeHHVm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:42:59 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:44266 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:58 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 375F26D;
        Wed,  8 Aug 2018 19:21:52 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E0D0E4B;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 3/5] watchdog: hpwdt: Display module parameters.
Date:   Wed,  8 Aug 2018 13:13:25 -0600
Message-Id: <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print module parameters when the driver is loaded.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index bb41714..69a88b1 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -320,9 +320,12 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		goto error_wd_register;
 	}
 
-	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
-			", timer margin: %d seconds (nowayout=%d).\n",
-			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
+	dev_info(&dev->dev, "HPE Watchdog Timer Driver: Version: %s\n",
+				HPWDT_VERSION);
+	dev_info(&dev->dev, "timeout: %d seconds (nowayout=%d)\n",
+				hpwdt_dev.timeout, nowayout);
+	dev_info(&dev->dev, "pretimeout: %s.\n",
+				pretimeout ? "on" : "off");
 
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
 		ilo5 = true;
-- 
1.8.3.1

