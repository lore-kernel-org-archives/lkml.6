Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A27C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0436B21711
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="URs0cOrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0436B21711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeGBMom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:44:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42140 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeGBMoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id y15-v6so6041250pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=URs0cOrYlP4BOAYTacOb341ahNRD+O96SbDO+rBDo9it/c7v3pLydiIQo3adVWu1Jh
         dPcX/HQIc1QhXtpJTqRuq3ytFbLGHIDhCxytbGJPnyIir4HUyT9Nc+HFScs1lThmf6ZU
         nZ9ukc9w/slVHpl9yfmI/QqQ2tW+KqWgNYBwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=ebYlxMWPrKXY1UlW/1O68qVbBkFncQ2XnTIfpG5ljxh1E17xlKApAUC27JO8K0CA86
         sxS1kdYtiDkhHilpU3PbDXBBlGXc2KMbrKmJ7/J4K8gUA3YqW0GcsDyVQ4estgp4aDFy
         omQWc2HM2bmphPzxCJyqmqe3GskqZmuIasEYr+beDv08CSHeJvuq1bLs6pO/kIaVuuH0
         ZPgy6nsWSq+P97WQwnerzWvNQ471bLqs5jQJGYSVTmT9SSyB7g+YsgpfB949qGkw8HYH
         Lu8hgXaSAg+/Lk4ee0CMTMgIlNWllCTwKLYQaLtTwOpJdjG0knHYwAB+2q0eP/0uQZdo
         kC8A==
X-Gm-Message-State: APt69E23X1LTWXKpOw4Q9p+G1sF0lCcok2aBGWXgU1NPVOowEj7AtAWO
        Fmss6gwch5hq79DHmyF0jq8gyfUvpOY=
X-Google-Smtp-Source: AAOMgpcr4QPHPXz0rC0f7/K93B9aK9D3F0WqgEr0RWHGi+fgrOJsJpsOh9Cl0VQf1/AeZaiAsi8hNA==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3-v6mr904635plo.111.1530535473517;
        Mon, 02 Jul 2018 05:44:33 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id m6-v6sm9301042pfh.153.2018.07.02.05.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:44:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 1/6] thermal: tsens: Get rid of unused fields in structure
Date:   Mon,  2 Jul 2018 18:14:04 +0530
Message-Id: <a55492279160077e59fcc1e29b2c3b6d9d0f822f.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/tsens.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 911c197..dc56e1e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,9 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
-	struct regmap_field		*status_field;
 	struct tsens_context		ctx;
-	bool				trdy;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.7.4

