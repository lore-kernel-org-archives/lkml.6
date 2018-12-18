Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BBC2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Sx4TZAPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeLRMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:18:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:18:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so2295669wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SkscCEtDXpliSXHUz/cuWzh5NuHyq42x9x7Eg9phJA0=;
        b=Sx4TZAPnVYELEi/GgiW2vm6HLxP6N3CesPKNUruVEtOrQdV3j+sJUglwhjkcqZlcLt
         FM3CCZsB4QyVZ8LX+cpq/z+1XCkXMNEbX6yGwR2HeBOMote03LYZtCRB1i/0AvSwQhcS
         HvM/qslHbK26aBNdqbHvbzKK5fbJSlX4Q90VHlnKpj6fc9T6TfsQKQtPYk/+TeU/WrK3
         5DICy+eqFo2fqf8a5JUIlCJcoTENy6ff747mQ2VNZOnIMd+Xi7ErwXXatX/Fy6pe7M8V
         yhHEd36TYjFL6Okln5g99tFj9Q9JzXVRw6bjxe6XOp0eVEiXvZw0GB74vuPE7BcFp02M
         pCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SkscCEtDXpliSXHUz/cuWzh5NuHyq42x9x7Eg9phJA0=;
        b=lLj/fdIeqQWzJYPqCtGf6kIe6E6E6F3lZV2T16d6F/Bg6lWnYf4Y1R+myM7d8scgry
         wrtdBXZVp5ARmkEbPFfQb3zUnM5XeG6GkK3urw1apTpjM7uULMQQ9YIcM0ivvXgsT4Xd
         eXkF0PvnuM0ZWCuPAUK3QtR4bR8AoiYVuF2XzLe7mvXII0ljdVhIpHgoDnPN5LobG0PC
         HEcp1tLxeBPaUPLEH8f3VU9iMWRTLB3V1EFdv4wGEVmvP54n9xSYywRE19Nip21Tm/io
         Slda8xU38LFj8oLQ68+PhgGmxJjr1OAS3akHFAH/aN0eKO8k+6knc7cQpoiFZknjpv8V
         Tc9g==
X-Gm-Message-State: AA+aEWazMTitC4SXT/VM4Th9dPLtRoR3RjpIQq89QvobsPDvjO9UCaMo
        uizcJEWjEyKGTIXf3V8u5RRg+2/KRQ7M8A==
X-Google-Smtp-Source: AFSGD/WQEIrEbaUo7eI1G29c2X+n1KtgyLsk4tqicmOf5dgboH1XY/qgCxqhmzmGHXqNTPd5hn7WcA==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr3047275wmd.51.1545135528993;
        Tue, 18 Dec 2018 04:18:48 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s66sm2092390wmf.34.2018.12.18.04.18.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 04:18:48 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] serial: uartps: Add the device_init_wakeup
Date:   Tue, 18 Dec 2018 13:18:39 +0100
Message-Id: <439951b77da9a1d4cc0551af41c158ae5908b840.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Initialise the device wakeup.

The device_init_wakeup is needed for the wakeup to work by default.
Uart can be configured as the primary wakeup source so it is good to
enable wakeup by default.

The same functionality is enabled also by 8250_omap, atmel_serial,
omap-serial and stm32-usart.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Change description based on request from Greg

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 379242b96790..0140644391df 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1624,6 +1624,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	device_init_wakeup(port->dev, true);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/*
@@ -1702,6 +1703,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	if (console_port == port)
-- 
1.9.1

