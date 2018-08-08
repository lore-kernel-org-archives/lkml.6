Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00642178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00642178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeHHVm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:42:59 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29861 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeHHVm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:58 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 921664F;
        Wed,  8 Aug 2018 19:21:52 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 473ED48;
        Wed,  8 Aug 2018 19:21:52 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 4/5] watchdog: hpwdt: Module paramerter alias.
Date:   Wed,  8 Aug 2018 13:13:26 -0600
Message-Id: <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module parameter "timeout" as an alias to "soft_margin."
This aligns hpwdt usage more closely with other WDT while
retaining backwards compatibility.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 69a88b1..eb947bc 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -367,6 +367,9 @@ static void hpwdt_exit(struct pci_dev *dev)
 module_param(soft_margin, int, 0);
 MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
 
+module_param_named(timeout, soft_margin, int, 0);
+MODULE_PARM_DESC(timeout, "Alias of soft_margin");
+
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-- 
1.8.3.1

