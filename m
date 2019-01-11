Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CCA2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YU+p55Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfAKFHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:07:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfAKFHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:07:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so6220051plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
        b=YU+p55SeJnQIgHec7XAyUbKnjGviwd9lj4/hjGV7pU0JlBvGpr7fB2OPSIizePumQw
         A4QA0cX9oN2AWA1N5HGcX9xtpBFGPE4giN6v0VK7Wj4rEJ9J/v+BW1Tc/dnmb0///afD
         j3Ci7u4e237aDGZcBMtvnC1PYNfiKPlzKx4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
        b=hiWmbila9lmME4bXBVScvoozvZT8Ny0KuFC7uSJTO25ky7i48W9iZIx1GvEiy9olpE
         jpPGZBLtm7rnBC00royEoW4gN0fRoPQWfTD3WNYxXP6r9HsJUSYUSREfQkrdvl0Dcs8j
         XVdxMfGBGK1iYtpKOB8cb9567l2O1GALTlV7ddN+I/uFedXOr/0u59yaPgjmyDNm9UP6
         v7ggpBTeHMi9eRTq2Q7nPU9VmxMx1swS3v8iD9pZwZcmi8ar9/VMIZ0Ayl3b9L2NQzzN
         NESASSb2UaRqxiE/it+Jyz0LgYt0m/1KpLyFNv2wtuw0tEqQdwxicSSuTVY5qkpk8SXz
         XZDw==
X-Gm-Message-State: AJcUuke/xfYdCyXHLhO60+lEbj5g4troI7+cmo8EYj0PjYaPJ83QdWVe
        yMUhvjjFVzFbY6qndUwhxqnDpQ==
X-Google-Smtp-Source: ALg8bN6qXpH5ZU7dI/TegGYCFj13wZx36FSvwK3yp9r91sma0olWBDoJ00hBgaT6WmO/9zi0rJq7RA==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr13388395pld.181.1547183270812;
        Thu, 10 Jan 2019 21:07:50 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:07:50 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH INTERNAL V3 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Date:   Fri, 11 Jan 2019 10:38:03 +0530
Message-Id: <1547183284-19956-3-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add support for new version of pwm-kona.
Add support to make PWM changes configured and stable.

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 30 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95ae..2b44ad8 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -45,30 +45,39 @@
  *    high or low depending on its state at that exact instant.
  */
 
-#define PWM_CONTROL_OFFSET			(0x00000000)
+#define PWM_CONTROL_OFFSET			0x00000000
 #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
 #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
 #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
 #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
 
-#define PRESCALE_OFFSET				(0x00000004)
+#define PRESCALE_OFFSET				0x00000004
 #define PRESCALE_SHIFT(chan)			((chan) << 2)
 #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
-#define PRESCALE_MIN				(0x00000000)
-#define PRESCALE_MAX				(0x00000007)
+#define PRESCALE_MIN				0x00000000
+#define PRESCALE_MAX				0x00000007
 
 #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
-#define PERIOD_COUNT_MIN			(0x00000002)
-#define PERIOD_COUNT_MAX			(0x00ffffff)
+#define PERIOD_COUNT_MIN			0x00000002
+#define PERIOD_COUNT_MAX			0x00ffffff
 
 #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
-#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
-#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
+#define DUTY_CYCLE_HIGH_MIN			0x00000000
+#define DUTY_CYCLE_HIGH_MAX			0x00ffffff
+
+#define PWM_MONITOR_OFFSET			0xb0
+#define PWM_MONITOR_TIMEOUT_US			5
+
+enum kona_pwmc_ver {
+	KONA_PWM_V1 = 1,
+	KONA_PWM_V2
+};
 
 struct kona_pwmc {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
+	enum kona_pwmc_ver version;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
@@ -76,11 +85,40 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
 	return container_of(_chip, struct kona_pwmc, chip);
 }
 
