Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2576399-1519122113-2-2181028504774643039
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
    t=1519122112; b=bQXhZLha7Ig8B6YSQbO+7LteBmW5dPuGsNyDOic43Un/CYi
    1xEcD9lG0esf78K79zwq81Xd6W8gKXrDpsu+nS+8uT/4lKpsoGd8Q9QbWC9J7rRr
    EL3lzSwKdiB7KdRqalmH7/QuAo2XwltaLyyjrgD5hOoP2NxWHrxLA91A8+5M+5AR
    DK1ZPx4eM8NGq99qOBpdyeWlvHmUJW0G/LAqk5PGN6qI+Ytp49QoQNA6w8Kk6WaM
    vwFr0lhvIDjetS9qgId9Okp/VITz9opuquW8KptCC0PQXGJ67PtjAJoY8ErXTDEP
    euhl5A3v3bnUwhEqwizs4aA5E3eiQ2nxxZPmSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519122112;
    bh=LqekoaVWXqq2qjuXhdr4g2/50c7NlSQ52IxlJmshV8o=; b=kHdpN9Zoub/G
    h07v7m3E2n6mEu+s9VcfvowCRGQxjKj+QB8Z9+nNIv29IaxiWvGXEhXqI1EhRawj
    /Wn44t2nnY9VgTJUi3sVjI54qFG2e5mMlFiOWUZdTYEXze+qzSoNjCUVI71fnmTB
    4Q/kLxu9C3e5jJQ6yzlTrtDYV5STG0TUJvtCob4J5aJhWE0DJymi1L4Qn5ntcb06
    +/3gztZb4zAmu1gfDyStxDCpTAtEL/PhYqdW9JLYEWxXuB678qJpV7j2GaD1m9Qn
    FLBN5GCQf33sJKsmVg8KXutWD4SJ9Nt5TR3L22bSow+KqBSmjJIHfmiYG6k3o214
    U9lKvvA8oQ==
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
        id S1751358AbeBTKVu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:21:50 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:55232 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeBTKVt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:21:49 -0500
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
Subject: [PATCH 5/9] serial: pxa: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:20 +0100
Message-Id: <1519119624-1268-6-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The serial_pxa_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: c8dcdc77298dde67 ("serial: pxa: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index baf552944d5686e8..ac25faa95baaad0e 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -885,6 +885,10 @@ static int serial_pxa_probe(struct platform_device *dev)
 		sport->port.line = dev->id;
 	else if (ret < 0)
 		goto err_clk;
+	if (sport->port.line > ARRAY_SIZE(serial_pxa_ports)) {
+		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
+		return -EINVAL;
+	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
 	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
-- 
2.7.4

