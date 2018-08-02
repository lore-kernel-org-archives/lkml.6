Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6042521580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6042521580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeHBXRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:17:15 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30771 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeHBXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:15 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 25D9A1D61;
        Thu,  2 Aug 2018 21:24:19 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 91CB181;
        Thu,  2 Aug 2018 21:24:18 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 3FB8437;
        Thu,  2 Aug 2018 21:24:18 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
Date:   Thu,  2 Aug 2018 15:15:40 -0600
Message-Id: <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print module parameters when the driver is loaded.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 8a85ddd..f098371 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	}
 
 	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
-			", timer margin: %d seconds (nowayout=%d).\n",
-			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
+		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
+		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
+		pretimeout ? "on" : "off");
 
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
 		ilo5 = true;
-- 
1.8.3.1

