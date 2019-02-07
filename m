Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E11721902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sU0v9qq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfBGM4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:56:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45034 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfBGM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:56:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id y1so4441540pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Tf/kMCCdkeqQnWWFTTv8/xc1yH66O1Xq3Z4kaU9bVds=;
        b=sU0v9qq55wH6RZ1IqLcOLRepVD1ccpTpRFppGRa4VCWQUbnzgIyNWV+du9D14r6IXV
         SMAH+vcKVAmm7wXBodx14h8gf+pPYJQvfmjDQFjZVnjRPWSVqj/gYrLRmdAzFIqj0+nU
         aTPkmaRsbf3w1Getc4x67lOB4e3t3mlqED+pPmlTUEvtvxBh2P2NjzTgPROB1ONzvR+P
         GF1OMJalZfmh2MB/wiNatnsMQ27h3Iw/YKtQogXolYFRXwG2wfuLwGsSVK3aU/nvISFx
         GeTnAuoJx8f2jnSlqqzx18tO9y5VtExoyTRYCT//p0kVZcPs+1W9oRUrr8OqTetvmEgf
         Cvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Tf/kMCCdkeqQnWWFTTv8/xc1yH66O1Xq3Z4kaU9bVds=;
        b=C6nA8K+yGh7cfSUN4moq9ylqJhkComuQraFKvHM0iVO43//38ht2NxWjEjwbHBvWfe
         xQcZx1JzlGXwjy0rwilg4Ca8T7xj/twnTJl1Ctt5KIbytTzdwTC+mddOnuQAU9fOcuN1
         fZdyIeKHYLdy71NO8KWHmnQ0UZFh0a+t1RKx031ek1hnCciA7rr4XScYeDN0IUBcWwCj
         UjSbrfULhvdGbjLt5LSUcnIMIKZ8E6tw7XBQerHgeGVc9ocRyfcJvPBOErlGBUMnachN
         nDPQ9c4x5Re+5bqSm6/9p2cdrA+GNB2K4OccQPxXvBhNxzs0vfm+ny1uznTRsSZs6dGR
         YUUg==
X-Gm-Message-State: AHQUAubYoh3uBcgZVFWLLU7VYopqSSWl7Sll0xIrf9i4siCPpcfjQQls
        L7g4XC6LVxe4Lk7tF6G3v3/qRz4vTSM=
X-Google-Smtp-Source: AHgI3IbV3hU0We1HQRBYn0OtUEdNsWgEBUzZwDaY2k+xFi5t1a+ZI14vug9ZprvbEYeSO2DvMf86uw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr1052210pge.130.1549544182620;
        Thu, 07 Feb 2019 04:56:22 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id y6sm13045892pfd.104.2019.02.07.04.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:56:22 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 15/24] drivers: thermal: tsens: change data type for sensor IDs
Date:   Thu,  7 Feb 2019 16:19:33 +0530
Message-Id: <86ff4442dc1cae50a5f63aaa06c831bd3ee76d9c.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDs cannot be negative, fix the data type.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index da4cfb23dfe9..e0c1ca1a7467 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -29,8 +29,8 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
-	int				hw_id;
+	unsigned int			id;
+	unsigned int			hw_id;
 	int				slope;
 	u32				status;
 };
-- 
2.17.1

