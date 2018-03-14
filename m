Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220671-1520987845-2-12478094418559536964
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
    t=1520987844; b=byHe3O9cpiYQ/9m6jYsmD/Rc7VdGW2ZLhwqP/ErY7FxuDGB
    9UKSL3oFVs0vAMDHmvkDyj+WTvil0vf/wJ6o8Y2DWaafbSs3jEXx4B3DXuFISMJ8
    hwgPw1aXD7dM9728t9ATj5TYaMS4bO6LRNsei34I1gMA3kZ1nCddGbnnn6hoHB7H
    8CoEYkVIPUv998GWUiP1oWHtndW9SbO2M/4y0g0PMjHVY2uaPt/ZsdrKocMwTego
    CzXHRklYTgKtvHKPcC4Ip7Wc1Av811flly2x26KHFm05t9sMYk1nI/uw4W8gwMaW
    TxiC9WIeByAg2ZZdGv/U3Wzaa9sSp9pqjoG9YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :in-reply-to:references:to:sender:list-id; s=arctest; t=
    1520987844; bh=7yFKG5iwm35DCPGaevoBG2xJZw8dSZy+aikj0QT9An0=; b=b
    8YCxSapoJpvs7o9ruQlt4ZN9nW/c+GYsrUOxNkc2lN+wCntXGELR5I2HyYYEYKxa
    XK8XyF/lp1tsuSCSOmDQsNPPeXRVMDVOuMFeOUmGG+152oVz3S3daMMo2JP3UmYY
    +BInGTJi7cq8llOES6JHr0bGRyNZrXGegY7EDekv8i1fgY12T68d9arkPJkN86kH
    3yYtkr7LJJKP4YduIdHHyJzHzji1Y4LQQ6ZSjh+Y85hNEKoZOVwiVAOtG69QwY3u
    enJqf2TETbEnY/C8IHa3aKKCQgrFsk2MqaFP3Hx2n6rDo5YhDdnN1qpOuiOqjmUb
    8n1VqSbJNpr2ohADFq2Jg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XcWL9LCJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-60 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=amk9f6Fg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XcWL9LCJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-60 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=amk9f6Fg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933055AbeCNAhM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 20:37:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35054 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeCNAhI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Mar 2018 20:37:08 -0400
X-Google-Smtp-Source: AG47ELswSo+GO0nulqMOZLYDLabfIjbyreHN+3jbhVdZByyVqUT5ctih3pQouLKNYicE5Y/ewghdUw==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Vignesh R <vigneshr@ti.com>, Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] serial: core: Allow skipping old serial port initialization
Date: Tue, 13 Mar 2018 18:36:55 -0600
Message-Id: <20180314003655.12141-4-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314003655.12141-1-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
To: unlisted-recipients:; (no To-header on input)
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

This is most noticeable when using earlycon, since part of the serial
console log will appear to disappear (when the bogus old takes over) and
then re-appear (when the real UART finally gets registered for the
console).

Create a global variable to allow skipping old serial port initialization
and wire it up to the special amdcz earlycon setup handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/8250/8250_core.c  | 6 ++++++
 drivers/tty/serial/8250/8250_early.c | 1 +
 include/linux/serial_8250.h          | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..91ee206096f1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -66,6 +66,9 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define SERIAL_PORT_DFNS
 #endif
 
+bool skip_old_serial_ports;
+EXPORT_SYMBOL(skip_old_serial_ports);
+
 static const struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
@@ -537,6 +540,9 @@ static void __init serial8250_isa_init_ports(void)
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
+	if (skip_old_serial_ports)
+		return;
+
 	for (i = 0, up = serial8250_ports;
 	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c6bf971a6038..8511b8e25b3f 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -202,6 +202,7 @@ static int __init early_amdcz_setup(struct earlycon_device *dev,
 {
 	struct uart_port *port = &dev->port;
 
+	skip_old_serial_ports = true;
 	port->uartclk = 48000000;
 
 	return early_serial8250_setup(dev, opt);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..cb6fd144529c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -146,6 +146,8 @@ void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
 
+extern bool skip_old_serial_ports;
+
 extern int early_serial_setup(struct uart_port *port);
 
 extern int early_serial8250_setup(struct earlycon_device *device,
-- 
2.16.2.804.g6dcf76e118-goog

