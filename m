Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC5CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="cP74gxUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8923A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIJWft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:35:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36100 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeIJWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:35:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so10840515pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4riHQT7qDryyU3g2tY4xvTPz3K+uThbtROHgfuuPfOM=;
        b=cP74gxUDdN5Gz2UWLwWF3PPhpLOrUvLXbjQpewSYqkYkh1CMbzr0E7zZPI12wHr6Gg
         yuBawJIvLF5IXIwVc+AiqONg9hyRMnlqyjnqhl1EDmYbe25o2/mhgXnq4IkaeYnzqTTz
         spDQUJjyhDzsJ3rxaJC7kj6fZvAO8FyjZenjz0VAb01dNpMWBZEuFxGpWwfgRfbgdj8u
         ORRutcXps7TWkBTPmvgMN9IYNWZbq5n1t8z2/lHphEFc1uCNlOUlSaOtjmrXiShP7UYt
         n/CCbp+pORhgtpFVnr0YAjgryZ6FA9BsBigpC7U/JwEm1cP369jWjwC2EDYZ0hxPLsBG
         KwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4riHQT7qDryyU3g2tY4xvTPz3K+uThbtROHgfuuPfOM=;
        b=rS7yWBsNXRfxXwoo8hwPfNdruhy2lxbrLaAP+zVi4BGBccNP8yvlNsvrTx7dR2mIMj
         5AXEXFBEpfKSvlQM4/kDOvDoyET3dRwe67Cajh7QuoEUhEqs6zT0ZPQCS4Z3om4TsNFI
         GiYgtQBGB+Zx0VV8jDz07ibZQW08a6xJJZmQSwzg+n5toyXs5d225gfLsaEoOVKTt9iK
         SxHlxFOGeomVnmJYQjZhgvn5aboTgM4UlEJvEDaT/T+IXto3CILndi21IldwvVxNoBgo
         qGRZOA9XE4XfyMWxc5y1ULkW6WZNHnLzYqBG8kve5AtnMn0oGfnLcCQ6iIPcH2Px8vNz
         GwnQ==
X-Gm-Message-State: APzg51D1sqJqF5BY6BNBiIKppLkalpsMTfVyxbjRz+wLaR95FgOpvgVW
        Md2e9q2ky5W0TGQkF8AJ06AJUMIm/oxhRKLj
X-Google-Smtp-Source: ANB0Vdaz58Aityj44twnJKIXbTUgr6WeSEPT99y4DoqRgByo5dKbQiKLnjFGXpiLMLhNO/L3z3tuYA==
X-Received: by 2002:a63:e516:: with SMTP id r22-v6mr24310338pgh.170.1536601237345;
        Mon, 10 Sep 2018 10:40:37 -0700 (PDT)
Received: from WorkZone.localdomain ([60.51.52.116])
        by smtp.gmail.com with ESMTPSA id h7-v6sm36004462pfd.155.2018.09.10.10.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:40:36 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPUIDLE DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
Date:   Tue, 11 Sep 2018 01:39:53 +0800
Message-Id: <20180910173953.10113-1-kw@fieahl.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use ktime_us_delta() to calculate last residency and
state usage unconditionally, it makes no sense to do this calculation 
when we fails to enter any idle state.
It can be optimize by moving the calculation after entered_state >= 0

While at it, merge those comment blocks into one and remove a
space between type casting of diff.

This patch has no functional changes.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
Changes from v1:
 - Rewrite changelog as Rafael J. Wysocki suggested
---
 drivers/cpuidle/cpuidle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6df894d65d9e..5f6b2c9b6555 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
-	diff = ktime_us_delta(time_end, time_start);
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
+	dev->last_residency = 0;
 
 	if (entered_state >= 0) {
-		/* Update cpuidle counters */
-		/* This can be moved to within driver enter routine
+		/* Update cpuidle counters
+		 * This can be moved to within driver enter routine,
 		 * but that results in multiple copies of same code.
 		 */
+		diff = ktime_us_delta(time_end, time_start);
+		if (diff > INT_MAX)
+			diff = INT_MAX;
+
+		dev->last_residency = (int)diff;
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
-	} else {
-		dev->last_residency = 0;
 	}
 
 	return entered_state;
-- 
2.18.0

