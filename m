Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B01ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9A214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVQsuPOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E9A214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIQXoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIQXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so8066330pgv.1;
        Mon, 17 Sep 2018 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1Quryx9grl41Nd+ls3UYvD3BSFyx3VEwFoALI86xJw=;
        b=tVQsuPOjqGVRle8ylIE8s1cW+1fpxJ9/yHljnmT+lGQ+WFaGI18TFmWHmHGxQ1vijA
         Siw/VBrlM1/sHRXaMFsISnFyf2xsfD6/IXQXkufrLENfvDjgFUpPebE8LkDIHDfT9Ltz
         DAxc54XiWOimBafflzb5pZa8jDp/sWznKk+oTLkRiiUKPFtqGnJjkM8eRPSuE7XRIYGG
         D9W4yrjVMN80MH+ntUNCZbzaC5S+rcsaxpBG+sPzLvN89UQYCSa2c0+BUMteYoSZG/9A
         dEeHwMAjVd3n2Hkm9wUQP+eDZnT2r8l5yDNjOCXjq4NPoEcTFiH23WJTzu+J0pYfVWRo
         a3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1Quryx9grl41Nd+ls3UYvD3BSFyx3VEwFoALI86xJw=;
        b=NfdJH7nWoH3404jbXRTHvDFfDK8VhYJHvxwSvWSQP9bQTuN31tBqK6TRB+5iD/lpr0
         OQA8mZAMy3iTftpIyvovDvHSLW3I/Yy8M7iVPjCBqYbcSmQwBSoI/UM3jVa+Ww4txTW4
         xG65VCqLhRs0SXraE1dMuBxRFT78sXjM99xSvNleEtL49UzpOwVzJtnarAgd2Q/okuEO
         p22IIeygSsWhr7mDeGFq8iXXCjTOh4Wq+kGwB/SeZZDGyyP10qIC/ZcnjZWRl7YjmPgA
         0DjKMwBNinyLTELrFn9e1Qkfm94ZZaBD1Eomj5nGY5ek4kDX6r+/cQKIpN+owQIsDwof
         DIhw==
X-Gm-Message-State: APzg51BiXPiFwaQZ8FR71B6cDrpk+jpnBIWG3RmMOZg1f7xf3BmfOGX7
        z3pfs+1SbSgKHUGxRKYYiszQD821
X-Google-Smtp-Source: ANB0VdaMekFx/e50wCirIkIu6OgBfIqYV/NronOKMUdRGpwLgnphfbw/GNC1xywDpyW/IBilrb2Hdg==
X-Received: by 2002:a62:e08b:: with SMTP id d11-v6mr27049617pfm.214.1537208174006;
        Mon, 17 Sep 2018 11:16:14 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:12 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors from static properties
Date:   Mon, 17 Sep 2018 11:16:02 -0700
Message-Id: <20180917181603.125492-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that static device properties understand notion of child nodes, let's
teach gpiolib to tie such children and machine GPIO descriptor tables.
We will continue using a single table for entire device, but instead of
using connection ID as a lookup key in the GPIO descriptor table directly,
we will perform additional translation: fwnode_get_named_gpiod() when
dealing with property_set-backed fwnodes will try parsing string property
with name matching connection ID and use result of the lookup as the key in
the table:

static const struct property_entry dev_child1_props[] __initconst = {
	...
	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
	{ }
};

static struct gpiod_lookup_table dev_gpiod_table = {
	.dev_id = "some-device",
	.table = {
		...
		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
		...
	},
};

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib.c | 109 +++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..f0e51d34a1c1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3959,39 +3959,44 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 }
 EXPORT_SYMBOL(gpiod_get_from_of_node);
 
-/**
- * fwnode_get_named_gpiod - obtain a GPIO from firmware node
- * @fwnode:	handle of the firmware node
- * @propname:	name of the firmware property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * This function can be used for drivers that get their configuration
- * from opaque firmware.
- *
- * The function properly finds the corresponding GPIO using whatever is the
- * underlying firmware interface and then makes sure that the GPIO
- * descriptor is requested before it is returned to the caller.
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
+static struct gpio_desc *pset_node_get_gpiod(struct fwnode_handle *fwnode,
+					     const char *propname, int index,
+					     enum gpio_lookup_flags *flags)
 {
-	struct gpio_desc *desc = ERR_PTR(-ENODEV);
-	unsigned long lflags = 0;
-	int ret;
+	struct property_set *pset;
+	const char *con_id;
 
-	if (!fwnode)
+	pset = to_pset_node(fwnode);
+	if (!pset)
 		return ERR_PTR(-EINVAL);
 
+	if (fwnode_property_read_string(fwnode, propname, &con_id)) {
+		/*
+		 * We could not find string mapping property name to
+		 * entry in gpio lookup table. Let's see if we are
+		 * dealing with firmware node corresponding to the
+		 * device (and not a child node): for such nodes we can
+		 * try doing lookup directly with property name.
+		 */
+		if (pset->parent)
+			return ERR_PTR(-ENOENT);
+
+		con_id = propname;
+	}
+
+	return gpiod_find(pset->dev, con_id, index, flags);
+}
+
+static struct gpio_desc *__fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+						  const char *propname,
+						  int index,
+						  enum gpiod_flags dflags,
+						  const char *label)
+{
+	struct gpio_desc *desc = ERR_PTR(-ENODEV);
+	enum gpio_lookup_flags lflags = 0;
+	int ret;
+
 	if (is_of_node(fwnode)) {
 		desc = gpiod_get_from_of_node(to_of_node(fwnode),
 					      propname, index,
@@ -4009,9 +4014,12 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		if (info.polarity == GPIO_ACTIVE_LOW)
 			lflags |= GPIO_ACTIVE_LOW;
+	} else if (is_pset_node(fwnode)) {
+		desc = pset_node_get_gpiod(fwnode, propname, index, &lflags);
+		if (IS_ERR(desc))
+			return desc;
 	}
 
-	/* Currently only ACPI takes this path */
 	ret = gpiod_request(desc, label);
 	if (ret)
 		return ERR_PTR(ret);
@@ -4024,6 +4032,47 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 	return desc;
 }
+
+/**
+ * fwnode_get_named_gpiod - obtain a GPIO from firmware node
+ * @fwnode:	handle of the firmware node
+ * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain for the consumer
+ * @dflags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
+ *
+ * This function can be used for drivers that get their configuration
+ * from opaque firmware.
+ *
+ * The function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * Returns:
+ * On successful request the GPIO pin is configured in accordance with
+ * provided @dflags.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	struct gpio_desc *desc;
+
+	if (!fwnode)
+		return ERR_PTR(-EINVAL);
+
+	desc = __fwnode_get_named_gpiod(fwnode, propname, index, dflags, label);
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT &&
+	    !IS_ERR_OR_NULL(fwnode->secondary)) {
+		desc = __fwnode_get_named_gpiod(fwnode->secondary,
+						propname, index, dflags, label);
+	}
+
+	return desc;
+}
 EXPORT_SYMBOL_GPL(fwnode_get_named_gpiod);
 
 /**
-- 
2.19.0.397.gdd90340f6a-goog

