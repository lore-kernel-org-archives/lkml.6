Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E126D27800
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E126D27800
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935128AbeF1S4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:56:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47863 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933843AbeF1S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:56:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DC4B8805BB; Thu, 28 Jun 2018 20:56:30 +0200 (CEST)
Date:   Thu, 28 Jun 2018 20:56:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180628185630.GA6095@amd>
References: <20180628134227.GA1719@arbeit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20180628134227.GA1719@arbeit>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Send out a morse code by using LEDs.
>=20
> This is useful especially on embedded systems without displays to tell the
> user about error conditions and status information.
>=20
> The trigger will be called "morse"
>=20
> The string to be send is written into the file morse_string and sent out
> with a workqueue. Supported are letters and digits.
>=20
> With the file dot_unit the minimal time unit can be adjusted in
> milliseconds.
>=20
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Can we get more general "pattern" trigger? Some LEDs can do that in
hardware, and it is more general than plain morse.

Ouch and it already was implemented :-). Patch is in attachment.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=delme
Content-Transfer-Encoding: quoted-printable

=46rom rteysseyre@gmail.com Fri Mar 20 15:40:22 2015
Return-Path: <rteysseyre@gmail.com>
X-Original-To: pavel@atrey.karlin.mff.cuni.cz
Delivered-To: pavel@atrey.karlin.mff.cuni.cz
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by atrey.karlin.mff.cuni.cz (Postfix) with ESMTP id 3275281ECB
	for <pavel@atrey.karlin.mff.cuni.cz>; Fri, 20 Mar 2015 15:40:22 +0100 (CET)
Received: by jabberwock.ucw.cz (Postfix)
	id 3053A1C00FF; Fri, 20 Mar 2015 15:40:22 +0100 (CET)
Delivered-To: pavel@jabberwock.ucw.cz
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.=
46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "smtp.gmail.com", Issuer "Google Internet Authority G2" (not ve=
rified))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 18EB61C00F9
	for <pavel@ucw.cz>; Fri, 20 Mar 2015 15:40:22 +0100 (CET)
Received: by wgbcc7 with SMTP id cc7so91022009wgb.0
        for <pavel@ucw.cz>; Fri, 20 Mar 2015 07:40:21 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dgmail.com; s=3D20120113;
        h=3Dsubject:from:to:cc:content-type:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DUdT+u6nHVkpFGm2AqZ0XFePjLX83mCQTkcoTCraWWvc=3D;
        b=3Db9VbjaS+0McMAtdeSJv1Lhb6RDg/noWghgIsbIZD/DpMnIXJ05Dyi160Jx28uS0=
YzT
         zyPmtmEv3IrnmkcCp7g6S6f04ATgi9q3tI+5qooaQS65V7bRtlpcTMoB8KEA38SsBt=
ap
         8Ng+65MHchSpmGyR/h0WxVg934ieNpySSLCQ/vSUu2lOxi0SLmyr93KqfZXQ6Yk5FC=
A3
         QOcCuiXpcLfmGbLwR2YT0uu3/60LOmWL6xt+J/bkWjo38qwqtH5phoa5ydjcUy5MZJ=
SZ
         tn4qM8mQ8YH9EUJ+VjcxQX4nYdY+Mf3tsnSOieHNzUVt+2z1GmLcDi1Jfe8MtyPh8+=
9m
         dp+w=3D=3D
X-Received: by 10.194.108.137 with SMTP id hk9mr118158926wjb.112.1426862421=
666;
        Fri, 20 Mar 2015 07:40:21 -0700 (PDT)
Received: from [192.168.244.132] (fs-141-0-203-237.fullsave.info. [141.0.20=
3.237])
        by mx.google.com with ESMTPSA id ha10sm6624401wjc.37.2015.03.20.07.=
40.20
        (version=3DSSLv3 cipher=3DRC4-SHA bits=3D128/128);
        Fri, 20 Mar 2015 07:40:20 -0700 (PDT)
