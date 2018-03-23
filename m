Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807219-2-8251132552639618843
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
    t=1521807219; b=oztvIkCsat6K05inL5i8bybhoq1DnWsecfmM07XvXC6vO1o
    gdiEqY7xjGqiBLip85IfCtt3IcKZtDP5YWYqueJrtkIPA31efbrTn2+UzigD+7gi
    ODArEQTipLR/eYckA5z7DGMRttxWQpA59wZ8paRV6skXJLqLS7+Z0dsIw5aIygmP
    auw8gnnlLijnxXJkDCiESaNIz5N6q6nAO4ZFshcPmK6K1qbMxVcUloisMz3O5wGY
    sla8DsL3iW1c2WWWIcSycZvHMwvNNbx93rjMHq0JNczzvDTQIlNMwB27QGOs73fM
    +wtaFhJzcbWhXZWlwlvdzKF2o12EjMUd+BbVppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807219; bh=sHHWdI3BkATvVoUVD5u3A7WqiC
    6hkKg64NFOkGe4WUU=; b=Gsl8ENswbaRCqGE29LcqXZwSGCMGhL3BCJLDFwdPhE
    6As9oa0BRIFP9hWXyuvBkxKLwpo1hCEcFCsqIiVvz21JAnYQgKIwv5A/Tq/DD/CM
    fsHar6bubKNV2abRJO3zErWkTXlPi/1ugd5+4VtR4Myn0HonLA5tZp/RzhgYsDve
    etUe0LNzHFnUaCw24GdrvoEFpZZgmOXSlbMLFzRsKWdqPTVRHffj8oBmFWpA3pz4
    He0mtiLfFIBMPMxe1wH82BWFHRic6nvGoMdDJAmVJaJYbMafNI2DT/ULIPZRXsrx
    jPBHx8NTKHRUI/CoqX6G8A+9yoCqYfEtlh5cna8Do16w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1752877AbeCWMNW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:13:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbeCWJ5S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 23/84] tty: goldfish: Enable earlycon only if built-in
Date: Fri, 23 Mar 2018 10:53:37 +0100
Message-Id: <20180323095415.396641894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -433,6 +433,7 @@ static int goldfish_tty_remove(struct pl
 	return 0;
 }
 
+#ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
 	__raw_writel(ch, port->membase);
@@ -456,6 +457,7 @@ static int __init gf_earlycon_setup(stru
 }
 
 OF_EARLYCON_DECLARE(early_gf_tty, "google,goldfish-tty", gf_earlycon_setup);
+#endif
 
 static const struct of_device_id goldfish_tty_of_match[] = {
 	{ .compatible = "google,goldfish-tty", },
