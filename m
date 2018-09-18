Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE79ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D92F214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJetEppu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D92F214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeIRGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41741 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeIRGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so105545pgv.8;
        Mon, 17 Sep 2018 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIsx+Lj2AOsNYnRJicwzzI3pQXrI3+GkDscgg4SjDng=;
        b=aJetEppu+LdT1fXncUO/hHryhQRy5cQ4bDPDl79s1EIO4b4MahV0XKDqBTt3vkdTpO
         m6wz6g0JSYDnlB1oua0H09pqMfHqCkDKGtTY9cW8t4BXtQnm5J6z7tiOxEKNs48mJIeZ
         Nfa6gJxD5TzmL7YTjzXEOc8x2JcIq1ggAtTUinM9Hc7l42qoi+yE6ieUWdyRUBnr3zUs
         CjSVdhKWGF++51eRTSpCriuvGCYKcs8YfaKjQpV+7Fz34UwtPLSM0NXeHzt7iEbOv6Br
         5PKy1HnYSIAhYFWFybl7VFLxiSR3+QWk6vGKGZbu3HtQrL14fCTaH1BSrJzCXY7C16EF
         4gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIsx+Lj2AOsNYnRJicwzzI3pQXrI3+GkDscgg4SjDng=;
        b=sIIOhOIDViUMiP5SNIzpLKjkeOsw5/jCgdSoKHtRh01ShO/V3MfgOMAlvqkX/8+wbX
         2vjmyH3dfiDasbpAR8zFVtHzWJ3YtWkpLHQKMiAaFE2o1bdWxFfWEUWfHjmi02Yc/uA6
         33aBY1IL3p/Z/OO3NxCmuCovieek5QZC8WKyex1QF735CO1PYL41DSYMpQISChxGTWuW
         5XdQsC4yWtC3Jb4TnZZlv8LfnalsjI0Of4XNeFB+S3HBMJKQz2T4HYVCX+c2lFkyCvhq
         wXF1iynDdq+eJLXUbmTfo8t2ivX4MfdDmNozHqZdxRN29CO7szWzN4KEWYKwG8T2S8GV
         F9Nw==
X-Gm-Message-State: APzg51BQMj3ZskYP9DEBoJpwK65FIJToxQTjHqmsxmpaSEG3f4GivD3f
        B2cIEIQbp56pETWiV2zRY70rqUp+
X-Google-Smtp-Source: ANB0Vdb9tywBVFUaGcvh+CNF+GMjKhNTUJ4XxvCx4GxxhlgWQOyNigRfkFBU0/3uMsIwY4ZLWBn12g==
X-Received: by 2002:a62:6104:: with SMTP id v4-v6mr28497263pfb.122.1537231667408;
        Mon, 17 Sep 2018 17:47:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:46 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] Input: iforce - split into core and transport modules
Date:   Mon, 17 Sep 2018 17:47:20 -0700
Message-Id: <20180918004732.9875-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have moved enough transport details into separate source files
we can change them into transport modules so that they are only loaded when
needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/Kconfig         |  8 ++---
 drivers/input/joystick/iforce/Makefile        |  7 ++--
 drivers/input/joystick/iforce/iforce-main.c   | 35 ++-----------------
 .../input/joystick/iforce/iforce-packets.c    |  2 ++
 drivers/input/joystick/iforce/iforce-serio.c  |  7 ++++
 drivers/input/joystick/iforce/iforce-usb.c    |  7 ++++
 drivers/input/joystick/iforce/iforce.h        |  2 --
 7 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/input/joystick/iforce/Kconfig b/drivers/input/joystick/iforce/Kconfig
index ab4dbcbcbf50..55f6ae1da6b0 100644
--- a/drivers/input/joystick/iforce/Kconfig
+++ b/drivers/input/joystick/iforce/Kconfig
@@ -13,15 +13,15 @@ config JOYSTICK_IFORCE
 	  module will be called iforce.
 
 config JOYSTICK_IFORCE_USB
-	bool "I-Force USB joysticks and wheels"
-	depends on JOYSTICK_IFORCE && (JOYSTICK_IFORCE=m || USB=y) && USB
+	tristate "I-Force USB joysticks and wheels"
+	depends on JOYSTICK_IFORCE && USB
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
 	  connected to your USB port.
 
 config JOYSTICK_IFORCE_232
