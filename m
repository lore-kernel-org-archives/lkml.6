Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87E2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ycon2hl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBUO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:56:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40001 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBUO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:56:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so30777011wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f4QPyLw7DhRZfGIHwG3TqBHT9onIr8H9EZ1us2ZyZuY=;
        b=Ycon2hl3zVQ4VtLp7RPIBLG8Ahj0gS+1MXFLixe0BfsxISShuEt0xF+pddbV7Pt/+/
         FJFSsYqC5q7m/lrMuzNGzHQHYxhiTQLxDnzE7U68uFBarD+GqRzqXDl7Xovi4QDsxdBf
         /4D3bJk7PKF3r/37roWYAlvTVXefcZXrobE6isuPavMrp0kVE/0lx1aBjNFPDvJUPwzv
         ELYFb5HxZjg9ZUvNyBhLX7z5rm6Z37fRSuVX5vLnXFbUCMFXgPpC/Vd9PXL06oePVFxB
         KW3ve+zUXk6u1h9F++2PzKyF6C1ezZcHGRlOOyMvk+JiYqQVIfCcN98fpMxjEuRbc2qm
         UBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f4QPyLw7DhRZfGIHwG3TqBHT9onIr8H9EZ1us2ZyZuY=;
        b=b4nxL7ant6lyGAly4ltaPF7OWoJW4GLPpWd95qBsKs6NA400h8L1+pg+VlMTjFSbDP
         L/YeUw0HX5/EmkF/gT+xv4ZQ+p+Jp6x0IFNYfknUrhnWRC4bqXasfpbRE+OX5nX4PaDz
         Ve55/XITkNXGub845pYLc4TtGdfFQnrRJf4Sa1xU7F4oodBYzOUnZkcHyTHH702XGWmy
         69d8W86HI4QokR9tHTyzdZ41bgTLeam5X8fPxMP6TMN0s30S3Ke1rDWLylmS7/xkKqdS
         gTtLffJMaJ+1wlOkLLhhVN0S80bI/gTUZsQuHZwxeXnPbC8gO78fh6JwafRS1G1aEOWm
         OT5Q==
X-Gm-Message-State: AHQUAuaVecOob8YVh2D4kwso3LTNiA7xekn3v9gnyU1sTnIGn7qs51FR
        4V/Y/yy3Wu6DFQ/x13Az3kvjPQ==
X-Google-Smtp-Source: AHgI3IZPyyKiY+OXr+Zs0yoeAfKEiozHPfPytBblgujLUpeTEAesIUQTevJXkBlqQtvi83fkNC+E+w==
X-Received: by 2002:adf:9167:: with SMTP id j94mr30344442wrj.106.1550761003712;
        Thu, 21 Feb 2019 06:56:43 -0800 (PST)
Received: from clegane.local (222.51.92.92.rev.sfr.net. [92.92.51.222])
        by smtp.gmail.com with ESMTPSA id k2sm6309181wmj.45.2019.02.21.06.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:56:43 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: Add a predict callback for the governors
Date:   Thu, 21 Feb 2019 15:56:31 +0100
Message-Id: <20190221145631.26356-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Predicting the next event on the current CPU is implemented in the
idle state selection function, thus the selection logic and the
prediction are tied together and it is hard to decorrelate both.

The following change introduces the cpuidle function to give the
opportunity to the governor to store the guess estimate of the
different source of wakeup and then reuse them in the selection
process. Consequently we end up with two separate operations clearly
identified.

As the next events are stored in the cpuidle device structure it is
easy to propagate them in the different governor callbacks.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 16 ++++++++++++++++
 include/linux/cpuidle.h   | 16 +++++++++++++++-
 kernel/sched/idle.c       |  5 +++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..fc6976bd702b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -296,6 +296,22 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	return entered_state;
 }
 
+/**
+ * cpuidle_predict - guess estimate the next events on the current CPU
+ *
+ * @drv: the cpuidle driver
+ * @dev: the cpuidle device
+ *
+ * Returns 0 on success, < 0 in case of error. The error code depends on
+ * the governor.
+ */
+int cpuidle_predict(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (cpuidle_curr_governor->predict)
+		return cpuidle_curr_governor->predict(drv, dev);
+	return 0;
+}
+
 /**
  * cpuidle_select - ask the cpuidle framework to choose an idle state
  *
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..8aba8b0a952d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -77,6 +77,13 @@ struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
 struct cpuidle_driver_kobj;
 
+struct cpuidle_predict {
+	ktime_t next_hrtimer;
+	ktime_t next_timer;
+	ktime_t next_irq;
+	ktime_t next_resched;
+};
+
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
@@ -89,6 +96,7 @@ struct cpuidle_device {
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
 	struct cpuidle_device_kobj *kobj_dev;
+	struct cpuidle_predict predict;
 	struct list_head 	device_list;
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
@@ -124,7 +132,8 @@ struct cpuidle_driver {
 extern void disable_cpuidle(void);
 extern bool cpuidle_not_available(struct cpuidle_driver *drv,
 				  struct cpuidle_device *dev);
-
+extern int cpuidle_predict(struct cpuidle_driver *drv,
+			   struct cpuidle_device *dev);
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev,
 			  bool *stop_tick);
@@ -158,6 +167,9 @@ static inline void disable_cpuidle(void) { }
 static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
 					 struct cpuidle_device *dev)
 {return true; }
+static inline int cpuidle_predict(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev)
+{return 0; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
 				 struct cpuidle_device *dev, bool *stop_tick)
 {return -ENODEV; }
@@ -241,6 +253,8 @@ struct cpuidle_governor {
 	void (*disable)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);
 
+	int  (*predict)		(struct cpuidle_driver *drv,
+ 					struct cpuidle_device *dev);
 	int  (*select)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev,
 					bool *stop_tick);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..e0e9a81cfec3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -185,6 +185,11 @@ static void cpuidle_idle_call(void)
 	} else {
 		bool stop_tick = true;
 
+		/*
+		 * Guess estimate the next events on the current CPU
+		 */
+		cpuidle_predict(drv, dev);
+
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-- 
2.17.1

