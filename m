Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E92ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22572083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjD4Myuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22572083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJZI0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:26:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44508 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeJZI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:26:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so4753087pgs.11;
        Thu, 25 Oct 2018 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iq4W3ckbo3T05M9TEh43hdkecT0tn3SQVt0ZFCy+G8o=;
        b=NjD4MyuhkPIOTPElvaykqmidngfdHDf6mo8KuUo+K7KTG/FTm8TWaa3Gk5A+LsNT3q
         WC+LVh44Ti6vay+gHsBre6CuQGvIKoj+AQps6qeM4B4CBLdV+kNggveUHPL3E0jn+8Z/
         UILuYyUlOjoozYGTZ4Ie9VS9ycOpYisNaQB/VuvllyDD8luLCzarhg+VwMFjTBQBfIFV
         XIzvipZAybzuDbZ41uCX7Cr83HiRaAo6Qe6jVufo+VdKitcz8gyPJtsngernN4XqWY11
         Jhwm74ard0bJ9xuKgB7Te6LDXyaEM5YVk/IVGMg17J3PgEE2n4I+++YYtyGaQkw5FQ0w
         fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iq4W3ckbo3T05M9TEh43hdkecT0tn3SQVt0ZFCy+G8o=;
        b=ELsvyw8Nvn/gcqFUoGs8eE133hMCFYwgy3p8J4vwXpgVeWJviAlzq62gQAP45iFtrI
         x4O+PjrqiFnhkDSFGZ9Og9oxRhLjd7sgWmrV6m2+71opmc+mWnYWL7xrcM4Dx6fZ/xyB
         YBVJIAyE3ib8tQ5Sp/TSAYmRgueD92tSy3G3AJzV/+HFBqRF8w3r8AXUrd/4e3B8mGId
         M/9N795ykaJtz7Dr7Gm04J6DZLCvzPYVRuyAvpTsoKHXg1x9LGxVAX0AANHXvQhfjC4P
         gR0Br7gxIHPy/dbNnT5ffprlzKpxCiANImMD99aHBlAnndAGgTkAb8jds3lEIWP+OOMo
         mRSg==
X-Gm-Message-State: AGRZ1gIOyU9+GF0JIzHmVeprFgPEWtA6t2sVby08xl4gwYP/M0UtvFVG
        sDjebhWRSMdbySmWKr7OmX0=
X-Google-Smtp-Source: AJdET5dTxr2Pkt5+HK7oJD7bOCic5UrSa1A6+/hajnYMCnmOW68+yDkjNKMft74e5qDuw0L3yABgcw==
X-Received: by 2002:a63:d0e:: with SMTP id c14-v6mr1147205pgl.281.1540511489426;
        Thu, 25 Oct 2018 16:51:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189-v6sm10453806pfa.91.2018.10.25.16.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:51:28 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] hwmon: (core) Add pm ops to hwmon class
Date:   Thu, 25 Oct 2018 16:51:18 -0700
Message-Id: <20181025235122.3240-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025235122.3240-1-nicoleotsuka@gmail.com>
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon core generates an extra child dev pointer for every
registered hwmon driver so as to link the new device to hwmon
class, and it exposes this new dev in /sys/class/hwmon/hwmon*/
directory including a power directory for pm runtime. However,
there is currently no way for hwmon drivers to link their own
pm related information to this power directory, so it's always
showing unsupported even if the driver implements the pm ops.

This is because pm_runtime core scans PM runtime callbacks in
the dev->driver pointer while this new child dev doesn't have
a driver pointer. It sounds easier to merely copy this driver
pointer from the parent dev to the child dev, however, this'd
create some problem like the same suspend() function might be
called twice during system suspend cycle and the second call
may fail since the device is already suspended, so the driver
would have to work around to bypass one of the two callbacks.

Actually, pm_runtime core also scans a class-level pm pointer:
         else if (dev->class && dev->class->pm)
                  ops = dev->class->pm;

This means that hwmon class in the hwmon core could actually
have its own generic pm callbacks so that a registered driver
would have the capability to link their own callbacks to the
hwmon core's.

So this patch adds a pm pointer to the hwmon class with some
generic pm callbacks of system suspend/resume and pm_runtime
suspend/resume, and also allows hwmon drivers to pass valid
pm pointers through _with_info API when registering devices.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v3->v4:
 * Dropped the risky pointer copies
 * Added generic pm runtime callbacks to the hwmon class
v2->v3:
 * N/A
v1->v2:
 * Added device pointers

 drivers/hwmon/hwmon.c | 24 ++++++++++++++++++++++++
 include/linux/hwmon.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..10bbd36be4a5 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/thermal.h>
@@ -103,11 +104,34 @@ static void hwmon_dev_release(struct device *dev)
 	kfree(to_hwmon_device(dev));
 }
 
+#define HWMON_PM_FUNCTION(name)					\
+static int __maybe_unused hwmon_##name(struct device *dev)	\
+{								\
+	struct hwmon_device *hwdev = to_hwmon_device(dev);	\
+	const struct hwmon_chip_info *chip = hwdev->chip;	\
+								\
+	if (chip && chip->pm && chip->pm->name)			\
+		return chip->pm->name(dev);			\
+								\
+	return 0;						\
+}
+
+HWMON_PM_FUNCTION(suspend)
+HWMON_PM_FUNCTION(resume)
+HWMON_PM_FUNCTION(runtime_suspend)
+HWMON_PM_FUNCTION(runtime_resume)
+
+static const struct dev_pm_ops hwmon_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(hwmon_suspend, hwmon_resume)
+	SET_RUNTIME_PM_OPS(hwmon_runtime_suspend, hwmon_runtime_resume, NULL)
+};
+
 static struct class hwmon_class = {
 	.name = "hwmon",
 	.owner = THIS_MODULE,
 	.dev_groups = hwmon_dev_attr_groups,
 	.dev_release = hwmon_dev_release,
+	.pm = &hwmon_pm,
 };
 
 static DEFINE_IDA(hwmon_ida);
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 99e0c1b0b5fb..edbeddb489f8 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -369,10 +369,12 @@ struct hwmon_channel_info {
  * Chip configuration
  * @ops:	Pointer to hwmon operations.
  * @info:	Null-terminated list of channel information.
+ * @pm:		Pointer to dev_pm_ops callbacks.
  */
 struct hwmon_chip_info {
 	const struct hwmon_ops *ops;
 	const struct hwmon_channel_info **info;
+	const struct dev_pm_ops *pm;
 };
 
 /* hwmon_device_register() is deprecated */
-- 
2.17.1

