Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D935217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkpJ1OAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAYSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35495 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAYSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so9223933ljb.2;
        Fri, 25 Jan 2019 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndbUj8k5FEYEV1SSU+gmxNi3BMlfpk8Kj/4PsfHlJtY=;
        b=IkpJ1OAAueblmBPrHgc6Ervs5VNIaz0M3Xvrt91XyQWhkRWmCrFtZu+SnuR4t4DTLq
         5bidoE1XlDAum/4t6KMGdUdZ7oN4L7ACcDiT5kysQ99wWLcFrPRN1qODzrscvIKJnZCX
         6ZrLeRadGTnVPuvaf9AFCPeswPq/wSuyA47BWKlYpwgp6NaXLcbKijcvk59345LXUJIw
         LH2mHvV77JttB+lr1DeZSqeEWLCBylH+275cs3h9nzUGsAcLU9jFQGmLbpR1WZhCrq+s
         FppnxfhtVzwohlRdwe2aYdDr+NiBbh6VIH1JSIb9LDZx+xmcJ9huYGg4qVS0ITs/UzYk
         btBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndbUj8k5FEYEV1SSU+gmxNi3BMlfpk8Kj/4PsfHlJtY=;
        b=Rw0in3TKydPQECO0RPEqytVSciFUt6imkSsRdUpNYkOVI8djaqVanuGoDovSb1NcUx
         EpDy4PL/XQgmz9gU5nEOjkzK1hk8Ge3LMwObuNTipcKBpgJHO5qeLZOQ1X/LbMzIXH1W
         a+/RwfbXw74ruLWOc5wsSBe4ftKS7DrmncoI+qGFj0ja99sj+DNHkcL4hobsJ7TpyU34
         V2omuq7HI1Kre6KzaYmz6KUZ/Tb9Ia8cH/byW8KDouvtB+q9kp6k8g+bEmU9znSzki++
         ySQq6I/M1uijviifzQIukIR3Am/TaXKrpEtKhmTA/QYhLkKIWPhU9+YjU5WXTXPpRFG5
         hMOQ==
X-Gm-Message-State: AJcUukdK+lJ4hGY9vMxXo52lTXb2IlDzRfpHKSQnItGQnWNsfUPlQ5BT
        FXWg8jQah3z4tMHaUKHSzS0=
X-Google-Smtp-Source: ALg8bN5r3USNaclBvDvS1n2+0V88IrY6OIZMEj0WkGxmoCR/8BFO7vZqE1W5oBByGhEOulEkZSwKsg==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr9612381lje.117.1548441846191;
        Fri, 25 Jan 2019 10:44:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id f18sm1715432lfk.18.2019.01.25.10.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:44:05 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] input: misc: bma150: Add support for device tree
Date:   Fri, 25 Jan 2019 19:43:59 +0100
Message-Id: <20190125184400.17669-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add basic of_match table to enable bma150 to be probed via DT

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index d101bb0a33d6..c26a118d89fa 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/bma150.h>
@@ -628,6 +629,14 @@ static int bma150_resume(struct device *dev)
 
 static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id bma150_of_match[] = {
+	{ .compatible = "bosch,bma150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bma150_of_match);
+#endif
+
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
 	{ "smb380", 0 },
@@ -640,6 +649,7 @@ MODULE_DEVICE_TABLE(i2c, bma150_id);
 static struct i2c_driver bma150_driver = {
 	.driver = {
 		.name	= BMA150_DRIVER,
+		.of_match_table = of_match_ptr(bma150_of_match),
 		.pm	= &bma150_pm,
 	},
 	.class		= I2C_CLASS_HWMON,
-- 
2.17.1

