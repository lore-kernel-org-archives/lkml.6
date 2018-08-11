Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000A22436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4GKmli8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B000A22436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHKEHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:07:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32872 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeHKEHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:07:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id b90-v6so4717460plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hh3dhIR2H2hQcGSB7bAcef0nVcc7E+h6SPFH2kmnZ3g=;
        b=G4GKmli8ggpF1cOSDJn7EVDxP6ZKj4bGPmxxtW5+4x1EYeyc9AMubKfbIL8G7cgyCb
         gmay90wr4lAEw3Gl0/UCnX2JmOnO64Md3jSonr4qIaLIy4/lVzY38WI6f8g4eYdi7Vn6
         plBBZ54EKY9KdgG80TBz9B2ZAMM+QMQTAc9xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hh3dhIR2H2hQcGSB7bAcef0nVcc7E+h6SPFH2kmnZ3g=;
        b=haMk5/PvDGvy+tYC+ENPUI8lzkesRfneCAvUR5OiVSHR7HbXGdOJDCRVzedkLoyyLO
         rzTp2HGdgt9nAYYcatp4HkkbSScdMKpalv7r3cvyQqY++ixjZqeHIkrgN9daxeC1YIHo
         Xil0BPQKIDk+Jum+Fa9YfyKop8MFr0W9NQZX+dXboWdzkjhTGv4LfF97vu87CveV14LK
         rgwTAKQmiTD6rLQUqcdpAUpcjbGWkkKpeneK4/GO6r7OUFLuBptua4eVG2aKPnFA850p
         nnoCSV4QFUA+Q1GqHou7UgfArpXZ05Wx0SLYKaKy17Bgk0aH6DI+5Zy7AwGOVITOSFrn
         I0dA==
X-Gm-Message-State: AOUpUlGGnvcWGe0EwQtGtQz27dJ51FN3f3+1wbi82P7tcllC+YmRS2H2
        4uhhs2rYvOXuHvj+hWZ+GOBc+Yyn8+ykpA==
X-Google-Smtp-Source: AA+uWPwxfwA/rKSiFHrsiy1nmqyPKtwG3k6JDKrHZeLhOW7UesA/6RBuM4rfc+RO5VZr76aM2k8t9Q==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr8290901plp.20.1533951312512;
        Fri, 10 Aug 2018 18:35:12 -0700 (PDT)
Received: from ubuntu.localdomain ([45.56.155.48])
        by smtp.gmail.com with ESMTPSA id d22-v6sm21722373pfk.69.2018.08.10.18.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 18:35:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] serial: sprd: Use readable macros instead of magic number
Date:   Fri, 10 Aug 2018 18:34:24 -0700
Message-Id: <7b3341ab8778d31bf564bdcbb04b8c6e09fa4d6d.1533950271.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define readable macros instead of magic number to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1b0e3fb..e18d8af 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -45,6 +45,8 @@
 
 /* data number in TX and RX fifo */
 #define SPRD_STS1		0x000C
+#define SPRD_RX_FIFO_CNT_MASK	GENMASK(7, 0)
+#define SPRD_TX_FIFO_CNT_MASK	GENMASK(15, 8)
 
 /* interrupt enable register and its BITs */
 #define SPRD_IEN		0x0010
@@ -82,11 +84,15 @@
 /* fifo threshold register */
 #define SPRD_CTL2		0x0020
 #define THLD_TX_EMPTY	0x40
+#define THLD_TX_EMPTY_SHIFT	8
 #define THLD_RX_FULL	0x40
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
+#define SPRD_CLKD0_MASK		GENMASK(15, 0)
 #define SPRD_CLKD1		0x0028
+#define SPRD_CLKD1_MASK		GENMASK(20, 16)
+#define SPRD_CLKD1_SHIFT	16
 
 /* interrupt mask status register */
 #define SPRD_IMSR			0x002C
@@ -115,7 +121,7 @@ static inline void serial_out(struct uart_port *port, int offset, int value)
 
 static unsigned int sprd_tx_empty(struct uart_port *port)
 {
-	if (serial_in(port, SPRD_STS1) & 0xff00)
+	if (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		return 0;
 	else
 		return TIOCSER_TEMT;
@@ -213,7 +219,8 @@ static inline void sprd_rx(struct uart_port *port)
 	struct tty_port *tty = &port->state->port;
 	unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
 
-	while ((serial_in(port, SPRD_STS1) & 0x00ff) && max_count--) {
+	while ((serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK) &&
+	       max_count--) {
 		lsr = serial_in(port, SPRD_LSR);
 		ch = serial_in(port, SPRD_RXD);
 		flag = TTY_NORMAL;
@@ -303,16 +310,17 @@ static int sprd_startup(struct uart_port *port)
 	struct sprd_uart_port *sp;
 	unsigned long flags;
 
-	serial_out(port, SPRD_CTL2, ((THLD_TX_EMPTY << 8) | THLD_RX_FULL));
+	serial_out(port, SPRD_CTL2,
+		   THLD_TX_EMPTY << THLD_TX_EMPTY_SHIFT | THLD_RX_FULL);
 
 	/* clear rx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0x00ff)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK)
 		serial_in(port, SPRD_RXD);
 
 	/* clear tx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0xff00)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		cpu_relax();
 
 	/* clear interrupt */
@@ -433,10 +441,11 @@ static void sprd_set_termios(struct uart_port *port,
 	}
 
 	/* clock divider bit0~bit15 */
-	serial_out(port, SPRD_CLKD0, quot & 0xffff);
+	serial_out(port, SPRD_CLKD0, quot & SPRD_CLKD0_MASK);
 
 	/* clock divider bit16~bit20 */
-	serial_out(port, SPRD_CLKD1, (quot & 0x1f0000) >> 16);
+	serial_out(port, SPRD_CLKD1,
+		   (quot & SPRD_CLKD1_MASK) >> SPRD_CLKD1_SHIFT);
 	serial_out(port, SPRD_LCR, lcr);
 	fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
 	serial_out(port, SPRD_CTL1, fc);
@@ -510,7 +519,7 @@ static void wait_for_xmitr(struct uart_port *port)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while (status & 0xff00);
+	} while (status & SPRD_TX_FIFO_CNT_MASK);
 }
 
 static void sprd_console_putchar(struct uart_port *port, int ch)
-- 
1.9.1

