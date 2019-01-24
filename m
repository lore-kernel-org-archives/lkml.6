Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09537C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BCC2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAVLp9UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfAXU2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:28:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52821 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfAXU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:27:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so4598043wml.2;
        Thu, 24 Jan 2019 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr4/BbRpVEWQXv12T0zxMGq0I9UYwLzSU2BFQ7EQtWo=;
        b=YAVLp9UNpipnUuEYY1divL9x2JIffPUh/yilFiykASCoTmsRmQAlEYPLp/XOIEj45Z
         XYt3BDjvOzD9ubbfQU6kILfEmN5hBpvVCGJ+JsXWZmB/znf1H24g/8EXl7pujhIRJ/3h
         9xaGj0mKZM5X45j7H175N63igszfLbvtcgvY/1yfAwDjj+pNGBWGXgF4xFIxSaAI4Cay
         L88BpdB+6twXFjZlpqGihqGdZDX+NQfB/9iBPPMdZ9uSEphsdEwbMnpuZC3jnPLjK3VY
         VCA6tTGQivauEjygZCJCOBCk4ukpfHJR5VfC55MF3DK8YuSwy3rW8jA1hQE1Bl0oByrZ
         SfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr4/BbRpVEWQXv12T0zxMGq0I9UYwLzSU2BFQ7EQtWo=;
        b=bft6aI8/plQGBOzia4uNM+bWAn5ig6cIUs/QcSKoVYXdvIL1jB4qE2N45rIjdEHDDQ
         vtJ/6Yc55sH1QhyDaiYOaKOh4LxUE+ZE1j42VcAYg8I0faYc2/xu+pIC2/aWZa8fp3QM
         7VV3xZSYNhTYtnANgrd9xK7h7Gun5P8R61SMkvfAb9aOSU7T/0VKRmb81JitWlvJGElV
         +Us6vY6ALfgqyE8PNmtKltjhxtgJzKuzCkdrSGUCwdtD3YglqREHPAkXuve+z4+5Kze7
         b87crFCQJVM8lvvOxMCdB28nYRIJStskl3D4rTv0i9m2tiINtdZV/B6jy3gYF+XMyGHv
         dbCg==
X-Gm-Message-State: AJcUukc4TXyow0TGdS1qDxYQZhBk1KzXM5RJhbNudadhCzanJIxO399Z
        VUZbAzzL5kFw055CJd3XLp8=
X-Google-Smtp-Source: ALg8bN52vADhE4joaXEfF03VuaO6b8ln2Y9GQHJZdE0nkDrwrK89XJ52/dVjPM6VmBUwI1oAMwzL7w==
X-Received: by 2002:a1c:ae15:: with SMTP id x21mr4084973wme.146.1548361677237;
        Thu, 24 Jan 2019 12:27:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:9dbf:5832:1d37:55b2])
        by smtp.googlemail.com with ESMTPSA id g67sm128617960wmd.38.2019.01.24.12.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:27:56 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] input: misc: pwm-vibra: Prevent unbalanced regulator
Date:   Thu, 24 Jan 2019 21:27:31 +0100
Message-Id: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

pwm_vibrator_stop disables the regulator, but it can be called from
multiple places, even when the regulator is already disabled. Fix this
by using regulator_is_enabled check when starting and stopping device.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Rather than using regulator_is_enabled api, use local flag for
    checking if regulator is enabled
---
 drivers/input/misc/pwm-vibra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 55da191ae550..9df87431d7d4 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -34,6 +34,7 @@ struct pwm_vibrator {
 	struct work_struct play_work;
 	u16 level;
 	u32 direction_duty_cycle;
+	bool vcc_on;
 };
 
 static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
@@ -42,10 +43,13 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	struct pwm_state state;
 	int err;
 
-	err = regulator_enable(vibrator->vcc);
-	if (err) {
-		dev_err(pdev, "failed to enable regulator: %d", err);
-		return err;
+	if (!vibrator->vcc_on) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
+		vibrator->vcc_on = true;
 	}
 
 	pwm_get_state(vibrator->pwm, &state);
@@ -76,7 +80,10 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
-	regulator_disable(vibrator->vcc);
+	if (vibrator->vcc_on) {
+		regulator_disable(vibrator->vcc);
+		vibrator->vcc_on = false;
+	}
 
 	if (vibrator->pwm_dir)
 		pwm_disable(vibrator->pwm_dir);
-- 
2.17.1

