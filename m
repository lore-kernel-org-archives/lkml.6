Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92F1222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wnfr3Jlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfBLWYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43167 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfBLWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222438euoutp025bddc37e5427d201d96c662b6ca1b0b4~CviLrB6k02689326893euoutp02g
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222438euoutp025bddc37e5427d201d96c662b6ca1b0b4~CviLrB6k02689326893euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010278;
        bh=ven8ijJD7K2NsKytZ4RUr1yQkq/83clgqubhQWcBU5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wnfr3JltiutYckBlO3IbrKa1T5Fj5e/d4bhvQ65h6zznWXWM9qn2u8Afi4kIMA6uy
         3GxRhslSfOA1imoik3PlY36apgKZoT0QCJUa233PnSXNT/9mZQ4u0TG14pgDF4ktcj
         AWiYQlYzDI5NIOR2csk+KE22k6301pmlYMf1W9LQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212222437eucas1p284970e88b818b674ac88a31b1142555b~CviKpFGAV1609016090eucas1p2w;
        Tue, 12 Feb 2019 22:24:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.03.04441.5A7436C5; Tue, 12
        Feb 2019 22:24:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868~CviJDMKwQ2094320943eucas1p2R;
        Tue, 12 Feb 2019 22:24:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212222435eusmtrp1b29fa2c10135e79a83408d09f6059200~CviI0VLTi2311323113eusmtrp1h;
        Tue, 12 Feb 2019 22:24:35 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-e4-5c6347a5f4b1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.93.04128.3A7436C5; Tue, 12
        Feb 2019 22:24:35 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222435eusmtip13c6a9209537cb4f3c73a588f5c82f513~CviIHxRrl2067220672eusmtip1D;
        Tue, 12 Feb 2019 22:24:35 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Date:   Tue, 12 Feb 2019 23:23:56 +0100
Message-Id: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRzGfXcuO1qz07T2aqYwMivKCwqdTKJE8JQfEvFTCjr1oCOntuO1
        +rC8zksmOixTh36wzaVotsRELedlhnlPS0VRQkyxROcFIyTnmfXt93+e53/h5SUQ4VvMkZAm
        JDPyBEm8GLdBW/v3Rq7UBUaHe2o6XKg3L5owqnxzAqW+bi1j1CuFKzWUucanZhRO1ER7FU6Z
        nvYCqrF3jk+Nf6zhUabm74CafaLFqS7lAo/qWcvDqPUy9uYJukHdAOhKxRhKZ3fN8OmalhS6
        dnMbo7t/dfDo9a5JnC7W6wBtanEOtr5n4xfDxEtTGbnHjUibOEPjAJK0GJY+2VeIKsBIUAGw
        JiDpA+u6V/ACYEMISS2A+esqS7EF4PicgscVJgD16/vIUUtViR5whgbA0aU+/r+WkcbOA4cg
        cNIdtukemBvsSV/4I2/1MIOQ/Ty42ak6nGRH3oW1r7/gZkZJV1gwX3vIAvIONBorMG6bM5we
        zj/MW5NB8HN5PWYeBEkDHw4X1vO4UACsVeYCju3gqlHP59gJDpYVoRyzcEipwzl+DPM+tVky
        12GPcQwzH42QF2FTuwcn34JZpjm+WYakLfz286RZRg6wtPU5wskCqMwVcukLUF80ajnmNNQ0
        lFuG07C3bMfyVmoAi6dUeAlwefl/WQ0AOiBiUlhZLMN6JTBp7qxExqYkxLpHJ8pawMFXGtw3
        braB7fEoAyAJID4u0PZFhQsxSSqbITMASCBie8Ftv+hwoSBGkvGQkSdGyFPiGdYAzhCoWCR4
        ZLUQJiRjJcnMfYZJYuRHLo+wdlSAMOepih1GEzK96LGHZvW+y7FVbaRXNssiIt1ckgOU5x06
        /uxqP8zweZnOQyveVt45Kkf73a4Fz9CttN+YW2mY1U7H4DHpvPoZu7ShDBVJQ8INwcvn6n0c
        Tkn9Svxl6Pur6oXLnSs72d3XZgPXBkTXp7rP2lZXb2hr/LXz3r4tYpSNk3hdQuSs5C/KVfuP
        RgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7qL3ZNjDA5sNLTYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl3Fo7QnmgofRFVePdrM0MJ737mLk5JAQMJGYM2ELYxcjF4eQwFJGiY1nvzJDJMQkJu3b
        zg5hC0v8udbFBlH0iVHifRtIEQcHm4CexI5VhSA1IgI2Eu/nnmEBqWEWuMYkcbvjPitIQljA
        V2Lemy4WEJtFQFWi695CNhCbV8BL4vjxmawQC+Qkbp7rBFvMKeAtcWbaSlaQ+UJANU0HDSYw
        8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGCPbjv3csoOx613wIUYBDkYlHt4VR5Ni
        hFgTy4orcw8xSnAwK4nwetokxwjxpiRWVqUW5ccXleakFh9iNAW6aSKzlGhyPjB+80riDU0N
        zS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MM5+8tnkEhdTUaDUzAPzPpS5
        T1Gcw3+gZGbDywfKJb9VFBUPT3L2/5J9aebbN/z75tvfq69W25iZZmraIcvf8+gs34XS+dbH
        ivUyOop/JnO+9ij57VC5w5Pz+uGe1SmX9oe2fP00N6PniLzM9aUyzPypcod5JMQCZu9fk8EQ
        d6/zBa/z19mmPEosxRmJhlrMRcWJAORdOFanAgAA
