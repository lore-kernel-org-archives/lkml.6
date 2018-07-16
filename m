Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF9A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2fwxdNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF9A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGPMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:04:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34424 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGPMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:04:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id n96-v6so31975775lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GW41+1i64qN88n/wuBAX0eAF5S8bxJ67TqW/BHxXAQ=;
        b=M2fwxdNs+WMJ4J66f4jzuDP9cDG5YYYtvt2lEJr/fi1z1KAzD7doqE0T725JINW/Qb
         grZHWI/OCetLbyxwnt8ibnYs7jmwVQUVvGXShkeyIX1tsi/CaWtHk3qqglXc+XCEvEgP
         iNpYFPIepX94Ueg2Z8srbtAchQ4nEk5SqNnVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GW41+1i64qN88n/wuBAX0eAF5S8bxJ67TqW/BHxXAQ=;
        b=eaLrVFQtPRSGyMuiCgrfGpD5igyFxKBs4DX4uP9vhicj55snvN5Nc4vrHtDbdUxkvq
         pCrAEIZmG7m9RyqZDvF/Ai7nGzyTnx8BAj4Is+BG8TVLWD88eeu/UbGuItYT0Dv+nu0h
         iJIEe3d3YJ1V/4bhYYqlnhWtCdF6KbynS3b4PDXYoi4B7aOMyrfEFFyznn955aJOQwWJ
         yIFo87Zt9yt4qDwZeItkZNCFAgoUgUeULLrUCSvRp+7c8/hRUuxAGSfk3Fl7Ts4b6GJe
         0iUvXWpldLnGYY/0EldG+5ynBq2VjiltsoLJIir9TuAHFL+HyzlvuHbqrm9Vw99JT5ZE
         ymfQ==
X-Gm-Message-State: AOUpUlHufDh1Z9iemBtJv6/Hg+E8MQt+bxtYyogMe1hByShMQJE9zWh9
        IZS5LIYs23hqK3O1nqR261sLiw==
X-Google-Smtp-Source: AAOMgpd6senYJlRxNEdVIlnz2TRv79kN4rSeSvexZrip3T4YRvtoJ1LzBoAlocMO/jscdG0uNPjBvQ==
X-Received: by 2002:a19:910a:: with SMTP id t10-v6mr10874234lfd.24.1531741019633;
        Mon, 16 Jul 2018 04:36:59 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id g11-v6sm2375691ljk.45.2018.07.16.04.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:36:59 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] regulator: qcom_spmi: Do not initialise static to NULL
Date:   Mon, 16 Jul 2018 13:35:24 +0200
Message-Id: <20180716113525.9335-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716113525.9335-1-niklas.cassel@linaro.org>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: do not initialise statics to NULL
+static struct regmap *saw_regmap = NULL;

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 054c0245aec1..dbe6ecc34859 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1060,7 +1060,7 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 #define SAW3_AVS_CTL_TGGL_MASK	0x8000000
 #define SAW3_AVS_CTL_CLEAR_MASK	0x7efc00
 
-static struct regmap *saw_regmap = NULL;
+static struct regmap *saw_regmap;
 
 static void spmi_saw_set_vdd(void *data)
 {
-- 
2.17.1

