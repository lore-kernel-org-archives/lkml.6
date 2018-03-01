Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3591957-1519928458-2-2540743308579225643
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
    t=1519928457; b=LpyXxlH6CB1BUGw4b7u0x0GO8ZGAaQ0Kid2J1TEJI1TvGts
    G3hj+hAEcyo6R6GzjvPcKviBPQ66lRqkGATJKszjEMvOvfQjnKsQXdvUto6gyCgU
    S0p9XlinjtZUhRIpAg5Q+ObvOeDgPWWZvBqOIr9Ieh2GH0dITbyeW41vOB266iYj
    e3ti86hjz6TVO0lqTketbYGR/neMtoq/OG5uvbUfHCgg26HPs6asdZudvS2JjA3R
    REQsSO77ML4ZWunCUxOb2DAQPXi/g85HyF9ZocopUMDnav0NC/Biclvn5jhk9nhu
    zyEJ54HO5BcAbC8GTeKTf7ALofyBP6REDqlRaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id:to:sender
    :list-id; s=arctest; t=1519928457; bh=6ccRM1QveNOBNQSVniMoe6IVFo
    qxHll4TUR/c/96whc=; b=Qeg37fvOzpUB2bvwNEEBC+9aVWuGTDBeue6EvmlOG5
    2kO9bFCqTuOfHJVKlmGENgwqplVe+gqYJTcSJYLwi+QQD4eeODEmKLrjxDva2hxj
    ZTcBbgz6nUxG6TvV6LkNTXeItNrdXfalrivW57CcMO5348kx3HdA/0175UFDQf2U
    DcMoF7UvuH5HwAzXYlK+JuNmCQGoWLkbHGpDhPiFvJe8Wit+n40M19PK6C33AP7A
    2j5a7sn3DALMpfNlf2/LgXRVod0+fa+IK+g3dCVxW9tVPEUCjW90jYydOrGLeO3N
    s8E+hTWBcOpVjAo5MsFsmvNX19d/3gmydVJFPKRYXmrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kWxbw5fa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiF+p19p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kWxbw5fa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RiF+p19p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033225AbeCASUh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 13:20:37 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36498 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033861AbeCASUd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Mar 2018 13:20:33 -0500
X-Google-Smtp-Source: AG47ELutcUXNaoJIY+LQTRFUIJIkDMA/dnA6sK/LZuTOiOdHQxGVp1KMJDCquIioQvXH72YdhwqNgw==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, briannorris@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] earlycon: Allow specifying a uartclk in options
Date: Thu,  1 Mar 2018 11:20:28 -0700
Message-Id: <20180301182028.237856-1-djkurtz@chromium.org>
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
 drivers/tty/serial/earlycon.c | 8 ++++++--
 include/linux/serial_core.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 870e84fb6e39..c9b38f520057 100644
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

