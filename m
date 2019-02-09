Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADCC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E21421929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiOx8B4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBIU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:59:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34481 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBIU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:59:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so10233839wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3DW2v8Jr8qnxl1LfWySKmyhEY7STPGyvaTKh7X6Nmp4=;
        b=kiOx8B4Xo5XQx+4Vt2KFJIN901A3wtUSgmJvgRClDyHJ03eB0CS8uecLtS7EwrKxsI
         tu/0IJWccNRvBSdhEbJhEFAIeWVOZcvTZK6L6fH4nlv2pIWpSAB0bA9D5ILmKvLNjgUe
         YDJZFWgv8GKHp6dVKrUi1Ion0SfbwnNW3d7T0zQo3IJSUu1My1nXyCWcBDqW24YBtM/R
         H9yUxJBFRyMv2TftOOnFrwxhnfccpg1by+Dd/qPDCTb1kI2FfVjrUn75sJvtuX3RZPve
         Yc4KIeq1Qky7ll6DNMm7y+Xo62+M0+2zFBHagg5BKDpS2e+OnxsTLEE0fiSf//JGrfyq
         M96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3DW2v8Jr8qnxl1LfWySKmyhEY7STPGyvaTKh7X6Nmp4=;
        b=UfAHaVaPgRfuPwyiDgCV48ZDZrB1g+yKTUQInXAVa13NvxzsWfYzroZBtNy7xYnqWU
         ZB/h1azOUW+2duD48qb8n0yOQJdmExqqxylwT1OY/pn6Yr6lihiku1ke5GBLD0t5uXVG
         xk7NzbrN1esMmCPel8iJtzTSa9tCvmAW0EAAVcgyofa6Q4ACDezUkmM+mese7Hl2MITt
         LOF6B/WvDDVnDXxDaXNgxzfO52+0kiaM7KALXjnQ55gJk2H/4RZrgcFB3I14bKViw5Mq
         GmI+hg5r0R9SD/hm82+CVeL/A2U2AvenujXe3EWNG5NBWgXHDQ0oNcsQ6ju6A+KdyIbG
         xs7A==
X-Gm-Message-State: AHQUAuYIu0Y/joYnZhFV4tAnKhf/REc67kvpJrR8J5IIQRJzIqdNpCLs
        LnxPyey+iCrTyk+pA2J0M60=
X-Google-Smtp-Source: AHgI3Ibyj6MD6+XE0EB3rDfhZIXo6fSgeJgXjt1IXOUQT8oibVM8tbgXm/MNQHibz/ARbsaK+kROtQ==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr3722063wml.96.1549745952165;
        Sat, 09 Feb 2019 12:59:12 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id q189sm5968232wma.27.2019.02.09.12.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 12:59:11 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/2] parport: daisy: use new parport device model
Date:   Sat,  9 Feb 2019 20:59:06 +0000
Message-Id: <20190209205907.3770-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify parport daisy driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/daisy.c | 32 +++++++++++++++++++++++++++++++-
 drivers/parport/probe.c |  2 +-
 drivers/parport/share.c | 14 +++++++++++++-
 include/linux/parport.h |  3 +++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 5484a46dafda..56dd83a45e55 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -213,10 +213,12 @@ void parport_daisy_fini(struct parport *port)
 struct pardevice *parport_open(int devnum, const char *name)
 {
 	struct daisydev *p = topology;
+	struct pardev_cb par_cb;
 	struct parport *port;
 	struct pardevice *dev;
 	int daisy;
 
+	memset(&par_cb, 0, sizeof(par_cb));
 	spin_lock(&topology_lock);
 	while (p && p->devnum != devnum)
 		p = p->next;
@@ -230,7 +232,7 @@ struct pardevice *parport_open(int devnum, const char *name)
 	port = parport_get_port(p->port);
 	spin_unlock(&topology_lock);
 
-	dev = parport_register_device(port, name, NULL, NULL, NULL, 0, NULL);
+	dev = parport_register_dev_model(port, name, &par_cb, devnum);
 	parport_put_port(port);
 	if (!dev)
 		return NULL;
@@ -480,3 +482,31 @@ static int assign_addrs(struct parport *port)
 	kfree(deviceid);
 	return detected;
 }
+
+static int daisy_drv_probe(struct pardevice *par_dev)
+{
+	struct device_driver *drv = par_dev->dev.driver;
+
+	if (strcmp(drv->name, "daisy_drv"))
+		return -ENODEV;
+	if (strcmp(par_dev->name, daisy_dev_name))
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct parport_driver daisy_driver = {
+	.name = "daisy_drv",
+	.probe = daisy_drv_probe,
+	.devmodel = true,
+};
+
+int daisy_drv_init(void)
+{
+	return parport_register_driver(&daisy_driver);
+}
+
+void daisy_drv_exit(void)
+{
+	parport_unregister_driver(&daisy_driver);
+}
diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index e035174ba205..e5e6a463a941 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -257,7 +257,7 @@ static ssize_t parport_read_device_id (struct parport *port, char *buffer,
 ssize_t parport_device_id (int devnum, char *buffer, size_t count)
 {
 	ssize_t retval = -ENXIO;
-	struct pardevice *dev = parport_open (devnum, "Device ID probe");
+	struct pardevice *dev = parport_open(devnum, daisy_dev_name);
 	if (!dev)
 		return -ENXIO;
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 5dc53d420ca8..b89560d53a35 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -137,11 +137,23 @@ static struct bus_type parport_bus_type = {
 
 int parport_bus_init(void)
 {
-	return bus_register(&parport_bus_type);
+	int retval;
+
+	retval = bus_register(&parport_bus_type);
+	if (retval)
+		return retval;
+#ifdef CONFIG_PARPORT_1284
+	daisy_drv_init();
+#endif
+
+	return 0;
 }
 
 void parport_bus_exit(void)
 {
+#ifdef CONFIG_PARPORT_1284
+	daisy_drv_exit();
+#endif
 	bus_unregister(&parport_bus_type);
 }
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 397607a0c0eb..e0992953ff2b 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -460,6 +460,7 @@ extern size_t parport_ieee1284_epp_read_addr (struct parport *,
 					      void *, size_t, int);
 
 /* IEEE1284.3 functions */
+#define daisy_dev_name "Device ID probe"
 extern int parport_daisy_init (struct parport *port);
 extern void parport_daisy_fini (struct parport *port);
 extern struct pardevice *parport_open (int devnum, const char *name);
@@ -467,6 +468,8 @@ extern void parport_close (struct pardevice *dev);
 extern ssize_t parport_device_id (int devnum, char *buffer, size_t len);
 extern void parport_daisy_deselect_all (struct parport *port);
 extern int parport_daisy_select (struct parport *port, int daisy, int mode);
+extern int daisy_drv_init(void);
+extern void daisy_drv_exit(void);
 
 /* Lowlevel drivers _can_ call this support function to handle irqs.  */
 static inline void parport_generic_irq(struct parport *port)
-- 
2.11.0

