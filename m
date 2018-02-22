Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713482-1519321839-2-15181795331889199796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519321838; b=fGLlKVGua5oPFnZTdj8044qAMd6mdVPnSFeWh/ZddmvCzi8
    Hd7tKGmis/51LS3DTWc6owjkAUVphsmZvcxz2KeHoYZCLKZbWYLlg2Shol5qZ1Nc
    oTzxAbApzwAV5c/DEqdNib3D8L04BTWNogEojz4HrktTDbsZPlasRXy1tslAdsU5
    J2Yn4LCC1SULdbgzgSw/IOu39KH92f5EvffO1kX9o+J7qUa3ng2GtcF9NvFYX0hS
    UsAJ7NafyxTaEV1Do97YGwGDaJIP7CDa8MeBHNXecvjQWEXN4HSpm/gGxWWY4Imb
    aDLKCbR6qs7QaLtAjI1bH6aiKX90JTEYnXPyZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519321838; bh=sOJquLft11jlZ7Bbp6FGKP09kn
    BUjeIlJvffJWPJbqI=; b=aGYkB2avsbr7qt4Vou8/mNaXelYI9RNIzwBRUIsAGF
    BcTKG62ySpiaAh2Dk81bsrnEYTWkJ4GhNsOSLw9cXGn0t2s9nL5Y8t3HLTMItGYB
    uSVEHVGJKSDSXj2+KKT3yLW/hDwSjdYCdMp9BsLZAjvSbm52WR38NY6NaXEAseVy
    0liJ3of1pTVvOoZ0nCIEKF/l0/b02Of2hN6GsfAZjybDD8450yIUkss4Vw7e26NI
    SnGnoW8vLIC+lcwY9sNUrd4BG21t9QWQDakIvuH7uv/d2CXs1U0SjFtUSXCe7y26
    XrEMnvwfGHZbWrJzsMe7sKt1aB9JWWd36UTGLjEURR8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeBVRuI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 12:50:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933441AbeBVRuF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Feb 2018 12:50:05 -0500
From: John Garry <john.garry@huawei.com>
To: <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <slaby@suse.com>, <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 1/2] serial: 8250_dw: add IO space support
Date: Fri, 23 Feb 2018 02:42:02 +0800
Message-ID: <1519324923-196857-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The current 8250_dw driver only supports MEM iotype. It is desired
to have a platform device-based 8250 UART driver for ACPI FW
with IO port iotype, so update the driver to support this.

Note: a solution needs to be found for autconfig
using MEM accessors only.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index cd1b94a..28fbc8f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -405,7 +405,7 @@ static void dw8250_setup_port(struct uart_port *p)
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *regs;
 	int irq = platform_get_irq(pdev, 0);
 	struct uart_port *p = &uart.port;
 	struct device *dev = &pdev->dev;
@@ -413,6 +413,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	int err;
 	u32 val;
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0) ?:
+	       platform_get_resource(pdev, IORESOURCE_IO, 0);
+
 	if (!regs) {
 		dev_err(dev, "no registers defined\n");
 		return -EINVAL;
@@ -425,22 +428,28 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&p->lock);
-	p->mapbase	= regs->start;
 	p->irq		= irq;
 	p->handle_irq	= dw8250_handle_irq;
 	p->pm		= dw8250_do_pm;
 	p->type		= PORT_8250;
 	p->flags	= UPF_SHARE_IRQ | UPF_FIXED_PORT;
 	p->dev		= dev;
-	p->iotype	= UPIO_MEM;
-	p->serial_in	= dw8250_serial_in;
-	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
-	if (!p->membase)
-		return -ENOMEM;
+	if ((regs->flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM) {
+		p->mapbase	= regs->start;
+		p->membase = devm_ioremap(dev, regs->start,
+					  resource_size(regs));
+		if (!p->membase)
+			return -ENOMEM;
+		p->iotype = UPIO_MEM;
+		p->serial_in	= dw8250_serial_in;
+		p->serial_out	= dw8250_serial_out;
+	} else {
+		p->iobase = regs->start;
+		p->iotype = UPIO_PORT;
+	}
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
1.9.1

