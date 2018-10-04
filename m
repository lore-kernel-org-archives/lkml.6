Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497AFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42021477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm5s2UNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C42021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJDOGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:06:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeJDOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:06:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so2936482pfh.2;
        Thu, 04 Oct 2018 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDLKC8mccMQlJBLbaeVeyOyj6CtF5fyW9cAMQS36jm4=;
        b=Lm5s2UNq9dlKEyciJVZJ4WBMKJPcBUcsWPztsqtIrEIRZN0tG0CU4Zj+NXNNZejdok
         xtrQyioLIwSGbo6NRL7ROjbir61XSlsPH5R+C7kqukeFKZIMs+9KQ9e91INYyzxGnpyd
         DwX53N1KRUtVApEm/0AXFealTiLb+W9MBbrCX1pT2VNU+GNkvtDyUJTdR7KDmPVAACCG
         xWJDCntxDIqTktISrQ2avjgK10bebWqGEKP+kBhgoHVpOnRpNvQroPjMFB7x0ZrecK1w
         Z4CmO3YZHoAbJ39NyMAf8Z4NAmw0OSoO1Po5BKDQnp8WYjuBzU6sZf7x2/ziy9BWjOV3
         oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDLKC8mccMQlJBLbaeVeyOyj6CtF5fyW9cAMQS36jm4=;
        b=FtwOJuQURQOyWplF8lWjiM7puOrMmICUTzyhb05Mdn5iGBe0Cxxc6DJyjl4xK1ru1B
         TooRyMvAS1ziqVfG+wUaoeWwtSHvVRWWLVneLWbt+VQQ4UJhLWFr+EsHz35pLutWtmpS
         mfUuJGEZv9WaD2ZPDTQ8J4nqoeLLzAW3/5AeBhF2p4mQZz1ceBMYCEP6JfGyMFam8M2F
         F8CMm1rpg1hpz+f840T6eDwOpVHiAKxOjfmPOHax2BDeuraeO5WnrHEaFYXVBlyGxofY
         SHqKFnUNxN5iRUZZXluPa0NWyy7frScOk00lUZhpbUYg8e4+ArEO5zdgGwvynwWwzIRv
         oF0Q==
X-Gm-Message-State: ABuFfoibFgVI/QYfT+b7/AspclP2rvejkRnhGAIcAGlg+TfqMrpWi3iQ
        sJcH7UhDhTZlhfwsnlL2t/0=
X-Google-Smtp-Source: ACcGV62aBpTAgkqdeyHi31u38i/vfNQThwN/twxEe+he9xjupOtmQ1137ffFsNiYopEZzzINIq/K7Q==
X-Received: by 2002:a62:e414:: with SMTP id r20-v6mr5389721pfh.25.1538637259299;
        Thu, 04 Oct 2018 00:14:19 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id r1-v6sm8645402pgo.81.2018.10.04.00.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:14:18 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id B5BEB161836; Thu,  4 Oct 2018 00:14:18 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH] TTY: Replace spin_is_locked() with spin_trylock()
Date:   Thu,  4 Oct 2018 00:14:04 -0700
Message-Id: <20181004071404.16407-1-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sn_sal_console_write() used spin_is_locked() + spin_lock() to get
achieve the same thing as a spin_trylock(), so simplify it by using that
instead. This is also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: <linux-serial@vger.kernel.org>
---
 drivers/tty/serial/sn_console.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 42b9aded4eb1..fe9170731c16 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -888,7 +888,7 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 
 	/* somebody really wants this output, might be an
 	 * oops, kdb, panic, etc.  make sure they get it. */
-	if (spin_is_locked(&port->sc_port.lock)) {
+	if (!spin_trylock_irqsave(&port->sc_port.lock, flags)) {
 		int lhead = port->sc_port.state->xmit.head;
 		int ltail = port->sc_port.state->xmit.tail;
 		int counter, got_lock = 0;
@@ -905,13 +905,11 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 		 */
 
 		for (counter = 0; counter < 150; mdelay(125), counter++) {
-			if (!spin_is_locked(&port->sc_port.lock)
-			    || stole_lock) {
-				if (!stole_lock) {
-					spin_lock_irqsave(&port->sc_port.lock,
-							  flags);
-					got_lock = 1;
-				}
+			if (stole_lock)
+				break;
+
+			if (spin_trylock_irqsave(&port->sc_port.lock, flags)) {
+				got_lock = 1;
 				break;
 			} else {
 				/* still locked */
@@ -938,7 +936,6 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 		puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
 	} else {
 		stole_lock = 0;
-		spin_lock_irqsave(&port->sc_port.lock, flags);
 		sn_transmit_chars(port, 1);
 		spin_unlock_irqrestore(&port->sc_port.lock, flags);
 
-- 
2.19.0

