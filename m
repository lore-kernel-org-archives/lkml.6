Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CCC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412FA22436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAiJ76gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412FA22436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeHKEHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:07:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39920 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeHKEHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:07:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so4706163plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NMIMGPdCCPLrDPv8AS7WcTkWP7rJgACQRrnn+5ajOBs=;
        b=JAiJ76gpwdRJQsLtQnbO/EbQ4gk/wIyhMdwA9Q2tR4ClBLLP4fkXTeVs0hs++4WEoZ
         UdtxoRXBC7or16pavVmiAJBSjSYTuBnHdxNPC94dYqUtzs6jnH/EFn+7zrqv+YnOCB65
         FwqQO4uQulUD6LMQc9CSX3pja7sNuK1wsUM/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NMIMGPdCCPLrDPv8AS7WcTkWP7rJgACQRrnn+5ajOBs=;
        b=VOSVtlneXFXMYqvkctN7P6fiEN/mSATEmXPGDRf3oPNGc3/JL0sxrPffoJzEisgAGp
         y2QlzEid/hG7rhDLGTm2oIyBH0PeoKPQCt5LzRsqZ1nD3qETVXoJf7EVcweAm6RPmtai
         rbon7L2tnvPL9Ys/AtZNi5nrMW9dUekEmEDi4Le1hph3mulHY54OCfXNnJC6HPTi8jV+
         SZ4DDspiltRSCYsbfo2YFl5UgXndI6nAaDyeVziwZ0UYNJVbncfAO27mCjFc3RW7mJvy
         lbRnzUB2WQuvKd46u/P8eHSFllMbuhS48oeDo+liF4PlkL++Llp03eaCPn5nPRJKMezz
         rUnQ==
X-Gm-Message-State: AOUpUlG/rn1hFCThA7F7UZIEFeSn5ZR+1aev/OtljzM3lVw7QZoHY+G2
        49552P1lnlOzi5bjx3Pi3fwt1w==
X-Google-Smtp-Source: AA+uWPyZPZ+n/gtVENDmBmwEg8OkY0Gv6W4OG9nfbnQy+e12plHW9L6+q9h1LZ1N4qG1J2Eq3TqBig==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2-v6mr8072421plb.179.1533951321536;
        Fri, 10 Aug 2018 18:35:21 -0700 (PDT)
Received: from ubuntu.localdomain ([45.56.155.48])
        by smtp.gmail.com with ESMTPSA id d22-v6sm21722373pfk.69.2018.08.10.18.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 18:35:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] serial: sprd: Change 'int' to 'unsigned int'
Date:   Fri, 10 Aug 2018 18:34:26 -0700
Message-Id: <59172367ea674d5d4a3bd7c4d52362445174536e.1533950271.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register offset value should be 'unsigned int' type.

Moreover, prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 03b0cd4..8d5c9cd 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -109,12 +109,14 @@ struct sprd_uart_port {
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
 static int sprd_ports_num;
 
-static inline unsigned int serial_in(struct uart_port *port, int offset)
+static inline unsigned int serial_in(struct uart_port *port,
+				     unsigned int offset)
 {
 	return readl_relaxed(port->membase + offset);
 }
 
-static inline void serial_out(struct uart_port *port, int offset, int value)
+static inline void serial_out(struct uart_port *port, unsigned int offset,
+			      int value)
 {
 	writel_relaxed(value, port->membase + offset);
 }
@@ -598,8 +600,7 @@ static void sprd_putc(struct uart_port *port, int c)
 	writeb(c, port->membase + SPRD_TXD);
 }
 
-static void sprd_early_write(struct console *con, const char *s,
-				    unsigned n)
+static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
1.9.1

