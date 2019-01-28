Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC4C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS8Z7Yvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA1GxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:53:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39413 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfA1GxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:53:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so7325635pld.6;
        Sun, 27 Jan 2019 22:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=06xdCdtRR06KTVY+pLjNmKSVjH30nkMmIgzGgULRezI=;
        b=RS8Z7YvbSvn3vYxVewo647h665538qs07iLt4dGFFckhXAxmSgQ/4ntHEwew7bwc6O
         b992er5IxFzxqGffeBJJscp4y6Z3LMjqmdmOUYGPm0E2vc8ZBOf0bBaC+zf0jJ+URN6H
         JUjs/QmJ3eqybmcvqXR+PBJtbYY/tDH9jDF7AAyFUg1o5bKHiCNh6copFdGr68BqjmfR
         50DsgfHOuwjZSg15V/s+m4C20TxVLmr1IL8f0J1zIRIZw+/yHdMGWvsTtan0Aa/25xkU
         kaJvOPcxN3vRXZ02h93dOv0ENZ8NHC2kok2djG0RStrshUkbJGOmCi9S2hwfatyuXffH
         t5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=06xdCdtRR06KTVY+pLjNmKSVjH30nkMmIgzGgULRezI=;
        b=biHM/8iqgIT/k5coNW7iDGInk6I/1cm7njw6IxdIRxz9ehZkp2ftwWrSpS/MorHDXC
         x4NA4bJfYNijcJoOzAU44/H7X0pji6RctIaaTIVV2/uiWYBjWgC1E0h6EEdZQos5vS7E
         XEBaY2hUW3dOnEK0p+f8YhmjQufjKMR7Ia9essfQDNmd30TYv7vk26LVCJkdLxXEHWr6
         KMxJ/7IMVFoIlwvDg82cm4+pUr/sydbXyT4bACSLJSynu0bp2ORBZ9Owv9/OTTOKiZx0
         46h4B4NCaD4DNFxXufj7j3X+PanSYWTXC/cSKthRyp0eeTjCgS/cF/mpLEOBbnIR6ywB
         Jb6g==
X-Gm-Message-State: AJcUukd13MIkQE/Uc+TjtJwYslPJ13h8L2MT1562fvXQWmxMIXO3CXmG
        LAUodIU/3GKv085pkF426iQ=
X-Google-Smtp-Source: ALg8bN4B7Q+Ycax2hd9srlD84igfxH4MYv/Lwz2fJLXrf0dt63AXNjdE0s6Zw/1j1Y7tBoS5tfHy/A==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr20012110plp.94.1548658384789;
        Sun, 27 Jan 2019 22:53:04 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id e16sm39769853pfn.46.2019.01.27.22.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:53:04 -0800 (PST)
Date:   Sun, 27 Jan 2019 22:53:02 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Switch pty driver to slave side in
 tty_set_termios()
Message-ID: <20190128065259.GA2976@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_set_termios() should be called with slave side of pty driver. So, If
tty driver is pty master, it needs to be switched to ->link.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..90c5ea8c399b 100644
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
@@ -314,11 +322,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
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
 
@@ -350,9 +359,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
 
 		/* Re-enable hardware flow control */
-		ktermios = tty->termios;
+		ktermios = real_tty->termios;
 		ktermios.c_cflag |= CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		status = tty_set_termios(real_tty, &ktermios);
 		BT_DBG("Enabling hardware flow control: %s",
 		       status ? "failed" : "success");
 	}
@@ -367,9 +376,10 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 
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

