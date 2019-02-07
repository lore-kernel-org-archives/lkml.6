Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3022621904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcTJr3vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBGM6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfBGM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4446606pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=PcTJr3vpWLYkIMmFeEOBKGBfgKSNXxceX8yGcDYbbqeqJdshZxstNRO6CGrI7fhLqk
         As9UpgVAA6o/0adAVkyNfBvNJjjF9rg03P/L9BwpoWfNehT92MNoctJopxO6YpR22j8K
         Hc0hNP2L/IpKga35OXuXSy9K3s3RFhM0rfzZMcbGJuLAknCjLheiq4Cx9EjM/H6Wb5D5
         L5cKrr7Boh6S/TK4koiRoTO+4GSvkJBuvKRHbSkoS/PJ5FekzvxEMq2u3zY8VxC1DqbS
         n4gXCBNHtfiFbtGbmZZgGq/LnC9QKcNRapZ4llki65mSKuHpjvw/P3S6WOLfIGXIVuBS
         W2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=XFgJ2I423YYyH/J0Up42QWBGy7t9qLvNM5akgMaAVy1ScmhCaj2Y1PTEUoEFCRYufD
         mfmKkPJlnNTIqj+zMbggQJ/P7Qbu0H1OxWlug1UE1O0ldklnX3rmXsLbDXc920ee7UNp
         rE3T9xeZZDQURV5JVmyGb36RBL4swjTwM9U75p/o0VMllHGEVeHAGeAxcZoGi3WRhMX5
         JwUEplWp3RiBTTAtb7EBia/mWSteSolsXZ+Lrr24O0jX1fG5P5t4ZhxAaC+WdZG0Guj5
         hs9UkW8ttZf/bOcKDNv9373CabJn3R2YGBatl31ytU721AlTjA531opGv+HNPFtDhHKZ
         1Bkg==
X-Gm-Message-State: AHQUAubn+3QPCaU7YqjGI9lF4a0g5wXx67hr0CVbFONwgJFLxBMfTl6z
        KJ7+bx2Y52RTOdELr8Mj31esGbwskgk=
X-Google-Smtp-Source: AHgI3Ib0siwCNYRoZpmOhOFFPxCdLkzxCLZlBTfJLe3WuxvkP4UYElin56BTrt3HlaCubMD2CgHqlg==
X-Received: by 2002:a63:20e:: with SMTP id 14mr822167pgc.161.1549544300932;
        Thu, 07 Feb 2019 04:58:20 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id p6sm12876887pfn.53.2019.02.07.04.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:58:20 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 12/24] drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
Date:   Thu,  7 Feb 2019 16:19:30 +0530
Message-Id: <999576e731dfc32bdd382ebb6506bf3d8f4f79e9.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We print a calibration failure message on -EPROBE_DEFER from
nvmem/qfprom as follows:
[    3.003090] qcom-tsens 4a9000.thermal-sensor: version: 1.4
[    3.005376] qcom-tsens 4a9000.thermal-sensor: tsens calibration failed
[    3.113248] qcom-tsens 4a9000.thermal-sensor: version: 1.4

This confuses people when, in fact, calibration succeeds later when
nvmem/qfprom device is available. Don't print this message on a
-EPROBE_DEFER.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b91a0b88d33c..057b33353ba3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -159,7 +159,8 @@ static int tsens_probe(struct platform_device *pdev)
 	if (priv->ops->calibrate) {
 		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
-			dev_err(dev, "tsens calibration failed\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "tsens calibration failed\n");
 			return ret;
 		}
 	}
-- 
2.17.1

