Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBCC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0443C21986
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVS2944z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0443C21986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeHEWOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so5783230pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7Nd3O7sGo6sZ4vJM8mnW0c4rn2Ly42ipcgyAN9gk2w=;
        b=lVS2944zufMrkgX8I++VvLqq4Kf4nrsGzlEjB+afKrTU+xTR1JFsulXALINaEudWM4
         GRejPPze392xqoWVtUjzZhdEwfD+5ufstXWrX315nw7fWDeG3Lv48dNIRTbX88CBma/K
         Ad8jLWw0j+GBDvnbTICVTwh/UBuloXiKzUxZRNEFR4vlgaTsMQ6PAFi5FcN7vnskYTK5
         FWue2Q/i2ve+pRZPsJQLjRko7bdZnYcDdvM0a31SphdAGJBN8RvMZczbAUuOMdniFZuG
         s3h9MpeUGQXLiNEvMu3WchP6t/ST7nMdL+lioJOUFrVulcjpN+PEyoqQd80rsLj0+14A
         6Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7Nd3O7sGo6sZ4vJM8mnW0c4rn2Ly42ipcgyAN9gk2w=;
        b=EWEtMSz602He8370hNbcU7cJ/QmBgVyRuiwSCfwzlzixp0Ovtl+9oPEbPxu+8gvAMC
         SzlzjMEw0lGbgz+Q14IPyQMxJjGRzPmcEedYcmDimZ5ULL058lecsAUMYmwzLhzs1zF7
         w1vvyC/LwSyb4L+JOWyXMqmwlBZVCNIQN1hx0f0T+3l9F2VwP6qH2aodEBEQT3sBE81l
         I7TpV7iK36iXTNtTGxV0SCQFu0MtMrLgkltxmXIScU/Ne1WukGroHIF97HfNLBbQbS5K
         BK+0NAHw2DWhRky+hhIhZMslNQvSqfApgxMygzxKBqKpRYRCwqxj1dQw+h1JpelMHB3n
         KQ3g==
X-Gm-Message-State: AOUpUlHwmjs6YLbwjaZmHO85AyUU+459cksB03IDNzjlyPIcBN9Vwzdf
        0hXCXA1KV7STV2y7RbgMVt8=
X-Google-Smtp-Source: AAOMgpfPZm662Mp2XQR6xbSFArDFgyj37UQmqh4iBC3QlMAkZir5agM50hdkK1HmNSRprJjQV2faqA==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr12200658pgc.344.1533499701339;
        Sun, 05 Aug 2018 13:08:21 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:20 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/15] staging: gasket: core: remove device enable and disable callbacks
Date:   Sun,  5 Aug 2018 13:07:39 -0700
Message-Id: <20180805200749.116693-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Device enable/disable operations are moving from being initiated through
the gasket framework to being initiated by the gasket device driver.
The driver can perform any processing needed for these operations before
or after the calls into the framework.  Neither of these callbacks are
implemented for the only gasket driver upstream today, apex.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c |  9 ---------
 drivers/staging/gasket/gasket_core.h | 27 ++-------------------------
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2741256eacfe8..b070efaf0d41c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -648,8 +648,6 @@ static void gasket_disable_dev(struct gasket_dev *gasket_dev)
 			gasket_page_table_cleanup(gasket_dev->page_table[i]);
 		}
 	}
-
-	check_and_invoke_callback(gasket_dev, driver_desc->disable_dev_cb);
 }
 
 /*
@@ -1408,13 +1406,6 @@ static int gasket_enable_dev(struct gasket_internal_desc *internal_desc,
 	}
 	gasket_dev->hardware_revision = ret;
 
-	ret = check_and_invoke_callback(gasket_dev, driver_desc->enable_dev_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in enable device cb: %d\n",
-			ret);
-		return ret;
-	}
-
 	/* device_status_cb returns a device status, not an error code. */
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
 	if (gasket_dev->status == GASKET_STATUS_DEAD)
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 9f9bc66a0daa0..5d40bc7f52e91 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -473,34 +473,11 @@ struct gasket_driver_desc {
 	 */
 	int (*device_close_cb)(struct gasket_dev *dev);
 
-	/*
-	 * enable_dev_cb: Callback immediately before enabling the device.
-	 * @dev: Pointer to the gasket_dev struct for this driver instance.
-	 *
-	 * This callback is invoked after the device has been added and all BAR
-	 * spaces mapped, immediately before registering and enabling the
-	 * [character] device via cdev_add. If this call fails (returns
-	 * nonzero), disable_dev_cb will be called.
-	 *
-	 * Note that cdev are initialized but not active
-	 * (cdev_add has not yet been called) when this callback is invoked.
-	 */
-	int (*enable_dev_cb)(struct gasket_dev *dev);
-
-	/*
-	 * disable_dev_cb: Callback immediately after disabling the device.
-	 * @dev: Pointer to the gasket_dev struct for this driver instance.
-	 *
-	 * Called during device shutdown, immediately after disabling device
-	 * operations via cdev_del.
-	 */
-	int (*disable_dev_cb)(struct gasket_dev *dev);
-
 	/*
 	 * sysfs_setup_cb: Callback to set up driver-specific sysfs nodes.
 	 * @dev: Pointer to the gasket_dev struct for this device.
 	 *
-	 * Called just before enable_dev_cb.
+	 * Called during the add gasket device call.
 	 *
 	 */
 	int (*sysfs_setup_cb)(struct gasket_dev *dev);
@@ -509,7 +486,7 @@ struct gasket_driver_desc {
 	 * sysfs_cleanup_cb: Callback to clean up driver-specific sysfs nodes.
 	 * @dev: Pointer to the gasket_dev struct for this device.
 	 *
-	 * Called just before disable_dev_cb.
+	 * Called during device disable processing.
 	 *
 	 */
 	int (*sysfs_cleanup_cb)(struct gasket_dev *dev);
-- 
2.18.0.597.ga71716f1ad-goog

