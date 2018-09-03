Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D010C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4136820867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="xHp9iAw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeICRen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:34:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38559 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeICRem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:34:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1109505wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4kS78oXJZUGrKCzUZpGpGSSBJzhOYunPNUj2kwOzEgs=;
        b=xHp9iAw+8VrtJ55yCGbUS/LsbIfQx11KWhD3nKNJpUdBQuS0Akxlsq2/Ar5zhzBh2B
         +Z4+giTfRKlN8XnLLp5NLAQaAWOPqwms9VzNbVcmTihl8TpEtlexlj4Ifn0+HzIaKnnp
         PxHnSlaT95qkLYtFRgsnb+/h4gCCuQDQy6wA88c8m4LajBk5MoMmD0ahlvFudLR8/Th5
         f5O8hJgVl65Kug+gXw5XfVxJOiez6nQbfCX7XRiv327okvPnFeLWwI3NGvPTV9W1mxWg
         kycv/bZG3jqfi4B3hEQwCejopqFZ3KOHje0ay9baF9z/SXeunQxla+MCMqC3dB/ruOno
         Snrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=4kS78oXJZUGrKCzUZpGpGSSBJzhOYunPNUj2kwOzEgs=;
        b=kq2GmmMUwO+QML6XXj/WQkf8QMElIChvzbUznkUCyYPvud8n2m6YSRM/T4LMRrfcZu
         5Rwn9xGMnkypfHFIhFMz1YTbk+TlkAa+L09ZL4aYwiOgfX0uUXrHGFFbgibtWN+tgXbV
         2pLumayr5YX42EGQD0bgvxgO/76r08ct6ORtRG2qqkUvEhqWgrsjB+mTay1nwQOtKBEp
         zrhW/UO+i5Y5iNlxYekaSfB4MDZH2ZBzfLtSaOaN1GwElGvzit4RtLwLCLeESpelTZ1x
         OhdU8jccz7kU4wQdXeyDgz7FBX+xK2v5GLvuyynBBWmcvJB3IFac3Ps8LkohP9w97MdB
         CXSw==
X-Gm-Message-State: APzg51AiYIq0o1WvoHK+XdVHsXcr/8NgV6QBlWkntoANZA3Ecuhb3cna
        bQ3gS+TTnIAS5bxow6ocUAtn92EYpD8kPg==
X-Google-Smtp-Source: ANB0VdZgCRGOum93NRq56PxvZJ4WKIrxkfXBAmHxd0FYHcIzv/Wf/zsCX1nZf80QmClPp3G60noOvw==
X-Received: by 2002:a1c:a94d:: with SMTP id s74-v6mr5477409wme.39.1535980474522;
        Mon, 03 Sep 2018 06:14:34 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t131-v6sm19273884wmg.10.2018.09.03.06.14.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:14:34 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] serial: uartps: Change uart ID port allocation
Date:   Mon,  3 Sep 2018 15:14:30 +0200
Message-Id: <8ade255a03610abfe28538d5fdff4cf37848c552.1535980468.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
In-Reply-To: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
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

Needs to be applied on the top of
https://lkml.org/lkml/2018/9/3/404
https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)

---
 drivers/tty/serial/xilinx_uartps.c | 106 ++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 71c032744dae..61c4a644e143 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -30,7 +30,6 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
-#define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
@@ -1370,6 +1369,85 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
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
+	int id;
+
+	mutex_lock(&bitmap_lock);
+
+	/* Alias list is stable that's why get alias bitmap only once */
+	if (!alias_bitmap_initialized) {
+		of_alias_get_alias_list(cdns_uart_of_match, "serial",
+					alias_bitmap, MAX_UART_INSTANCES);
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
@@ -1403,21 +1481,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1446,7 +1520,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	rc = uart_register_driver(cdns_uart_uart_driver);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to register driver\n");
-		return rc;
+		goto err_out_id;
 	}
 
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
@@ -1587,7 +1661,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
 
@@ -1610,6 +1687,9 @@ static int cdns_uart_remove(struct platform_device *pdev)
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

