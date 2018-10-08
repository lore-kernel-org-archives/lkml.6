Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8729C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2C2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="H7ObzLCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC2C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHT2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:28:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33687 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:28:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so20615968wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vVuFMlihYr6DWRxThKteT20nApP3XsywkcmTmPCEflI=;
        b=H7ObzLCy/ZCfPbs/Dk0v2jk4CHN2RHqQlm+4dnnrbeQV7d57VesngOki8gCqJiALMr
         qlgwMp3hXOZogHWNdNfz2VDm50yzyh0UuukyqBxYKBo33szufcDIp+MKjcAAC6Ii52U+
         syeKzeOKYAz+tny/IG+swVjq3te5EzbgLDYKm2vXjfpNAOKhNBTSavcG3yFGr2Xq9o6L
         JO6ij9zOKEjSH4DXgyP+ATzV2EJyizf38NhsotUZal7a0hJS1FKhBki2D4IwbKAo0pjF
         d2ecfvz0aO/Z78/fEloRzZibzpaGFP5CQbIqp6occrycH4sB2/YGG1BWMqry3Yq1lHmT
         KZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vVuFMlihYr6DWRxThKteT20nApP3XsywkcmTmPCEflI=;
        b=M7fQ4K9s3qexaaAfTBl0pLWWYwCBSDL3cc8LYVBb2Dm0k16TTBeMt0noW3IHQW6Y4M
         C8c/2Qu3UO3urcbDuortJN2LCX1IrpGVOLM9fZ4HGFmM88DzyUlW1okWKSVvIygkTsim
         VxVYoC0++ZLlDOFv/O1o/eh9hbFzALnq9wo/WWJ8IuyD3S6cYZtLqizM63Nz+bdZcl+o
         +0icfolhYeOdJQFO2VmaeMsP2LFDyRaEDyV897rCTaDbadycm6NveVfkgtasXyShmKb7
         FDD4fZnMA13z/P66ZtZf45qLFpYEDyp3uzLTpD7c71iiywQEe2m3fcgW5sBsaZMx7Aut
         k6EQ==
X-Gm-Message-State: ABuFfoicMoNzcmO54n9evkD9/xbD22kN0v6GN1H6cYNmG/fbWVSGSKmo
        RH3KuaCmcl3VEEASyHQ1unUznI8RcPkOIQ==
X-Google-Smtp-Source: ACcGV62N2F+bZgV1J24sHxF5eD6E4Yigry8pvIcnaCNd6hMOcbV8woAkGYLSAXivFBDfKu+sVh9E/w==
X-Received: by 2002:adf:f5c6:: with SMTP id k6-v6mr16339704wrp.59.1539001040786;
        Mon, 08 Oct 2018 05:17:20 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n68-v6sm7494634wmn.5.2018.10.08.05.17.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 05:17:20 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES
Date:   Mon,  8 Oct 2018 14:17:19 +0200
Message-Id: <01aec25ae2cee7857d92140e98fde1da28393937.1539001037.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aliases >= MAX_UART_INSTANCES is no problem to find out and use but in
error path is necessary skip clearing bits in bitmap to ensure that only
bits in allocated bitmap are handled and nothing beyond that.
Without this patch when for example serial90 alias is used then in error
patch bit 90 is clear in 32bit wide bitmap.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on tty-next tree.

---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e82d1d56399f..29a18103182d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1673,7 +1673,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
+	if (cdns_uart_data->id < MAX_UART_INSTANCES)
+		clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1698,7 +1699,8 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
+	if (cdns_uart_data->id < MAX_UART_INSTANCES)
+		clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
1.9.1

