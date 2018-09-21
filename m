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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4957ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02B21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgaB21sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02B21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbeIUP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:59:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389630AbeIUP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:59:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so12286468wre.2;
        Fri, 21 Sep 2018 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+k8VQnKn4mutcliPiNEY+rHvbFqnNR24naQdY6mjm90=;
        b=JgaB21sWBO6OpxFqgWMQavCm/A+X6hF2JaWSmFzpr9+DEbV3NPYZAo6KEEi1QV7S4l
         3kiX+GyqwgTUmLIuqpuxQ47J+RiziJF5OCp8/F2FGB4oeau5V7GalasRrLeGfVmkoBFm
         2JeTjYbXWjbB33uI/bN1KTeMHokqGRZ5iAg2bWcOP5PKuDKFEetg6zmHd8t/7WCzr7Be
         K+FKWD/D85Nyd7LiIs+XquKiRaJUY7MZLlcRsrpDuHsinvdIXXF4pb3LheT/HU3AmgK8
         em5UWTQTL9HqHUPN39qPdFcO59XZxzSt+JoAvmHNUeZH1NLuPk2D6BeJ6aq3w00mnjB7
         t73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+k8VQnKn4mutcliPiNEY+rHvbFqnNR24naQdY6mjm90=;
        b=fwWJLvt5yMuIrS9VV5kSYkYarTYRxhjRsTZTaXYEjfzroBA1HwlVpoy8utMWg/mi+R
         6swYLR1f3LUNgn0W4JYdMtRkLWJKCYXp3PU/7+gh/a6ir5kJ6QqtWeFjxI+NPegkZUkN
         HCS16PR0u5YklMuSqnsyD8GkAFGND3GnQnWDQN1pW+aEnBah0QkJBmkQxW7ddQRLRf3O
         oZtHhF35xxE1qKh1IvvdNMkUjDcBty3GNwumygM7CM0xM/1Ak4BnpiO9lz8oCxq1PLZC
         XUZk9mOI3VXPSvWzky6hCDpyqyCxmYfPpnpK4s1cFuxbF5M3OFbYSEgGhwpbQ1TG6Ok6
         CV7w==
X-Gm-Message-State: APzg51CoEq8YYoVUsP6lgM7n40jXUVYoSwuUOuDLkzPjKnhDLgDG7jTb
        R8epjFrbgpJXtuvOEd/YUEKgpXe6
X-Google-Smtp-Source: ANB0VdYFCd5AGIaBmfOSFeAXSVTGl/SCbnuZdUzCs9onEUmGa3tY41jBtKH3YnN7Vd4CyW57J1Ta2A==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr36970485wrm.143.1537524651799;
        Fri, 21 Sep 2018 03:10:51 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id j191-v6sm4618354wmb.37.2018.09.21.03.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:10:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: pwm-fan: Set fan speed to 0 on suspend
Date:   Fri, 21 Sep 2018 12:10:48 +0200
Message-Id: <20180921101048.11679-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921101048.11679-1-thierry.reding@gmail.com>
References: <20180921101048.11679-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Technically this is not required because disabling the PWM should be
enough. However, when support for atomic operations was implemented in
the PWM subsystem, only actual changes to the PWM channel are applied
during pwm_config(), which means that during after resume from suspend
the old settings won't be applied.

One possible solution is for the PWM driver to implement its own PM
operations such that settings from before suspend get applied on resume.
This has the disadvantage of completely ignoring any particular ordering
requirements that PWM user drivers might have, so it is best to leave it
up to the user drivers to apply the settings that they want at the
appropriate time.

Another way to solve this would be to read back the current state of the
PWM at the time of resume. That way, in case the configuration was lost
during suspend, applying the old settings in PWM user drivers would
actually get them applied because they differ from the current settings.
However, not all PWM drivers support reading the hardware state, and not
all hardware may support it.

The best workaround at this point seems to be to let PWM user drivers
tell the PWM subsystem that the PWM is turned off by, in addition to
disabling it, also setting the duty cycle to 0. This causes the resume
operation to apply a configuration that is different from the current
configuration, resulting in the proper state from before suspend getting
restored.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/hwmon/pwm-fan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 936aaf76dd6e..7da6a160d45a 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -294,9 +294,19 @@ static int pwm_fan_remove(struct platform_device *pdev)
 static int pwm_fan_suspend(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct pwm_args args;
+	int ret;
+
+	pwm_get_args(ctx->pwm, &args);
+
+	if (ctx->pwm_value) {
+		ret = pwm_config(ctx->pwm, 0, args.period);
+		if (ret < 0)
+			return ret;
 
-	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
+	}
+
 	return 0;
 }
 
-- 
2.19.0