X-CMS-MailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new mechanism for devfreq devices which changes polling
interval. The system should sleep longer when the devfreq device is almost
not used. The devfreq framework will not schedule the work too often.
This low-load state is recognised when the device is operating at the lowest
frequency and has low busy_time/total_time factor (< 30%).
When the frequency is different then min, the device is under normal polling
which is the value defined in driver's 'polling_ms'.
When the device is getting more pressure, the framework is able to catch it
based on 'load' in lowest frequency and will start polling more frequently.
The second scenario is when the governor recognised heavy load at minimum
frequency and increases the frequency. The devfreq framework will start
polling in shorter intervals.
The polling interval, when the device is not heavily, can also be changed
from userspace of defined by the driver's author.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
 drivers/devfreq/governor.h                |   3 +-
 drivers/devfreq/governor_simpleondemand.c |   6 +-
 3 files changed, 145 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c200b3c..29e99ce 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,13 @@
 #include <linux/of.h>
 #include "governor.h"
 
+/* The ~30% load threshold used for load calculation (due to fixed point
+ * arithmetic) */
+#define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
+
+static const
+unsigned int default_polling_idle_ms = CONFIG_DEVFREQ_DEFAULT_POLLING_IDLE_MS;
+
 static struct class *devfreq_class;
 
 /* The list of all device-devfreq governors */
