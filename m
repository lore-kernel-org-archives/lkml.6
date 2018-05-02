Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1076443-1525281313-2-2415275205563059951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525281312; b=Aq9rJTxkBe02Z7qLsylWfHwoy28fI/8TJOKM/IjOGBBpyYu4JD
    js9nblZklXNdNIkJbpepTxQPy6vi4/nFMkrGyXAeHbYJ1hlZzZf/+fl5uhs5IPWb
    9bJVeyAhS6ir9lWVwQJjQd+u25hOhTH3a8FXEyTkpLzvSpLR8uYd8X36xy+mXGpv
    GlB2VGWaZVFmtE28Jh1v/qKGzHvLd5/2BE8Vbga6eBw+Debri8cav8UJt4HDhmum
    i0hthyEaqNHOGYiHcqXAIRCdV6KTzxMMwtR9JAJlFEO4ciSSFeEdip1PHigM49BY
    r9Wlaa5YvR1OyJ7fLo+XqFMbWG+qf6oPTyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525281312; bh=fXDSs3SOoIRekJB/qaUw5oKceL/COI
    paBVC888HHB9c=; b=nqdS8T/Ev/8mqIB+McoSESarLyA5DgSOkx5uJ/7vJRXdGu
    JKF35lRB+B7KpXOvMRmEAw3ZUvAfDYScNp0wr1JjgyIrLDZYHD9a7rcFybON8IQO
    a8Ds59Y2dVBMcF8bBOCn3Nv7D5Utsakm+mIZ+aaiQyyRF6rNAO49TArifUlS5HXE
    FBKBf6KIpuQOMX5kbtNEymBZUIRsR8mIuMlxdP8fTF7hz3hiDIFpU2UiMC2J2DeI
    bqLsCL65LBW94GSjkZnhlIpQdHmfVzZiXV6BLrSrMEWYfzO/i1gJFYYrjAbNGTHg
    F1h/eMYLtJjDCnW+yC9fI7IMqb6NWtporXNfAf0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIY9tCLpnZSBO5Q/bcYjXQcmkitfNz/gWZX/lEney1kVZ2M6tI0EhzWOKpQnuQZZXHKix3obKwQ8Fb/RFKTWpm4pUIeeOgXE2tzTIml7n6sVhsOB4P8n
    TF+gfe3NTkugGnu0L9F+3tD1TYF2CyNp0eIAFlomEl5YkST/xmO0Hdg6QnI2bq+kkVgBsif+r2TcPGhO0Oi95W8tUYe60YvsxyXG/rVIbxWeQeGXUWRsUaTg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=sozttTNsAAAA:8
    a=pGLkceISAAAA:8 a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8 a=n-LJQ6D0-nDkTcXN1wQA:9
    a=x8gzFH9gYPwA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=UeCTMeHK7YUBiLmz_SX7:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEBRPH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:15:07 -0400
Received: from muru.com ([72.249.23.125]:39798 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeEBRPF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 May 2018 13:15:05 -0400
From: Tony Lindgren <tony@atomide.com>
To: Peter Hurley <peter@hurleysoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] serial: 8250: omap: Fix idling of clocks for unused uarts
Date: Wed,  2 May 2018 10:15:00 -0700
Message-Id: <20180502171500.60462-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I noticed that unused UARTs won't necessarily idle properly always
unless at least one byte tx transfer is done first.

After some debugging I narrowed down the problem to the scr register
dma configuration bits that need to be set before softreset for the
clocks to idle. Unless we do this, the module clkctrl idlest bits
may be set to 1 instead of 3 meaning the clock will never idle and
is blocking deeper idle states for the whole domain.

This might be related to the configuration done by the bootloader
or kexec booting where certain configurations cause the 8250 or
the clkctrl clock to jam in a way where setting of the scr bits
and reset is needed to clear it. I've tried diffing the 8250
registers for the various modes, but did not see anything specific.
So far I've only seen this on omap4 but I'm suspecting this might
also happen on the other clkctrl using SoCs considering they
already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.

Let's fix the issue by configuring scr before reset for basic dma
even if we don't use it. The scr register will be reset when we do
softreset few lines after, and we restore scr on resume. We should
do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
using clkctrl similar to omap4.

Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
bits are needed for the clkctrl to idle after a softreset.

And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
for the related workaround to be enabled. This same compatible
value will also be used for omap5.

Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around
idling UART after using DMA")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1110,13 +1110,14 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
 static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
-	{ .compatible = "ti,omap4-uart" },
+	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
@@ -1362,6 +1363,16 @@ static int omap8250_soft_reset(struct device *dev)
 	int sysc;
 	int syss;
 
+	/*
+	 * At least on omap4, unused uarts may not idle after reset without
+	 * a basic scr dma configuration even with no dma in use. The
+	 * module clkctrl status bit will stay set blocking idle for the
+	 * whole clockdomain. The softreset below will clear scr, and we
+	 * restore it on resume so this is safe to do on all SoCs needing
+	 * omap8250_soft_reset() quirk.
+	 */
+	serial_out(up, UART_OMAP_SCR,
+		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
 	sysc = serial_in(up, UART_OMAP_SYSC);
 
 	/* softreset the UART */
-- 
2.17.0
