Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6184C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E37820883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3OWoL4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E37820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbeGLIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38275 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeGLIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id m1-v6so8072136wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4oDCvpizcqb4/i72AEYMNJaEhphPFSx5aHBq53Ho/iA=;
        b=a3OWoL4Vp80GEEuiDKAcU/ezGaF6QUXrPPqun6YOEM430ATQ/tv6xlqMWYN3C8kLVy
         sc5M+Ai2YZDqebh5I3O1+kU1zQw52Hy8Ui1nUaiEhvTxGvri4U/YivldyJ5MVvMasv01
         dH15X6u//xcTAQKZPItMYBCW0a+adlAg+PSV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4oDCvpizcqb4/i72AEYMNJaEhphPFSx5aHBq53Ho/iA=;
        b=RCcG1Sfg5dM992HiIdS630yLRyw9x56+nhJzbo14Wr27bgKzQ+z42OYsVLxvZRljwy
         GZHAesVy4fAxXFpACYp6p6xbEPj14T/fL8PaWULC9NaIGb7Maxye0DNltOARprtw4cUB
         lguDZfb6Avx4lT63nYjwnC/uuqX/BIPE3zJzw30i/xVRt4WzkHuyH/6WifzImBr7pu/j
         ovWOa8hQ+u6NVNP3lBh5ZEHTvNaOxDkksniARME3a9t5EOWwnNnEwpP8n57/zv94h21D
         NHy1bFGNlLXGfpWIJQbAr7PtCMHjc6oHvTJbCFSNy4LKoJtCL5yG1eG7dtSJKi+9ggpz
         zxtA==
X-Gm-Message-State: AOUpUlEc+ovlVtqau2v2aC3nqM0jGuOiWxd7spjU+xPqjNcCDQnezc5W
        LeDoNp1jNHJ986B+S2oJP6GnXsKNTG8=
X-Google-Smtp-Source: AAOMgpeaA4xQC2EVTTraKfFFim5VtOIl0xI27q3Q/94Fbym6mgrbW+sefWuF/DJ66fTg1RkQoH0Pmg==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr1048205wrf.46.1531384781236;
        Thu, 12 Jul 2018 01:39:41 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id q8-v6sm7631341wmb.3.2018.07.12.01.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:39:40 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v7 1/7] thermal: tsens: Get rid of unused fields in structure
Date:   Thu, 12 Jul 2018 14:09:02 +0530
Message-Id: <f52bbf49172aeae4ef2a1cd70bf6224b6191b327.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
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

