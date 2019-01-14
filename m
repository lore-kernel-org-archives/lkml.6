Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF6DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED35206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Jb0DCkdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfANQyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:54:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfANQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:54:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so257117wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=YDlLAbjE1Bp+CpbdaiFh8za0XJ4VNrbI5R9WvhyxgIc=;
        b=Jb0DCkdWMu/er0vZsOggLA4HFLbM5pLR7C/JpUHBMaAHDnp8+TWTR/1n1/LMIaoCAK
         H+ale06NO9L6hXvsm1RNGK15egin4S6VCrgq4d8ExkZ0X/8SYJeqf4tiqihd6b5bGvzi
         oI/VVDIc5UYae5tGSxjpaeU6b6rUoYSWbdOqvedXbaHfnlELFOTEgfKq90zqV+5JhNoH
         lCUBS2b1nxjogAQl3uITl311zKHFFyLUq7Njwr/46b3OfYJYGDZgM6dwOL8LLbFDSJhR
         JTDM+wsehpsFprsu8oN+yoGltYjS5VrkY8JF5DJ17sfARoUIl9bB/BXpX0kXXwxtL5CH
         UQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YDlLAbjE1Bp+CpbdaiFh8za0XJ4VNrbI5R9WvhyxgIc=;
        b=g+ajwbiBLDT4KSLIpNGK+PmjVUX/hU8+UX+RY5fCrK0ZyyK8n+y7Lzq57jFNN7PmFU
         mQkIw7rEq7ribyeqBio5iUxXUkQ07S88lAl0MsscpnfsqwtBXxKo2sNn3Yl0fFwoejFl
         eZnx5HYbisIvjJYTra4uT8Nd2U5YXs4dttRDvSdxk/YJN0bUk6KGggukwpH8dD7lNMFX
         Y+jxYPDn8bEfl2jjAlqj4YuHxUiNY6Yuyqwlo4bOnSaQDtqQmweyFl/GXYb6uJgHoXGE
         tCi4cYsOCSNHmRzYx3XCPud1d6J+GbYYq583teDNDa8wuYhM9h0aQFuK/HqEZ9gkeyTM
         DcKw==
X-Gm-Message-State: AJcUukdJlBO/CTm6GpDCMGNwBg/EMPHuYyHr1WWeOmPTBH87jSKQ/314
        DStwkaO0js+N32h8KCq7f7iRDA==
X-Google-Smtp-Source: ALg8bN5WKaMg8ZtcDbbOc8T92Few5xuQokHuFX92gPx15BV3tslpwz15VAQZEBvZV00HsiYBUfh9jA==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr27141wmf.85.1547484871518;
        Mon, 14 Jan 2019 08:54:31 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b18sm70411000wrw.83.2019.01.14.08.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 08:54:30 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: meson: if no alias specified use an available id
Date:   Mon, 14 Jan 2019 17:54:26 +0100
Message-Id: <1547484866-3600-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At probe, the uart driver tries to get an id from a device tree alias.
When no alias was specified, the driver would return an error and probing
would fail.

Providing an alias for registering a serial device should not be mandatory.
If the device tree does not specify an alias, provide an id from a reserved
range so that the probing can continue.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a842591b37c..fbc5bc022a39 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -72,7 +72,8 @@
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
 
-#define AML_UART_PORT_NUM		6
+#define AML_UART_PORT_NUM		12
+#define AML_UART_PORT_OFFSET		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
 
@@ -654,10 +655,20 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	int ret = 0;
+	int id = -1;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
+	if (pdev->id < 0) {
+		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
+			if (!meson_ports[id]) {
+				pdev->id = id;
+				break;
+			}
+		}
+	}
+
 	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
 		return -EINVAL;
 
-- 
2.7.4

