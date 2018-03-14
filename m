Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220671-1520987826-2-13523872148154476904
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520987825; b=IaMCnZFUZqix+DO/oLjSyn5UmsfuTn1ltB4S3FBOmADjzvj
    vHQLh+P8aviUDw76zfTkeZA91EEBqAiqM5yvhjDU1lwH58LiG1M5x+LsaWk5Nqg+
    CIShMVoKbmTBi+28rTKiJ/WIll4fPnxHY+uqjhOsKY6TomkRWB5YYwmA5LiJShGY
    LdCJBaLKVA7O6MpF+BVdIygbu65TTUqrzM8ZaJdlggFGKnowIQyVHTv9R48dRANn
    x7vJZjw8GRUXUgPU2r79JIb8ckuTcGHHXmIceRsW9Cds8qpN1m4zryETCN2LDDcI
    KUb/EN9Dt24rotzMn7zQxM3cXpy8hi3giyT8avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :in-reply-to:references:to:sender:list-id; s=arctest; t=
    1520987825; bh=OuVer0mDa6Y1H+JQYPUa+54JE5+NjeW13hBCpsGSeoY=; b=b
    wOPQX3yu559KQjByT9DPrxLVanuwPN58DEjaLQXvBi5yqqrcIrrXIMNesKu3b5CC
    i2gvsU4glHlsCPerWleEgNgOkL1Gw+OvipVqXmlhnJHoS58EOpor5poH+NcnN/Qu
    0c5cSS9xRMRANTgf2pMpT2HYzS3sOCHzqfGvVvOHd6+fZj3THDhyUbEh9NaDPOxA
    E4FCaswSrk7etQ23bntc/5lmyR3pPwmcpyoQrd2bSROeq4siR7k/LxEgNZ9XK+ve
    MLbNhaMJ6Y5ZyftbWx51gngLPdl90UK6Pcu5LrydYESEbKDIXfPaLezvhsf+C9QQ
    deJsbyF1uKBGg1xT7vk0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=SB6z0pPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-60 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UbpektbP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=SB6z0pPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-60 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UbpektbP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932590AbeCNAhC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 20:37:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38525 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbeCNAhC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Mar 2018 20:37:02 -0400
X-Google-Smtp-Source: AG47ELusWKJ8oXKLKQtOJMS4VzJfqLChIWlqdJMb/o+XV68o4dHZd4XnPT3ZB25qbqjpY9o1N+47Eg==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
Date: Tue, 13 Mar 2018 18:36:53 -0600
Message-Id: <20180314003655.12141-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314003655.12141-1-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
input clock.

Allow these platforms to set up this clock by specifying a kernel command
line like:
earlycon=amdcz,mmio32,0xfedc6000,115200

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/8250/8250_early.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index ae6a256524d8..c6bf971a6038 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -195,3 +195,18 @@ static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
 OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
 
 #endif
+
+#ifdef CONFIG_SERIAL_8250_DW
+static int __init early_amdcz_setup(struct earlycon_device *dev,
+				    const char *opt)
+{
+	struct uart_port *port = &dev->port;
+
+	port->uartclk = 48000000;
+
+	return early_serial8250_setup(dev, opt);
+}
+
+EARLYCON_DECLARE(amdcz, early_amdcz_setup);
+
+#endif
-- 
2.16.2.804.g6dcf76e118-goog

