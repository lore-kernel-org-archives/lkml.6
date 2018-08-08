Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A1CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C66219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cK591AKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C66219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHHPfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:35:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48504 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeHHPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:35:03 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78DFE3j038438;
        Wed, 8 Aug 2018 08:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533734114;
        bh=RJOGxxHqYWBRuUHrhs3lNB21ebTjqUHo8VIhfR0V21s=;
        h=From:To:CC:Subject:Date;
        b=cK591AKjPxL8V+cMYL6zfxWJKRvXyRD6/n1V2aoTtVYEhp5UfxDbk8NDOYONPWTXj
         rl85KaFqTLKQpYP87vv5d2TsdEkSr2v2oKAdsGIb8s0rVDenFennu1zTSKGaWNiGov
         C77zfyujISDYs+CbkVJfOlFIRycQgAx5ek0LFvzE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78DFE8g018474;
        Wed, 8 Aug 2018 08:15:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 08:15:14 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 08:15:14 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78DFAmV019133;
        Wed, 8 Aug 2018 08:15:11 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <baolin.wang@linaro.org>,
        <d-gerlach@ti.com>, <tony@atomide.com>, <grygorii.strashko@ti.com>,
        <j-keerthy@ti.com>, <t-kristo@ti.com>
Subject: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs
Date:   Wed, 8 Aug 2018 18:44:59 +0530
Message-ID: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
add the flag for all the other SoCs.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Keerthy <j-keerthy@ti.com> 
Acked-by: Tony Lindgren <tony@atomide.com>
---

Changes in v2:

  * Changed am43 compatible to more generic ti,am43 to cover epos boards.
  * Added Tony's Ack.

 drivers/clocksource/timer-ti-32k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 29e2e1a..dd09171 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
+	if (!of_machine_is_compatible("ti,am43"))
+		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 	ti_32k_timer.counter = ti_32k_timer.base;
 
 	/*
-- 
1.9.1

