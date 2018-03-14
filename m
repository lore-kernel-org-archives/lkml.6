Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2690414-1521063933-2-10219453146551039118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1521063932; b=gu3TTyu+L2XqnRUqRWgT3QOScgYMYb503ct+ytw2q0qtIkh
    crh+fh4lMD4OnxSDBiCMCvWk72wf8EiwKrHA4HGdODOAtVyPs+Bti5NcyQm/m3Nt
    xIHU14Ua4oEL687RVHdtM9hLRp4kN6xZLM+AJJcJvrlEszlg4ZRPyg84wj5iITiU
    Rl/0lUn22MIdEBpjVOukyuJ3rzIZSIkUSK+GxtKVaEdty5Uis3gxGawRgaIe0wA/
    v3Fa4McW8OXuUlxrCVzTNX5zYmn1exPDfgoveg9o6f5WjAAzY0c5FLaJghp4J9oZ
    dp3yMpAiBr3/kYBnTw0tkesqR4mHJyNerWbc2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521063932;
    bh=Dd+sY8VB0n2Dhzi5d6tuYSWul9PxVrYcsXleQfMmaMg=; b=c9n3ow/T1rJN
    KIewyDqSfBFYr7ig9LJPDcHpshEUqgo/zJvEU4eghAHLbfpnM5RoFdqMHEf11iyK
    2WqTFAdIGktyTjffxPvokX1AuCZB+k1XZRneT4GW1WBYWd28G1te2gzHbvFo8fP2
    W63snCZDPS+yZfSCZ3vjPHmzNQBi6jBcG0A8nH8RJ6dfc5ERYLNc+zSvNMzDnuIE
    M9JpCmTayl2aWMTpWl2aFafcd3hl1OvZKHNQpBlSXR7rFE5nV/A59POIIcOFbFYc
    np822D/88IEV0atCKDNFI1N3Vt9fvgY8f8cn0HwLlHWN7CwYCL1a0g2TKRI3YnNp
    YHbFvPhI5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Fy+JxLEV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ub2M7lHv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Fy+JxLEV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ub2M7lHv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCNVpE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 17:45:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40589 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeCNVpA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 17:45:00 -0400
X-Google-Smtp-Source: AG47ELv0zL1htaeISAP7a733ZLsdMDmsXn1sCEfkbK4Ebo+YUo76Sj2u3dhWrVO+ynCltp9Bnw1Qjg==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Vignesh R <vigneshr@ti.com>, Sean Young <sean@mess.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v2 3/3] serial: core: Allow skipping old serial port initialization
Date: Wed, 14 Mar 2018 15:44:38 -0600
Message-Id: <20180314214439.27806-4-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314214439.27806-1-djkurtz@chromium.org>
References: <20180314214439.27806-1-djkurtz@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The old_serial_port global array in 8250_core is supposed to hold an entry
for each serial port on the system that cannot be discovered via a
standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is populated
at compile-time from the value specified in the SERIAL_PORT_DFNS macro.
This macro is defined in arch/serial.h.

For x86, this macro is currently unconditionally initialized to supply
four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).

However, not all x86 CPUs have these four ioport UARTs.  For example, the
UARTs on AMD Carrizo and later are separate memory mapped Designware IP
blocks.

Fairly early in boot the console_initcall univ8250_console_init iterates
over this array and installs these old UARTs into the global array
serial8250_ports.  Further, it attempts to register them for use as
the console.  In other words, if, for example, the kernel commandline has
console=ttyS0, the console will be switched over to one of these
non-existent UARTs.  Only later, when the real UART drivers are probed
and their devices are instantiated will the console switch back over to
the proper UART.

This is noticeable when using earlycon, since part of the serial console
log will appear to disappear (when the bogus old takes over) and then
re-appear (when the real UART finally gets registered for the console).

The problem is even more noticable when *not* using earlycon, since in
this case the entire console output is missing, having been incorrectly
played back to the non-existing serial port.

Create a global variable to allow skipping old serial port initialization
and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz earlycon
setup handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
Changes since v1:
 * Rename variable to serial8250_skip_old_ports
 * Also set variable in acpi/spcr. to support no-earlycon case.

 drivers/acpi/spcr.c                  | 2 ++
 drivers/tty/serial/8250/8250_core.c  | 6 ++++++
 drivers/tty/serial/8250/8250_early.c | 1 +
 include/linux/serial_8250.h          | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 52d840d0e05b..f59591283410 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 
 /*
@@ -208,6 +209,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	}
 
 	if (amdcz_present(table)) {
+		serial8250_skip_old_ports = true;
 		if (enable_earlycon)
 			uart = "amdcz";
 	}
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..a04da392a251 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -66,6 +66,9 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define SERIAL_PORT_DFNS
 #endif
 
+bool serial8250_skip_old_ports;
+EXPORT_SYMBOL(serial8250_skip_old_ports);
+
 static const struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
@@ -537,6 +540,9 @@ static void __init serial8250_isa_init_ports(void)
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
+	if (serial8250_skip_old_ports)
+		return;
+
 	for (i = 0, up = serial8250_ports;
 	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c6bf971a6038..288d2be82990 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -202,6 +202,7 @@ static int __init early_amdcz_setup(struct earlycon_device *dev,
 {
 	struct uart_port *port = &dev->port;
 
+	serial8250_skip_old_ports = true;
 	port->uartclk = 48000000;
 
 	return early_serial8250_setup(dev, opt);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..02570edaddd8 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -136,6 +136,12 @@ struct uart_8250_port {
 	struct uart_8250_em485 *em485;
 };
 
+#ifdef CONFIG_SERIAL_8250
+extern bool serial8250_skip_old_ports;
+#else
+static const bool serial8250_skip_old_ports;
+#endif
+
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 {
 	return container_of(up, struct uart_8250_port, port);
-- 
2.16.2.804.g6dcf76e118-goog

