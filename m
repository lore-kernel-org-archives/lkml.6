Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520848261-2-4336759125453657616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520848260; b=GFWW91e1CBlnhjDkBCAjOd3kvKpTinhlGt9yC/aSsBF8czZ
    Ga8h9zYgYyz/7ltEJHkk2v+Mw8cxkGCGkVIdOI9jEhbbsjkr3mH+bnrsdQj+gO2+
    bdZf0OcRUqiwShIKwVpKKLY1RvVd3UfGusHz0wvzChv5NWnXWUeDKwO5AMi+oS2A
    SQkO7YSHGXYMI61ZURklbhbKm3QbEQAwDAHAh/JkepPgXoWptqFx8WhgzScKFsp4
    2F9qAPHz9hSL70ldUbUJZ1sd6eLlrN3tSNfC2q2Or2SBEt8aDgtKf7cUZvLKEZyo
    /FrsB5KmyGWsZvPuUvrXO2WFqMK9mJ9eKbmDogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520848260; bh=/oO/Kt
    hhXqEZmyyUPUCvXIYli54nEjKSgFLI1DPAx74=; b=omdGrNjxy55SarTRVcN4Jg
    OADR0xAeKjwXclOMLh9xVTFs2lvWxlZvxyBIFtKveiij6u90++klL1AgytUjd8DJ
    X/hzTsF11fsBGl4xgT272YK2Od9vulO3XkVe0xPkAj9h3YKU9i558iK1P/qWFAS6
    ++fkvvUV5npaTJOozrnfbAo9k3j+tE9zBIWOui5H1CuzBGfgCA4+VltT4pYmST5A
    lTxsd5zqTOXCva14jLQDsNwcVwg7/8re2XNfJeNvHSv9meDFCKnQ/rkmcjpdzyMr
    xuQWjyXUuszRBN3DK8fzVl7IDqRmjD6cjyWxPRrNY2XZeXabNu4cm9dY20SuFwHQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCLJuq convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 12 Mar 2018 05:50:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45949 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752246AbeCLJun (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Mar 2018 05:50:43 -0400
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>,
        Yves COPPEAUX <Yves.COPPEAUX@st.com>
Subject: [PATCH v2 2/2] serial: stm32: add support for RS485 hardware control
 mode
Thread-Topic: [PATCH v2 2/2] serial: stm32: add support for RS485 hardware
 control mode
Thread-Index: AQHTued/ZrZ01GSheEqtogqHXdyPFA==
Date: Mon, 12 Mar 2018 09:50:05 +0000
Message-ID: <1520848188-7343-3-git-send-email-bich.hemon@st.com>
References: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_05:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement Driver Enable signal (DE) to activate the transmission mode
of the external transceiver.

Signed-off-by: Yves Coppeaux <yves.coppeaux@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 130 ++++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h |   3 +
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0fa735b..345fbf3 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -62,6 +62,113 @@ static void stm32_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 	writel_relaxed(val, port->membase + reg);
 }
 
