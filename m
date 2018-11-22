Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A4920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Qr/MzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A4920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393453AbeKVUCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:02:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35499 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbeKVUCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:02:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id v1-v6so9003235plo.2;
        Thu, 22 Nov 2018 01:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ACUNLoznwnHbuSMw5JykDoPOoiMS1cJESLZHwuChfgQ=;
        b=f9Qr/MzT51nGl6dxJi/dZcg6GVpMSfJ+4cl4ceqXz0BG/uEJKbFIUIojc1v0awkDEZ
         +0DHeYI0JvMU9/faLI80ob8yMdTwZDVI3RUSNBjF6yHOa4tJxTNlPFLMjqqG42A5cn2X
         U3i+1341iP6qrEahqP7jYCZGB4AnUTnuQT54acX7GTrUwPZ25D83UjGbBsocBngnMnZh
         X2fqM8hB/QCe+kLIugptXIc9TsYzrMUKcYiHrYJBDQB8FgUHUvZsfd3GO/8+l9jNwizf
         uXMKKTeQ2j1jgqtsQgibqxK8aNrfsvCZCt8QtyOCCNYjQDinqQztWqXUOcS4LHNILsO3
         jC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ACUNLoznwnHbuSMw5JykDoPOoiMS1cJESLZHwuChfgQ=;
        b=rD8PPTVggl8XCfIloQOMcf1YJl7M5TKTOTqthdkr99EP9xdJwTNddDmBUbsOF/86/h
         Y7k1DySv9Ux7g3OVGAezwGHo+gpcS5d/EBC4eQXGvXitfx0/684Mk2cRak0mlozCz16K
         EAqaOAK0RI51owy9ZqCMycxZgWfQJQdif+atw56kqbyBkOsiPYTqylAKTIFAIt3v5A6i
         AM2K5Veecfx3GUlstj4gA1q3qkkVEomEWByGHquAPm1qI+tpY0k+6VOQwFmS79AREQ/D
         aRXFsbG3wGtbKaF3pQTJgpvjtstPw8VKV9UGxRb/7RLKL0kFQg79T7edcSVK50lgGLg6
         TDTA==
X-Gm-Message-State: AA+aEWYctY/2jZSSnhu1AaH2cn8wngCFWMXwdvpAx42bGRuI8d0xxOSs
        OxxAsGtMj4yCUDA5HgxtQ40=
X-Google-Smtp-Source: AFSGD/WQwJ+2kZDxHroSLaYy0csklZB9oBn2XEurXXc7t50TAXsvPuiwe+f+SKOHaNMCymQGALmbaA==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59-v6mr10651865plb.26.1542878635366;
        Thu, 22 Nov 2018 01:23:55 -0800 (PST)
Received: from ip-172-31-7-250.ap-northeast-2.compute.internal (ec2-52-78-83-66.ap-northeast-2.compute.amazonaws.com. [52.78.83.66])
        by smtp.gmail.com with ESMTPSA id 128-v6sm56008130pfd.64.2018.11.22.01.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 01:23:54 -0800 (PST)
From:   Chanho Park <parkch98@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Chanho Park <parkch98@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] tty: do not set TTY_IO_ERROR flag if console port
Date:   Thu, 22 Nov 2018 18:23:47 +0900
Message-Id: <1542878627-25315-1-git-send-email-parkch98@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Commit 761ed4a94582 ('tty: serial_core: convert uart_close to use
tty_port_close') and Commit 4dda864d7307 ('tty: serial_core: Fix serial
console crash on port shutdown), a serial port which is used as
console can be stuck when logging out if there is a remained process.
After logged out, agetty will try to grab the serial port but it will
be failed because the previous process did not release the port
correctly. To fix this, TTY_IO_ERROR bit should not be enabled of
tty_port_close if the port is console port.

Reproduce step:
- Run background processes from serial console
$ while true; do sleep 10; done &

- Log out
$ logout
-> Stuck

- Read journal log by journalctl | tail
Jan 28 16:07:01 ubuntu systemd[1]: Stopped Serial Getty on ttyAMA0.
Jan 28 16:07:01 ubuntu systemd[1]: Started Serial Getty on ttyAMA0.
Jan 28 16:07:02 ubuntu agetty[1643]: /dev/ttyAMA0: not a tty

Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty_port_close")

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Chanho Park <parkch98@gmail.com>
---
 drivers/tty/tty_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cb60750..044c3cb 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -633,7 +633,8 @@ void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	tty_port_shutdown(port, tty);
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	if (!port->console)
+		set_bit(TTY_IO_ERROR, &tty->flags);
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
 }
-- 
1.9.1

