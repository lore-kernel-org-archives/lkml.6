Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9671C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1C0208DE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glFa02Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C0208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeHEWOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39720 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeHEWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so4715995plt.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUjLrCINFhUHEvJtdiJwX9hsyE9DR/+wSvQzVqArlCQ=;
        b=glFa02Yj5Y2LpMAggF7eOZDIr40n8Fw/4BNZmwzrtsTmA3WDtw2ewmxVad7oxVpW4M
         EKdHrSYEniN8KJUYKYw8dliocawG8jfZeQbDb8mmrVlq2VO7c68mNzZQg1ei2Tfvrooa
         u3WxOATu3Ii9Mr4HZI/60BsehZVGUq4bI5L1PbyiRJRbmKIalnAi5Ii+WQLEkYFdF1bY
         xMQMZtar7+nStGppz5LObZULaZn4AVmCKH9ZVVGEVEuITRN1ARphPk7GWqG+fvkGBqWG
         CUPMFEdQ2D4zj/oqbIQeULJCt299/sc8aGwVHANcOk7iGczfjN//EDZsOxreh/mRQMxj
         CxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUjLrCINFhUHEvJtdiJwX9hsyE9DR/+wSvQzVqArlCQ=;
        b=qoh7ilXjFBm0ZHP7Deq22pj1rTgHISfGfxc28cvr4NIygNmKqya4l8sfCPeKljfxCF
         bpmTX6tkeSb6aZ4YxgaSYYM0EPKpaDwY/OYgxYx3rjwbfeAsYYmRdX6CtsnaX2sf6kEc
         0GbR3t+rPx27QgwssKrGC0AkXdl5tEJa5c8/Gdep0jsDK9nhI9JYqzZL2FdnVedbu/Cx
         1b6fPi7it26Zl6bUDSnDtLa04reecqvbnFaQ+BBlMSi/lBAA8ChauWMMU0RpKXVxJ0u1
         cVupwFgg9V0eem7a3hcrg2bfxkWFyhkI49alBiONzY35qA86LkCqKD7g0s1vL1Hb/1JV
         BTmA==
X-Gm-Message-State: AOUpUlEEJJvVdkEr0UQoNX0Gi79IpmIoNoNmAbH562WT6i28fqOg+rmV
        JfAco9KLQhC7ykkBZNtr2emgwlW1
X-Google-Smtp-Source: AAOMgpdz29j+0yPqNJUyWB+MqkhrKCG+YmkgJsATao3S/n4SoNaSSFTvGHYz5Y1cw1vMMMANYw3IrQ==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2-v6mr11295617plt.260.1533499711992;
        Sun, 05 Aug 2018 13:08:31 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:31 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/15] staging: gasket: core: remove sysfs setup and cleanup callbacks
Date:   Sun,  5 Aug 2018 13:07:45 -0700
Message-Id: <20180805200749.116693-12-toddpoynor@gmail.com>
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

Gasket device drivers now call into the gasket framework to initialize
and de-initialize, rather than the other way around.  The calling code
can perform sysfs setup and cleanup actions without callbacks from the
framework.  Remove the sysfs setup and cleanup callbacks.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 10 ----------
 drivers/staging/gasket/gasket_core.h | 18 ------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0d76e18fcde5b..ace92f107ed58 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1489,18 +1489,9 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	if (ret)
 		goto fail4;
 
-	ret = check_and_invoke_callback(gasket_dev,
-					driver_desc->sysfs_setup_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in sysfs setup cb: %d\n", ret);
-		goto fail5;
-	}
-
 	*gasket_devp = gasket_dev;
 	return 0;
 
-fail5:
-	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
 fail4:
 fail3:
 	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
@@ -1550,7 +1541,6 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 
 	gasket_cleanup_pci(gasket_dev);
 
-	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
 	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
 	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
 	gasket_free_dev(gasket_dev);
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 0ef0a2640f0fe..275fd0b345b6e 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -444,24 +444,6 @@ struct gasket_driver_desc {
 	 */
 	int (*device_close_cb)(struct gasket_dev *dev);
 
-	/*
-	 * sysfs_setup_cb: Callback to set up driver-specific sysfs nodes.
-	 * @dev: Pointer to the gasket_dev struct for this device.
-	 *
-	 * Called during the add gasket device call.
-	 *
-	 */
-	int (*sysfs_setup_cb)(struct gasket_dev *dev);
-
-	/*
-	 * sysfs_cleanup_cb: Callback to clean up driver-specific sysfs nodes.
-	 * @dev: Pointer to the gasket_dev struct for this device.
-	 *
-	 * Called during device disable processing.
-	 *
-	 */
-	int (*sysfs_cleanup_cb)(struct gasket_dev *dev);
-
 	/*
 	 * get_mappable_regions_cb: Get descriptors of mappable device memory.
 	 * @gasket_dev: Pointer to the struct gasket_dev for this device.
-- 
2.18.0.597.ga71716f1ad-goog