Subject: [PATCH v2] leds: Add arbitrary pattern trigger
=46rom: =3D?ISO-8859-1?Q?Rapha=3DEBl?=3D Teysseyre <rteysseyre@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Joe Xue <lgxue@hotmail.com>, Bryan Wu <cooloney@gmail.com>,=20
 "rpurdie@rpsys.net" <rpurdie@rpsys.net>, Linux LED Subsystem
 <linux-leds@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=3D"UTF-8"
Date: Fri, 20 Mar 2015 15:42:02 +0100
Message-ID: <1426862522.48232.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-34.el6)=20
Content-Transfer-Encoding: 8bit
X-CRM114-Status: Good  ( pR: 191.7191 )
Status: RO
Content-Length: 17146

Hi all,

Following your comments about [PATCH] leds: Add arbitrary pattern trigger,
here is a revised version of this patch.

This is intended for embedded systems without screen or network access
to show a status (or error) code to a human.

It's been tested on an ARM architecture (Xilinx Zynq 7010 SoC,
which CPU is a dual ARM Cortex-A9), with a non-mainline
kernel (xilinx-v2014.4, based of a 3.17.0 kernel).
Unfortunately, I don't have other hardware to test it on.
It compiles fine in a 3.19.0-rc1 source tree.
Additional testing and comments would be appreciated.

Changes since version 1:
 - Fixed typos in documentation and comments.
 - Fixed MODULE_LICENSE string.
 - No more mutex in atomic context.
 - Return EINVAL when invalid patterns are written to the "pattern" attribu=
te.



Add a new led trigger supporting arbitrary patterns.
This is useful for embedded systems with no screen or network access.

Export two sysfs attributes: "pattern", and "repeat".

When "repeat"=3D-1, repeat the pattern indefinitely. Otherwise,
repeat it the specified number of times. "pattern" specifies
the pattern as comma separated couples of "brightness duration"
values. See detailled documentation in patch.

Signed-off-by: Rapha=EBl Teysseyre <rteysseyre@gmail.com>
---
 Documentation/leds/ledtrig-pattern.txt |   86 +++++++
 drivers/leds/trigger/Kconfig           |   10 +
 drivers/leds/trigger/Makefile          |    1 +
 drivers/leds/trigger/ledtrig-pattern.c |  432 ++++++++++++++++++++++++++++=
