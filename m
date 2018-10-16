Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B7F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NWypIqF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B7F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJPPL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59800 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJPPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016072251euoutp028054f81d8b6633c73bbb805aedf07bdb~eBd1qSgM81635816358euoutp02G;
        Tue, 16 Oct 2018 07:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016072251euoutp028054f81d8b6633c73bbb805aedf07bdb~eBd1qSgM81635816358euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539674571;
        bh=n6s8ODfGLPqt06r2NaOTqEiqXV/ukN9zx/7Pm9IszQY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NWypIqF+yyM+Kpywi/RAx1LjeWf2aVwz6I3NDhDZkPp7w8l+It6nVY9Czk192+Um4
         NfI8AEbk8RIjTPtUTwx2BBviorGR8XJ9OoVknibXevcfsnfn18LahvMzKXVj2FHh6l
         QTeF4NmfP36cuemuyV+XHvH1YYymjhhhP4xJKpMo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072250eucas1p1ebd0f93494648a7b2177c051a3e9124b~eBd1FnnA01687516875eucas1p1q;
        Tue, 16 Oct 2018 07:22:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.F8.04294.AC195CB5; Tue, 16
        Oct 2018 08:22:50 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016072249eucas1p28855602564eb74a771fe521712962680~eBd0UM8Ui2131721317eucas1p2q;
        Tue, 16 Oct 2018 07:22:49 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-c0-5bc591cabcce
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.F5.04284.9C195CB5; Tue, 16
        Oct 2018 08:22:49 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGO0048DKHZVR70@eusync1.samsung.com>;
        Tue, 16 Oct 2018 08:22:49 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] driver core: add deferring probe reason to
 devices_deferred property
Date:   Tue, 16 Oct 2018 09:22:43 +0200
Message-id: <20181016072244.1216-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <20181016072244.1216-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7djPc7qnJh6NNmjs5Le4te4cq8XLCYcZ
        LTbOWM9qMfXhEzaL5sXr2SwWTlvOaLHp8TVWi8u75rBZrD1yl91i7pepzA5cHjtn3WX32LSq
        k81j/9w17B6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mm61/mEuWKtc8avt
        BksDY59sFyMnh4SAicSqm/eZuxi5OIQEVjBKdPxcwQ7hfGaU6Nq9HsjhAKu69UwdIr6MUeLi
        in1QRf8ZJba/28YKMopNQFPi7+abbCC2iICxRP/ZWWBFzAJvmCSePJjCBJIQFoiWOP32JyOI
        zSKgKjGt/QI7iM0rYC5xaeZhRoib5CUeHm8HszkFLCSub9jMDBFfwybx52g2hO0isXBOJyuE
        LSzx6vgWdghbRqKz4yAThF0v0TTzCthvEgIdjBInFi9ng0hYSxw+fhGsmVmAT2LStunMEG/y
        SnS0CUGUeEjs3/wUbKaQQDejxOffohMYJRcwMqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P
        3cQIjNfT/45/2cG460/SIUYBDkYlHt4f149EC7EmlhVX5h5ilOBgVhLhla08Gi3Em5JYWZVa
        lB9fVJqTWnyIUZqDRUmcd9m8jdFCAumJJanZqakFqUUwWSYOTqkGxtRfdgX9zxi+7BTlUPi2
        vqf9Xuy+RLE2F4Xrc1K5Dz+21nGr7XyusPPw8SmvT3Nvtz4foWX9+8SyGccmROjmlCsKqD2s
        ypbur/04+0PJ06JTBYrv0+s8uL5xT3Jr17F5/8zNr++exs/CXYv5643jq2LydotJTz9RkB74
        rj85VamGaYrby9U7lViKMxINtZiLihMBHWX7LdMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t/xy7onJx6NNpjxQ9ni1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyrjV+oe5YK1yxa+2
        GywNjH2yXYwcHBICJhK3nql3MXJxCAksYZQ4N62NGcJpZJK4vmwfWxcjJwebgKbE3803wWwR
        AWOJ/rOz2EGKmAXeMUnMevKCESQhLBAtcfrtTzCbRUBVYlr7BXYQm1fAXOLSzMNgcQkBeYmH
        x9vBbE4BC4nrGzYzg9hCQDW3L7SxT2DkWcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
        2LYd+7l5B+OljcGHGAU4GJV4eH9cPxItxJpYVlyZe4hRgoNZSYRXtvJotBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQZGbZ1rk2v8+Z1Ytz1OWL7zqP2O
        1B/+CTwZ+76f+WWfuWn3c53uXYtbZtzgvJ+gFLuJ3/FFq0b+ySe3H64L+NNbXRXbyXrDfY1B
        g/v+2r0RNXreDGwi+00OlrLPqPrAZr40plrgn2u+1cslsWWbAh+e7VMsP5LAsH/elTn3LDI4
        SyVm+TXXGd9UYinOSDTUYi4qTgQAdw6ryjICAAA=