+static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
+				 unsigned int kona_ver)
+{
+	struct kona_pwmc *kp = to_kona_pwmc(chip);
+	unsigned int value;
+	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
+
+	switch (kona_ver) {
+	case KONA_PWM_V1:
+		/*
+		 * There must be a min 400ns delay between clearing trigger and
+		 * settingit. Failing to do this may result in no PWM signal.
+		 */
+		ndelay(400);
+		return 0;
+	case KONA_PWM_V2:
+		do {
+			value = readl(kp->base + PWM_MONITOR_OFFSET);
+			if (!(value & (BIT(chan))))
+				return 0;
+			ndelay(1);
+		} while (count--);
+
+		return -ETIMEDOUT;
+	default:
+		return -ENODEV;
+	}
+}
+
 /*
  * Clear trigger bit but set smooth bit to maintain old output.
  */
-static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
-	unsigned int chan)
+static int kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
+					  unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -88,14 +126,10 @@ static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
 	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/*
-	 * There must be a min 400ns delay between clearing trigger and setting
-	 * it. Failing to do this may result in no PWM signal.
-	 */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
-static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+static int kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -104,8 +138,7 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/* Trigger bit must be held high for at least 400 ns. */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
 static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -115,6 +148,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 val, div, rate;
 	unsigned long prescale = PRESCALE_MIN, pc, dc;
 	unsigned int value, chan = pwm->hwpwm;
+	int ret;
 
 	/*
 	 * Find period count, duty count and prescale to suit duty_ns and
@@ -156,7 +190,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * validated immediately instead of on enable.
 	 */
 	if (pwm_is_enabled(pwm)) {
-		kona_pwmc_prepare_for_settings(kp, chan);
+		ret = kona_pwmc_prepare_for_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev, "failed to prepare pwm settings: %d\n",
+				ret);
+			return ret;
+		}
 
 		value = readl(kp->base + PRESCALE_OFFSET);
 		value &= ~PRESCALE_MASK(chan);
@@ -167,7 +206,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
 
-		kona_pwmc_apply_settings(kp, chan);
+		ret = kona_pwmc_apply_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev, "failed to apply settings: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -187,7 +231,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+	ret = kona_pwmc_prepare_for_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return ret;
+	}
 
 	value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -198,7 +246,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
+	ret = kona_pwmc_apply_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to apply pwm settings: %d\n", ret);
+		return ret;
+	}
 
 	clk_disable_unprepare(kp->clk);
 
@@ -231,8 +283,13 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
 	unsigned int value;
+	int ret;
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+	ret = kona_pwmc_prepare_for_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return;
+	}
 
 	/* Simulate a disable by configuring for zero duty */
 	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
@@ -243,7 +300,11 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	value &= ~PRESCALE_MASK(chan);
 	writel(value, kp->base + PRESCALE_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
+	ret = kona_pwmc_apply_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return;
+	}
 
 	clk_disable_unprepare(kp->clk);
 }
@@ -256,14 +317,26 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	.owner = THIS_MODULE,
 };
 
+static const struct of_device_id bcm_kona_pwmc_dt[] = {
+	{ .compatible = "brcm,kona-pwm", .data = (void *)KONA_PWM_V1},
+	{ .compatible = "brcm,kona-pwm-v2", .data = (void *)KONA_PWM_V2},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
+
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
 	struct kona_pwmc *kp;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
+	of_id = of_match_node(bcm_kona_pwmc_dt, pdev->dev.of_node);
+	if (!of_id)
+		return -ENODEV;
+
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (kp == NULL)
 		return -ENOMEM;
@@ -276,6 +349,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.npwm = 6;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
+	kp->version = (enum kona_pwmc_ver)of_id->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kp->base = devm_ioremap_resource(&pdev->dev, res);
@@ -322,12 +396,6 @@ static int kona_pwmc_remove(struct platform_device *pdev)
 	return pwmchip_remove(&kp->chip);
 }
 
-static const struct of_device_id bcm_kona_pwmc_dt[] = {
-	{ .compatible = "brcm,kona-pwm" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
-
 static struct platform_driver kona_pwmc_driver = {
 	.driver = {
 		.name = "bcm-kona-pwm",
-- 
1.9.1

