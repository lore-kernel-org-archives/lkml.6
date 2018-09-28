Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9944216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kw0tkYeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9944216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeI1I2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:28:01 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:52955 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbeI1I1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:27:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8S25FOh028340;
        Fri, 28 Sep 2018 11:05:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8S25FOh028340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538100317;
        bh=qrMl6WEtjLnR57tbyGnjTHcU0qOzQwOlqOxyoz9Z1G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw0tkYeKZoLQhNC4UPqrgHnswyDQ41sQrfkYanwisfO2q5GXgHb5K9RgKh7AGr9WK
         kKRxTJZJXdrzR4S3MlzO7IeNNnrhhpF/tcCDNs+PcSyv+N98rH+UskFZ0HjXsFu+YO
         YOrsUHlJM563wgDMa81wdQdsQ5jR48RFVceZDK9vK6QH6NcUf28Cy0iIZXUC9/sP/S
         MThGsWVwG47gdIfUVKEegIUKHUXEpOwMqwoCr65KBOGZAiyIw3eriyax5doNRAJtXW
         EHMga9BgaB3U0Jpk53O5BoGOgRmh4FeGTcwC9fxStz/Ou+n5qs+xq79HU7yZxBl9Ug
         xs2facKDqC8Yg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] serial: 8250_uniphier: remove unused "fifo-size" property
Date:   Fri, 28 Sep 2018 11:05:07 +0900
Message-Id: <1538100309-24323-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO size of the UART devices is 64 on almost all UniPhier SoCs
with the exception Pro4TV SoC (MN2WS0235), which used 128 FIFO size.
However, Pro4TV SoC was never upstreamed, and out of production.

So, this property has never been used in a useful way.
Let's remove old unused code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2:
  - Fix the product code in git-log: MN2WS0230 -> MN2WS0235

 Documentation/devicetree/bindings/serial/uniphier-uart.txt |  4 ----
 drivers/tty/serial/8250/8250_uniphier.c                    | 10 +---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
index 0b3892a..811c479 100644
--- a/Documentation/devicetree/bindings/serial/uniphier-uart.txt
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -6,9 +6,6 @@ Required properties:
 - interrupts: a single interrupt specifier.
 - clocks: phandle to the input clock.
 
-Optional properties:
-- fifo-size: the RX/TX FIFO size.  Defaults to 64 if not specified.
-
 Example:
 	aliases {
 		serial0 = &serial0;
@@ -19,5 +16,4 @@ Example:
 		reg = <0x54006800 0x40>;
 		interrupts = <0 33 4>;
 		clocks = <&uart_clk>;
-		fifo-size = <64>;
 	};
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 28d88ccf..d292654 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -12,9 +12,6 @@
 
 #include "8250.h"
 
-/* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
-#define UNIPHIER_UART_DEFAULT_FIFO_SIZE	64
-
 /*
  * This hardware is similar to 8250, but its register map is a bit different:
  *   - MMIO32 (regshift = 2)
@@ -185,12 +182,6 @@ static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
 
 	port->uartclk = clk_get_rate(priv->clk);
 
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port->fifosize = prop;
-	else
-		port->fifosize = UNIPHIER_UART_DEFAULT_FIFO_SIZE;
-
 	return 0;
 }
 
@@ -241,6 +232,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
+	up.port.fifosize = 64;
 	up.port.regshift = UNIPHIER_UART_REGSHIFT;
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.capabilities = UART_CAP_FIFO;
-- 
2.7.4

