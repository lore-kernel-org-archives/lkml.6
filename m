Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9584CECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2D2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViIImC8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE2D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeIQFKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37474 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbeIQFKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:43 -0400
Received: by mail-io1-f65.google.com with SMTP id v14-v6so10076657iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mLIm+CPnzkl6UQkh/tstY1IOawXp7bQelRcUAvyv2I=;
        b=ViIImC8M62l8kYkhVQwEsX4r/wgwu8DdANBxBs04jgwnNbnAkbTwz5mpfspMX9wsJ8
         Hv6XZri5hqvK8P7Sdo41iFU3IGqrJpukxmRxMXX4uvpexOLSUw5udG1JmfRNMKpJpw4y
         E8MKKrrmfGScUPrB99QUPsbefI8C/1Kbs8GWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mLIm+CPnzkl6UQkh/tstY1IOawXp7bQelRcUAvyv2I=;
        b=O6UrsgV/x38z+xK5NqwmtTSemwl8ydS6Qh0PTqPTVeGqAoqEQvquoXc868R+bCd7m8
         SR6QQn05PRede9mgXJNem6DNtgcGqHVp4cqSX7T7iLOcjZGMUc+l1K/G/KrRnoM9/6h8
         h9cvkwnbA24FM+58TWGuxNynAKGV8PC3WNl+n4nM5uaEju2jHgxIYFsO9xVPDoOzqKrp
         qaw13kgLCPFrnvxpQgL6biBUkdeSqyhRPr92ZuAZTAusTFlJVdWf5MN96bOwhILvbXVH
         9wW6vkeW1YszQ4NCAAasK8mB1cf7zVjnsL0+R6oOOff4uGHmFLOtim1/9eFU3rSjTVVP
         83Xw==
X-Gm-Message-State: APzg51DRvV6UOqbUlBSjAKAgahvGeykKk4xfSzpT7JUHwzgkBw5E4yAK
        UIYoNwfzHBT9TQJJiku3bP3DmA==
X-Google-Smtp-Source: ANB0Vdbnw4TiZfe+hVhh/m7DBCal0KaHSVpO0aez7tkwWYq0SVS+bJBhQS8zf5vdnmO5JhIVUuq2pg==
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr18643055iof.173.1537141562485;
        Sun, 16 Sep 2018 16:46:02 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:46:02 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] silmbus: ngd: register controller after power up.
Date:   Sun, 16 Sep 2018 16:45:44 -0700
Message-Id: <20180916234546.29661-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Register slimbus controller only after finishing powerup sequnce so that we
do not endup in situation where core starts sending transactions before
the controller is ready.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index b9f2e3f..0241373 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1238,8 +1238,17 @@ static int qcom_slim_ngd_enable(struct qcom_slim_ngd_ctrl *ctrl, bool enable)
 			pm_runtime_resume(ctrl->dev);
 		pm_runtime_mark_last_busy(ctrl->dev);
 		pm_runtime_put(ctrl->dev);
+
+		ret = slim_register_controller(&ctrl->ctrl);
+		if (ret) {
+			dev_err(ctrl->dev, "error adding slim controller\n");
+			return ret;
+		}
+
+		dev_info(ctrl->dev, "SLIM controller Registered\n");
 	} else {
 		qcom_slim_qmi_exit(ctrl);
+		slim_unregister_controller(&ctrl->ctrl);
 	}
 
 	return 0;
@@ -1361,11 +1370,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	int ret;
 
 	ctrl->ctrl.dev = dev;
-	ret = slim_register_controller(&ctrl->ctrl);
-	if (ret) {
-		dev_err(dev, "error adding slim controller\n");
-		return ret;
-	}
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
@@ -1375,7 +1379,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		goto err;
+		return ret;
 	}
 
 	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
@@ -1387,8 +1391,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-err:
-	slim_unregister_controller(&ctrl->ctrl);
 wq_err:
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
@@ -1460,7 +1462,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	slim_unregister_controller(&ctrl->ctrl);
+	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
-- 
2.9.3

