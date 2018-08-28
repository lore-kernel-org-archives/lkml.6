Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50062C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAUfRUOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeH1RbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39120 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeH1RbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so1405419edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OtEL3twwCU5dkO9QBj71MwoA7SMZwYjEh3tYcgqkpCQ=;
        b=hAUfRUOWAG5vo0DUb55qiamCf0cyPx+qw4vg/Y0V8lbY9FCoWZXRguDvGH5v9Y/sFE
         lgm+Z3VO566KEnZlAKhQHNnIJwwDRkuX4w1hhd8KIuBd4lZHs6th8l451rGU1hlzGG1T
         8ilgCMIpl3lam2rRA2IRNP4ZLo3h8YpkBxn9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OtEL3twwCU5dkO9QBj71MwoA7SMZwYjEh3tYcgqkpCQ=;
        b=YIBNMeabd4Dj30wrv80rqkQTNUlvULiXZZsdzliR/kCboUaxMZSI2ay/IUjNC6zkzs
         i+ixpj+DRMg4fafzoic7B0wR3BHm4QmDin8EIVmfGl2wecIxWbOu05ox4hbPqsh66uP4
         dOWKUFkW8aTxwqHIcb8YekPOcUyFvnEi/Ct6b3thXLimBCuAI7muXuGkeYT+9cTpUY9p
         5w77vXZDdpS70/YcNkLRBtqTKjR96uk3i3XYD/KBgaqoMri9iBqMdLfiuBU2mRLqZhPz
         aZd1jldSFeoUYJAXoOESUUpxiLMCbBY9bYkgJNrAdZQBJ4JlHSfZLXEBufh+GGaTHAKB
         zs1Q==
X-Gm-Message-State: APzg51DsorzDnywfbnAHQ6dIyvPzViMLhxK+tCRu+xNJmcsJe1PDolnh
        K4+NxSlxhwctZSLzntcVW0cm7INYBGc=
X-Google-Smtp-Source: ANB0VdYI57irc0nSWvAIIp3CFr2lQgCV6tZnfJU29uINsUoGxrh7P37jaY52aH0dHd44dKZACbo1CA==
X-Received: by 2002:a50:9e2f:: with SMTP id z44-v6mr2517744ede.242.1535463570195;
        Tue, 28 Aug 2018 06:39:30 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id j10-v6sm610521ede.5.2018.08.28.06.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 05/11] thermal: tsens: Get rid of dead code
Date:   Tue, 28 Aug 2018 19:08:34 +0530
Message-Id: <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw_id is dynamically allocated but not used anywhere. Get rid of dead
code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 90bb431cf740..9a8e8f7b4ae1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
 {
 	int i;
 	struct thermal_zone_device *tzd;
-	u32 *hw_id, n = tmdev->num_sensors;
-
-	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
-	if (!hw_id)
-		return -ENOMEM;
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-- 
2.17.1

