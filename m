Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDDFC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE29220651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzVAlxWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE29220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJWEw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:52:26 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51331 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeJWEwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:52:25 -0400
Received: by mail-qk1-f201.google.com with SMTP id x75-v6so47037226qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8DIj4IRdM90qds78E1Podgiufp7Zvg6YWMRF56u4GjE=;
        b=KzVAlxWFoyLmGtUZPIaLxJyhUdxuXSmGzTegaON4i8DgLt5S3Qcnqhvnn6V/DrloVz
         OiJLRBNbWNMZGoxxCjdHzTs8T+wSSUF7drHV8h+OKIMBXm6M0p1UCRqwhwNeDCAI32+e
         vYQ7Bm1Mz+kiGbiuE9Lu+zsFoGl0ZfZZ14M0DT6CFIhEz3T1zEMwMO24iZ1JkAxsXe+x
         TCHUt12v2pgJAcGsOAi/LJtWss0Mc1ksakgcu9nrnmb9f48FpWC5UINsEtdjsBFHd9hj
         qZbsHRGd8m+oHF9/rF83TrcrVC45KweisKorX3IijLA8/m1c6a4PTxDgeDTpBeZkz7DZ
         LnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8DIj4IRdM90qds78E1Podgiufp7Zvg6YWMRF56u4GjE=;
        b=LxXbjA9wlGBBjNdWX9DctP5f2gB5CW5yiI8QwRFgo2pMb/NuyabC9hZgOyITYw4YML
         uUZqwoAeK22C+AUzPZhmlW3sjUpfHX2fGtAWa3IQpTs+tauGM+HlN+I/Fszl43CMsCMp
         2Z1xEqkCAFAJtMZ7TMSNEOboDlDi2gJ0G4QUMBRsRaOAw7qhkYqjpcK+CitUwJ+0npJf
         LEgbCQnGpQgOPrEFlijl7dTTdtsEhji3C2tMW1Gz/nFMPO0jIiOcGWW47+AsKcBI0HIv
         y82/Csb8Lc0TXA5ERfUGQbJRdCU4xDsA7DddzyEvZ8yTcx6g/d2LsSRhQucbImuK+Juw
         fegQ==
X-Gm-Message-State: AGRZ1gJQkpqEL4p7jTzffmzMnE9DHVmI4inTtMNYkisrqi95YK11K93h
        Srg7Qz1WT4mm8RHOMF1FwacnSx0XWabKwS/2oxGRnSCDY0Fbw2vnSOpHy/GmRQjbL6/PffEwNOR
        dK1QvviWES7XcKnIdgu0Ht6aEOq6rG7lbHT98rNMojwZzzKicqQbSa6bsWAhdeXQSkdAUHRjv
X-Google-Smtp-Source: AJdET5eWzeQiRF+3Z0Zz7VQNi+XuGvtAcFwNquHMMxK3m8i3QHXaIsdv3NVvGojLvsSR/fAF1Psrqk/BN/t1
X-Received: by 2002:a37:2b0d:: with SMTP id r13mr2786429qkh.38.1540240343545;
 Mon, 22 Oct 2018 13:32:23 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:32:17 -0600
Message-Id: <20181022203218.7007-1-zwisler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH 1/2] thermal: Add notifier call chain for hot/critical events
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

This will allow drivers to register a callback for important
thermal events and log critical thresholds that cause the system
to shut down.

There are other places this might work, but after consideration
I think it makes sense to have the chain at this level:

The ACPI thermal driver has an existing notify function that is
eventually called into, but that would limit the notifier to only
working on systems that use ACPI.

The cpufreq driver is already getting a notify callback executed
in this path (tz->ops->notify) but the threshold info is not passed
to the cpu_cooling notifier chain so it is not useful for logging.

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
[ rez: updated changelog for upstream ]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/thermal/thermal_core.c | 38 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a0..e1f8764b3d9f9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
+#include <linux/notifier.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -313,12 +314,46 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+static BLOCKING_NOTIFIER_HEAD(thermal_notifier_list);
+
+/**
+ * register_thermal_notifier - Register function to be called for
+ *                             critical thermal events.
+ *
+ * @nb: Info about notifier function to be called
+ *
+ * Currently always returns zero, as blocking_notifier_chain_register()
+ * always returns zero.
+ */
+int register_thermal_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&thermal_notifier_list, nb);
+}
+EXPORT_SYMBOL(register_thermal_notifier);
+
+/**
+ * unregister_thermal_notifier - Unregister thermal notifier
+ *
+ * @nb: Hook to be unregistered
+ *
+ * Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_thermal_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&thermal_notifier_list, nb);
+}
+EXPORT_SYMBOL(unregister_thermal_notifier);
+
+
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 				      int trip,
 				      enum thermal_trip_type trip_type)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
+
+	blocking_notifier_call_chain(&thermal_notifier_list,
+				     trip_type, NULL);
 }
 
 /**
@@ -385,6 +420,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
+	blocking_notifier_call_chain(&thermal_notifier_list,
+				     trip_type, NULL);
+
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
 			  "critical temperature reached (%d C), shutting down\n",
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f9..b948344d55cab 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/sysfs.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
@@ -542,4 +543,7 @@ static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 }
 #endif
 
+extern int register_thermal_notifier(struct notifier_block *);
+extern int unregister_thermal_notifier(struct notifier_block *);
+
 #endif /* __THERMAL_H__ */
-- 
2.19.1.568.g152ad8e336-goog

