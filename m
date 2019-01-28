Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78EAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7445920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBkjHG8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfA1Sd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:33:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38030 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfA1SdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so15107129wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RRgZHYe/sVOgOfTVgbFLvS25NV8X1dawYq/ksWlnIWI=;
        b=aBkjHG8f4o7l4eAKKLn0A5CYBd6ZjbqSwcMHrsKnKYYsX+97CiBkCBRosG00FDtOec
         6bj0G87MmFaIKC27H2bBs+H41I3bzjfQof/VXxY65M62SBLpVr3H1oeLoz6tIVhdXu1C
         fA825X/ocmyVr9XKqUYCZitYuJ7skV1pTC4Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RRgZHYe/sVOgOfTVgbFLvS25NV8X1dawYq/ksWlnIWI=;
        b=ecsOb1VjhCqIcUgfZS5kSv+MJyDuks3774ZcX99TdK4Y4Jqr0f2k+R9rnSptjwi0SM
         7Imqv3rDMLpcHlrPtSac+r4luf76m9lAu6WvjnitqdCG3HdgfyPC4Vdfh/Hjy1kPlhnd
         byeSWn+MFEGsXJOntem4dgfhw+/JtMCTXud4k/lNbKTuE+cISyXZqAJUjYnWcnVdB4Qn
         AsTPbPIL0TylLdHo6axlEEp7R35XlM0YER+4HcQ60W/M2PLPrJp4iTfCSUHTqEDAJjDF
         pjX47YCx44xuPUlhJyeYtB+GN/kiNYcvJh/ixit2ewamNSzW8sSHS0cv++n+7FtBUDJ7
         8IyQ==
X-Gm-Message-State: AJcUukeGek0C64qvebONaHVQxK+LU3alTHxUWe0Picaonfhac4gOQynx
        ZDtGSqeTBfIrDdxe2EGPropwqA==
X-Google-Smtp-Source: ALg8bN6cE9J4XbUBm/UdlGabrLL56GfQlK48Skq315vXOb+ojjzflSNy6lUxVrSh2ha2PeblIBB66g==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr18771984wme.6.1548700401391;
        Mon, 28 Jan 2019 10:33:21 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:20 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 03/14] mbox: qcom: replace integer with valid macro
Date:   Mon, 28 Jan 2019 19:32:50 +0100
Message-Id: <1548700381-22376-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct macro when registering the platform device.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0d64aa5..7a1b4ff 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 register_clk:
 	apcs->clk = platform_device_register_data(&pdev->dev,
 						  "qcom-apcs-msm8916-clk",
-						  -1, NULL, 0);
+						  PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(apcs->clk))
 		dev_err(&pdev->dev, "failed to register APCS clk\n");
 
-- 
2.7.4

