Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8649C21903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="Xjqf2CUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390424AbfBROYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:24:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37195 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389814AbfBROD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so13903285edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlgMi7EUDch9k0ALR7Q1zPGaXCvfUKqLAbFj7Wd2gYI=;
        b=Xjqf2CUTK3wWht17aEOAfDSRolyYwwEgAB17Hbj0Bz1DyXH86CotYo4nyRklgT/rSD
         eSN/mf1lcvmMZNhjgf2Dp8QQ+OyaQjqhflJKsAyk5ch7c2anSejIDuxPg351D9OIAC5I
         XB3aJL8f0SYEaijY2jGLrVizGZKqjfbrSJSe+2kJBlPHaAH7LcdIx+zEfL9v9JDjLy40
         /NbM3Rj+BpkJlVDwreItXS2VB22ny0PZcUA8/SWtfN/mEK2Hv2lt+fhuYFIeCy88I+Ue
         sEi0cl3RD+LfCL9Y8iK6nm2P9yPlSY0h1O6Soci3IDh16V+wUgIMKJ+o9mLZj8yEnKXB
         A3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlgMi7EUDch9k0ALR7Q1zPGaXCvfUKqLAbFj7Wd2gYI=;
        b=XIuMeXpcXBeElA1/nvxRwCE8xP9l8yYZAD5+RuPFitZ5X1t1FiNupnA11ambhN3jwu
         vXhigp5pUTamiHgrasuUEQC3bPfu11dNbl9EYfDPJWWor7pay1N8YlUJRdhsx5VIGZGk
         4bgpcxSrIq5o6nZSx3hE4zTyAK85SAofRfIhfs4zYHitn0GqpAduJnJYFfLMYjoYQwqI
         x95yq0NE1EF4NxT77iotGCyQrsF9IICreAsmc+0uoS8G9OCjdZbUGTMBkEk8LNQoGKhZ
         b+1Wlyg5qU33sGwD564LPnXztwQGQZHN3Wn31Cx4gkGpY71+zuLgm7uUt839sEURajNk
         tS3g==
X-Gm-Message-State: AHQUAuZYbHXlvvzoTP91rdpXBmlFWp9ULtdQWcqs5ElKscAxJAxlYMwd
        Cj3dp15bxAT261yTLy+OaHX12w==
X-Google-Smtp-Source: AHgI3IY0ceN0vfQ9xmpYZOcoyNSJemRZclaQngynB0UdW0cgs6sy04XzxzixF0mhiQPAsNetmxb/iA==
X-Received: by 2002:a17:906:82d1:: with SMTP id a17mr16402415ejy.164.1550498636470;
        Mon, 18 Feb 2019 06:03:56 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:55 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 8/8] iio/counter/ftm-quaddec: add handling of under/overflow of the counter.
Date:   Mon, 18 Feb 2019 15:03:21 +0100
Message-Id: <20190218140321.19166-8-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is implemented by polling the counter value. A new parameter
"poll-interval" can be set in the device tree, or can be changed
at runtime. The reason for the polling is to avoid interrupts flooding.
If the quadrature input is going up and down around the overflow value
(or around 0), the interrupt will be triggering all the time. Thus,
polling is an easy way to handle overflow in a consistent way.
Polling can still be disabled by setting poll-interval to 0.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/iio/counter/ftm-quaddec.c | 199 +++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/counter/ftm-quaddec.c b/drivers/iio/counter/ftm-quaddec.c
index ca7e55a9ab3f..3a0395c3ef33 100644
--- a/drivers/iio/counter/ftm-quaddec.c
+++ b/drivers/iio/counter/ftm-quaddec.c
@@ -25,11 +25,33 @@
 
 struct ftm_quaddec {
 	struct platform_device *pdev;
+	struct delayed_work delayedcounterwork;
 	void __iomem *ftm_base;
 	bool big_endian;
+
+	/* Offset added to the counter to adjust for overflows of the
+	 * 16 bit HW counter. Only the 16 MSB are set.
+	 */
+	uint32_t counteroffset;
+
+	/* Store the counter on each read, this is used to detect
+	 * if the counter readout if we over or underflow
+	 */
+	uint8_t lastregion;
+
+	/* Poll-interval, in ms before delayed work must poll counter */
+	uint16_t poll_interval;
+
 	struct mutex ftm_quaddec_mutex;
 };
 
