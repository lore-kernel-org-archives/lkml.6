Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458146-1524152584-2-12817662182745721579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524152583; b=Ig1ecYoZ+cwLrgzlIMRAEIDj/fpDrNkHOkdO4B23rVHePHzoxI
    PCFlCCdX4RfyPyfRttXfRxo2qdbZMYwW4T0yCcWVIXqdm3nOJk94P0t6hJMni5cb
    NkgwJ75RhX889HQOTvLCggqQDOhbQikuWM+6jJiRRZXgFgCn6ucpPt9QONVKchae
    hsHOl+O1+ZISSTcttfQ8zQWxKQb6Ij2uQfJr4yrKcAhlqccclMLuDQJsM8zkDqI+
    uhWLFqVNBmHSQTXZkx+hNjkMUV1ghlQczL8PVcKcyS3Ug/A0Cp21/z+ixjzyvosj
    r2DK22lNWTI/GBAbaSSf6xMQC51aH3w2Yjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524152583;
    bh=y1ZgkHFKv0COLWh8RDJNe+FHm9B7uDpiY87mFPkC7cg=; b=VlM8yumSs/c9
    jR+y62Z2E/AlzHnWaMxsfHM2EMMSAbOqOsRUwOn82cSnV1BdEeTHZh+O3hV7sKyh
    nlEbxZl4s0UC43HWwUIINNxt/o98hQlzx6ZylM3tw7YnnD+i3SQwPTAsfY9GmddB
    GJGepzMcIfat4REP5SbwnFRWTudj1PX3Vgx+JkHt6kWav8k9674voQS6f1Ty1iLk
    qnjcpN4ZsWCWxJpHF8RdwnQAmfiWDkoD4cvPHiHyKk+TESe9I5tVDdy6NftuoOCO
    MJa08LjbLUaDTnP5yK+yJ3ZZpIy8n29VBRkMARAJvArXgH2vP/9LRVdWrOi3cPLA
    cOd0veMpKA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEnJKY1+Gd246S980o+UQ4/n+nN1HwoDl4Mw1pD7e2dGG4i/xmelk986sai2mqxZfe2hqARNGIjLApdZB1gfK6RoFFCl0J+MkEHT+pn7SxpL+Erk8iOX
    J3b1qY0QRIhL5HlN+ybLg9n7XWnWuQvC1VcO1ks4acg3oiC3lJANLhMA1a2MnSa+kR2gMsWX39JQC0m0KqN2cyFBV8dg6LMzJFZwZjhlQlv+mhTMTnRCcAg4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FamwaA8_r38A:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=GRKs1fooyUzndFG0pkQA:9
    a=Zq_zd6a0TDVMBGTV:21 a=FWITCdWJgjFIcX6Q:21 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeDSPnC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:43:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752385AbeDSPnB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 11:43:01 -0400
From: John Garry <john.garry@huawei.com>
To: <gregkh@linuxfoundation.org>, <jslaby@suse.com>, <joel@jms.id.au>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>, <fcooper@ti.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <yamada.masahiro@socionext.com>, <khoroshilov@ispras.ru>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] serial: 8250_of: Add IO space support
Date: Thu, 19 Apr 2018 23:37:48 +0800
Message-ID: <1524152268-228631-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the 8250_of driver only supports MEM IO type
accesses.

Some development boards (Huawei D03, specifically) require
IO space access for 8250-compatible OF driver support, so
add it.

The modification is quite simple: just set the port iotype
and associated flags depending on the device address
resource type.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 9835b1c..a7ffaf6 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -92,13 +92,43 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_unprepare;
 	}
 
+	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+				  UPF_FIXED_TYPE;
 	spin_lock_init(&port->lock);
-	port->mapbase = resource.start;
-	port->mapsize = resource_size(&resource);
 
-	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-		port->mapbase += prop;
+	if ((resource.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;
+		port->iobase = resource.start;
+	} else {
+		port->mapbase = resource.start;
+		port->mapsize = resource_size(&resource);
+
+		/* Check for shifted address mapping */
+		if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+			port->mapbase += prop;
+
+		port->iotype = UPIO_MEM;
+		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
+			switch (prop) {
+			case 1:
+				port->iotype = UPIO_MEM;
+				break;
+			case 2:
+				port->iotype = UPIO_MEM16;
+				break;
+			case 4:
+				port->iotype = of_device_is_big_endian(np) ?
+					       UPIO_MEM32BE : UPIO_MEM32;
+				break;
+			default:
+				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
+					 prop);
+				ret = -EINVAL;
+				goto err_dispose;
+			}
+		}
+		port->flags |= UPF_IOREMAP;
+	}
 
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
@@ -114,26 +144,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->line = ret;
 
 	port->irq = irq_of_parse_and_map(np, 0);
-	port->iotype = UPIO_MEM;
-	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-		switch (prop) {
-		case 1:
-			port->iotype = UPIO_MEM;
-			break;
-		case 2:
-			port->iotype = UPIO_MEM16;
-			break;
-		case 4:
-			port->iotype = of_device_is_big_endian(np) ?
-				       UPIO_MEM32BE : UPIO_MEM32;
-			break;
-		default:
-			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-				 prop);
-			ret = -EINVAL;
-			goto err_dispose;
-		}
-	}
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
@@ -147,8 +157,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->type = type;
 	port->uartclk = clk;
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
 		port->flags |= UPF_SKIP_TEST;
-- 
1.9.1

