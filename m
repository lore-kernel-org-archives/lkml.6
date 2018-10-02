Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8565C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8788C20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLDbEj7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8788C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeJBLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 07:23:56 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33909 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeJBLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 07:23:56 -0400
Received: by mail-it1-f195.google.com with SMTP id l127-v6so6140952ith.1;
        Mon, 01 Oct 2018 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DH054wl72zM1HNiTxLQ+ihPqQrph5m/fo/tSkCUcvPw=;
        b=sLDbEj7IvO4JVkx5nvtxoYVgCxKK5KflrRDC2B82zYUAZ9JAHqkIXOkwR6C41bOAmR
         xtcA/xvQ0daaA3EK8JJy/zGcfVnc5tOC0gNgCKK4mqnXV9dnt5XZg4/2xmgcvdeAWaUS
         pJKpnXJlyHPoFD03wM/oLaQqGN7vmvPq6vm41VjBPjCSRb2A/DSgaejm/fGgL6v9TDpD
         vbte+7OekLKdqBc0Go28OO2Up3k9uCVsKbFwLzhhD/t4AIPaV7F0gOidAcJ/EWSu17nD
         uBCJzCcOLfim1wCIR/8xLmCHGsxS+wnVTBe5O1Mhwh/EXduvG73PZNlEBxmfhysz1kXE
         y7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DH054wl72zM1HNiTxLQ+ihPqQrph5m/fo/tSkCUcvPw=;
        b=FlX6dW6suEAzmnddL2DOzFQv2SBR3m6USwGIT9eS1STxWkj8VYLMFQjZMGqh/fRkK1
         zS6r1LOHgrJBGUR/j2ap8hT/LeE3+Jm5f3QUe7a81dO/NrdzF2cwa8j7c2/nVy1tttlW
         uX2D2O75Us0HGKINfuvAY7d6xbVrmked4gLTOb282qUDvXm+sscyAYlEoCG/0JbLSnKE
         xCum6BKCUziuvXXCUBnfeMDDFul/d7LnwA6uPScAPuued+U0YQTfVBdNXNRMMs/mEB/N
         xmjTknqT2hnMGl9FD1tVnYUG0w6OJlJdHAiTrzRvxyxebESf8WvHjvtVrVypt6iHCW6V
         N2iw==
X-Gm-Message-State: ABuFfoj1NgSDzJIHIjHczDFxdsofOKYQwyYJkFewluzG9Bif7gJQqa14
        cI9caUo8xEVxXGPrcH6CKXc=
X-Google-Smtp-Source: ACcGV62j1/7yFwDmCS7adVAUVt6dRUcAH1IdQ/rYu13IZcivpgDFyWjFgKkpEFA5ZVlhoZhHOmq6Ow==
X-Received: by 2002:a63:7c5e:: with SMTP id l30-v6mr12895651pgn.45.1538455361355;
        Mon, 01 Oct 2018 21:42:41 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x13-v6sm17098316pgl.87.2018.10.01.21.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 21:42:40 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] Revert "serial: 8250_dw: Fix runtime PM handling"
Date:   Mon,  1 Oct 2018 21:42:37 -0700
Message-Id: <1538455357-16344-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d76c74387e1c978b6c5524a146ab0f3f72206f98.

While commit d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling")
fixes runtime PM handling when using kgdb, it introduces a traceback for
everyone else.

BUG: sleeping function called from invalid context at
	/mnt/host/source/src/third_party/kernel/next/drivers/base/power/runtime.c:1034
in_atomic(): 1, irqs_disabled(): 1, pid: 1, name: swapper/0
7 locks held by swapper/0/1:
 #0: 000000005ec5bc72 (&dev->mutex){....}, at: __driver_attach+0xb5/0x12b
 #1: 000000005d5fa9e5 (&dev->mutex){....}, at: __device_attach+0x3e/0x15b
 #2: 0000000047e93286 (serial_mutex){+.+.}, at: serial8250_register_8250_port+0x51/0x8bb
 #3: 000000003b328f07 (port_mutex){+.+.}, at: uart_add_one_port+0xab/0x8b0
 #4: 00000000fa313d4d (&port->mutex){+.+.}, at: uart_add_one_port+0xcc/0x8b0
 #5: 00000000090983ca (console_lock){+.+.}, at: vprintk_emit+0xdb/0x217
 #6: 00000000c743e583 (console_owner){-...}, at: console_unlock+0x211/0x60f
irq event stamp: 735222
__down_trylock_console_sem+0x4a/0x84
console_unlock+0x338/0x60f
__do_softirq+0x4a4/0x50d
irq_exit+0x64/0xe2
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5 #6
Hardware name: Google Caroline/Caroline, BIOS Google_Caroline.7820.286.0 03/15/2017
Call Trace:
 dump_stack+0x7d/0xbd
 ___might_sleep+0x238/0x259
 __pm_runtime_resume+0x4e/0xa4
 ? serial8250_rpm_get+0x2e/0x44
 serial8250_console_write+0x44/0x301
 ? lock_acquire+0x1b8/0x1fa
 console_unlock+0x577/0x60f
 vprintk_emit+0x1f0/0x217
 printk+0x52/0x6e
 register_console+0x43b/0x524
 uart_add_one_port+0x672/0x8b0
 ? set_io_from_upio+0x150/0x162
 serial8250_register_8250_port+0x825/0x8bb
 dw8250_probe+0x80c/0x8b0
 ? dw8250_serial_inq+0x8e/0x8e
 ? dw8250_check_lcr+0x108/0x108
 ? dw8250_runtime_resume+0x5b/0x5b
 ? dw8250_serial_outq+0xa1/0xa1
 ? dw8250_remove+0x115/0x115
 platform_drv_probe+0x76/0xc5
 really_probe+0x1f1/0x3ee
 ? driver_allows_async_probing+0x5d/0x5d
 driver_probe_device+0xd6/0x112
 ? driver_allows_async_probing+0x5d/0x5d
 bus_for_each_drv+0xbe/0xe5
 __device_attach+0xdd/0x15b
 bus_probe_device+0x5a/0x10b
 device_add+0x501/0x894
 ? _raw_write_unlock+0x27/0x3a
 platform_device_add+0x224/0x2b7
 mfd_add_device+0x718/0x75b
 ? __kmalloc+0x144/0x16a
 ? mfd_add_devices+0x38/0xdb
 mfd_add_devices+0x9b/0xdb
 intel_lpss_probe+0x7d4/0x8ee
 intel_lpss_pci_probe+0xac/0xd4
 pci_device_probe+0x101/0x18e
...

Revert the offending patch until a more comprehensive solution
is available.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Fixes: d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fa8dcb470640..d31b975dd3fd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -630,10 +630,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
-#ifdef CONFIG_PM
-	uart.capabilities |= UART_CAP_RPM;
-#endif
-
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
-- 
2.7.4