+struct counter_result {
+	/* 16 MSB are from the counteroffset
+	 * 16 LSB are from the hardware counter
+	 */
+	uint32_t value;
+};
+
 #define HASFLAGS(flag, bits) ((flag & bits) ? 1 : 0)
 
 #define DEFAULT_POLL_INTERVAL    100 /* in msec */
@@ -74,8 +96,75 @@ static void ftm_set_write_protection(struct ftm_quaddec *ftm)
 	ftm_write(ftm, FTM_FMS, FTM_FMS_WPEN);
 }
 
+/* must be called with mutex locked */
+static void ftm_work_reschedule(struct ftm_quaddec *ftm)
+{
+	cancel_delayed_work(&ftm->delayedcounterwork);
+	if (ftm->poll_interval > 0)
+		schedule_delayed_work(&ftm->delayedcounterwork,
+				   msecs_to_jiffies(ftm->poll_interval));
+}
+
+/* Reports the hardware counter added the offset counter.
+ *
+ * The quadrature decodes does not use interrupts, because it cannot be
+ * guaranteed that the counter won't flip between 0xFFFF and 0x0000 at a high
+ * rate, causing Real Time performance degration. Instead the counter must be
+ * read frequently enough - the assumption is 150 KHz input can be handled with
+ * 100 ms read cycles.
+ */
+static void ftm_work_counter(struct ftm_quaddec *ftm,
+			     struct counter_result *returndata)
+{
+	/* only 16bits filled in*/
+	uint32_t hwcounter;
+	uint8_t currentregion;
+
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
+	ftm_read(ftm, FTM_CNT, &hwcounter);
+
+	/* Divide the counter in four regions:
+	 *   0x0000-0x4000-0x8000-0xC000-0xFFFF
+	 * When the hwcounter changes between region 0 and 3 there is an
+	 * over/underflow
+	 */
+	currentregion = hwcounter / 0x4000;
+
+	if (ftm->lastregion == 3 && currentregion == 0)
+		ftm->counteroffset += 0x10000;
+
+	if (ftm->lastregion == 0 && currentregion == 3)
+		ftm->counteroffset -= 0x10000;
+
+	ftm->lastregion = currentregion;
+
+	if (returndata)
+		returndata->value = ftm->counteroffset + hwcounter;
+
+	ftm_work_reschedule(ftm);
+
+	mutex_unlock(&ftm->ftm_quaddec_mutex);
+}
+
+/* wrapper around the real function */
+static void ftm_work_counter_delay(struct work_struct *workptr)
+{
+	struct delayed_work *work;
+	struct ftm_quaddec *ftm;
+
+	work = container_of(workptr, struct delayed_work, work);
+	ftm = container_of(work, struct ftm_quaddec, delayedcounterwork);
+
+	ftm_work_counter(ftm, NULL);
+}
+
+/* must be called with mutex locked */
 static void ftm_reset_counter(struct ftm_quaddec *ftm)
 {
+	ftm->counteroffset = 0;
+	ftm->lastregion = 0;
+
 	/* Reset hardware counter to CNTIN */
 	ftm_write(ftm, FTM_CNT, 0x0);
 }
@@ -110,18 +199,91 @@ static int ftm_quaddec_read_raw(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct ftm_quaddec *ftm = iio_priv(indio_dev);
-	uint32_t counter;
+	struct counter_result counter;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ftm_read(ftm, FTM_CNT, &counter);
-		*val = counter;
+	case IIO_CHAN_INFO_PROCESSED:
+		ftm_work_counter(ftm, &counter);
+		if (mask == IIO_CHAN_INFO_RAW)
+			counter.value &= 0xffff;
+
+		*val = counter.value;
+
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
 }
 
