Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADCAC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFC20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UaRqvkoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfAUShn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:37:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfAUShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:37:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6794206wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvDjW2J5ri+L1/t5EFcSwU+ZHLISGJXvHZow6RDENGk=;
        b=UaRqvkoNmHSnsc0tMky0m0e163SucC8NyO5xumxs0pjp1bei31WVInpKX+wnekzsOh
         LqOCTwkib3Z6OHOMmvCqHwTCvBkxQ2n4zUhEumBACxn/8ielPeTbZfqMsB2hYA2svRf9
         JxJxHfM/w1F9vvJRQa9pFjloDs/bqorc7DCfL3pGqfx+qBRsCTNk9Rur+0aA2pmiDRmG
         63gXtC5tXhvUt+1xQ9ucx51nHLoI4qkbNXGrLtdS0AtioN3xqElidqcwXa8p+l4xUJgc
         fOm84Q83Qwl3s6BrgswQ6BE4L2O5aDV2bLtgr81cOK1MOx3YHVRRnwSCEOozZR2D1IVm
         5pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvDjW2J5ri+L1/t5EFcSwU+ZHLISGJXvHZow6RDENGk=;
        b=gXPqltBbkXTKyWz/AzVMckdqBYa4nS+uJeXo6l6n0FLBrPmdQGtcYlHzekWx8kF+r8
         Yd7IDX2ha0HuWvuzenzs4n+PHl3wit19MURiSHZMssB3fntkBx2CF5xxPILNlk7nEJ85
         2eD84fph/imw5Ge/o5ibB1CAM4BYCPs32hcVUovT/mRXh5PwKO5u2GExKqLgkDncXiBm
         b87G+1h+VF0GWpUyvud3ujwBFHIK1P0P96tDYDaoNhyvz5ojsU/HpYJnYgeFsDBPTVbo
         9yPMGA67ynTnTwe2x3DqxPGJoK0iPRI6hoaawCimNePmkETdPyMNDf5xRibi9Kou3Xzh
         m5Cw==
X-Gm-Message-State: AJcUukegkIL2lnWv26MMaH/eQPnxWnT1HKW7K8V9UrRv6LKcONtsSgBp
        3r2SyOyKAAKXV2zrLTElemY=
X-Google-Smtp-Source: ALg8bN4xvcqQeupyAnI04ZNE9CTepqUx4xXne8UdCkoys+QsZSqtdQH5jyfZqxgZ7y6bLHK5M0Vosg==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr529576wmc.42.1548095855568;
        Mon, 21 Jan 2019 10:37:35 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73A8100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73a:8100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 199sm55700630wmh.21.2019.01.21.10.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:37:35 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        boris.brezillon@free-electrons.com, thierry.reding@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] regulator: pwm: suppress EPROBE_DEFER error message
Date:   Mon, 21 Jan 2019 19:37:23 +0100
Message-Id: <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress the "Failed to get PWM" error output if the actual error code
is EPROBE_DEFER. This makes the behavior of the pwm-regulator driver
consistent with what most other drivers do (which is: print all errors
except EPROBE_DEFER).

An example where this cleans up the kernel log are the 32-bit Amlogic
Meson boards:
multi_v7_defconfig has CONFIG_REGULATOR_PWM=y and CONFIG_PWM_MESON=m.
When booting such a board (for example the Meson8b Odroid-C1) the
following message is printed five times during boot:
  pwm-regulator regulator-vcck: Failed to get PWM: -517
On the sixth call the pwm-meson driver is finally loaded (as rootfs
becomes ready) and the "VCCK" pwm-regulator comes up fine.

Fixes: aa66cc6630a408 ("regulator: pwm-regulator: get voltage and duty table from dts")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/regulator/pwm-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 3f53f9134b32..7789d181ae67 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -357,7 +357,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+
 		return ret;
 	}
 
-- 
2.20.1

