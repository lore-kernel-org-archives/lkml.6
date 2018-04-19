Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3239998-1524146840-2-12666682062791347354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524146839; b=VNBFTGkIhRnS0JJRaOjSaty7KbkczQTlvgwhVVvkYZ6KSBbLo+
    MgbzW/2godkzROmKvWBBeXOfWKM4x4eH7axq+FsgL0ep/9Qpeg4F81gpyQN+gFZ2
    +PUpgf5P0M4fi2b1OkqFsW13sHOgiO6D+gBijIWco3zOrHWkWgmQUeyG/ZFTEyEA
    Ts149RfzMM4j2bp+PycW/tSy+cbo5e5SWVSgIJ6pFHvz58yw2caHvlJioDkYNiiN
    bsaFdIvcriWbsWXNSyzc4xzwD4w6RwyEHosbxNdagIOColbOss7PQsgF8eURJezl
    FNZqiqyTuWwRN8mVUqR3MEBvfhlA0QTEYDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524146839; bh=
    yNk/AivqHssHuReHutxjd4+CVrug7frdqVOoomkd/g4=; b=VR1TvplKEJSnpcuV
    MhcWdySnWuQyUA1fdfljcYpXRkXh0F7skp2I14W6oH49KdbFo6uUw0DvQLSK61nZ
    LfwByZwsEz0DtArSX8SdOQMCXqXdsjkbeuQaSgpB2rTInAtUtSa0iTQhDcR7SofE
    4hfDtRyucA3uix8sXJ7FgHOZP7ddJQMz3YPIFdjkny29CUdxTT5Gagj9/Xo6b7/9
    0kjmOrWeJHdQ2IdybS0UC08Q2dVmRZsAaA4IRUf2W9l5VtewNCjIz8Cabe5ELDmO
    ZEy1OonANYrtymkU9BMs6Cc8rJE+LZ42kwKtFuolCbPKShyf+HHIN7KZpLQm8DEL
    JFz3gA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPg28grNGnQhR+4ktcrVGQDHqNKUVHQaJDsukBzqRBPCfHFP3I8FONpOLye3+EW3MQgFUxwfDcvgXRK4vnax4UfLJ9yX4XtSf+C6EhpRQtsihwlBhU2g
    XzRvWtLqllW96TfDosujmqFYvnUPYgAa5iowdhv1K7Se2tHbPMbM/I5hs6Dp9hxi4SshDYIPiN9nu6vd2FGiSZxKa4NMF4oiBOumdtPE1sVT2y08DB16jjOw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LDBv8-xUAAAA:8
    a=VwQbUJbxAAAA:8 a=g4fqUOnKwHXVDwzwUXoA:9 a=x8gzFH9gYPwA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDSOHP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:07:15 -0400
Received: from sauhun.de ([88.99.104.3]:45350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753563AbeDSOHO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:14 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 53/61] tty: serial: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:23 +0200
Message-Id: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/tty/serial/imx.c              | 18 ++++++------------
 drivers/tty/serial/qcom_geni_serial.c |  6 ++----
 drivers/tty/serial/st-asc.c           |  6 ++----
 drivers/tty/serial/xilinx_uartps.c    |  6 ++----
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..f370c1cf4f27 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2408,8 +2408,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
 static int imx_uart_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	imx_uart_save_context(sport);
 
@@ -2420,8 +2419,7 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 static int imx_uart_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_enable(sport->clk_ipg);
@@ -2435,8 +2433,7 @@ static int imx_uart_resume_noirq(struct device *dev)
 
 static int imx_uart_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
 	uart_suspend_port(&imx_uart_uart_driver, &sport->port);
@@ -2454,8 +2451,7 @@ static int imx_uart_suspend(struct device *dev)
 
 static int imx_uart_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	/* disable wakeup from i.MX UART */
 	imx_uart_enable_wakeup(sport, false);
@@ -2470,8 +2466,7 @@ static int imx_uart_resume(struct device *dev)
 
 static int imx_uart_freeze(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	uart_suspend_port(&imx_uart_uart_driver, &sport->port);
 
@@ -2480,8 +2475,7 @@ static int imx_uart_freeze(struct device *dev)
 
 static int imx_uart_thaw(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_port *sport = platform_get_drvdata(pdev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	uart_resume_port(&imx_uart_uart_driver, &sport->port);
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 65ff669373d4..66558d42d980 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1085,8 +1085,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 
 static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
 	uart_suspend_port(uport->private_data, uport);
@@ -1095,8 +1094,7 @@ static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
 
 static int __maybe_unused qcom_geni_serial_sys_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
 	if (console_suspend_enabled && uport->suspended) {
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 5f9f01fac6dd..7971997cdead 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -842,16 +842,14 @@ static int asc_serial_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int asc_serial_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 
 	return uart_suspend_port(&asc_uart_driver, port);
 }
 
 static int asc_serial_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 
 	return uart_resume_port(&asc_uart_driver, port);
 }
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index abcb4d09a2d8..3ec4efbf25a9 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1430,8 +1430,7 @@ static int cdns_uart_resume(struct device *device)
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
 
 	clk_disable(cdns_uart->uartclk);
@@ -1441,8 +1440,7 @@ static int __maybe_unused cdns_runtime_suspend(struct device *dev)
 
 static int __maybe_unused cdns_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
 
 	clk_enable(cdns_uart->pclk);
-- 
2.11.0

