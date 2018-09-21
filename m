Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77396ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AE521531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXpjSgMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AE521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbeIUP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:59:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:59:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id f21-v6so2436291wmc.5;
        Fri, 21 Sep 2018 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0vxQJrW8p1Rec88UNy3atst5yfRwb5Gz6J6VEWXW1g=;
        b=IXpjSgMSsRFOr0yT84YLfMHz2TWtSajozPAlR2jJD7qxWsMdjujQhRZfeRuBZmx3q2
         lYtf5bxBABjQe+pyip5fL/rqG9XWahG2vnn/j8NZyV7Z4ZX5wwxqKTa3j+UVwcCPZQoN
         Hx4CzeNhXeUjTGoI5HcVxcVciOlupDwAgXzVfJ7TY76gcaJbgWsheXT+uATDGVZorhlg
         ENEk9A9uKiek66NcbJJGHEwrajz0+ULXq1emw0rcgQoGLQH0PSvpJCSgfKI5TMC9QH1+
         nDmywmgVQA1DOV/i3CUgREPesXU0nMEMktYpisd9+Sxm9n8HAGiLyFPpaoofizuVYIW6
         0Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0vxQJrW8p1Rec88UNy3atst5yfRwb5Gz6J6VEWXW1g=;
        b=FmK5C3PgBeWkeAjXwKsgx0QKdInfzKw7lZCjQSeb2Iyq4n+uwsQfLQZbH6Db5qvFaS
         1VbK19lOW8b+F9IHzZl15FGyy2mGMIPzMGfX+e/C5aJ3uQiweCEsTGXAqPyw+qr4wGCT
         OnQUqFYa8uUzOtYk43DGEt/FoMgjfCsJwqsri24CIRoX2rbEXPiv3uSjnmSxusLp2RKX
         nKlU1VFetht69RqT0dwkt2ttEoonnq7F0V+dA0dpRKI/pjVPLwJURfIETUMg6Ry4U5aZ
         8Ia9ZOcMi77rT0jGMwkcHmR4LO4PTDVaUI78xsmivnhOswuY2QJVuJScpehb8Z0zkyAh
         rCKw==
X-Gm-Message-State: ABuFfogo+bBwda2PCA5AF3tZyDX0OjvlniXWIVQY1/WEnoVGj8sqR33B
        etKqCjWBR9hTQO8fnHzvYAg=
X-Google-Smtp-Source: ACcGV62BJh3VzPWnZsOR/88SPM6F00DDKb9KqRN4wvfosx8Y/PF4atj89M6eaIUWp+WCpNvduGxBpQ==
X-Received: by 2002:a1c:b404:: with SMTP id d4-v6mr6452893wmf.28.1537524650414;
        Fri, 21 Sep 2018 03:10:50 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id u1-v6sm19528013wrt.59.2018.09.21.03.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:10:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: pwm-fan: Silence error on probe deferral
Date:   Fri, 21 Sep 2018 12:10:47 +0200
Message-Id: <20180921101048.11679-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Probe deferrals aren't actual errors, so silence the error message in
case the PWM cannot yet be acquired.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/hwmon/pwm-fan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7838af58f92d..936aaf76dd6e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -221,8 +221,12 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
-		dev_err(&pdev->dev, "Could not get PWM\n");
-		return PTR_ERR(ctx->pwm);
+		ret = PTR_ERR(ctx->pwm);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
+
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, ctx);
-- 
2.19.0

