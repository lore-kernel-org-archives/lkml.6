Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeFBCcW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 22:32:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36288 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeFBCcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 22:32:21 -0400
X-Google-Smtp-Source: ADUXVKKGLlk7cRf9jOvvglh3TOi6hAlC9VFlSN+2uulSjSLj3+ky/n8Z7UAehIHewQR7xs8EvCLP3w==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: rjw@rjwysocki.net, chenhong3@huawei.com, ravisadineni@chromium.org,
        pavel@ucw.cz, ravisadineni@google.com, dtor@google.com,
        len.brown@intel.com, gregkh@linuxfoundation.org
Cc: tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: [PATCH] power: Print wakeup_count instead of event_count in the sysfs attribute.
Date: Fri,  1 Jun 2018 19:32:15 -0700
Message-Id: <20180602023215.176521-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we show event_count instead of wakeup_count as part of per
device wakeup_count sysfs attribute. Change it to wakeup_count to make
it more meaningful.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/base/power/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 0f651efc58a1a..d713738ce7967 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -353,7 +353,7 @@ static ssize_t wakeup_count_show(struct device *dev,
 
 	spin_lock_irq(&dev->power.lock);
 	if (dev->power.wakeup) {
-		count = dev->power.wakeup->event_count;
+		count = dev->power.wakeup->wakeup_count;
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-- 
2.17.1.1185.g55be947832-goog
