Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04382C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BCD20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="lplkt9Gv";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="Nwmjam1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BCD20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeILT6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:37 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:36438 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbeILT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:37 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CES6Px000481
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp;
 bh=7zdda0X6TRrOWse/hlHAYwPeyxrnVmtmmijt//VkoJk=;
 b=lplkt9GvtZ8ChtwgX04JlwIBdvCKIKZ1UiAKFCN/ApT7SdmAWy2hnjkl/B7MQ2KermQ2
 fZLTl7yXEUA6TUrOCgQTNIiRIUoHJAUWLOP8/OcJxZXTjU9UfFXAkRkgt7oIMasBxN2i
 RFDZTDp74DFKTgnEMSEJka78U3mcp+QNEeOGQAhIsY/lnvX2K4I+iU7+sz9u21QFpFQE
 1Vheqqi2mvGZjaUytV7huazQBmlgDRH+/qo0XCXlF3I/Z5/xSDhJU2PXwrwbRekfbZVS
 cMVramX4BbEYO1ojArxGX9D7Sgr+bbfgD6vCoJ0OIxLPvGFudauycvZs4xtEXRFTL6sC sg== 
Received: from mail-wm0-f70.google.com (mail-wm0-f70.google.com [74.125.82.70])
        by mx08-00252a01.pphosted.com with ESMTP id 2mc2wft2hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:16 +0100
Received: by mail-wm0-f70.google.com with SMTP id z2-v6so1712143wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7zdda0X6TRrOWse/hlHAYwPeyxrnVmtmmijt//VkoJk=;
        b=Nwmjam1+0RVFEfXUrAo/grpkqcutdhN+AqjFbdtN8ewbND17QEWa6xW3ZetGvWheGT
         tIX0v3jzTXZUjYxQnvaUJuTj1HVYKyhoQYPgUgfQmy/5W9eKawNdf8dtwtTJBIW5YDtJ
         aj2MG1vNqFSTD72jVmWft0CRgkio+gSQeh0VStRzy6ul+cJWrJgYjl2pAcLva5syCbJP
         EFOH9LL//LEEi47nYpKs5P7AZ0J26G9DtsKgLB8AGCa6+RL15H9bDF+Zx5bxkzRc+9dJ
         7ZUQOYc3dk+Erqff4Xyvv8HKDjaoTRg7cklj5s0JLkX7Sd2ZH8aRdnYfvCQfhKiyNLfe
         RGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7zdda0X6TRrOWse/hlHAYwPeyxrnVmtmmijt//VkoJk=;
        b=XHkeT9an4q4B3sqECoYsendAup00e8uwV5u7kIH/qQjRFU7f/6jOaaHeNU8E0+q5Gl
         jJN0iAiP1uzVWSL1HvdPteYnxsUXsrHwdkS2+5xeVRM9sMqM4DMWc9JUbAKr4HVAc/Lj
         gMiMyJKbBKR1ueCfDazbGtVNT3jx0tXHRDGJRA2SINsczvskLBhAs4UuOO2YBXDXXjOn
         xSXapCvKOUlhPYK9e/oBLnjHNjWCYyLLZchR3Uaiziu85vt4SYujqP9lbGH6IA0YgIz3
         33uSICqqp0KLETT1reF7HdjOrv8mAya3AOZqIHZ4NnfBcR+tLkzr9tehxmlnX9+LUp4P
         CCqQ==
X-Gm-Message-State: APzg51AY53IPivQo1Ql8W4KpTIwCwcROj4PuZQCAt6WNAE3yCmBLUgmZ
        jnwamQHt4OYcPvXVQneV2gDWHs7YgAmghNy3LXDZxTC4cqaiTiBGmjgxPyvc+uDGFW079nYfVD+
        uWWnx1Xy9kvtNrP5r/Kw3NQNk
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr1769079wme.128.1536762735736;
        Wed, 12 Sep 2018 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdacaM8qEzWF9fGAYLxCcy41ZdwR7eDirKNmqD+JbRNeaaCsgXSXFbaJRnVthHhhY0nAvrBclA==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr1769059wme.128.1536762735418;
        Wed, 12 Sep 2018 07:32:15 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:2381:fdf7:14:e45c:95a2:cfa0:31e0])
        by smtp.gmail.com with ESMTPSA id h82-v6sm948217wme.11.2018.09.12.07.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:32:14 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 2/2] sc16is7xx: Fix for "Unexpected interrupt: 8"
Date:   Wed, 12 Sep 2018 15:31:56 +0100
Message-Id: <1536762716-30673-3-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC16IS752 has an Enhanced Feature Register which is aliased at the
same address as the Interrupt Identification Register; accessing it
requires that a magic value is written to the Line Configuration
Register. If an interrupt is raised while the EFR is mapped in then
the ISR won't be able to access the IIR, leading to the "Unexpected
interrupt" error messages.

Avoid the problem by claiming a mutex around accesses to the EFR
register, also claiming the mutex in the interrupt handler work
item (this is equivalent to disabling interrupts to interlock against
a non-threaded interrupt handler).

See: https://github.com/raspberrypi/linux/issues/2529

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/tty/serial/sc16is7xx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 47b4115..2680986 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -328,6 +328,7 @@ struct sc16is7xx_port {
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
 	struct kthread_work		irq_work;
+	struct mutex			efr_lock;
 	struct sc16is7xx_one		p[0];
 };
 
@@ -499,6 +500,21 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= 4;
 	}
 
+	/* In an amazing feat of design, the Enhanced Features Register shares
+	 * the address of the Interrupt Identification Register, and is
+	 * switched in by writing a magic value (0xbf) to the Line Control
+	 * Register. Any interrupt firing during this time will see the EFR
+	 * where it expects the IIR to be, leading to "Unexpected interrupt"
+	 * messages.
+	 *
+	 * Prevent this possibility by claiming a mutex while accessing the
+	 * EFR, and claiming the same mutex from within the interrupt handler.
+	 * This is similar to disabling the interrupt, but that doesn't work
+	 * because the bulk of the interrupt processing is run as a workqueue
+	 * job in thread context.
+	 */
+	mutex_lock(&s->efr_lock);
+
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 
 	/* Open the LCR divisors for configuration */
@@ -514,6 +530,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
+	mutex_unlock(&s->efr_lock);
+
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler);
@@ -696,6 +714,8 @@ static void sc16is7xx_ist(struct kthread_work *ws)
 {
 	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
 
+	mutex_lock(&s->efr_lock);
+
 	while (1) {
 		bool keep_polling = false;
 		int i;
@@ -705,6 +725,8 @@ static void sc16is7xx_ist(struct kthread_work *ws)
 		if (!keep_polling)
 			break;
 	}
+
+	mutex_unlock(&s->efr_lock);
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
@@ -899,6 +921,9 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (!(termios->c_cflag & CREAD))
 		port->ignore_status_mask |= SC16IS7XX_LSR_BRK_ERROR_MASK;
 
+	/* As above, claim the mutex while accessing the EFR. */
+	mutex_lock(&s->efr_lock);
+
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
@@ -920,6 +945,8 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
+	mutex_unlock(&s->efr_lock);
+
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 4 / 0xffff,
@@ -1185,6 +1212,7 @@ static int sc16is7xx_probe(struct device *dev,
 	s->regmap = regmap;
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
+	mutex_init(&s->efr_lock);
 
 	kthread_init_worker(&s->kworker);
 	kthread_init_work(&s->irq_work, sc16is7xx_ist);
-- 
2.7.4

