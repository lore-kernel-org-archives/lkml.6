Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A1EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60C8204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnbCGG/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60C8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbeKGHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34242 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbeKGHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so12963601ljd.1;
        Tue, 06 Nov 2018 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zC8olPXIP1m+aElXQbL+eklfUqpBvpm5fTfyFX939O4=;
        b=JnbCGG/iqJqmzm3r05laPiqYRzAhKXyIb7p/ikLm1IdCrAYnaZZYYr5Q/Oeg+4ni8Y
         riUd+pRvYLG8MGgLPaND9C/adfI7T2LU++24btG7BIYASKzXihb5BXCe2ESERZOsOHel
         K/ErnBz8D/nnz/u9YzmhMm908ShsnIJA0lGkcIouN8ZQWJvJqah7JG5WHcS66Mud/uZh
         51BUUpDMQ/gDrPdscpUG7X5QtKS2S14Ar5JZ8p6jS+sL/tf/dnnzAxScr9c2DiaV+/sP
         NP5JIqMLPX5ODQGSU1FceqtaOJ+ksi7Lu9aQ1okhuz52nI3fDnc92x42vh7dPpLU0cWv
         q/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zC8olPXIP1m+aElXQbL+eklfUqpBvpm5fTfyFX939O4=;
        b=spJ65x6MC1DUBsFWd1EpY98Ur2MfE7AXRwPnc+iqFD0vKXJoBTwtSW5HMthD7uHrea
         cltYj6Wzs8M9ZDGwdJPJudoJIRVUGGuhn9Kj33qFyryd37iPRoEsZ2huujLSnWzxaw1I
         6c5vWj/e2Gwi0NpFGa3BsRriKaR7tCsc5O9sqBxI+eB0BZ55JXosA5f0AnRM3bE0b5BX
         +Qf6HNTWREDwqB7XGEPgeay6HUw9IPXvmjz7v3J2IieJRceS4PFZ+y7gGRY8fVSv6IVY
         iW3cUTMuEDCpS4+nvUm/B+LYDQQ51ApuTiaqRGMZSWab6q+wpQ88Jsvme6xfzv+O8+X+
         F3uA==
X-Gm-Message-State: AGRZ1gKQyBxi96h6N0RWCY6AThM5biqq5wN0UCGc/OEuPezW1vkWZXOW
        mqtWoZ1uXpjnG+D2Sx477RMR3MCw
X-Google-Smtp-Source: AJdET5cgiClT+5ZvcvVpNGdRgWhCQcvjUEkB/wK4f+1KfTQZKUm0L99P7PKEomyMLP0FlBEfw0La0Q==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr251315ljj.18.1541542067439;
        Tue, 06 Nov 2018 14:07:47 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:46 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: [PATCH 02/24] leds: core: Add support for composing LED class device names
Date:   Tue,  6 Nov 2018 23:07:10 +0100
Message-Id: <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add public led_compose_name() API for composing LED class device
name basing on fwnode_handle data. The function composes device name
according to either a new <color:function> pattern or the legacy
<devicename:color:function> pattern. The decision on using the
particular pattern is made basing on whether fwnode contains new
"function" and "color" properties, or the legacy "label" proeprty.

Backwards compatibility with in-driver hard-coded LED class device
names is assured thanks to the default_desc argument.

In case none of the aformentioned properties was found, then, for OF
nodes, the node name is adopted for LED class device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
---
 Documentation/leds/leds-class.txt |  2 +-
 drivers/leds/led-core.c           | 71 +++++++++++++++++++++++++++++++++++++++
 include/linux/leds.h              | 32 ++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
index 836cb16..e9009c4 100644
--- a/Documentation/leds/leds-class.txt
+++ b/Documentation/leds/leds-class.txt
@@ -43,7 +43,7 @@ LED Device Naming
 
 Is currently of the form:
 
-"devicename:colour:function"
+"colour:function"
 
 There have been calls for LED properties such as colour to be exported as
 individual led class attributes. As a solution which doesn't incur as much
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index ede4fa0..f7371fc 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -16,6 +16,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/rwsem.h>
 #include "leds.h"
 
