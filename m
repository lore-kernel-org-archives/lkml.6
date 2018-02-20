Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2493035-1519120683-2-10840293182293998342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='be',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519120682; b=AjGtwYjK+XJhATy8Bl94T4uXhhUBnI8H9tu6/qP/bGbW/5N
    Gk2rWQYBP+iradDP0aqLzJJnUIXe4yk+mv+ZCj1KGXt1YeF5J7d5p2vSxEllWr1Q
    USGQ14LDZUZ72YN88qjJ5TNi8hR+/JcHWxjWdwYnIftVjTs8mtCkHpwOtotE/IPi
    kgcOE09ydN1hE01cRNVYIeWEXiHD9g95Dq2hTokEz92rkdh6hpsXkvB9fFaQeYZu
    gqnAcGMYlZbTqvWZxLb41dAcjV9k3zReKl0FdPRGVv6UUJnuydYvW+Lti12nrzBU
    tIA8V5CTdiFd9I/jdNnudeeDsxzsDhdspPMgKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120682;
    bh=n1Uye7gL8M1BVt8+yrNcq63/XRJ8GNrgSU9yOXWIZ/I=; b=ei0iM7EKP1g9
    LuikG9wp1yAKhkO07jOaOQJjHMKOhKOyeqoeaOs4Xl/pMvZ2CQzIv6tUkN6VNoST
    m1OFIQ1V4jugLRuigSEto/KBt5oBZk2qYs++mDxtHUqPk/mKQSOn4bfKsb84cYEa
    dnplxVC02jl6Kn+0mdEavMfMc4QwPnuoXUL6mPaQxrMsXfuxAkOm4CuHF2Zy6Z9h
    uqc8/h69gqLfI1+v+ki7l7V7eTXPfaVuI5Sg5LDQ+52XIOIO1fcCVP2QrtbpEJCO
    JxMEJlNMscjqkZlgWuQFBfbzqi/VWXJ4WBohmKxfXmjq57lmKH6uRJ2idtxPIKZp
    NCeY3112QA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBTJ6A (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:58:00 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:59758 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeBTJ51 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 04:57:27 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/9] serial: fsl_lpuart: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:17 +0100
Message-Id: <1519119624-1268-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The lpuart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 970416c691dc68b5 ("serial: fsl_lpuart: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8cf112f2efc30707..5218e2ed1ba90a5b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2145,6 +2145,10 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	if (ret >= UART_NR) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		return -EINVAL;
+	}
 	sport->port.line = ret;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4

