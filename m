Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2738277-1520030535-2-13970161603561939625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ru',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520030534; b=onx6ulT1Q6pxSHzkqq9+LiQAWz38gH+Eh55KixgelnSlpQL
    TIbvSNyjZ6x60b0qsXvr1gFykMtrndishydreoAQvgdnWrskhXqSa2V7rNmRzfPk
    NPCOvvUche+r0qk6eu9525QLGfkNHKConNKKigM1EAo8jLE7B7OOAIuWo/AeHFCI
    J0DU88J4Pg0AjjcVARwAGL75inaIZ0JWvI6X3ld9NQYrXyL8Ve1h1Rq0gpi3qQgJ
    RlYC1WY/EwBXGhDsurmy8C5aFn2CUsOUNJTmtDfxcM2ghC0CyPm0B1oDevBXi3za
    crU69IC1mBHZzP2O1COpjfmKfh7V8XOPz1sIjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520030534; bh=aWFbuVSq6FQFjFgBVpeGDMRc3B
    odEpNpJCvs2gpmLo8=; b=slxYt2TXy6427WFxvigNfLNty+GtNiDIaQ5hZJ5VXJ
    mir3aOrdrFACToGvWWFvaxw5gfti8GdPsMkLHC99DprpFn6iQwBmkscj5j5UOBpQ
    JNsmwlDh4F5PzXb/jV+JqJJXOi+sd7jPCH4S0skR/Ha8Vjpi7pCANoHoRoOSPtZy
    JAXwLzkdNNNBBFl76AOungzMf2PFU5tlI9ENPXkcv5/aJvrRIJJ2Mw1PY0LykpsX
    MBthRd4wuvTrXcBPeEdfn6ymMnAvwtl9twCs6CunxQ4Q5EzDNeXbHciIhAt70fPW
    Jtt7gByYZna3yi88b45IvQ4etFH62AjHpVjmJ8oJm3gA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ispras.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ispras.ru header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ispras.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ispras.ru header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCBWmN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:42:13 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55404 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932121AbeCBWmM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Mar 2018 17:42:12 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] serial: mxs-auart: disable clks of Alphascale ASM9260
Date: Sat,  3 Mar 2018 01:42:01 +0300
Message-Id: <1520030521-19049-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In case of Alphascale ASM9260 probe() enables s->clk and s->clk_ahb
via mxs_get_clks(), but there is no disable of the clocks.
The patch adds it to error paths and to mxs_auart_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 254da0d753fb ("serial: mxs-auart: add Alphascale ASM9260 support")
---
 drivers/tty/serial/mxs-auart.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 079dc47aa142..531c374a5e3e 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1674,8 +1674,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -ENXIO;
+	if (!r) {
+		ret = -ENXIO;
+		goto out_disable_clks;
+	}
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
@@ -1690,21 +1692,23 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->mctrl_prev = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto out_disable_clks;
+	}
 
 	s->port.irq = irq;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
 			       dev_name(&pdev->dev), s);
 	if (ret)
-		return ret;
+		goto out_disable_clks;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		return ret;
+		goto out_disable_clks;
 	}
 
 	/*
@@ -1712,7 +1716,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		return ret;
+		goto out_disable_clks;
 
 	auart_port[s->port.line] = s;
 
@@ -1720,7 +1724,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-		goto out_disable_clks_free_qpio_irq;
+		goto out_free_qpio_irq;
 
 	/* ASM9260 don't have version reg */
 	if (is_asm9260_auart(s)) {
@@ -1734,13 +1738,15 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_disable_clks_free_qpio_irq:
-	if (s->clk)
-		clk_disable_unprepare(s->clk_ahb);
-	if (s->clk_ahb)
-		clk_disable_unprepare(s->clk_ahb);
+out_free_qpio_irq:
 	mxs_auart_free_gpio_irq(s);
 	auart_port[pdev->id] = NULL;
+
+out_disable_clks:
+	if (is_asm9260_auart(s)) {
+		clk_disable_unprepare(s->clk);
+		clk_disable_unprepare(s->clk_ahb);
+	}
 	return ret;
 }
 
@@ -1751,6 +1757,10 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[pdev->id] = NULL;
 	mxs_auart_free_gpio_irq(s);
+	if (is_asm9260_auart(s)) {
+		clk_disable_unprepare(s->clk);
+		clk_disable_unprepare(s->clk_ahb);
+	}
 
 	return 0;
 }
-- 
2.7.4