+static void stm32_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
+				   u32 delay_DDE, u32 baud)
+{
+	u32 rs485_deat_dedt;
+	u32 rs485_deat_dedt_max = (USART_CR1_DEAT_MASK >> USART_CR1_DEAT_SHIFT);
+	bool over8;
+
+	*cr3 |= USART_CR3_DEM;
+	over8 = *cr1 & USART_CR1_OVER8;
+
+	if (over8)
+		rs485_deat_dedt = delay_ADE * baud * 8;
+	else
+		rs485_deat_dedt = delay_ADE * baud * 16;
+
+	rs485_deat_dedt = DIV_ROUND_CLOSEST(rs485_deat_dedt, 1000);
+	rs485_deat_dedt = rs485_deat_dedt > rs485_deat_dedt_max ?
+			  rs485_deat_dedt_max : rs485_deat_dedt;
+	rs485_deat_dedt = (rs485_deat_dedt << USART_CR1_DEAT_SHIFT) &
+			   USART_CR1_DEAT_MASK;
+	*cr1 |= rs485_deat_dedt;
+
+	if (over8)
+		rs485_deat_dedt = delay_DDE * baud * 8;
+	else
+		rs485_deat_dedt = delay_DDE * baud * 16;
+
+	rs485_deat_dedt = DIV_ROUND_CLOSEST(rs485_deat_dedt, 1000);
+	rs485_deat_dedt = rs485_deat_dedt > rs485_deat_dedt_max ?
+			  rs485_deat_dedt_max : rs485_deat_dedt;
+	rs485_deat_dedt = (rs485_deat_dedt << USART_CR1_DEDT_SHIFT) &
+			   USART_CR1_DEDT_MASK;
+	*cr1 |= rs485_deat_dedt;
+}
+
+static int stm32_config_rs485(struct uart_port *port,
+			      struct serial_rs485 *rs485conf)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	u32 usartdiv, baud, cr1, cr3;
+	bool over8;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+
+	port->rs485 = *rs485conf;
+
+	rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		cr1 = readl_relaxed(port->membase + ofs->cr1);
+		cr3 = readl_relaxed(port->membase + ofs->cr3);
+		usartdiv = readl_relaxed(port->membase + ofs->brr);
+		usartdiv = usartdiv & GENMASK(15, 0);
+		over8 = cr1 & USART_CR1_OVER8;
+
+		if (over8)
+			usartdiv = usartdiv | (usartdiv & GENMASK(4, 0))
+				   << USART_BRR_04_R_SHIFT;
+
+		baud = DIV_ROUND_CLOSEST(port->uartclk, usartdiv);
+		stm32_config_reg_rs485(&cr1, &cr3,
+				       rs485conf->delay_rts_before_send,
+				       rs485conf->delay_rts_after_send, baud);
+
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			cr3 &= ~USART_CR3_DEP;
+			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		} else {
+			cr3 |= USART_CR3_DEP;
+			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+		}
+
+		writel_relaxed(cr3, port->membase + ofs->cr3);
+		writel_relaxed(cr1, port->membase + ofs->cr1);
+	} else {
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_DEM | USART_CR3_DEP);
+		stm32_clr_bits(port, ofs->cr1,
+			       USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
+	}
+
+	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static int stm32_init_rs485(struct uart_port *port,
+			    struct platform_device *pdev)
+{
+	struct serial_rs485 *rs485conf = &port->rs485;
+
+	rs485conf->flags = 0;
+	rs485conf->delay_rts_before_send = 0;
+	rs485conf->delay_rts_after_send = 0;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	uart_get_rs485_mode(&pdev->dev, rs485conf);
+
+	return 0;
+}
+
 static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 			    bool threaded)
 {
@@ -498,6 +605,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	struct serial_rs485 *rs485conf = &port->rs485;
 	unsigned int baud;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
@@ -515,7 +623,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel_relaxed(0, port->membase + ofs->cr1);
 
 	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
-	cr1 |= BIT(cfg->uart_enable_bit);
+
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
@@ -553,9 +661,11 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	if (usartdiv < 16) {
 		oversampling = 8;
+		cr1 |= USART_CR1_OVER8;
 		stm32_set_bits(port, ofs->cr1, USART_CR1_OVER8);
 	} else {
 		oversampling = 16;
+		cr1 &= ~USART_CR1_OVER8;
 		stm32_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
 	}
 
@@ -592,10 +702,28 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (stm32_port->rx_ch)
 		cr3 |= USART_CR3_DMAR;
 
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		stm32_config_reg_rs485(&cr1, &cr3,
+				       rs485conf->delay_rts_before_send,
+				       rs485conf->delay_rts_after_send, baud);
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			cr3 &= ~USART_CR3_DEP;
+			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		} else {
+			cr3 |= USART_CR3_DEP;
+			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+		}
+
+	} else {
+		cr3 &= ~(USART_CR3_DEM | USART_CR3_DEP);
+		cr1 &= ~(USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
+	}
+
 	writel_relaxed(cr3, port->membase + ofs->cr3);
 	writel_relaxed(cr2, port->membase + ofs->cr2);
 	writel_relaxed(cr1, port->membase + ofs->cr1);
 
+	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 2294d0f..6f294e2 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -135,6 +135,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_BRR_DIV_F_MASK	GENMASK(3, 0)
 #define USART_BRR_DIV_M_MASK	GENMASK(15, 4)
 #define USART_BRR_DIV_M_SHIFT	4
+#define USART_BRR_04_R_SHIFT	1
 
 /* USART_CR1 */
 #define USART_CR1_SBK		BIT(0)
@@ -162,6 +163,8 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_M1		BIT(28)		/* F7 */
 #define USART_CR1_IE_MASK	(GENMASK(8, 4) | BIT(14) | BIT(26) | BIT(27))
 #define USART_CR1_FIFOEN	BIT(29)		/* H7 */
+#define USART_CR1_DEAT_SHIFT 21
+#define USART_CR1_DEDT_SHIFT 16
 
 /* USART_CR2 */
 #define USART_CR2_ADD_MASK	GENMASK(3, 0)	/* F4 */
-- 
1.9.1
