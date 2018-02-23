Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3019937-1519393184-2-4342592108314575954
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
    t=1519393183; b=L1FGw9D5LeqSPaRhQuYEmOAXHJ+zMj8FTKSoORGPVxK7WNk
    odLETMWnHRPqWTRjC44Y+KzaO+rLc46tOkYSskDo9KWPBGmiwJ7lbKWsAoq9I+9O
    wSR1gOndzulW6QooPLK7aIA9qb1rkHIk91MVDlLAmtXGIWodK1Av6CvtramZ1xV+
    yaE3381J/RtxlmPJ2c6/OMdbewkT2a9oUDPuP2lZe5d5WwLIOewwIlWtU4e7RkoY
    jgxmIKiXBOyMbSPhKZbCfZnr2rtNWhbfEJlDqSAL7a80Vc9BQ2DP21PvYI1paeBK
    cVeOGHWNOCEtZGJboJBAscMt/tsrCu96SX2ISeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519393183;
    bh=KzWboYbBI3jlKq6K51r3g//KPHZVeIgbehj5XRRJJvU=; b=awwfLnXLhAvJ
    TyxkdqKvY/cUV9DVuCim7Sx0Biw9ELtNMtYpKD9JB5093jzDJvglW4rMhA0njfA1
    3yeZdVg5oYefJdIYW2YadMiyhCnruHUsscqVZZz5zXCOlgnMug734ge7J/mZGFTU
    auTwffvuunpngN3QVMpwaImA/IvZLFdaJ14le1fPr3Bc4RsMyMvJh4j3LfJ6zyXB
    HaerHW7whWGNj7ojYZwhSilBb8GG7SYfuw4jAYM3rT33MVaHBspoT/uNXRy+4+nR
    PXw5H/ZTcqt4KkfQcj4/67EOfoAwBu9c8Z4GdT9BPgOxPJbFK3FdYTkKdYIof+rb
    7QJ0cf1Guw==
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
        id S1751953AbeBWNj0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 08:39:26 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:60014 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeBWNiq (ORCPT
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
Subject: [PATCH v2 8/9] serial: sirf: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 14:38:36 +0100
Message-Id: <1519393117-31998-9-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sirf_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: a6ffe8966acbb66b ("serial: sirf: use dynamic method allocate uart structure")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE().
---
 drivers/tty/serial/sirfsoc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 9925b00a97772a1b..38622f2a30a92e7d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1283,6 +1283,11 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		goto err;
 	}
 	sirfport->port.line = of_alias_get_id(np, "serial");
+	if (sirfport->port.line >= ARRAY_SIZE(sirf_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sirfport->port.line);
+		return -EINVAL;
+	}
 	sirf_ports[sirfport->port.line] = sirfport;
 	sirfport->port.iotype = UPIO_MEM;
 	sirfport->port.flags = UPF_BOOT_AUTOCONF;
-- 
2.7.4

