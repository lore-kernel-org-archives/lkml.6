Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17755C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07C421473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQl0fNX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07C421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeJEWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45105 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeJEWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so8219509ljc.12;
        Fri, 05 Oct 2018 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZYrX2cHrRHO72sYFW2dQ4W2aTFd9QrYyocgaRcj5ck=;
        b=TQl0fNX4yPOWF2SJpV+MT7CIPzVMrllXlQvz7PDLOYb2ERjR3w62saoMlpwc8ZNPXI
         6ScVzRt7391Bk/TcSYb/vTjMulT27hAoz5Wfhnx14uP1S9jEY1++c5/3WBtTpHCREQj5
         qXpQgcrporgo/RhSxIzwKfvgkDWjVqpxeESt6IflJX4YFefhcu1QX/dPSI5X3CiCwUPX
         j0HlOnrPTzbg8UvsENr0CRr5+ZYU/6CdU8U2BPQd9K8Fm/OITK2VVDkk/OF0zRsZzqvd
         aJcXz87MRr8UayzOpeiGX4xqDLWEZo4xlWvds+DX4Qam2ST4reTvmDebR2t8zUYduLrl
         e2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZYrX2cHrRHO72sYFW2dQ4W2aTFd9QrYyocgaRcj5ck=;
        b=DsepQ2hLhiOJIDUI5+e/KW6a4LSh84bnpExSchk8OBSvKyePHgMszDlWafw/TsIN4u
         6rTXuX0/MfoCYh/JFcfEOW//OYbpi4rGnZGaRn4l3dbPDKvvp1LT4mI+/BkuYNe3Hy5f
         wCRJ4On/sR+6P+rm9n7KqaulwTrD4tjQ3kOSD8lcOlZNvtAN1+GJdx5e4Cv3h6ViI3Z1
         QXp4xNo5Of+ZJEGtrs6+R/Mek0ZiAN1Qlh16Z2c/4E88gxBoZQog6yeTVL6tIw5YTFkj
         5AK2qylCcdTvu1aAMI4aCNjLrTxlcX2DaUIhvVvUz4d9OYdz3PWBOIjwG1jxYzIs6M00
         a2WQ==
X-Gm-Message-State: ABuFfohtt0oEzjZ3UdXEE492/e6Jjs8Rbm2jHoFBD0h3mBLTfkEsQMeo
        cTYp3cBE2/I1JKBF9s7HbPE=
X-Google-Smtp-Source: ACcGV62DaIGEh6vJplL1djjMuCC+EO8ZG/zZQCkX3xeVZHKZkoyxJTd5FYJdmVY6RBfEHEwh7Femmw==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr831598ljg.114.1538753876464;
        Fri, 05 Oct 2018 08:37:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 03/11] regulator: core: Mutually resolve regulators coupling
Date:   Fri,  5 Oct 2018 18:36:30 +0300
Message-Id: <20181005153638.1886-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If registered regulator found a couple, then the couple can find the
registered regulator too and hence coupling can be mutually resolved
at the registration time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 54 +++++++++++++---------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5105eaaf3cef..925df9e6f1e3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4439,7 +4439,7 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
-static int regulator_fill_coupling_array(struct regulator_dev *rdev)
+static void regulator_resolve_coupling(struct regulator_dev *rdev)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled = c_desc->n_coupled;
@@ -4453,33 +4453,21 @@ static int regulator_fill_coupling_array(struct regulator_dev *rdev)
 
 		c_rdev = of_parse_coupled_regulator(rdev, i - 1);
 
-		if (c_rdev) {
-			c_desc->coupled_rdevs[i] = c_rdev;
-			c_desc->n_resolved++;
-		}
-	}
-
-	if (rdev->coupling_desc.n_resolved < n_coupled)
-		return -1;
-	else
-		return 0;
-}
+		if (!c_rdev)
+			continue;
 
-static int regulator_register_fill_coupling_array(struct device *dev,
-						  void *data)
-{
-	struct regulator_dev *rdev = dev_to_rdev(dev);
+		regulator_lock(c_rdev);
 
-	if (!IS_ENABLED(CONFIG_OF))
-		return 0;
+		c_desc->coupled_rdevs[i] = c_rdev;
+		c_desc->n_resolved++;
 
-	if (regulator_fill_coupling_array(rdev))
-		rdev_dbg(rdev, "unable to resolve coupling\n");
+		regulator_unlock(c_rdev);
 
-	return 0;
+		regulator_resolve_coupling(c_rdev);
+	}
 }
 
-static int regulator_resolve_coupling(struct regulator_dev *rdev)
+static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
 
@@ -4519,13 +4507,6 @@ static int regulator_resolve_coupling(struct regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
-	/*
-	 * After everything has been checked, try to fill rdevs array
-	 * with pointers to regulators parsed from device tree. If some
-	 * regulators are not registered yet, retry in late init call
-	 */
-	regulator_fill_coupling_array(rdev);
-
 	return 0;
 }
 
@@ -4662,11 +4643,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
-	ret = regulator_resolve_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
-
-	if (ret != 0)
+	ret = regulator_init_coupling(rdev);
+	if (ret < 0)
 		goto wash;
 
 	/* add consumers devices */
@@ -4700,6 +4678,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	rdev_init_debugfs(rdev);
 
+	/* try to resolve regulators coupling since a new one was registered */
+	mutex_lock(&regulator_list_mutex);
+	regulator_resolve_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	/* try to resolve regulators supply since a new one was registered */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
@@ -5155,9 +5138,6 @@ static int __init regulator_init_complete(void)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
 
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_register_fill_coupling_array);
-
 	return 0;
 }
 late_initcall_sync(regulator_init_complete);
-- 
2.19.0

