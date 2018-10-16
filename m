Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C824C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F662148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkamGQ8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F662148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJQHrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:39 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37805 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbeJQHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:38 -0400
Received: by mail-vk1-f202.google.com with SMTP id w65-v6so2434404vkw.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v7Vdu6qIuJDj39fxhnwZmKq9fD4gFEoXGX/BaHbf6WY=;
        b=SkamGQ8FhTSHorjRljiJ6OFjD1m25IP36W7aMKtTvCYBTsCiHMQ+g6OFZ5CrW0Upqi
         7mPFJKchLsgfdjOW+QOJbhaJfZoUjNBWn9pxuTZBLRFB/G3iYschPGYmqGTRLXnWXe56
         E+Ku6Hy4CgqEyeNB+DFizdSn/TCDkQ73T+lJA0qmOY+SQIGxS8zbc7Yu8SDw01YaZYbQ
         3c7PRNsuK6UycYb0zxh8yXy4612Ntg8n3d0GWgXfEUqF0cnDN9FCfxwow5Au5BXO1w+l
         5vR1oqiR6EH4rgQ6FYCUHMk9hG+r+Vwcq9dCw+Vig44hEnQNg09IjV8bDhM4LIW0YOUH
         z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v7Vdu6qIuJDj39fxhnwZmKq9fD4gFEoXGX/BaHbf6WY=;
        b=HdMBDQ6W+sCI32KupvR9EzJoEaTwy1W7cFjVhE/wA5hqBf57GsOjlpprE1H2GzI/7O
         NYeM82OMJEPwJ25sH9JEaqTfqbusw5o6V6RQEqbXjiqMwndsi2j+86kshd3Z6KiLD5gO
         kKdhNQeH8d7NQoR1JWTGY0ZRnJkEn3pG+QEYsBp70fnBuxnzWmXQnke8aPkSrfWVRBvV
         tGQ7lJslvMNlsrqtjDfVkJdVRKez2XGDJGZ0jX2Ydt40vT9yDCAhwp1Xn7EMoGJkO77r
         SljUVI1gRXTXDK8/B4O5tE6aRFErB4CvsS7qoXau6t6FQbQI9Qcqust6T3+BVYXhOMCx
         JD5A==
X-Gm-Message-State: ABuFfohl8OIa+FwKxEKuZZkLBjE5//SZwYKstMSR9XHwiURXb00vQtjz
        Lxh7u1q2XetphHZXeFLYkqFSoWD+b/aA0mW/pX/itg==
X-Google-Smtp-Source: ACcGV624pVPucriQYprUzO/GVEaPpNRkvZ/3eMhUsnZvHlDsB/kz5iwwgeHbsp39vDToO03LzP5qRgwLVX6LGUat1s5cMA==
X-Received: by 2002:a67:7ec5:: with SMTP id z188mr18417863vsc.30.1539734087634;
 Tue, 16 Oct 2018 16:54:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:14 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-26-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 25/31] kunit: added concept of platform mocking
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform mocking is the mocking of all platform specific functions that
interact directly with hardware. In effect, this provides the ability to
mock any hardware behavior.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/base/Makefile                |  1 +
 drivers/base/platform-mock.c         | 65 ++++++++++++++++++++++++++++
 include/linux/platform_device_mock.h | 64 +++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/base/platform-mock.c
 create mode 100644 include/linux/platform_device_mock.h

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 704f442958103..77cc599daa020 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
+obj-$(CONFIG_PLATFORM_MOCK) += platform-mock.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/platform-mock.c b/drivers/base/platform-mock.c
new file mode 100644
index 0000000000000..3df9f1b0bb50f
--- /dev/null
+++ b/drivers/base/platform-mock.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fake platform device API for unit testing platform drivers.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/platform_device_mock.h>
+#include <linux/of_platform.h>
+
+struct device_node *of_fake_node(struct test *test, const char *name)
+{
+	struct device_node *node;
+
+	node = test_kzalloc(test, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	of_node_init(node);
+
+	return node;
+}
+
+struct platform_device *
+of_fake_probe_platform(struct test *test,
+		       const struct platform_driver *driver,
+		       const char *node_name)
+{
+	struct platform_device *pdev;
+	struct device_node *of_node;
+	int ret;
+
+	of_node = of_fake_node(test, node_name);
+	if (!of_node)
+		return ERR_PTR(-ENOMEM);
+
+	test_info(test, "Creating device");
+	pdev = of_platform_device_create(of_node, node_name, NULL);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	test_info(test, "Probing");
+	ret = driver->probe(pdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pdev;
+}
+
+struct platform_device *of_fake_probe_platform_by_name(struct test *test,
+						       const char *driver_name,
+						       const char *node_name)
+{
+	const struct device_driver *driver;
+
+	test_info(test, "Locating driver by name");
+	driver = driver_find(driver_name, &platform_bus_type);
+	if (!driver)
+		return ERR_PTR(-ENODEV);
+
+	return of_fake_probe_platform(test,
+				      to_platform_driver(driver),
+				      node_name);
+}
diff --git a/include/linux/platform_device_mock.h b/include/linux/platform_device_mock.h
new file mode 100644
index 0000000000000..898539d166f66
--- /dev/null
+++ b/include/linux/platform_device_mock.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fake platform device API for unit testing platform drivers.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/platform_device.h>
+#include <kunit/mock.h>
+
+static inline struct platform_driver *platform_driver_find(const char *name)
+{
+	struct device_driver *driver;
+
+	driver = driver_find(name, &platform_bus_type);
+	if (!driver)
+		return NULL;
+
+	return to_platform_driver(driver);
+}
+
+/**
+ * of_fake_node()
+ * @test: the test to associate node with
+ * @name: name of the node
+ *
+ * The &struct device_node returned is allocated as a root node with the given
+ * name and otherwise behaves as a real &struct device_node.
+ *
+ * Returns: the faked &struct device_node
+ */
+struct device_node *of_fake_node(struct test *test, const char *name);
+
+/**
+ * of_fake_probe_platform()
+ * @test: the test to associate the fake platform device with
+ * @driver: driver to probe
+ * @node_name: name of the device node created
+ *
+ * Creates a &struct platform_device and an associated &struct device_node,
+ * probes the provided &struct platform_driver with the &struct platform_device.
+ *
+ * Returns: the &struct platform_device that was created
+ */
+struct platform_device *
+of_fake_probe_platform(struct test *test,
+		       const struct platform_driver *driver,
+		       const char *node_name);
+
+/**
+ * of_fake_probe_platform_by_name()
+ * @test: the test to associate the fake platform device with
+ * @driver_name: name of the driver to probe
+ * @node_name: name of the device node created
+ *
+ * Same as of_fake_probe_platform() but looks up the &struct platform_driver by
+ * the provided name.
+ *
+ * Returns: the &struct platform_device that was created
+ */
+struct platform_device *of_fake_probe_platform_by_name(struct test *test,
+						       const char *driver_name,
+						       const char *node_name);
-- 
2.19.1.331.ge82ca0e54c-goog