++++
 4 files changed, 529 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/leds/ledtrig-pattern.txt
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/leds/ledtrig-pattern.txt b/Documentation/leds/le=
dtrig-pattern.txt
new file mode 100644
index 0000000..579295e
--- /dev/null
+++ b/Documentation/leds/ledtrig-pattern.txt
@@ -0,0 +1,86 @@
+LED Pattern Trigger
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This is a LED trigger allowing arbitrary pattern execution. It can do grad=
ual
+dimming. This trigger can be configured to repeat the pattern a number of
+times or indefinitely. This is intended as a way of communication for embe=
dded
+systems with no screen.
+
+The trigger can be activated from user space on LED class devices as shown
+below:
+
+  echo pattern > trigger
+
+This adds the following sysfs attributes to the LED:
+
+  pattern - specifies the pattern. See syntax below.
+
+  repeat - number of times the pattern must be repeated.
+	writing -1 to this file will make the pattern
+	repeat indefinitely.
+
+The pattern will be restarted each time a new value is written to
+the pattern or repeat attribute. When dimming, the LED brightness
+is set every 50 ms.
+
+pattern syntax:
+The pattern is specified in the pattern attribute with an array of comma-
+separated "brightness/length in miliseconds" values. The two components
+of each value are to be separated by a space.
+
+For example, assuming the driven LED supports
+intensity value from 0 to 255:
+
+  echo 0 1000, 255 2000 > pattern
+
+Or:
+
+  echo 0 1000, 255 2000, > pattern
+
+Will make the LED go gradually from zero-intensity to max (255) intensity
+in 1000 milliseconds, then back to zero intensity in 2000 milliseconds:
+
+LED brightness
+    ^
+255-|       / \            / \            /
+    |      /    \         /    \         /
+    |     /       \      /       \      /
+    |    /          \   /          \   /
+  0-|   /             \/             \/
+    +---0----1----2----3----4----5----6------------> time (s)
+
+
+
+To make the LED go instantly from one brigntess value to another,
+use zero-time lengths. For example:
+
+  echo 0 1000, 0 0, 255 2000, 255 0 > pattern
+
+Will make the LED stay off for one second, then stay at max brightness
+for two seconds:
+
+LED brightness
+    ^
+255-|        +---------+    +---------+
+    |        |         |    |         |
+    |        |         |    |         |
+    |        |         |    |         |
+  0-|   -----+         +----+         +----
+    +---0----1----2----3----4----5----6------------> time (s)
+
+
+Notes:
+
+Patterns with invalid syntax are reported with EINVAL, the
+resulting LED brightness is undefined. Reading the pattern
+back returns an empty string.
+
+Patterns with less than two values, no value with time length > 50
+milliseconds, or no two values with differing brightnesses
+result in the LED being set at the brightness of the first value,
+or zero if the pattern contains no value. EINVAL is returned,
+and reading the pattern back returns an empty string.
+
+Because sysfs is used to define the pattern, patterns that need more than
+PAGE_SIZE characters to describe aren't supported. PAGE_SIZE is system
+dependent.
diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index 49794b4..ce27bdb 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -108,4 +108,14 @@ config LEDS_TRIGGER_CAMERA
 	  This enables direct flash/torch on/off by the driver, kernel space.
 	  If unsure, say Y.
=20
+config LEDS_TRIGGER_PATTERN
+	tristate "LED Pattern Trigger"
+	depends on LEDS_TRIGGERS
+	help
+	  This allows LEDs blinking with an arbitrary pattern. Can be useful
+	  on embedded systems with no screen to give out a status code to
+	  a human.
+
+	  If unsure, say N
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 1abf48d..a739429 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_LEDS_TRIGGER_CPU)		+=3D ledtrig-cpu.o
 obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)	+=3D ledtrig-default-on.o
 obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+=3D ledtrig-transient.o
 obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+=3D ledtrig-camera.o
+obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+=3D ledtrig-pattern.o
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/=
ledtrig-pattern.c
new file mode 100644
index 0000000..fdf231d
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,432 @@
+/*
+ * Arbitrary pattern trigger
+ *
+ * Copyright 2015, Epsiline
+ *
+ * Author : Rapha=EBl Teysseyre <rteysseyre@gmail.com>
+ *
+ * Idea discussed with Pavel Machek <pavel@ucw.cz> on
+ * <linux-leds@vger.kernel.org> (march 2015, thread title
+ * [PATCH RFC] leds: Add status code trigger)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include "../leds.h"
+
+struct pattern_step {
+	int brightness;
+	int time_ms;
+};
+
+struct pattern_trig_data {
+	struct pattern_step *steps; /* Array describing the pattern */
+	struct mutex lock;
+	char is_sane;
+	struct pattern_step *curr;
+	struct pattern_step *next;
+	int time_ms; /* Time in current step */
+	int nsteps;  /* Number of steps */
+	int repeat;  /* < 0 means repeat indefinitely */
+	struct workqueue_struct *queue;
+	struct delayed_work dwork;
+	struct led_classdev *led_cdev; /* Needed by pattern_trig_update() */
+};
+
+#define UPDATE_INTERVAL 50
+/* When doing gradual dimming, the led brightness
+   will be updated every UPDATE_INTERVAL milliseconds */
+
+#define PATTERN_SEPARATOR ","
+
+#define MAX_NSTEPS (PAGE_SIZE/4)
+/* The "pattern" attribute contains at most PAGE_SIZE characters.
+   Each pattern step in this attribute needs at least 4 characters
+   (a 1-digit number for the led brighntess, a space,
+   a 1-digit number for the time, a PATTERN_SEPARATOR).
+   Therefore, there is at most PAGE_SIZE/4 steps. */
+
+static int pattern_trig_initialize_data(struct pattern_trig_data *data)
+{
+	mutex_init(&data->lock);
+	mutex_lock(&data->lock);
+
+	data->is_sane =3D 0;
+	data->steps =3D kzalloc(MAX_NSTEPS*sizeof(struct pattern_step),
+			GFP_KERNEL);
+	if (!data->steps)
+		return -ENOMEM;
+
+	data->curr =3D NULL;
+	data->next =3D NULL;
+	data->time_ms =3D 0;
+	data->nsteps =3D 0;
+	data->repeat =3D -1;
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static void pattern_trig_clear_data(struct pattern_trig_data *data)
+{
+	data->is_sane =3D 0;
+	kfree(data->steps);
+}
+
+/*
+ *  is_sane : pattern checking.
+ *  A pattern satisfying these three conditions is reported as sane :
+ *    - At least two steps
+ *    - At least one step with time >=3D UPDATE_INTERVAL
+ *    - At least two steps with differing brightnesses
+ *  When @data->pattern isn't sane, a sensible brightness
+ *  default is suggested in @brightness
+ *
+ * DO NOT call pattern_trig_update() on a not-sane pattern
+ * with is_sane =3D 1, you'll be punished with an infinite
+ * loop in the kernel.
+ */
+static int is_sane(struct pattern_trig_data *data, int *brightness)
+{
+	int i;
+	char stept_ok =3D 0;
+	char stepb_ok =3D 0;
+
+	*brightness =3D 0;
+	if (data->nsteps < 1)
+		return 0;
+
+	*brightness =3D data->steps[0].brightness;
+	if (data->nsteps < 2)
+		return 0;
+
+	for (i =3D 0; i < data->nsteps; i++) {
+		if (data->steps[i].time_ms >=3D UPDATE_INTERVAL) {
+			if (stepb_ok)
+				return 1;
+			stept_ok =3D 1;
+		}
+		if (data->steps[i].brightness !=3D data->steps[0].brightness) {
+			if (stept_ok)
+				return 1;
+			stepb_ok =3D 1;
+		}
+	}
+
+	return 0;
+}
+
+static int reset_pattern(struct pattern_trig_data *data,
+			struct led_classdev *led_cdev)
+{
+	int brightness;
+
+	mutex_lock(&data->lock);
+	data->is_sane =3D 0; /* Prevent pattern_trig_update()
+			      from scheduling new work */
+	mutex_unlock(&data->lock);
+
+	flush_workqueue(data->queue);
+
+	mutex_lock(&data->lock);
+	if (is_sane(data, &brightness)) {
+		data->curr =3D data->steps;
+		data->next =3D data->steps + 1;
+		data->time_ms =3D 0;
+		data->is_sane =3D 1;
+		queue_delayed_work(data->queue, &data->dwork, 0);
+		mutex_unlock(&data->lock);
+		return 0;
+	}
+
+	mutex_unlock(&data->lock);
+	led_set_brightness(led_cdev, brightness);
+	return -EINVAL;
+}
+
+/* --- Sysfs handling --- */
+
+static ssize_t pattern_trig_show_repeat(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
+	struct pattern_trig_data *data =3D led_cdev->trigger_data;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", data->repeat);
+}
+
+static ssize_t pattern_trig_store_repeat(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
+	struct pattern_trig_data *data =3D led_cdev->trigger_data;
+	long res;
+	int err;
+
+	err =3D kstrtol(buf, 10, &res);
+	if (err)
+		return err;
+
+	mutex_lock(&data->lock);
+	data->repeat =3D res < 0 ? -1 : res;
+	mutex_unlock(&data->lock);
+
+	reset_pattern(data, led_cdev);
+
+	return count;
+}
+
+DEVICE_ATTR(repeat, S_IRUGO | S_IWUSR,
+	pattern_trig_show_repeat, pattern_trig_store_repeat);
+
+static ssize_t pattern_trig_show_pattern(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
+	struct pattern_trig_data *data =3D led_cdev->trigger_data;
+	ssize_t count =3D 0;
+	int i;
+
+	if (!data->steps || !data->nsteps)
+		return 0;
+
+	for (i =3D 0; i < data->nsteps; i++)
+		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
+				"%d %d" PATTERN_SEPARATOR,
+				data->steps[i].brightness,
+				data->steps[i].time_ms);
+	buf[count - 1] =3D '\n';
+	buf[count] =3D '\0';
+
+	return count + 1;
+}
+
+static ssize_t pattern_trig_store_pattern(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
+	struct pattern_trig_data *data =3D led_cdev->trigger_data;
+	int cr =3D 0;  /* Characters read after a successful sscanf call */
+	int ccr =3D 0; /* Characters read before looking for PATTERN_SEPARATOR */
+	int tcr =3D 0; /* Total characters read in buf */
+	int ccount;  /* Number of successful conversions in a sscanf call */
+
+	mutex_lock(&data->lock);
+	data->is_sane =3D 0;
+
+	for (data->nsteps =3D 0; data->nsteps < MAX_NSTEPS; data->nsteps++) {
+		cr =3D 0;
+		ccount =3D sscanf(buf + tcr, " %d %d %n" PATTERN_SEPARATOR " %n",
+				&data->steps[data->nsteps].brightness,
+				&data->steps[data->nsteps].time_ms, &ccr, &cr);
+
+		if (!cr) { /* PATTERN_SEPARATOR not reached */
+			if (ccount =3D=3D 2) {
+				/* Successful conversion before
+				   looking for PATTERN_SEPARATOR. */
+				data->nsteps++;
+				tcr +=3D ccr;
+			}
+
+			if (tcr !=3D count) {
+				/* Invalid syntax */
+				data->nsteps =3D 0;
+				mutex_unlock(&data->lock);
+				return -EINVAL;
+			}
+
+			mutex_unlock(&data->lock);
+
+			if (reset_pattern(data, led_cdev)) {
+				/* Invalid pattern */
+				data->nsteps =3D 0;
+				return -EINVAL;
+			}
+
+			return count;
+		}
+
+		tcr +=3D cr;
+	}
+
+	/* Shouldn't reach that */
+	WARN(1, "MAX_NSTEP too small. Please report\n");
+	data->nsteps =3D 0;
+	mutex_unlock(&data->lock);
+	return -EINVAL;
+}
+
+DEVICE_ATTR(pattern, S_IRUGO | S_IWUSR,
+	pattern_trig_show_pattern, pattern_trig_store_pattern);
+
+static int pattern_trig_create_sysfs_files(struct device *dev)
+{
+	int err;
+
+	err =3D device_create_file(dev, &dev_attr_repeat);
+	if (err)
+		return err;
+
+	err =3D device_create_file(dev, &dev_attr_pattern);
+	if (err)
+		device_remove_file(dev, &dev_attr_repeat);
+
+	return err;
+}
+
+static void pattern_trig_remove_sysfs_files(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_pattern);
+	device_remove_file(dev, &dev_attr_repeat);
+}
+
+/* --- Led intensity updating --- */
+
+static int compute_brightness(struct pattern_trig_data *data)
+{
+	if (data->time_ms =3D=3D 0)
+		return data->curr->brightness;
+
+	if (data->curr->time_ms =3D=3D 0) /* Don't divide by zero */
+		return data->next->brightness;
+
+	return data->curr->brightness + data->time_ms
+		* (data->next->brightness - data->curr->brightness)
+		/ data->curr->time_ms;
+}
+
+static void update_to_next_step(struct pattern_trig_data *data)
+{
+	data->curr =3D data->next;
+	if (data->curr =3D=3D data->steps)
+		data->repeat--;
+
+	if (data->next =3D=3D data->steps + data->nsteps - 1)
+		data->next =3D data->steps;
+	else
+		data->next++;
+
+	data->time_ms =3D 0;
+}
+
+static void pattern_trig_update(struct work_struct *work)
+{
+	struct delayed_work *dwork =3D to_delayed_work(work);
+	struct pattern_trig_data *data =3D
+		container_of(dwork, struct pattern_trig_data, dwork);
+
+	mutex_lock(&data->lock);
+
+	if (!data->is_sane || !data->repeat) {
+		mutex_unlock(&data->lock);
+		return;
+	}
+
+	if (data->time_ms > data->curr->time_ms)
+		update_to_next_step(data);
+
+	/* is_sane() checked that there is at least
+	   one step with time_ms >=3D UPDATE_INTERVAL
+	   so we won't go in an infinite loop */
+	while (data->curr->time_ms < UPDATE_INTERVAL)
+		update_to_next_step(data);
+
+	if (data->next->brightness =3D=3D data->curr->brightness) {
+		/* Constant brightness for this step */
+		led_set_brightness(data->led_cdev, data->curr->brightness);
+		queue_delayed_work(data->queue, &data->dwork,
+				msecs_to_jiffies(data->curr->time_ms));
+		update_to_next_step(data);
+	} else {
+		/* Gradual dimming */
+		led_set_brightness(data->led_cdev, compute_brightness(data));
+		data->time_ms +=3D UPDATE_INTERVAL;
+		queue_delayed_work(data->queue, &data->dwork,
+				msecs_to_jiffies(UPDATE_INTERVAL));
+	}
+
+	mutex_unlock(&data->lock);
+}
+
+/* --- Trigger activation --- */
+
+static void pattern_trig_activate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data =3D NULL;
+	int err;
+
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	err =3D pattern_trig_initialize_data(data);
+	if (err) {
+		kfree(data);
+		return;
+	}
+
+	led_cdev->trigger_data =3D data;
+	data->led_cdev =3D led_cdev;
+	data->queue =3D alloc_ordered_workqueue("pattern trigger on %s", 0,
+					led_cdev->name ? led_cdev->name : "?");
+	INIT_DELAYED_WORK(&data->dwork, pattern_trig_update);
+	pattern_trig_create_sysfs_files(led_cdev->dev);
+}
+
+static void pattern_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data =3D led_cdev->trigger_data;
+
+	if (data) {
+		pattern_trig_remove_sysfs_files(led_cdev->dev);
+
+		mutex_lock(&data->lock);
+		data->is_sane =3D 0; /* Prevent pattern_trig_update()
+				      from scheduling new work */
+		mutex_unlock(&data->lock);
+
+		flush_workqueue(data->queue);
+		destroy_workqueue(data->queue);
+
+		led_set_brightness(led_cdev, LED_OFF);
+		pattern_trig_clear_data(data);
+		kfree(data);
+
+		led_cdev->trigger_data =3D NULL;
+	}
+}
+
+static struct led_trigger pattern_led_trigger =3D {
+	.name =3D "pattern",
+	.activate =3D pattern_trig_activate,
+	.deactivate =3D pattern_trig_deactivate,
+};
+
+/* --- Module loading/unloading --- */
+
+static int __init pattern_trig_init(void)
+{
+	return led_trigger_register(&pattern_led_trigger);
+}
+
+static void __exit pattern_trig_exit(void)
+{
+	led_trigger_unregister(&pattern_led_trigger);
+}
+
+module_init(pattern_trig_init);
+module_exit(pattern_trig_exit);
+
+MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
+MODULE_DESCRIPTION("Statuscode LED trigger");
+MODULE_LICENSE("GPL v2");
--=20
1.7.1




--IJpNTDwzlM2Ie8A6--

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls1L14ACgkQMOfwapXb+vKhlwCff1L9SY90fCtV/lYAjTtqNi/A
5jsAoJummZtIjUmyYKsVO/yqneE8uykn
=98P2
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
