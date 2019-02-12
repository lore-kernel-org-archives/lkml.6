Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5F4222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="uMfMxJcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfBLVk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:40:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBLVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:40:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so233383wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=l9xTOy4/qDInsSV4I504D/GrKNX7DgtF5llzBfy8xc4=;
        b=uMfMxJcbpvvhWg/8oG/9EsR2YdIg3jljZ+P4dUk4IhfDIoN+gsT4L7PGk+d1VJawYs
         q5Yw7tBmRU/BBzx1+/9t4TDfLJZ/5at0Ir4HUYZ4xdWgeCdHoTcw2DRW4lgUa2yTY/tn
         0n7oN1zc7WrdS/1qQy2kTrATHb6EnNH/tuPW5o1hZLygf748JKvk5GOZ2K1ImD0R2q/p
         mpCZ4khjfDY/kuAk4wD4VV8AfLQkywHDsjtj9ukdZluLBPFzyakavrYtLdkw8qYZLwc3
         hW9sOoVZLGWYj7fYXanjGyObVVvOlZbgR78JhIdE0SVoAS8jcJfkj5CpodiMGZbd5qGi
         Uv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=l9xTOy4/qDInsSV4I504D/GrKNX7DgtF5llzBfy8xc4=;
        b=t7mkHI7m25ZvL0i2bsgAvIeomqwIAi1/IZiHoq9r1Z6ODuQh51+9wR+zOvLXBzorsA
         +pxaOpZdPrBZVhpUjTyZdaQpPB7eWdkfvTYYysfoxdDtYOj+yRnvYUEX/iylcyFwYvSD
         iigTOIMEAZVGZ7MI5/gDxEIpSPlhoGnMFd21ZXx4Qo3TWwji5hlxeLcUVxxcE9gQtLt7
         Q/qXbgFDD/9Wx4mkOM6L91qTf3+B4RV6iRA1hCNqKo12ae60IDHt1HMONvmbbL3+ztLa
         7P9akFf+wr2jRmj6H8eie2RSxeiQMPwl9cK44l9RzsEQaPRirlgP2EhLR6p72Uxn9ZiH
         5dPg==
X-Gm-Message-State: AHQUAubWiCvEyawbKwoFducKjB4nafpq35Ct+iDNnWHfRrdmk3EJ8Uux
        xFgLXe9qjRJ3ib1L3ob4eH4NAA==
X-Google-Smtp-Source: AHgI3Ib7gbOkZXVlNsHtidDy1m6L9ZflLD5kILMyXF0ZR1hd43mdxgckG63fO69yDPOiPzPoEvRXOw==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr4328646wrx.243.1550007625861;
        Tue, 12 Feb 2019 13:40:25 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id t18sm3467122wmt.35.2019.02.12.13.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 13:40:24 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: Enable baud clock during initialisation
Date:   Tue, 12 Feb 2019 21:40:22 +0000
Message-Id: <20190212214022.9446-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos 5260, like the 5433, appears to require baud clock as
well as pclk to be running before accessing any of the registers,
otherwise an external abort is raised.

The serial driver already enables baud clock when required, but only
if it knows which clock is baud clock. On older SoCs baud clock may be
selected from a number of possible clocks so to support this the driver
only selects which clock to use for baud clock when a port is opened,
at which point the desired baud rate is known and the best clock can be
selected.

The result is that there are a number of circumstances in which
registers are accessed without first explicitly enabling baud clock:
 - while the driver is being initialised
 - the initial parts of opening a port for the first time
 - when resuming if the port hasn't been already opened

The 5433 overcomes this currently by marking the baud clock as
CLK_IGNORE_UNUSED, so the clock is always enabled, however
for the 5260 I've been trying to avoid this.

This change adds code to pick the first available clock to use
as baud clock and enables it while initialising the driver.

This code wouldn't be sufficient on a SoC which supports
multiple possible baud clock sources _and_ requires the
correct baud clock to be enabled before accessing any of the
serial port registers (in particular the register which selects
which clock to use as the baud clock).  As far as I know
such hardware doesn't exist.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/tty/serial/samsung.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 9fc3559f80d9..83fd51607741 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1694,6 +1694,42 @@ s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
 }
 #endif
 
+static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
+{
+	struct device *dev = ourport->port.dev;
+	struct s3c24xx_uart_info *info = ourport->info;
+	char clk_name[MAX_CLK_NAME_LENGTH];
+	unsigned int clk_sel;
+	struct clk *clk;
+	int clk_num;
+	int ret;
+
+	clk_sel = ourport->cfg->clk_sel ? : info->def_clk_sel;
+	for (clk_num = 0; clk_num < info->num_clks; clk_num++) {
+		if (!(clk_sel & (1 << clk_num)))
+			continue;
+
+		sprintf(clk_name, "clk_uart_baud%d", clk_num);
+		clk = clk_get(dev, clk_name);
+		if (IS_ERR(clk))
+			continue;
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			clk_put(clk);
+			continue;
+		}
+
+		ourport->baudclk = clk;
+		ourport->baudclk_rate = clk_get_rate(clk);
+		s3c24xx_serial_setsource(&ourport->port, clk_num);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /* s3c24xx_serial_init_port
  *
  * initialise a single serial port from the platform device given
@@ -1788,6 +1824,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		goto err;
 	}
 
+	ret = s3c24xx_serial_enable_baudclk(ourport);
+	if (ret)
+		pr_warn("uart: failed to enable baudclk\n");
+
 	/* Keep all interrupts masked and cleared */
 	if (s3c24xx_serial_has_interrupt_mask(port)) {
 		wr_regl(port, S3C64XX_UINTM, 0xf);
@@ -1901,6 +1941,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	 * and keeps the clock enabled in this case.
 	 */
 	clk_disable_unprepare(ourport->clk);
+	if (!IS_ERR(ourport->baudclk))
+		clk_disable_unprepare(ourport->baudclk);
 
 	ret = s3c24xx_serial_cpufreq_register(ourport);
 	if (ret < 0)
-- 
2.13.6

