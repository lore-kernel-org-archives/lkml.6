Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49827C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697821872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVWkWsJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfAYDzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:55:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39607 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfAYDzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:55:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so4090315pfc.6;
        Thu, 24 Jan 2019 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cybw0B3smWl3ggaY2rGioXhyGSgdUMHQ0vjwYWmqmf0=;
        b=GVWkWsJNMgzCrXLMTjpxfZpFJ5zk5a3yPOROBFpUjCyFTd6OebkvUS6jeX/WU8HbPt
         a3VFZBLx6Ll4TWwqnGNEdCndAlQ7zw6Qyb2CMJY8UR/lCYXxGSRbCOu9/OJ34o3yIJeo
         sZ2vvXfkcV3bAM2ZYVsiiP93u9xyr8b02Z8JtWuAvN3HKcbBh0c4LE9Ay3n96rfG/1wh
         qWUb8n9To8dEACaeIGZmuqzIWyP3NgLNXNTneUCs3G4sJLRAFBaMTcWprKMvmBk4syzV
         OrsWxxXoqGF2UT/QOKNQ5BmA2TQqGkr2MQxc37tBFiOCAa5rl+QABQ5qxU/IQI1nlKXW
         nRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cybw0B3smWl3ggaY2rGioXhyGSgdUMHQ0vjwYWmqmf0=;
        b=mDQtEnJ9vNfsR6r6hxar4brfFi4ye1VvO1Wodf2/5e2AiWRK2bOKSdQziRdpeIeiCD
         4yi4MQjElG+cI3MrVmVSknoLozxJn/FBWp1UEIy5/DAwfCEV19TYbDIWbseaP+PnRXYE
         fHdsP1t62hB4vUElCLAKnG+tm52vVJV565g69CI6ACsO900sWS1Ih07MKVHd4IfLkINf
         NCOgOvn18s6hbcUjBeYF6WamcfhaMmazAhrj6frkc9AGF7fuQ7KUtS7y4ud6KTbIsS9+
         xB3mpQg0uLXTKic4bbHQyiRRzdrU3ka/HBongqgsr0oIEOOoJDJSzrQ/iz1NlgoHvjPl
         4Y/Q==
X-Gm-Message-State: AJcUukeXri2jzLKKy1OsHmhZ8tpU1R7qLVCej2lO4SxJ/rcnTE2Z5p0o
        BF8GerOUvOZWTDDiCzp9u/7J1Aj1
X-Google-Smtp-Source: ALg8bN6+C2ITwqljOp/IOurKkt8T7/fo0VgdA6FRMDYzOd8IV1njd+tFaUqLpN18OKFm5ph1uGlSFQ==
X-Received: by 2002:a63:2586:: with SMTP id l128mr8671573pgl.104.1548388515745;
        Thu, 24 Jan 2019 19:55:15 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id i193sm77952257pgc.22.2019.01.24.19.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 19:55:15 -0800 (PST)
Date:   Thu, 24 Jan 2019 19:55:12 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ldisc: Fix for pty driver
Message-ID: <20190125035510.GA21654@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_set_termios() should be called with slave side of pty driver. So, If
tty driver is pty master, it needs to be switched to ->link. Also,
tiocmget() and tiocmset() operations are optional so we need NULL check
for some drivers missing the operations like pty.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 76 +++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..169dde91b3d3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -299,10 +299,18 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+/* If driver is pty master, return slave side */
+static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
+{
+	return  (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+		 tty->driver->subtype == PTY_TYPE_MASTER) ? tty->link : tty;
+}
+
 /* Flow control or un-flow control the device */
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 {
 	struct tty_struct *tty = hu->tty;
+	struct tty_struct *real_tty;
 	struct ktermios ktermios;
 	int status;
 	unsigned int set = 0;
@@ -314,45 +322,52 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		return;
 	}
 
+	real_tty = hci_uart_get_real_tty(tty);
 	if (enable) {
 		/* Disable hardware flow control */
-		ktermios = tty->termios;
+		ktermios = real_tty->termios;
 		ktermios.c_cflag &= ~CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		status = tty_set_termios(real_tty, &ktermios);
 		BT_DBG("Disabling hardware flow control: %s",
 		       status ? "failed" : "success");
 
-		/* Clear RTS to prevent the device from sending */
-		/* Most UARTs need OUT2 to enable interrupts */
-		status = tty->driver->ops->tiocmget(tty);
-		BT_DBG("Current tiocm 0x%x", status);
-
-		set &= ~(TIOCM_OUT2 | TIOCM_RTS);
-		clear = ~set;
-		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-		       TIOCM_OUT2 | TIOCM_LOOP;
-		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-			 TIOCM_OUT2 | TIOCM_LOOP;
-		status = tty->driver->ops->tiocmset(tty, set, clear);
-		BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
+		if (tty->driver->ops->tiocmget && tty->driver->ops->tiocmset) {
+			/* Clear RTS to prevent the device from sending */
+			/* Most UARTs need OUT2 to enable interrupts */
+			status = tty->driver->ops->tiocmget(tty);
+			BT_DBG("Current tiocm 0x%x", status);
+
+			set &= ~(TIOCM_OUT2 | TIOCM_RTS);
+			clear = ~set;
+			set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			status = tty->driver->ops->tiocmset(tty, set, clear);
+			BT_DBG("Clearing RTS: %s", status ? "failed" :
+			       "success");
+		}
 	} else {
-		/* Set RTS to allow the device to send again */
-		status = tty->driver->ops->tiocmget(tty);
-		BT_DBG("Current tiocm 0x%x", status);
-
-		set |= (TIOCM_OUT2 | TIOCM_RTS);
-		clear = ~set;
-		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-		       TIOCM_OUT2 | TIOCM_LOOP;
-		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-			 TIOCM_OUT2 | TIOCM_LOOP;
-		status = tty->driver->ops->tiocmset(tty, set, clear);
-		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
+		if (tty->driver->ops->tiocmget && tty->driver->ops->tiocmset) {
+			/* Set RTS to allow the device to send again */
+			status = tty->driver->ops->tiocmget(tty);
+			BT_DBG("Current tiocm 0x%x", status);
+
+			set |= (TIOCM_OUT2 | TIOCM_RTS);
+			clear = ~set;
+			set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			status = tty->driver->ops->tiocmset(tty, set, clear);
+			BT_DBG("Setting RTS: %s", status ? "failed" :
+			       "success");
+		}
 
 		/* Re-enable hardware flow control */
-		ktermios = tty->termios;
+		ktermios = real_tty->termios;
 		ktermios.c_cflag |= CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		status = tty_set_termios(real_tty, &ktermios);
 		BT_DBG("Enabling hardware flow control: %s",
 		       status ? "failed" : "success");
 	}
@@ -367,9 +382,10 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
-	struct tty_struct *tty = hu->tty;
+	struct tty_struct *tty;
 	struct ktermios ktermios;
 
+	tty = hci_uart_get_real_tty(hu->tty);
 	ktermios = tty->termios;
 	ktermios.c_cflag &= ~CBAUD;
 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
-- 
2.17.1