@@ -144,6 +151,38 @@ static int set_freq_table(struct devfreq *devfreq)
 }
 
 /**
+ * devfreq_get_polling_delay() - gets the polling delay for current state
+ * @devfreq:	the devfreq instance.
+ *
+ * Helper function which checks existing device state and returns polling
+ * interval. The function requires the caller holds devfreq->lock.
+ */
+static int devfreq_get_polling_delay(struct devfreq *devfreq)
+{
+	unsigned int scaling_min_freq;
+	unsigned long load;
+
+	lockdep_assert_held(&devfreq->lock);
+
+	/* Check the frequency of the device. If it not the lowest then use
+	 * device's polling_ms interval and job is done. */
+	scaling_min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
+	if (scaling_min_freq != devfreq->previous_freq)
+		return devfreq->profile->polling_ms;
+
+	/* The device is running minimum frequency, check the load and if
+	 * the value crosses the threshold, start polling with device's
+	 * polling_ms value. */
+	load = devfreq->last_status.busy_time << 10;
+	load /= devfreq->last_status.total_time;
+
+	if (load > LOAD_THRESHOLD_IN_DEVICE_USAGE)
+		return devfreq->profile->polling_ms;
+	else
+		return devfreq->profile->polling_idle_ms;
+}
+
+/**
  * devfreq_update_status() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
@@ -378,14 +417,17 @@ static void devfreq_monitor(struct work_struct *work)
 	int err;
 	struct devfreq *devfreq = container_of(work,
 					struct devfreq, work.work);
+	unsigned int polling_ms;
 
 	mutex_lock(&devfreq->lock);
+	polling_ms = devfreq_get_polling_delay(devfreq);
+
 	err = update_devfreq(devfreq);
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
 	schedule_delayed_work(&devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+			      msecs_to_jiffies(polling_ms));
 	mutex_unlock(&devfreq->lock);
 }
 
@@ -401,6 +443,7 @@ static void devfreq_monitor(struct work_struct *work)
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+	/* Start polling with normal (not idle) polling interval. */
 	if (devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
@@ -464,6 +507,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	if (!devfreq->stop_polling)
 		goto out;
 
+	/* In resume, normal (not idle) polling interval is used. */
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
@@ -485,43 +529,60 @@ EXPORT_SYMBOL(devfreq_monitor_resume);
  * devfreq_interval_update() - Update device devfreq monitoring interval
  * @devfreq:    the devfreq instance.
  * @delay:      new polling interval to be set.
+ * @idle:	indicates state for which the new interval is going to be set.
  *
  * Helper function to set new load monitoring polling interval. Function
- * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
+ * to be called from governor in response to DEVFREQ_GOV_INTERVAL or
+ * DEVFREQ_GOV_IDLE_INTERVAL event.
  */
-void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
+void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay,
+			     bool idle)
 {
-	unsigned int cur_delay = devfreq->profile->polling_ms;
+	unsigned int cur_delay;
 	unsigned int new_delay = *delay;
+	bool dev_in_idle = false;
 
 	mutex_lock(&devfreq->lock);
-	devfreq->profile->polling_ms = new_delay;
 
+	cur_delay = devfreq_get_polling_delay(devfreq);
+	/* check if we are currently in idle state, it will be needed later */
+	if (cur_delay == devfreq->profile->polling_idle_ms)
+		dev_in_idle = true;
+
+	if (idle)
+		devfreq->profile->polling_idle_ms = new_delay;
+	else
+		devfreq->profile->polling_ms = new_delay;
+
+	/* device is in suspend, does not need to do anything more. */
 	if (devfreq->stop_polling)
 		goto out;
 
-	/* if new delay is zero, stop polling */
-	if (!new_delay) {
+	/* if new delay is zero and it is for 'normal' polling,
+	 * then stop polling */
+	if (!new_delay && !idle) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		return;
 	}
 
-	/* if current delay is zero, start polling with new delay */
-	if (!cur_delay) {
+	/* if current delay is zero and it is not for idle,
+	 * start polling with 'normal' polling interval */
+	if (!cur_delay && !idle) {
 		schedule_delayed_work(&devfreq->work,
-			msecs_to_jiffies(devfreq->profile->polling_ms));
+			msecs_to_jiffies(new_delay));
 		goto out;
 	}
 
-	/* if current delay is greater than new delay, restart polling */
-	if (cur_delay > new_delay) {
+	/* if current delay is greater than new delay and the new polling value
+	 * corresponds to the current state, restart polling */
+	if (cur_delay > new_delay && dev_in_idle == idle) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
 		if (!devfreq->stop_polling)
 			schedule_delayed_work(&devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+			      msecs_to_jiffies(new_delay));
 	}
 out:
 	mutex_unlock(&devfreq->lock);
@@ -590,6 +651,24 @@ static void devfreq_dev_release(struct device *dev)
 }
 
 /**
+ * polling_idle_init() - Initialize polling interval for device's low-load.
+ * @df:		the devfreq device which is setup
+ *
+ * The function checks if the driver's code defined the 'polling_idle_ms' and
+ * leaves it or tries to initialise according to the framework's default value
+ * and 'normal' polling interval ('polling_ms').
+ */
+static void polling_idle_init(struct devfreq *df)
+{
+	if (!df->profile->polling_idle_ms)
+		df->profile->polling_idle_ms = default_polling_idle_ms;
+
+	if (df->profile->polling_idle_ms <= df->profile->polling_ms)
+		df->profile->polling_idle_ms = df->profile->polling_ms +
+			default_polling_idle_ms;
+}
+
+/**
  * devfreq_add_device() - Add devfreq feature to the device
  * @dev:	the device to add devfreq feature.
  * @profile:	device-specific profile to run devfreq.
@@ -664,6 +743,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	polling_idle_init(devfreq);
+
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
@@ -1235,6 +1316,13 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&df->lock);
+	if (df->profile->polling_idle_ms < value) {
+		mutex_unlock(&df->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&df->lock);
+
 	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
 	ret = count;
 
@@ -1242,6 +1330,42 @@ static ssize_t polling_interval_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(polling_interval);
 
+static ssize_t
+polling_idle_interval_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_idle_ms);
+}
+
+static ssize_t polling_idle_interval_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	unsigned int value;
+	int ret;
+
+	if (!df->governor)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%u", &value);
+	if (ret != 1)
+		return -EINVAL;
+
+	mutex_lock(&df->lock);
+	if (df->profile->polling_ms > value) {
+		mutex_unlock(&df->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&df->lock);
+
+	df->governor->event_handler(df, DEVFREQ_GOV_IDLE_INTERVAL, &value);
+	ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(polling_idle_interval);
+
 static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1408,6 +1532,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_available_frequencies.attr,
 	&dev_attr_target_freq.attr,
 	&dev_attr_polling_interval.attr,
+	&dev_attr_polling_idle_interval.attr,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index f53339c..fa4f0c5 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -24,6 +24,7 @@
 #define DEVFREQ_GOV_INTERVAL			0x3
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
+#define DEVFREQ_GOV_IDLE_INTERVAL			0x6
 
 #define DEVFREQ_MIN_FREQ			0
 #define DEVFREQ_MAX_FREQ			ULONG_MAX
@@ -62,7 +63,7 @@ extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_monitor_suspend(struct devfreq *devfreq);
 extern void devfreq_monitor_resume(struct devfreq *devfreq);
 extern void devfreq_interval_update(struct devfreq *devfreq,
-					unsigned int *delay);
+				    unsigned int *delay, bool idle);
 
 extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c0417f0..cc1feac 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -100,7 +100,11 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		break;
 
 	case DEVFREQ_GOV_INTERVAL:
-		devfreq_interval_update(devfreq, (unsigned int *)data);
+		devfreq_interval_update(devfreq, (unsigned int *)data, false);
+		break;
+
+	case DEVFREQ_GOV_IDLE_INTERVAL:
+		devfreq_interval_update(devfreq, (unsigned int *)data, true);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-- 
2.7.4

