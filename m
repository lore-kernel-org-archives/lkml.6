Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2493035-1519120753-2-4449460247397094371
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
    t=1519120753; b=dj2ehjxsBeITudKlXYCAKQYp0g/nyVGajBLRWcjoqusnfRB
    GlpQRuZkE9u+lBdjrF4YNymcVfTtgcFJF/HX7AIHt7gHLRi5OQfHd+RuD2msTH1a
    PNKE+6GE6aQ8G2QNji38u2sbbP7yrWx6Nje7YgHxCBy9XWKvPyk2zl+ktGYTEvlv
    zDJrghJsjggtR6oyNogeejfF4Lu1jDc7JTdLKQGn6Jp0H0XWS3X+8llLEDfZGQ+k
    QRKo5e5D98BTfwsdffugh8+KOpBLW+8PddcfrDYy/gp820ZE/ZWhrG8Ohjme4skC
    +hrhknPuEPfQwgqw8szkyXWQFeME7juGdIG3OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120753;
    bh=cyqL2nEh9Ffuo/ZojD3+ZQCvoPw7E/4ZJVa8CJYtATQ=; b=izYrIwBo8B6s
    ACDyMpZiC+GYPq+D0TnUxiQTyS0N9xH88jFUATHsq2F0K4ETv6ha/iinhziEjIxh
    gPTjbukBq/q2TiQOTN8N36/Y8Gr+U+JImWw6EuxVaqYg457g+kmQKOvKmSEf9NAo
    RhuSy53A9kPXEPv584FAJ0py7xZ54ldqceWZaOWuROQw3YVRN3ktve0MP5cJEX2+
    cdi9iyPoOzCz46Od39uAiG7MNyzuQKLQZ7qlLPwhWQvXbK0wv4vaijDuAPFP0IhZ
    zUQS1jkK3b/cnZ8QWLzP0I0fzNEXcuZHktoUb2UKPKN/F2d3nNbpggyUTlnWh9eR
    1A9nZDFfcg==
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
        id S1751443AbeBTJ6B (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:58:01 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:59766 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeBTJ51 (ORCPT
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
Subject: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:18 +0100
Message-Id: <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The imx_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1d7ca382bc12b238..e89e90ad87d8245c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_device *pdev)
 		serial_imx_probe_pdata(sport, pdev);
 	else if (ret < 0)
 		return ret;
+	if (sport->port.line >= UART_NR) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sport->port.line);
+		return -EINVAL;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4

