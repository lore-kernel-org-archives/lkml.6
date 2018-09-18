Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AE2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC50214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="LNFNSXTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC50214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeIRUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:31:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37327 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbeIRUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:31:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id n11-v6so3179173wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F+1mYJMei29eUR2nJectoN5TKsQf3tb+AAYZDIefR4Q=;
        b=LNFNSXTvh3ROQqo+09JDBKwIx4+isJKPsrCGDwmUIFS4WEzkw6DfErFYhXPupvXRyj
         EDnxQ/wh1tpW5804zTWtsBlns4Sl9cXltyxpv4FdFw5rQCzcnalWMe1y2ngUsd5p4ztM
         Bjw+1hz45ypn4KtJIXB7QbzpVKF45gxgNgYSILxcZz7ZUqLy+wnz1si6I+dH87VbDdjM
         qQPRsyY+tgj/ojc3c2ga7rAtQDng9ITEAzm14oGFJRa/T4U+R+gIVL4FGUoiv/bwX5Jf
         WuWT7WD45w4AF0M9JvMEoKpariNWrlhdrI62pPn3DvDVb/Cw3CibcB0NtDT+685krPUU
         9xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=F+1mYJMei29eUR2nJectoN5TKsQf3tb+AAYZDIefR4Q=;
        b=fz2wVYFzpwhyZa/QbVt9vT3/v0XUIkkElrFvhix5kIso/RcZHBMsMOUWihQ0D4gN5W
         Nsfem+dG9E2Sgj64TnYkMqwvCOZ47KsIm4Dg8GzhMG3qaiNFchCQ8ANR1C5meNk1lqAn
         2XNZjV/WiNc2Aw8ErhqlBsSUmKvdUMQfH9scD6TfwVpMVSc/StwNXfYE5C0MzrWkreTG
         +IvJdIuWJ/RUEcA9vBPl7xMDH6KnBzXvJNM39Nf9AWtoWG5RyVcnRhmLvSlj4tF2SNcJ
         JLCef83gSW+6dIsaMzJPzXHGPhXMIcNZ7G0f4MhbQKpkpoM5CEBqa3orbQJSra7XSroI
         g8jg==
X-Gm-Message-State: APzg51Bb6WUTjz2s5Pv/VJu8St1tvfwvgPZWD8ynlhxeeTilVw+pkmeN
        L+fVXfnuu6JDKQdMbfEFofl9O/nu14AGbA==
X-Google-Smtp-Source: ANB0VdbRAiEI28xwHqmuE62Pb0NkZtZ/xm3ZpjT3GIwdyXCP5tLWFBBZ+61uFjG43cvueb045sNi0Q==
X-Received: by 2002:a1c:98cc:: with SMTP id a195-v6mr17071339wme.64.1537282682609;
        Tue, 18 Sep 2018 07:58:02 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y10-v6sm16906633wrl.87.2018.09.18.07.58.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 07:58:02 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] serial: uartps: Change uart ID port allocation
Date:   Tue, 18 Sep 2018 16:57:59 +0200
Message-Id: <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
In-Reply-To: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPs which have alias algorightm all the time using that alias and
minor number. It means serial20 alias ends up as ttyPS20.

If alias is not setup for probed IP instance the first unused position is
used but that needs to be checked if it is really empty because another
instance doesn't need to be probed at that time. of_alias_get_alias_list()
fills alias bitmap which exactly shows which ID is free.
If alias pointing to different not compatible IP, it is free to use.

cdns_get_id() call is placed below structure allocation to simplify
error path.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- Add handle of return value from of_alias_get_alias_list

Needs to be applied on the top of
https://lkml.org/lkml/2018/9/3/404
https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)

Greg: Please apply it with
"of: base: Introduce of_alias_get_alias_list() to check alias IDs
Rob is ok with that.

---
 drivers/tty/serial/xilinx_uartps.c | 109 ++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 71c032744dae..f77200a0f461 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -30,7 +30,6 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
-#define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
@@ -1370,6 +1369,88 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+/*
+ * Maximum number of instances without alias IDs but if there is alias
+ * which target "< MAX_UART_INSTANCES" range this ID can't be used.
+ */
+#define MAX_UART_INSTANCES	32
+
+/* Stores static aliases list */
+static DECLARE_BITMAP(alias_bitmap, MAX_UART_INSTANCES);
+static int alias_bitmap_initialized;
+
+/* Stores actual bitmap of allocated IDs with alias IDs together */
+static DECLARE_BITMAP(bitmap, MAX_UART_INSTANCES);
+/* Protect bitmap operations to have unique IDs */
+static DEFINE_MUTEX(bitmap_lock);
+
+static int cdns_get_id(struct platform_device *pdev)
+{
+	int id, ret;
+
+	mutex_lock(&bitmap_lock);
+
+	/* Alias list is stable that's why get alias bitmap only once */
+	if (!alias_bitmap_initialized) {
+		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
+					      alias_bitmap, MAX_UART_INSTANCES);
+		if (ret)
+			return ret;
+
+		alias_bitmap_initialized++;
+	}
+
+	/* Make sure that alias ID is not taken by instance without alias */
+	bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
+
+	dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
+		MAX_UART_INSTANCES, bitmap);
+
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev,
+			 "No serial alias passed. Using the first free id\n");
+
+		/*
+		 * Start with id 0 and check if there is no serial0 alias
+		 * which points to device which is compatible with this driver.
+		 * If alias exists then try next free position.
+		 */
+		id = 0;
+
+		for (;;) {
+			dev_info(&pdev->dev, "Checking id %d\n", id);
+			id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
+
+			/* No free empty instance */
+			if (id == MAX_UART_INSTANCES) {
+				dev_err(&pdev->dev, "No free ID\n");
+				mutex_unlock(&bitmap_lock);
+				return -EINVAL;
+			}
+
+			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
+			/* Check if ID is empty */
+			if (!test_and_set_bit(id, bitmap)) {
+				/* Break the loop if bit is taken */
+				dev_dbg(&pdev->dev,
+					"Selected ID %d allocation passed\n",
+					id);
+				break;
+			}
+			dev_dbg(&pdev->dev,
+				"Selected ID %d allocation failed\n", id);
+			/* if taking bit fails then try next one */
+			id++;
+		}
+	}
+
+	mutex_unlock(&bitmap_lock);
+
+	return id;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1403,21 +1484,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!cdns_uart_uart_driver)
 		return -ENOMEM;
 
-	/* Look for a serialN alias */
-	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
+	cdns_uart_data->id = cdns_get_id(pdev);
 	if (cdns_uart_data->id < 0)
-		cdns_uart_data->id = 0;
-
-	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		return -ENODEV;
-	}
+		return cdns_uart_data->id;
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
 				     CDNS_UART_NAME, cdns_uart_data->id);
-	if (!driver_name)
-		return -ENOMEM;
+	if (!driver_name) {
+		rc = -ENOMEM;
+		goto err_out_id;
+	}
 
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
@@ -1446,7 +1523,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	rc = uart_register_driver(cdns_uart_uart_driver);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to register driver\n");
-		return rc;
+		goto err_out_id;
 	}
 
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
@@ -1587,7 +1664,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-
+err_out_id:
+	mutex_lock(&bitmap_lock);
+	clear_bit(cdns_uart_data->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	return rc;
 }
 
@@ -1610,6 +1690,9 @@ static int cdns_uart_remove(struct platform_device *pdev)
 #endif
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
+	mutex_lock(&bitmap_lock);
+	clear_bit(cdns_uart_data->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
 	pm_runtime_disable(&pdev->dev);
-- 
1.9.1

