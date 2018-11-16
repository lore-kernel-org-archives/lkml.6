Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2FF2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fapVZTL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2FF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeKPVNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:13:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33834 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPVNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:13:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so4708046pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6LJBTmjPNOjTTUrUiu6Uu+XwWfVjQEp0CGIbptL2pHE=;
        b=fapVZTL3wXtnQ6qrqRRDkPW6zHsdgy5Hy97ifAbfHXRkAIiBxsmM0Sy8undREmQltZ
         aWIExxCEv7GERjq3U5gIThtpDaIv68DyzvWZg+mMtu8D+GCLNz8sKR2/r5/GBsn5M8YL
         Qv4l4dWy/0EKyK5VjrApfY2CXYwApuZdj6eHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6LJBTmjPNOjTTUrUiu6Uu+XwWfVjQEp0CGIbptL2pHE=;
        b=UVKGo67v+ByuGunhEwQFIT5GQO4RoUFQMOp+sNnm0DKGA1IpCHle9EBl6fC5lXOxw6
         xc6e56+wGW5xopkXoYz2bgiA3p6VYRdIimBzO2YLHqhT1W5EekX0AxlDV2dy9k2HN6ah
         4x1r1kfTC4cnKuLxSGQRRNB8A/wIRzIrTi6Rg0Js9f5+0U7bcnR8x9xdrObjIhtgi8Jx
         JpmpvTqz3FduhfGl4uM66QDr/8J6+rhY5NdN+7fXGb+nyiW63irzy9sknLWJNH53dhb1
         6cBny6zYv7yYVexo3KPoUpsIUnIBEoXWTWP8NW5obPsS0G2/m2oFaXHLdzSkKAZnNEB9
         JcuA==
X-Gm-Message-State: AGRZ1gLrbOvn0VoUAtQTs3GYsEVFWhSFxQxKKokn7+V8TX3ets4kIIgn
        1W/rtUm/sKMW5bHZudCjpWpouw==
X-Google-Smtp-Source: AJdET5dfi9j3r0ERwcuY1UtDOiaDjOZsh3x1EIH3bhnmuLfEZxizntcPaiO9nukcVW1tJo8voLzH+w==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr9577968pgg.398.1542366114488;
        Fri, 16 Nov 2018 03:01:54 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 202sm21268106pfy.87.2018.11.16.03.01.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 03:01:53 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: [PATCH 1/6] power: supply: charger-manager: Remove unused index counting
Date:   Fri, 16 Nov 2018 19:01:08 +0800
Message-Id: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused index counting.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index faa1a67..a1b420a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1687,10 +1687,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Counting index only */
-	while (desc->psy_charger_stat[i])
-		i++;
-
 	/* Check if charger's supplies are present at probe */
 	for (i = 0; desc->psy_charger_stat[i]; i++) {
 		struct power_supply *psy;
-- 
1.7.9.5

