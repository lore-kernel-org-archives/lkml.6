Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549902-1519120681-2-18281545606931473306
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
    t=1519120681; b=Pk1EEUn3A40ZGn+pTvOapDlUssTiLJyqwpsg3GaSiTUnXtE
    Xwcdcw1fVuJCE1Eony5t/VdBT/AZf/H7s4297G0f7h1fDlkJU6IORjuF2JqvUj6C
    InzQ8Hiuz3FBJ3WTVKvWfppQ9Sj9N+XsH9Yn4ewKFscVK8AHGgdl2LJn13GnTNGN
    M/s32emoGC/htw+qfGoNCtvuEW45upNKctF5J+NJ9FRvatjIpdSvXBVl0wcb2Aqy
    B6ipJGfMGAVoSu4A62yzRaYvYbccN7lWZYl1oCdBojgMDkr91SzGQmTwEE4S4V1i
    6XU4mIf40WxVdLqLYBUJZABUq7TLPdNvU3mPqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519120681;
    bh=Mj3mlp05aK1mLGGLCgAHTFHpjbXkJs2OsJVyH7O5qSQ=; b=cMcbuSrckARc
    7JKIX4+SEe/EpfysajnlSstWvsSjKaZRtl8FgNcxT9tR3AMW5ZYIjRozScYPWvPa
    BWq1necaUcrMO2Rp2aQgE9bVPaUFo6tXpnL1hQQ2EisdK6JUftsuOzw+zxmDV3GR
    nKAfP4D4eC1PIXHtDWEAzi84MBbJYJVJsEOxO2g8E7goK5iYxXG6SWrunR2xCQv1
    rvJ3lyDZoNDGvk3qmaQxYw10IN0nI9Yb3gLaOoBJCojimQbfWdB9KvPRayeQIkeX
    JIQFi/WhezdAVjkNMjnqw5ReXAnE62dVrU5NTJPaAQqe+24CmDuVzzh7jK50bAMu
    1S33r8VQOg==
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
        id S1751260AbeBTJ56 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:57:58 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:59728 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeBTJ51 (ORCPT
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
Subject: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:24 +0100
Message-Id: <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cdns_uart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
-- 
2.7.4

