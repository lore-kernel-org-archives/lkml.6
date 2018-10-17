Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF08ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5CF2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bALUkESm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5CF2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJQQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:54:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60684 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:54:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017085953euoutp01eea45d02fded47101e44152f3e3a3025~eWb2xSbQD1975819758euoutp01e;
        Wed, 17 Oct 2018 08:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017085953euoutp01eea45d02fded47101e44152f3e3a3025~eWb2xSbQD1975819758euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539766793;
        bh=WI3F1xM62Fk6UsbqhzCd5tOGs2n0Z2wRTbCYB/hEOYE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=bALUkESmhsnI/WK1AExu92XbOoyALmltC1nUSst0YoeDXYh5QOII5ufFICsiN+STy
         gzuwKcWkd/9wqhwpXsXPAiKeNmpzq05/1KUlk8TOiKu2F981ytNamB+vTAnzKWshy3
         nLEa79h0w+03PiDMcxn1Q6Zrqjf0M2gHzCVXg0jY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017085952eucas1p2cecdc59208b26971f564651c8c06872a~eWb16pLde2641926419eucas1p2A;
        Wed, 17 Oct 2018 08:59:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.F1.04294.80AF6CB5; Wed, 17
        Oct 2018 09:59:52 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab~eWb1OCkZl2643026430eucas1p2n;
        Wed, 17 Oct 2018 08:59:52 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-b0-5bc6fa0821a9
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.C8.04284.80AF6CB5; Wed, 17
        Oct 2018 09:59:52 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ0074EJNRRY50@eusync1.samsung.com>;
        Wed, 17 Oct 2018 09:59:52 +0100 (BST)
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
Subject: [PATCH v2 2/3] driver core: add deferring probe reason to
 devices_deferred property
Date:   Wed, 17 Oct 2018 10:59:36 +0200
Message-id: <20181017085936.30886-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7djP87ocv45FG7x4o25xa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzWHvkLrvF3C9TmR24PHbOusvusWlV
        J5vH/rlr2D02L6n3eL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZSz+t5i1oEOlYvm9
        iSwNjL9luxg5OSQETCR6ds9j6WLk4hASWMEoMfXWGSYI5zOjxIfp04EyHGBVV6eLQ8SXMUr8
        2j2ZEcL5zyixZPp8JpBRbAKaEn8332QDsUUEjCX6z85iByliFnjDJPHkwRSwImGBOIm2E81g
        RSwCqhInN+1gBLF5BSwkfs/dzQpxk7zEw+PtYHFOgWCJpdvPMoMMkhBYwybxqbWNGaLIReL6
        5jcsELawxKvjW9ghbBmJzo6DTBB2vUTTzCtQzR2MEicWL2eDSFhLHD5+EWwbswCfxKRt05kh
        /uSV6GgTgijxkLjQ+wAaFksYJSa2P2abwCi5gJFhFaN4amlxbnpqsVFearlecWJucWleul5y
        fu4mRmDMnv53/MsOxl1/kg4xCnAwKvHw7hA7Fi3EmlhWXJl7iFGCg1lJhDdzMVCINyWxsiq1
        KD++qDQntfgQozQHi5I477J5G6OFBNITS1KzU1MLUotgskwcnFINjKHrGGsjn3Mev8Ub88c0
        JSNbK/D0g6eCxyuqD018dWD+Ysbv4Su3Ljux4KtsYXff29cPVnO827/Pq8fnzNLFt9Y+W3We
        X9ba4XfhPOnio4rnVwdfTpynOb+sNd6W2fnYDPeVAeXN/LEnSy5X/Di7/NR+zefhfRafTs5s
        XOQR4v3F8u5sBtvPFzYosRRnJBpqMRcVJwIA8PVif9UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t/xy7ocv45FG3ycwmVxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzWHvkLrvF3C9TmR24PHbOusvusWlV
        J5vH/rlr2D02L6n3eL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZSz+t5i1oEOlYvm9
        iSwNjL9luxg5OCQETCSuThfvYuTiEBJYwihxqm8iO4TTyCTxd8c1pi5GTg42AU2Jv5tvsoHY
        IgLGEv1nZ4EVMQu8Y5KY9eQFI0hCWCBOou1EM1gRi4CqxMlNO8DivAIWEr/n7mYFsSUE5CUe
        Hm8Hi3MKBEss27UELC4kECBxfvcTtgmMPAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIE
        Btu2Yz8372C8tDH4EKMAB6MSD+8OsWPRQqyJZcWVuYcYJTiYlUR4MxcDhXhTEiurUovy44tK
        c1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTAyd9WoFAfvrWP5OCf7+O3Lry1m
        X9pxYfm5FUe31F9zskqYOIX9myXn9GkfnNPPhUYrpYneM0lwfhe7qelH5s5/iytbFqdErS2c
        /9/N7lnhYmNOUYuP5zsn89+bz3FwiV1VkmtaZGQY+3/BQx7TViy6cGRRIivz5g3+sq6f5WS3
        ye4I4dqYLNCgxFKckWioxVxUnAgAIMtP+zICAAA=
X-CMS-MailID: 20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab
References: <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com>
        <CGME20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab@eucas1p2.samsung.com>
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
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
v2:
  - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
  - use kasprintf instead of bunch of code,
  - keep consistent format of devices_deferred lines,
  - added R-Bs (again I hope changes above are not against it).
---
 drivers/base/base.h |  3 +++
 drivers/base/core.c | 11 +++++++----
 drivers/base/dd.c   | 21 ++++++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..effbd5e7f9f1 100644
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
+extern void __deferred_probe_set_msg(const struct device *dev,
+				     struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index aa6f3229d066..560758b2ae79 100644
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
@@ -3091,13 +3092,15 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (err == -EPROBE_DEFER)
-		return err;
-
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	dev_err(dev, "%pV, %d\n", &vaf, err);
+
+	if (err != -EPROBE_DEFER)
+		dev_err(dev, "%pV, %d\n", &vaf, err);
+	else
+		__deferred_probe_set_msg(dev, &vaf);
+
 	va_end(args);
 
 	return err;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..345fbfe335d1 100644
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
@@ -202,6 +205,21 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/*
+ * __deferred_probe_set_msg() - Set defer probe reason message for device
+ */
+void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
+{
+	mutex_lock(&deferred_probe_mutex);
+
+	if (dev->p->deferred_probe_msg)
+		kfree(dev->p->deferred_probe_msg);
+	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV",
+					       dev_driver_string(dev), vaf);
+
+	mutex_unlock(&deferred_probe_mutex);
+}
+
 /*
  * deferred_devs_show() - Show the devices in the deferred probe pending list.
  */
@@ -212,7 +230,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 	mutex_lock(&deferred_probe_mutex);
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
-		seq_printf(s, "%s\n", dev_name(curr->device));
+		seq_printf(s, "%s\t%s\n", dev_name(curr->device),
+			   curr->device->p->deferred_probe_msg ?: "");
 
 	mutex_unlock(&deferred_probe_mutex);
 
-- 
2.18.0