-	bool "I-Force Serial joysticks and wheels"
-	depends on JOYSTICK_IFORCE && (JOYSTICK_IFORCE=m || SERIO=y) && SERIO
+	tristate "I-Force Serial joysticks and wheels"
+	depends on JOYSTICK_IFORCE && SERIO
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
 	  connected to your serial (COM) port.
diff --git a/drivers/input/joystick/iforce/Makefile b/drivers/input/joystick/iforce/Makefile
index bc5bda22f15e..414075019a4f 100644
--- a/drivers/input/joystick/iforce/Makefile
+++ b/drivers/input/joystick/iforce/Makefile
@@ -4,8 +4,7 @@
 # By Johann Deneux <johann.deneux@gmail.com>
 #
 
-obj-$(CONFIG_JOYSTICK_IFORCE)	+= iforce.o
-
+obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce.o
 iforce-y := iforce-ff.o iforce-main.o iforce-packets.o
-iforce-$(CONFIG_JOYSTICK_IFORCE_232)	+= iforce-serio.o
-iforce-$(CONFIG_JOYSTICK_IFORCE_USB)	+= iforce-usb.o
+obj-$(CONFIG_JOYSTICK_IFORCE_232)	+= iforce-serio.o
+obj-$(CONFIG_JOYSTICK_IFORCE_USB)	+= iforce-usb.o
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 894769d03df3..3a0698327c42 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -24,7 +24,7 @@
 #include "iforce.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
-MODULE_DESCRIPTION("USB/RS232 I-Force joysticks and wheels driver");
+MODULE_DESCRIPTION("Core I-Force joysticks and wheels driver");
 MODULE_LICENSE("GPL");
 
 static signed short btn_joystick[] =
@@ -411,35 +411,4 @@ int iforce_init_device(struct device *parent, u16 bustype,
  fail:	input_free_device(input_dev);
 	return error;
 }
-
-static int __init iforce_init(void)
-{
-	int err = 0;
-
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	err = usb_register(&iforce_usb_driver);
-	if (err)
-		return err;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	err = serio_register_driver(&iforce_serio_drv);
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	if (err)
-		usb_deregister(&iforce_usb_driver);
-#endif
-#endif
-	return err;
-}
-
-static void __exit iforce_exit(void)
-{
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	usb_deregister(&iforce_usb_driver);
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	serio_unregister_driver(&iforce_serio_drv);
-#endif
-}
-
-module_init(iforce_init);
-module_exit(iforce_exit);
+EXPORT_SYMBOL(iforce_init_device);
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 8a9a152bb595..70db273e5045 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -96,6 +96,7 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data)
 
 	return 0;
 }
+EXPORT_SYMBOL(iforce_send_packet);
 
 /* Start or stop an effect */
 int iforce_control_playback(struct iforce* iforce, u16 id, unsigned int value)
@@ -203,3 +204,4 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			break;
 	}
 }
+EXPORT_SYMBOL(iforce_process_packet);
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 6ff1bbeeb494..6c6411fbdc32 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/serio.h>
 #include "iforce.h"
 
 struct iforce_serio {
@@ -250,3 +251,9 @@ struct serio_driver iforce_serio_drv = {
 	.connect	= iforce_serio_connect,
 	.disconnect	= iforce_serio_disconnect,
 };
+
+module_serio_driver(iforce_serio_drv);
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
+MODULE_DESCRIPTION("RS232 I-Force joysticks and wheels driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d4e7a24922cd..9d635f01cf19 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/usb.h>
 #include "iforce.h"
 
 struct iforce_usb {
@@ -316,3 +317,9 @@ struct usb_driver iforce_usb_driver = {
 	.disconnect =	iforce_usb_disconnect,
 	.id_table =	iforce_usb_ids,
 };
+
+module_usb_driver(iforce_usb_driver);
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
+MODULE_DESCRIPTION("USB I-Force joysticks and wheels driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index d9712c48ba74..3e3df83b9d77 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -26,8 +26,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
-#include <linux/usb.h>
-#include <linux/serio.h>
 #include <linux/circ_buf.h>
 #include <linux/mutex.h>
 
-- 
2.19.0.397.gdd90340f6a-goog

