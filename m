Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3019937-1519393197-2-5019579754551367731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='be',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519393196; b=t8MZYXU2jaa37aP6DiKC5IRBYQ00vJZrTpMorrlrd9srh+0
    Zpp4uj2l7GABaLQohDb5kkpZwgV9Cbcu8pzxmIHr0sWCkrP8h+oukImBZas5NVih
    yrZ0DYyIY5vIDWuTrxBoTTssW3CAu0EfL8DRZDfQbl1pw3fedHImWqP2Nd5vy7KD
    ZsRAe6mv7G8jn6WFvDQ4d8RvG1JUMCy8S6KTRUKhsSsBwmezvKDwYBdSBM0bcHQY
    PNxH9RJACshtWvxmyIivd4jUL64kUzbLcZn0WGA4PEQOECbRzodJWH1vXt+kAV1N
    KWbcsnoL0Exd/gxu+o5OnLofADuT+NN6ywHuQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519393196;
    bh=MPDIezCDKG5AiABZtrQ6RWUS1xCdOBTiy8WYhLPozuk=; b=Uy4eaPIujXLz
    dvRWhnBm3BBjcl/w+Kc1ZRbXkXWmHOt9Pv6x/cO9SdyKbXT1cFHx4kcTDFQSAxsY
    ZKdSrPzDpuiPrxacsRTVu0FGo52LTe8SM+3/OPl8te6iKwSzJ1YkKSILb7gD6GjR
    lDA9H6xDg52DwFg/pZ5Yt8ECVN35uVXmuZRb2CcUVFRxuAO+FzyLDSvL/kifmzC2
    EE0+5GxLPaTG/NTg0pEz4wPaRr2pY/wtpXtRr4D+ZtTNDkCZJP33jTQFjfyaDDmW
    CTA3Yd6vMBtyZFNi0NbC+HV6nkep7qC8Xz+xMpvHQGmMnzkeeoDSWoIqPIrDX9Ls
    5DJOaTs9cg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=glider.be header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBWNjZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 08:39:25 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:60028 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeBWNiq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:46 -0500
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
Subject: [PATCH v2 6/9] serial: samsung: Fix out-of-bounds access through serial port index
Date: Fri, 23 Feb 2018 14:38:34 +0100
Message-Id: <1519393117-31998-7-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, or from an incrementing probe index, which
may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using
a legitimate DTB or legitimate board code.

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing ports")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE(),
  - Update patch description for non-DT case.
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f9fecc5ed0cee826..3f2f8c118ce09d56 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1818,6 +1818,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
-- 
2.7.4

