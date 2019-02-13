Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC7C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450F5222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZRJ5oiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390809AbfBMIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:47:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37106 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:47:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so1506434wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SYKHrrKARz+Cr4tfpNwFsT80ECJj5aS0+BF4T2lIKBE=;
        b=oZRJ5oiD4imBz/p/n/41GOb2WEp2UIH4WYY4MmUSJehshd2HQwjDTaorWEQW0fLygK
         dDiMf89Urg4NzYOEcc/E/wsHkh/bz3+0pdTHo1ID9DT352KG6hFbGxCBSAtViFgA5fDu
         KdNl5NWJJUHDBicrzdWRKpfGihhHl43e0RuDNbFBHWPr2wy2lmMHLmeRDO3KyFtsk52v
         tLaxA1wumGTHLhA5S0rh1jvCw8GffhFQxAswK3dpL7bJVrdmUwvoAjELHRQxezsKDSDA
         C8KXn5QkK1sH5cJImIf8IzL17MWrFE/VRGeoGcrsJip2JGK9IDNdzzv3cZ47Je+AYgkA
         ILwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SYKHrrKARz+Cr4tfpNwFsT80ECJj5aS0+BF4T2lIKBE=;
        b=OLg8Rrlz88/kJ2vGlRKEy2KsV8YmJmuP9Y6LRyvsyReOp3fMc6fWJppEd1FeIU8ND0
         bcJCkldc0W0JsVJ1f5jZIEostXTw3SguHaF2feC118PKo39VusxYFCTMgIsmrAYtbsXG
         9A0/mlgIY9b3PJe4gQ2bCxrHODcQoALzaG7oHzC8Y5/HldpGf7As283vBtVBbMMW4FQo
         8TPvNDFYENAHLh5WZQNAxOeJ6eertDiy3wgru8i6D3TQyURPuSJuqtTH9n9ktUGFzEzd
         0ow5dpaMM9wdob4QbMGTVLAN9F4hIVakUC9MLU633OJ5SJ4ZQ56K9+7hYN8cckxbTUdy
         TBKg==
X-Gm-Message-State: AHQUAuYZxKwmAWKJAIbdrfutZMnwAvV3f8WX0A7gRY/tXoi+he6piGML
        VU6ysR8NGtJyHE4aAh2BjNM=
X-Google-Smtp-Source: AHgI3IbN1ZbCyJCGkBA993nroBfgBGhAhmY5OxHQ0sBGdZYV16oJSUpdOIwjMWA6mo10FhZqgxKfDw==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr6018661wrj.0.1550047629951;
        Wed, 13 Feb 2019 00:47:09 -0800 (PST)
Received: from debian.lan ([212.161.95.162])
        by smtp.gmail.com with ESMTPSA id d9sm20792347wrn.72.2019.02.13.00.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:47:09 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] parport: daisy: use new parport device model
Date:   Wed, 13 Feb 2019 08:47:06 +0000
Message-Id: <20190213084706.2886-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify parport daisy driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v2: hide ifdef in the header file

 drivers/parport/daisy.c | 32 +++++++++++++++++++++++++++++++-
 drivers/parport/probe.c |  2 +-
 drivers/parport/share.c | 10 +++++++++-
 include/linux/parport.h | 13 +++++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)

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
index 5dc53d420ca8..0171b8dbcdcd 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -137,11 +137,19 @@ static struct bus_type parport_bus_type = {
 
 int parport_bus_init(void)
 {
-	return bus_register(&parport_bus_type);
+	int retval;
+
+	retval = bus_register(&parport_bus_type);
+	if (retval)
+		return retval;
+	daisy_drv_init();
+
+	return 0;
 }
 
 void parport_bus_exit(void)
 {
+	daisy_drv_exit();
 	bus_unregister(&parport_bus_type);
 }
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 397607a0c0eb..f41f1d041e2c 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -460,6 +460,7 @@ extern size_t parport_ieee1284_epp_read_addr (struct parport *,
 					      void *, size_t, int);
 
 /* IEEE1284.3 functions */
+#define daisy_dev_name "Device ID probe"
 extern int parport_daisy_init (struct parport *port);
 extern void parport_daisy_fini (struct parport *port);
 extern struct pardevice *parport_open (int devnum, const char *name);
@@ -468,6 +469,18 @@ extern ssize_t parport_device_id (int devnum, char *buffer, size_t len);
 extern void parport_daisy_deselect_all (struct parport *port);
 extern int parport_daisy_select (struct parport *port, int daisy, int mode);
 
+#ifdef CONFIG_PARPORT_1284
+extern int daisy_drv_init(void);
+extern void daisy_drv_exit(void);
+#else
+static inline int daisy_drv_init(void)
+{
+	return 0;
+}
+
+static inline void daisy_drv_exit(void) {}
+#endif
+
 /* Lowlevel drivers _can_ call this support function to handle irqs.  */
 static inline void parport_generic_irq(struct parport *port)
 {
-- 
2.11.0

