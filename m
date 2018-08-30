Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6AB204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzKDfk4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6AB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeH3FrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so3116924plb.3;
        Wed, 29 Aug 2018 18:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/6K4S4/MCf4PvzZUqxPNwP4rElLsJ7tp0RDtzFeYlQ=;
        b=nzKDfk4HCXxA6sLL1zFmFjXdXs1EpZ939fN8D/ykhhTBR/MYkrNU7BevgE6XihX7Wv
         8ro9C3HtTfwMMCZXKoAVdOand6w3hYrm6359+jgwzcWILOP+Y2MFwhsKNxmx0Vrr6ep2
         AJSEYQtWJ8CR4f+uP72hj79HrpoRsjbbN5LhX9dIclmY/AaRWRHgll2A8+ToybpRHPt5
         qOu0F0jqpaBsVWhn1HIGY+L13jUnuyKyIZiHE4JuJmGSlXkpGpiLyHxWCug40oeCbRQ8
         CokEAmywnParmh2bGgVySyxKpAHcwXrrIYWxDUP2jUUTgqWnJ9b9mi4sMA2ztEc9An4Q
         0Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/6K4S4/MCf4PvzZUqxPNwP4rElLsJ7tp0RDtzFeYlQ=;
        b=CYrSk2rNSw66+mFqCyjJzmTfhAfOohN3qyrRd4zRuUbM0TOfGknbzBRfnuptE52g48
         kPyqflcn60vnF9cYLxnncR0/5CAQ0RMUcF4kTgSNGWJ6+VjfPMQ2mKQgBdftZ1P2rGJd
         pREdxsihgcI3+pevhPqM+Bd6eXCgEaISi4hpUlBZDZLufFwqRFAvorRjj5PurcyD2P1B
         VOKoUQNcq2Cd4R6DeVmdnf8bc9r+10rFqbtKzLRj5MNopSqiV2gOdVdt/AJxQkfUTu86
         ++Vkug/h+DjVtFdmoB7zPfXjuIGDbgkmiFvodKmbop/UChOS9UxFc7TDzSomKNShe2y3
         DXhg==
X-Gm-Message-State: APzg51BLZNcGmsvs4L7bJvuLZxpj2J5UH2JWe0fcTWhhp3j21Mb8nIRJ
        Wv1ReOCTOzxAtBdvyNBQytQ=
X-Google-Smtp-Source: ANB0VdbEl9qwqobBUdclBmNwRNGOrsvUiwW6gBnQq2nO1/OHBQFeS+lC81T+KGUlkrIaYImQ0VcF8A==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr8005200pla.120.1535593647163;
        Wed, 29 Aug 2018 18:47:27 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 6-v6sm8049246pfr.115.2018.08.29.18.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:26 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
Subject: [PATCH V2 3/4] serial: f81232: implement break control
Date:   Thu, 30 Aug 2018 09:47:12 +0800
Message-Id: <1535593634-22004-4-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v2:
	1: Fix f81232_break_ctl() for mis-operated set_mask_register().
	2: Add set break control bit in f81232_set_termios().

 drivers/usb/serial/f81232.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 56adae8a9ee0..863430d7535f 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	bool is_break;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
@@ -377,13 +378,24 @@ static void f81232_process_read_urb(struct urb *urb)
 
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
-	/* FIXME - Stubbed out for now */
+	struct usb_serial_port *port = tty->driver_data;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	int status;
+	u8 tmp = 0;
 
-	/*
-	 * break_state = -1 to turn on break, and 0 to turn off break
-	 * see drivers/char/tty_io.c to see it used.
-	 * last_set_data_urb_value NEVER has the break bit set in it.
-	 */
+	mutex_lock(&priv->lock);
+
+	if (break_state) {
+		priv->is_break = !!break_state;
+		tmp = UART_LCR_SBC;
+	}
+
+	status = f81232_set_mask_register(port, LINE_CONTROL_REGISTER,
+						UART_LCR_SBC, tmp);
+	if (status)
+		dev_err(&port->dev, "set break failed: %d\n", status);
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_find_clk(speed_t baudrate)
@@ -519,6 +531,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -572,11 +585,18 @@ static void f81232_set_termios(struct tty_struct *tty,
 		break;
 	}
 
+	mutex_lock(&priv->lock);
+
+	if (priv->is_break)
+		new_lcr |= UART_LCR_SBC;
+
 	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
 	if (status) {
 		dev_err(&port->dev, "%s failed to set LCR: %d\n",
 			__func__, status);
 	}
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_tiocmget(struct tty_struct *tty)
-- 
2.7.4

