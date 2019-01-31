Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA0C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F92218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjXoAcLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfAaJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:32:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42209 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbfAaJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:32:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1218299plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfC9+eAikTn1H/a1iW03wD6rYHQGLgaCvt1m7j56SP4=;
        b=NjXoAcLPt4BQXlvSgW9NNwbQfE3cDmurrkDmSsaM1U8DT6U76TteHgSH51Qx+20JoP
         +L+JbN1UOB19rGXfEY99O8O9MrhkLzNZGtOxdf6Uv+UJ+WFuBfC531jzHb4i4tE5wsTb
         q4WC3v9mUOtT+SfZjgzwY5j+K0lp3I77A9Sn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfC9+eAikTn1H/a1iW03wD6rYHQGLgaCvt1m7j56SP4=;
        b=bpg69l1djFEDiF6F8OgZjQ5UndmfHBl6ZTAnAGtRC61Z3WD5HJLL4dZWWCtx1KRP3t
         rR0nCjMV4etaTxKry9+qFmCieKfjicCWW/UzGzQBlnRhDxtfkJ+bx9sM2zfMuo4Dj6rO
         YszAnlADzykHSDUXHj2fDvA13rTRRVx8kcjjhVs2vkgSK4JiwCYqLBtMMBrRBHUZj6Z4
         z4n45FsqpHW3IiOdRA/c+JOJmz/Fx8u8wzi3K4WDzvDrTyQUrvSBRISZaXDlKjzrZCSp
         9W+cFJk/DUkgDRR0lQLXqCBqiypXqh+uk61OPAPPa8LwedDKD++Un+QDvuCBBD7TXN+x
         7fXw==
X-Gm-Message-State: AJcUuke/0h6vHdaLr+qoQeDdvyVuR4F/NXTFum5iZDJxTRK0EZK6OjtL
        7zsQgtC/fLDOyx2iA3VnnwGZ1w==
X-Google-Smtp-Source: ALg8bN6wW4zrbVPAvblq8kwrvUbjgmiVd/81UtpX8aPBr4uGV6KpmgeA3+p7dIenYGxwjGzm/UZ4CA==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11mr34892596plt.179.1548927122757;
        Thu, 31 Jan 2019 01:32:02 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:32:02 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/6] cros_ec: differentiate SCP from EC by feature bit.
Date:   Thu, 31 Jan 2019 17:31:30 +0800
Message-Id: <20190131093131.245531-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a SCP and EC would both exist on a system, and use the cros_ec_dev
driver, we need to differentiate between them for the userspace, or they
would both be registered at /dev/cros_ec, causing a conflict.

Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v3:
 - No change.

Changes from v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c            | 9 +++++++++
 include/linux/mfd/cros_ec.h          | 1 +
 include/linux/mfd/cros_ec_commands.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2d0fee488c5aa8..67983853413d07 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -414,6 +414,15 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "SCP detected.\n");
+		/*
+		 * Help userspace differentiating ECs from SCP,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588c8776da..fd297cf8f97295 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c357b..3e5da6e93b2f42 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU exposes a SCP */
+	EC_FEATURE_SCP = 39,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
2.20.1.611.gfbb209baf1-goog

