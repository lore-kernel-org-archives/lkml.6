Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597D8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbXbCYun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeLQJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53858 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732103AbeLQJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so11588675wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rA8teKiCQvBpv/jfjC2a7MA/lCNZKpqm0xO+S8oLkqM=;
        b=YbXbCYunUW3tubTWVVJb5UBGIYmnq3QR6aAeKO8sBv641SUkCq2JGFk3UXK9gihIF+
         yS59VYvgidBAEq9hRQ3kc5BPXQuoJEoA2f6mXSojC1iz7M4w1nmn/S/TNOGEKdzbLP7n
         tCUPHDMhIQ7mrxrDTHm3zx9iIT7shIbdFz2GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rA8teKiCQvBpv/jfjC2a7MA/lCNZKpqm0xO+S8oLkqM=;
        b=XveO3VxmSqt07li1r7m8y6rAwDRaDSCJ3RnxRcsuCJjBWBhkeQRkvwPHTGIfrtBM1D
         clJxTIaX5fwlDG8rQ7BFHCAMSsvZm++Jv5j/Z1RIQ2sQF5Mb+mdHZC0wC2yzuwWSsmY5
         65Rq7zG83kLPwHBngQZLayA3HsmwvXbEabzqks1uf9soyWjXBPa2qculLHgx3EFnxhsx
         UkleQ75M9XW5p90HB7wSAwjipzVFeov1DB3anWd6oQ2PcRyoPxUa2VMSEl76AesWLsZF
         txVidjn+0LGHsuM3BvPTPXQ90RHI5HEa+dBpAh9lAM8JxL0D89RBNMt9LXziNHb31e/3
         Fu8A==
X-Gm-Message-State: AA+aEWYAC/pnBlvaPD356ALo0kdSDUoLX/eoy0DH0WJ+bSIAjlCa677Z
        nQUF5NxNoy80iCx2QLGV4IcaeA==
X-Google-Smtp-Source: AFSGD/UYdiFVj+9m/cqZ0SaVersMLTUha7XyliP7JunYTdoPuXWcGMWWqcUG/I8FWhybcV+WFxCHSw==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr10854223wmb.115.1545039999082;
        Mon, 17 Dec 2018 01:46:39 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:38 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 02/13] mbox: qcom: add APCS child device for QCS404
Date:   Mon, 17 Dec 2018 10:46:19 +0100
Message-Id: <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is clock controller functionality in the APCS hardware block of
qcs404 devices similar to msm8916.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index aed23ac..dc8fdab1 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
-		apcs->clk = platform_device_register_data(&pdev->dev,
-							  "qcom-apcs-msm8916-clk",
-							  -1, NULL, 0);
-		if (IS_ERR(apcs->clk))
-			dev_err(&pdev->dev, "failed to register APCS clk\n");
-	}
-
 	platform_set_drvdata(pdev, apcs);
 
+	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
+	    of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
+		goto register_clk;
+
+	return 0;
+
+register_clk:
+	apcs->clk = platform_device_register_data(&pdev->dev,
+						  "qcom-apcs-msm8916-clk",
+						  -1, NULL, 0);
+	if (IS_ERR(apcs->clk))
+		dev_err(&pdev->dev, "failed to register APCS clk\n");
+
 	return 0;
 }
 
-- 
2.7.4

