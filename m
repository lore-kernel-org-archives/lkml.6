Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DCC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D5D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="pS4FZEhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D5D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeICRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:25:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43662 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeICRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:25:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so574173wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wAc4mxprrZJRSDLuxfERTSaZgAw7fCrShliGBe4qeqE=;
        b=pS4FZEhw7zF6nZgXqlCQ6bCl9RhWC/J6l1HgAJm8bzW7ZOtRRN4T/sb369s2zEu7ff
         MydpiD5+ZR2GAK6/ykyK8EUpSEfG6S8M5kGia24DRr00FSUuz7qSvhSrq2mTh3PwGtAH
         rtY9GMQE67ikbg6eBZGcCyNw1+gFwA6LMLYgE6Ths1DxgkA2jPDMb7Mg55XukQw+vzwj
         f+/Il9p4uOwcV/Vp0pll5Fzn2AuN7/2N5wh3VzYbbnpzh+IkIcuHmFJu+pn1EI4yJR2K
         z0/hNYnljPdgg66nzSwn2sEr3YSzRdd0ehrGuc35D+I5UWE8gSdK6k3mqXufL2ZuBp1S
         svGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wAc4mxprrZJRSDLuxfERTSaZgAw7fCrShliGBe4qeqE=;
        b=YdmaiBGYT5yrZ0HIGwAfuyYgiB2MBm5WwaobRhXrjLZlY68RDTDa5xwpgp3zV3kHMx
         s0kWP4bU1NrNxTZ+yg7DPRcBJDb7hBrJVWyei4uStnw7uO9ZMcx8Xu4Dyy5Q5E7/ksHd
         RH2cUSNbQQ4L1tMf5uBvrZaUwCYD7rVJxOx3YniJuH68wD+Vd6X24ObJb29Dvitut7Lf
         7tRHBZz1hfVpn961LZnJJPVcRgfzy7trMZDKGkVDuqG/zAU9M9qPc293JtG0MfL7QUgK
         JSZ32MLjgAGG8e7DNj3ptBxt8b3kSlvP9THm+ghjJOQZzVxb0SR71oFRtoCu/o57dYCC
         dBiA==
X-Gm-Message-State: APzg51AaYeBN4xN7tukWGto5m9gGSlW9kDtODoNqLa76gM8cTBz7ubjQ
        tS05oiAVml7InITg+nnrUG235icw7sJJKQ==
X-Google-Smtp-Source: ANB0VdZaw8aUDEfh0YkAjceX+8VIuWLS4RjfSrZXa9thDYinWtuyIeNw9EToCmbJVRZ2uVifDHNAWg==
X-Received: by 2002:adf:f4ce:: with SMTP id h14-v6mr20484921wrp.259.1535979946877;
        Mon, 03 Sep 2018 06:05:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d22-v6sm20506367wra.80.2018.09.03.06.05.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:05:46 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Enable automatic flow control
Date:   Mon,  3 Sep 2018 15:05:37 +0200
Message-Id: <2e3db53f40db4ce52000f39461c9b0e534e8ec2c.1535979935.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable automatic flow control which should ensure that there is no
mainteinance in connection for zcu100 BT case.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Nava kishore Manne <navam@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a48f19b1b88f..e5d90611c03f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1003,13 +1003,12 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	val = readl(port->membase + CDNS_UART_MODEMCR);
 	mode_reg = readl(port->membase + CDNS_UART_MR);
 
-	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
+	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR |
+		 CDNS_UART_MODEMCR_FCM);
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
-	if (mctrl & TIOCM_RTS)
-		val |= CDNS_UART_MODEMCR_RTS;
-	if (mctrl & TIOCM_DTR)
-		val |= CDNS_UART_MODEMCR_DTR;
+	if (mctrl & TIOCM_RTS || mctrl & TIOCM_DTR)
+		val |= CDNS_UART_MODEMCR_FCM;
 	if (mctrl & TIOCM_LOOP)
 		mode_reg |= CDNS_UART_MR_CHMODE_L_LOOP;
 	else
-- 
1.9.1