@@ -327,3 +329,72 @@ void led_sysfs_enable(struct led_classdev *led_cdev)
 	led_cdev->flags &= ~LED_SYSFS_DISABLE;
 }
 EXPORT_SYMBOL_GPL(led_sysfs_enable);
+
+static void led_parse_properties(struct fwnode_handle *fwnode,
+				 struct led_properties *props)
+{
+	int ret;
+
+	if (!fwnode)
+		return;
+
+	ret = fwnode_property_read_string(fwnode, "label", &props->label);
+	if (!ret)
+		return;
+
+	ret = fwnode_property_read_string(fwnode, "function", &props->function);
+	if (ret)
+		pr_info("Failed to parse function property\n");
+
+	ret = fwnode_property_read_string(fwnode, "color", &props->color);
+	if (ret)
+		pr_info("Failed to parse color property\n");
+}
+
+int led_compose_name(struct fwnode_handle *fwnode, const char *led_hw_name,
+		     const char *default_desc, char *led_classdev_name)
+{
+	struct led_properties props = {};
+
+	if (!led_classdev_name)
+		return -EINVAL;
+
+	led_parse_properties(fwnode, &props);
+
+	if (props.label) {
+		/*
+		 * Presence of 'label' DT property implies legacy LED name,
+		 * formatted as <devicename:color:function>, with possible
+		 * section omission if doesn't apply to given device.
+		 *
+		 * If no led_hw_name has been passed, then it indicates that
+		 * DT label should be used as-is for LED class device name.
+		 * Otherwise the label is prepended with led_hw_name to compose
+		 * the final LED class device name.
+		 */
+		if (!led_hw_name) {
+			strncpy(led_classdev_name, props.label,
+				LED_MAX_NAME_SIZE);
+		} else {
+			snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+				 led_hw_name, props.label);
+		}
+	} else if (props.function || props.color) {
+		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+			 props.color ?: "", props.function ?: "");
+	} else if (default_desc) {
+		if (!led_hw_name) {
+			pr_err("Legacy LED naming requires devicename segment");
+			return -EINVAL;
+		}
+		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+			 led_hw_name, default_desc);
+	} else if (is_of_node(fwnode)) {
+		strncpy(led_classdev_name, to_of_node(fwnode)->name,
+			LED_MAX_NAME_SIZE);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(led_compose_name);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 646c49a..ddb4001 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -238,6 +238,32 @@ extern void led_sysfs_disable(struct led_classdev *led_cdev);
 extern void led_sysfs_enable(struct led_classdev *led_cdev);
 
 /**
+ * led_compose_name - compose LED class device name
+ * @child: child fwnode_handle describing a LED,
+ *	   or a group of synchronized LEDs.
+ * @led_hw_name: name of the LED controller, used when falling back to legacy
+ *		 LED naming; it should be set to NULL in new LED class drivers
+ * @default_desc: default <color:function> tuple, for backwards compatibility
+ *		  with in-driver hard-coded LED names used as a fallback when
+ *		  "label" DT property was absent; it should be set to NULL
+ *		  in new LED class drivers
+ * @led_classdev_name: composed LED class device name
+ *
+ * Create LED class device name basing on the configuration provided by the
+ * board firmware. The name can have a legacy form <devicename:color:function>,
+ * or a new form <color:function>. The latter is chosen if at least one of
+ * "color" or "function" properties is present in the fwnode, leaving the
+ * section blank if the related property is absent. The former is applied
+ * when legacy "label" property is present in the fwnode. In case none of the
+ * aformentioned properties was found, then, for OF nodes, the node name
+ * is adopted for LED class device name.
+ *
+ * Returns: 0 on success or negative error value on failure
+ */
+extern int led_compose_name(struct fwnode_handle *child, const char *led_hw_name,
+			    const char *default_desc, char *led_classdev_name);
+
+/**
  * led_sysfs_is_disabled - check if LED sysfs interface is disabled
  * @led_cdev: the LED to query
  *
@@ -414,6 +440,12 @@ struct led_platform_data {
 	struct led_info	*leds;
 };
 
+struct led_properties {
+	const char *color;
+	const char *function;
+	const char *label;
+};
+
 struct gpio_desc;
 typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
 				unsigned long *delay_on,
-- 
2.1.4