X-CMS-MailID: 20181016072249eucas1p28855602564eb74a771fe521712962680
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072249eucas1p28855602564eb74a771fe521712962680
References: <20181016072244.1216-1-a.hajda@samsung.com>
        <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/debug/devices_deferred property contains list of deferred devices.
This list does not contain reason why the driver deferred probe, the patch
improves it.
The natural place to set the reason is probe_err function introduced recently,
ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
will be attached to deferred device and printed when user read devices_deferred
property.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/base.h |  3 +++
 drivers/base/core.c | 15 +++++++++------
 drivers/base/dd.c   | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..6f9371bfe40b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -75,6 +75,7 @@ struct device_private {
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
+	char *deferred_probe_msg;
 	struct device *device;
 };
 #define to_device_private_parent(obj)	\
@@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
+extern void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
+				     va_list args);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 23fabefb217a..df9895adf11b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * This helper implements common pattern present in probe functions for error
  * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * In case of -EPROBE_DEFER it sets defer probe reason.
  * It replaces code sequence:
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -3091,15 +3092,17 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (err != -EPROBE_DEFER) {
-		va_start(args, fmt);
+	va_start(args, fmt);
 
-		vaf.fmt = fmt;
-		vaf.va = &args;
+	vaf.fmt = fmt;
+	vaf.va = &args;
 
+	if (err != -EPROBE_DEFER)
 		__dev_printk(KERN_ERR, dev, &vaf);
-		va_end(args);
-	}
+	else
+		__deferred_probe_set_msg(dev, fmt, args);
+
+	va_end(args);
 
 	return err;
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..e2f81e538d4b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -27,6 +27,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/slab.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
 	if (!list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Removed from deferred list\n");
 		list_del_init(&dev->p->deferred_probe);
+		kfree(dev->p->deferred_probe_msg);
+		dev->p->deferred_probe_msg = NULL;
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
@@ -202,6 +205,32 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/*
+ * __deferred_probe_set_msg() - Set defer probe reason message for device
+ */
+void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
+				     va_list args)
+{
+	const int size = 128;
+	char **p;
+	int n;
+
+	mutex_lock(&deferred_probe_mutex);
+
+	p = &dev->p->deferred_probe_msg;
+	if (!*p) {
+		*p = kmalloc(size, GFP_KERNEL);
+		if (!*p)
+			goto end;
+	}
+	n = snprintf(*p, size, "%s %s: ", dev_driver_string(dev), dev_name(dev));
+	if (n < size)
+		vsnprintf(*p + n, size - n, fmt, args);
+
+end:
+	mutex_unlock(&deferred_probe_mutex);
+}
+
 /*
  * deferred_devs_show() - Show the devices in the deferred probe pending list.
  */
@@ -212,7 +241,10 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 	mutex_lock(&deferred_probe_mutex);
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
-		seq_printf(s, "%s\n", dev_name(curr->device));
+		if (curr->device->p->deferred_probe_msg)
+			seq_puts(s, curr->device->p->deferred_probe_msg);
+		else
+			seq_printf(s, "%s\n", dev_name(curr->device));
 
 	mutex_unlock(&deferred_probe_mutex);
 
-- 
2.18.0