+static uint32_t ftm_get_default_poll_interval(const struct ftm_quaddec *ftm)
+{
+	/* Read values from device tree */
+	uint32_t val;
+	const struct device_node *node = ftm->pdev->dev.of_node;
+
+	if (of_property_read_u32(node, "poll-interval", &val))
+		val = DEFAULT_POLL_INTERVAL;
+
+	return val;
+}
+
+static ssize_t ftm_read_default_poll_interval(struct iio_dev *indio_dev,
+					uintptr_t private,
+					struct iio_chan_spec const *chan,
+					char *buf)
+{
+	const struct ftm_quaddec *ftm = iio_priv(indio_dev);
+	uint32_t val = ftm_get_default_poll_interval(ftm);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", val);
+}
+
+static ssize_t ftm_read_poll_interval(struct iio_dev *indio_dev,
+				uintptr_t private,
+				struct iio_chan_spec const *chan,
+				char *buf)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+
+	uint32_t poll_interval = READ_ONCE(ftm->poll_interval);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", poll_interval);
+}
+
+static ssize_t ftm_write_poll_interval(struct iio_dev *indio_dev,
+				uintptr_t private,
+				struct iio_chan_spec const *chan,
+				const char *buf, size_t len)
+{
+	struct ftm_quaddec *ftm = iio_priv(indio_dev);
+	uint32_t newpoll_interval;
+	uint32_t default_interval;
+
+	if (kstrtouint(buf, 10, &newpoll_interval) != 0) {
+		dev_err(&ftm->pdev->dev, "poll_interval not a number: '%s'\n",
+			buf);
+		return -EINVAL;
+	}
+
+	/* Don't accept polling times below the default value to protect the
+	 * system.
+	 */
+	default_interval = ftm_get_default_poll_interval(ftm);
+
+	if (newpoll_interval < default_interval && newpoll_interval != 0)
+		newpoll_interval = default_interval;
+
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
+	WRITE_ONCE(ftm->poll_interval, newpoll_interval);
+	ftm_work_reschedule(ftm);
+
+	mutex_unlock(&ftm->ftm_quaddec_mutex);
+
+	return len;
+}
+
 static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
 				uintptr_t private,
 				struct iio_chan_spec const *chan,
@@ -135,8 +297,11 @@ static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
 	ftm_reset_counter(ftm);
 
+	mutex_unlock(&ftm->ftm_quaddec_mutex);
 	return len;
 }
 
@@ -192,6 +357,17 @@ static const struct iio_enum ftm_quaddec_prescaler_en = {
 };
 
 static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
+	{
+		.name = "default_poll_interval",
+		.shared = IIO_SHARED_BY_TYPE,
+		.read = ftm_read_default_poll_interval,
+	},
+	{
+		.name = "poll_interval",
+		.shared = IIO_SHARED_BY_TYPE,
+		.read = ftm_read_poll_interval,
+		.write = ftm_write_poll_interval,
+	},
 	{
 		.name = "reset",
 		.shared = IIO_SEPARATE,
@@ -205,7 +381,8 @@ static const struct iio_chan_spec_ext_info ftm_quaddec_ext_info[] = {
 static const struct iio_chan_spec ftm_quaddec_channels = {
 	.type = IIO_COUNT,
 	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_PROCESSED),
 	.ext_info = ftm_quaddec_ext_info,
 	.indexed = 1,
 };
@@ -232,10 +409,14 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 
 	ftm->pdev = pdev;
 	ftm->big_endian = of_property_read_bool(node, "big-endian");
+	ftm->counteroffset = 0;
+	ftm->lastregion = 0;
 	ftm->ftm_base = of_iomap(node, 0);
 	if (!ftm->ftm_base)
 		return -EINVAL;
 
+	ftm->poll_interval = ftm_get_default_poll_interval(ftm);
+
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &ftm_quaddec_iio_info;
@@ -245,9 +426,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	ftm_quaddec_init(ftm);
 
 	mutex_init(&ftm->ftm_quaddec_mutex);
+	INIT_DELAYED_WORK(&ftm->delayedcounterwork, ftm_work_counter_delay);
+
+	ftm_work_reschedule(ftm);
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret) {
+		cancel_delayed_work_sync(&ftm->delayedcounterwork);
 		mutex_destroy(&ftm->ftm_quaddec_mutex);
 		iounmap(ftm->ftm_base);
 	}
@@ -261,13 +446,15 @@ static int ftm_quaddec_remove(struct platform_device *pdev)
 
 	ftm = (struct ftm_quaddec *)platform_get_drvdata(pdev);
 	indio_dev = iio_priv_to_dev(ftm);
-	/* This is needed to remove sysfs entries */
+	/* Make sure no concurrent attribute reads happen*/
 	devm_iio_device_unregister(&pdev->dev, indio_dev);
 
+	cancel_delayed_work_sync(&ftm->delayedcounterwork);
+
 	ftm_write(ftm, FTM_MODE, 0);
 
-	iounmap(ftm->ftm_base);
 	mutex_destroy(&ftm->ftm_quaddec_mutex);
+	iounmap(ftm->ftm_base);
 
 	return 0;
 }
-- 
2.17.1

