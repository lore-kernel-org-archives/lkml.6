Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607228-1519929846-2-10882495055710720426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519929845; b=EOEXeJyxhhChIHooOSTlCBlwzKUfuVcd/E5BL5WvdSn83ts
    9jwJ5jwdxtpfL0miDLD7CjUrwk5sHJxJjXxf/lSm97uOFPt3V4RmzTvbN2VIFYLg
    FQts87GqG95RJNRHZyDl4hXTyhx4i0RjYpUBDEd6XAVa9/1L9ZsAd99uJP5c+30W
    GfvygEriWIlRk78ZRpOA5dFCc2ZnEq1pdx8qdHIq6E2rzI85Xkf8iurZD9Xo2/xE
    A65Za3ZAm5vFlzS0TK+KEBW0KOxkzinoPLajRujw5guQnmpLcirVeK8vuswihunr
    EEFqPQ2biY46sLmyKJQ4z6kxei7DLcx7cuJM4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id:to:sender
    :list-id; s=arctest; t=1519929845; bh=tC7/GVALl55bUrzL/6cUtV1dhi
    m8iYxLY8HZvwzf+qA=; b=f3qtkmO9fnx5RiLmkR0yJ2xRR+Zxi4BUHnG0P/JZc2
    ApkMvw7apM5AS2z4Xn/UWkNyk8r0aXjLd+aoa4jwiEbhpfOYSsXlodG5neSY0Ov1
    TO6XVmVGw202413GmgoaoeQtj6GsaFJ2mVKPh4CSznomvwt/bWJESPbkODB61Mno
    xnnxXNep6zUA1WGpB+SsS9nJsBgzT1PNMpwvSWlDpsN3fH++ByhiRgdWQr4q7wn3
    M0BvZ9F74+/5pIht2YCT6JZiS56FKGzmTbs6/qMovBxBiR8eTc8GUshItimFro6Z
    ENLey6wIpdDA5kD0fBNZdjClJXTgp+knKRHCZF1VvpJw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=IK+2A0kz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b5aRV0qw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=IK+2A0kz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b5aRV0qw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161008AbeCASnp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 13:43:45 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40250 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034098AbeCASnk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Mar 2018 13:43:40 -0500
X-Google-Smtp-Source: AG47ELs9L6Dff6XlNjgf9gbK9+KgUlHHl/fIa4inrmbZYNzDGE3BNeyj5SssQLgduWlPst2F/pTmuA==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, briannorris@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Saeger <tom.saeger@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Thu,  1 Mar 2018 11:43:33 -0700
Message-Id: <20180301184335.248378-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
To: unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently when an earlycon is registered, the uartclk is assumed to be
BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
options, then 8250_early's init_port will program the UART clock divider
registers based on this assumed uartclk.

However, not all uarts have a UART clock of 1843200.  For example, the
8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
on such a device will result in incorrect divider values and a wrong UART
clock.

Fix this by extending the earlycon options parameter to allow specification
of a uartclk, like so:

 earlycon=uart,mmio32,0xfedc6000,115200,48000000

If none is specified, fall-back to prior behavior - 1843200.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/tty/serial/earlycon.c                   | 8 ++++++--
 include/linux/serial_core.h                     | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..20e72cada38e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -958,6 +958,9 @@
 			to be equivalent to 'mmio'. 'options' are specified
 			in the same format described for "console=ttyS<n>"; if
 			unspecified, the h/w is not initialized.
+			A UART clock rate can also be appended after the baud,
+			as in <options> = 115200n8,48000000; if unspecified,
+			the default 1843200 will be used.
 
 		pl011,<addr>
 		pl011,mmio32,<addr>
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 870e84fb6e39..e846f406a1c6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -115,12 +115,17 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	}
 
 	if (options) {
-		device->baud = simple_strtoul(options, NULL, 0);
+		char *uartclk;
+		device->baud = simple_strtoul(options, &uartclk, 0);
+		if (*uartclk++ == ',')
+			port->uartclk = simple_strtoul(uartclk, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strlcpy(device->options, options, length);
 	}
 
+	port->uartclk = (port->uartclk) ?: BASE_BAUD * 16;
+
 	return 0;
 }
 
@@ -134,7 +139,6 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		buf = NULL;
 
 	spin_lock_init(&port->lock);
-	port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..b772f0d20b18 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -343,7 +343,7 @@ static inline int uart_poll_timeout(struct uart_port *port)
 struct earlycon_device {
 	struct console *con;
 	struct uart_port port;
-	char options[16];		/* e.g., 115200n8 */
+	char options[32];		/* e.g., 115200n8,48000000 */
 	unsigned int baud;
 };
 
-- 
2.16.2.395.g2e18187dfd-goog

