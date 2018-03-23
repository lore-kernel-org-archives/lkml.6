Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806073-2-16354316277310641771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806073; b=us/laejaXrirr0zZYXLHVDSWVc9TdCYHTPcPy94rwZrKI+J
    v+UB0trl5yaCHMf5A9/5NVRoaPE8gf6aVhmGZGCyJ9mBG6M8kTXshS7ed9yYG7nf
    vuiqb/szYYJSim60HDUDwJLOA1uPp3zqjbU3sfpgIRZQERzwSweIQ9InPk2T2t9G
    w4nQBZnHlNx7u8D9INpkrsivigI7NV/dx/aDlFOw1Fv/00ooAQrq10UC2zz2l5e4
    GFxo/ROzD0cza0K9cthPu5qA2UC9uw7hj1k7qgEA+9SdV2ujSUYJHliljaqOjfSd
    HrKWl7e3+5X01Rbm9JdS6uZxPW4Y1N8jAeNjIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806073; bh=cDSeymhqn+SBJ0ZtB6v1gINjSt
    gBXqz6oQockmn57VY=; b=ON5akDW7hXSr254IWpxWb7QX9K4ucTeRmYKwNlwbXt
    AH2DbSOoGBgRhJEQkHlkcRH1FeYaAd+xgb5+w4nc9ALqW/PvKTJ91+b6cgpnxrcT
    lu0anJ2NXZXb744uott3a3bVifRX3hgIaC6rrKOCEhSOo/jdVFUkhUwbSQJccNpe
    oijYcDzFk/GY4xl8OB8q1A7NXq4gM8G1/6vMB94ag3epxc6oxLab/nkYUzeOL5xN
    T69gtOWE9LNzIjwobncaHMtUOb5By+9VtuH8HprL2uq4io28NDvn2y2vaRsEebNu
    SQLKeOmkvoYV7uCjbJXlgJoNi22mI5uybfw9/81e6ugQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeCWKBd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753908AbeCWKBb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 19/77] tty: goldfish: Enable earlycon only if built-in
Date: Fri, 23 Mar 2018 10:53:53 +0100
Message-Id: <20180323094143.490235440@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>


[ Upstream commit 6a28fd2bbc94bfca105632e5ef8a9dbe63ba0b39 ]

Commit 3840ed9548f7 ("tty: goldfish: Implement support for kernel
'earlycon' parameter") breaks an allmodconfig config on x86:
|  LD      vmlinux.o
|  MODPOST vmlinux.o
|drivers/tty/serial/earlycon.o: In function `parse_options':
|drivers/tty/serial/earlycon.c:97: undefined reference to `uart_parse_earlycon'
|Makefile:1005: recipe for target 'vmlinux' failed

earlycon.c::parse_options() invokes uart_parse_earlycon() from serial_core.c
which is compiled=m because GOLDFISH_TTY itself (and most others) are =m.
To avoid that, I'm adding the _CONSOLE config option which is selected if the
GOLDFISH module itself is =y since it doesn't need the early bits for the =m
case (other drivers do the same dance).
The alternative would be to move uart_parse_earlycon() from
serial_core.c to earlycon.c (we don't have that many users of that
function).

Fixes: 3840ed9548f7 ("tty: goldfish: Implement support for kernel
       'earlycon' parameter")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Miodrag Dinic <miodrag.dinic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/Kconfig    |    6 +++++-
 drivers/tty/goldfish.c |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -394,10 +394,14 @@ config GOLDFISH_TTY
 	depends on GOLDFISH
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
 	help
 	  Console and system TTY driver for the Goldfish virtual platform.
 
+config GOLDFISH_TTY_EARLY_CONSOLE
+	bool
+	default y if GOLDFISH_TTY=y
+	select SERIAL_EARLYCON
+
 config DA_TTY
 	bool "DA TTY"
 	depends on METAG_DA
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -442,6 +442,7 @@ static int goldfish_tty_remove(struct pl
 	return 0;
 }
 
+#ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
 	__raw_writel(ch, port->membase);
@@ -465,6 +466,7 @@ static int __init gf_earlycon_setup(stru
 }
 
 OF_EARLYCON_DECLARE(early_gf_tty, "google,goldfish-tty", gf_earlycon_setup);
+#endif
 
 static const struct of_device_id goldfish_tty_of_match[] = {
 	{ .compatible = "google,goldfish-tty", },
