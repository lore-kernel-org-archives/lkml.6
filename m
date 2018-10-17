Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0211921470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8AoyWxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0211921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJRGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:54:21 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34423 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeJRGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:54:21 -0400
Received: by mail-qk1-f201.google.com with SMTP id y201-v6so29715965qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=oP7X8xTbzB83fCqBZnkS2a5Tulwi7NQH82EUDN8Qkrg=;
        b=i8AoyWxcR+i0oSkuqls6/EbqetvvBem5a57CtZMyHHFdD282NvRntG/KOpTuMRlKV/
         2PxCFUsQrmPacLOOI7fbRvT7puowmgWgL3D8kRabEP0INvYoS6+cjCavNw6EB9giA3cg
         k87XP3OJ6AlhvLviqZfgUmw83sW3cS24WewTYQZHrF9P3SprlQEQsNFsbJryJGt8G3+b
         ArrQZ1cf7zuihxXUHHF3DiRvVEo6f36frkBU2i50Sa4weIe7v0pUkOob0pLIM2DSXQwY
         Urx6x4c66WadGrU0VzXDUkeUwV2VCNiUK4igWBBJRAAvLbkQr39w/TIqfnExLP2V6lpJ
         h5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=oP7X8xTbzB83fCqBZnkS2a5Tulwi7NQH82EUDN8Qkrg=;
        b=XaR03+6dXK6ATTDe+XVwWAvqxEad6qLEs/Al8WmR4c1xR3nrgIZ5YEx5VPlEULvp+V
         P29GrZnTd7nVejqmhBVm2jqsXVqcBhAT0vKAGtZaOUujQLQE78IJaZRCrTTKupewvp7G
         NzP5R4J7XLADn5IsmZVX7DcS/s1GF7o5tYF2qntN1Bz3l9pdTuPxV4c0hH4Q19BIBuxJ
         fpaJlsdc2loFdo3A4tJwuUyLULTMYm2zbwtKKsA3/aHINPkNQ2IUnGlYYItXdLiGYbYX
         3sV6hz4vg164UvUjkwt5M8fR1MH/zPyHnNLTyRjKZ8Z9kSaUD45i6s6Vnmc0FekczjkG
         hRWw==
X-Gm-Message-State: ABuFfoheS4iW/DmvQL1SMT/2rAcyQsdO/fWko+hhDurVECwnSP9XZedw
        wnjrZhH5oag/tEgUzL7LNZ5pCuy0tw==
X-Google-Smtp-Source: ACcGV62Z9wsNwk04FVsHx+qMcqs7qJtlM1fZdLd2cv5nIo2hRIADxgzURNLx2j5thw6dMfC1P/Ja8mioEg==
X-Received: by 2002:a0c:99ed:: with SMTP id y45mr6403774qve.7.1539816986663;
 Wed, 17 Oct 2018 15:56:26 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:56:22 -0700
Message-Id: <20181017225622.8366-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH 2/2] hwmon: (isl68137) add accessors to enable/disable AVS mode
From:   Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, kunyi@google.com,
        Robert Lippert <rlippert@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Lippert <rlippert@google.com>

This patch adds sysfs files avs(0|1)_enabled underneath the I2C device
to control the AVS state of each rail and perform the appropriate
hacks when enabling AVS.

The ISL68137 has issues wrt AVS operation mode that require it
to be enabled/disabled at runtime.

Additionally enabling AVS mode requires a hack to set the VOUT value
before enabling to make sure that the device does not switch to
an old cached AVS provided value and is instead in a "clean" state
before booting.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Kun Yi <kunyi@google.com>
---
 drivers/hwmon/pmbus/isl68137.c | 120 ++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 2a5322e4a286..94e2894f13bc 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -19,8 +19,11 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
 #include "pmbus.h"
 
+#define ISL68137_VOUT_AVS 0x30
+
 static struct pmbus_driver_info isl68137_info = {
 	.pages = 2,
 	.format[PSC_VOLTAGE_IN] = direct,
@@ -56,10 +59,123 @@ static struct pmbus_driver_info isl68137_info = {
 	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
 };
 
+static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
+					     int page,
+					     char *buf)
+{
+	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+
+	return sprintf(buf, "%d\n",
+		       (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS ? 1 : 0);
+}
+
+static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
+					      int page,
+					      const char *buf, size_t count)
+{
+	int rc, op_val;
+
+	if (count < 1) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	switch (buf[0]) {
+	case '0':
+		op_val = 0;
+		break;
+	case '1':
+		op_val = ISL68137_VOUT_AVS;
+		break;
+	default:
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Writes to VOUT setpoint over AVSBus will persist after the VRM is
+	 * switched to PMBus control. Switching back to AVSBus control
+	 * restores this persisted setpoint rather than re-initializing to
+	 * PMBus VOUT_COMMAND. Writing VOUT_COMMAND first over PMBus before
+	 * enabling AVS control is the workaround.
+	 */
+	if (op_val == ISL68137_VOUT_AVS) {
+		int vout_command = pmbus_read_word_data(client, page,
+							PMBUS_VOUT_COMMAND);
+		rc = pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,
+					   vout_command);
+		if (rc)
+			goto out;
+	}
+
+	rc = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
+				    ISL68137_VOUT_AVS, op_val);
+
+out:
+	return rc < 0 ? rc : count;
+}
+
+static ssize_t isl68137_avs_enable_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	struct i2c_client *client = kobj_to_i2c_client(&dev->kobj);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+
+	return isl68137_avs_enable_show_page(client, attr->index, buf);
+}
+
+static ssize_t isl68137_avs_enable_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(&dev->kobj);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+
+	return isl68137_avs_enable_store_page(client, attr->index, buf, count);
+}
+
+static SENSOR_DEVICE_ATTR_2(avs0_enabled, 0644,
+			    isl68137_avs_enable_show, isl68137_avs_enable_store,
+			    0, 0);
+static SENSOR_DEVICE_ATTR_2(avs1_enabled, 0644,
+			    isl68137_avs_enable_show, isl68137_avs_enable_store,
+			    0, 1);
+
+static int isl68137_remove(struct i2c_client *client);
+
 static int isl68137_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	return pmbus_do_probe(client, id, &isl68137_info);
+	int rc;
+
+	rc = pmbus_do_probe(client, id, &isl68137_info);
+	if (rc)
+		return rc;
+
+	rc = device_create_file(&client->dev,
+				&sensor_dev_attr_avs0_enabled.dev_attr);
+	if (rc)
+		goto out_fail;
+	rc = device_create_file(&client->dev,
+				&sensor_dev_attr_avs1_enabled.dev_attr);
+	if (rc)
+		goto out_fail;
+
+	return rc;
+
+out_fail:
+	isl68137_remove(client);
+	return rc;
+}
+
+static int isl68137_remove(struct i2c_client *client)
+{
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_avs1_enabled.dev_attr);
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_avs0_enabled.dev_attr);
+	return pmbus_do_remove(client);
 }
 
 static const struct i2c_device_id isl68137_id[] = {
@@ -75,7 +191,7 @@ static struct i2c_driver isl68137_driver = {
 		   .name = "isl68137",
 		   },
 	.probe = isl68137_probe,
-	.remove = pmbus_do_remove,
+	.remove = isl68137_remove,
 	.id_table = isl68137_id,
 };
 
-- 
2.19.1.331.ge82ca0e54c-goog

