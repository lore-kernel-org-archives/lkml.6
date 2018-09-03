Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4120C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DC20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OYfUNFl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeICRbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52446 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeICRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id y139-v6so1129998wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZuPRWG0B4enQGXI2G2oBqHrb6zTd1Azps2shrb64GUU=;
        b=OYfUNFl57bmxosC7xk8Xsi/uLPSBLOLQHsj9lV3/vd1PlgzHq8xf5QHUir3BD7vs5j
         inDbwhjSAcuQTpWec61031DJl6KF7RLxKtzI6F3nRp233fIP0gOV8kkmCYlKZUNql9C8
         +0NPKeg5OeTJPEiSViWy0QdK56ryGQOBQiABf5uo8rn7wPSr7xn1AfSYwDJy/nQGP4Cy
         96VzOkBRfChYGe1QCK9zgr04OBRd9dBxrTp1P35STqGHW+rSiogqFp4b0ykycNI1cN8B
         0H4lJ+wD5Ze5p9tRe4YgMBW1zOiW3n84NdMLCmt4EpYmq72VlaThXBD4C/7IugUp3RnC
         VbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=ZuPRWG0B4enQGXI2G2oBqHrb6zTd1Azps2shrb64GUU=;
        b=bqCey0g3jyv6LgJkJB/SXDEswqG4Uvk25qN7xRS6rfp3Qqmn80IQeDSb29zekBge+G
         aqOQJdfpTX7GN2rnTIAGmJHBtVqeHaxJg+O57idRUrMvSsSXK2A9JNGKfcELMsHyiSjW
         qalnyw6tU2aSY06vRIZzx1UUplylMDb5zBlRueks+bxIozdXELdUoTopbLIAEx4Mhc0j
         Qm4EVHOuLMIyL1Y2ouHRfqR+dwQdWmLwLhXPq30zNInDoVZxWemmGBAxNHPOv9eJRH4q
         VRT3g1x6uTRqUn/ms7FrF1xWqPlvJ0OrN2f9lQq6xZAJfePpXV1Qx1UVxQa0a8wDQUz2
         2vRw==
X-Gm-Message-State: APzg51BSnysty6JqlQHHmRrb6y2XCf52aWhCh/yl8J1sK6bMUNLt0t43
        rkMeIGE7wvkcywezIZstY23D90xp8Ms0Iw==
X-Google-Smtp-Source: ANB0VdYWVBM+6Rh5h7FfDwqpBa0deOAjJ5zDnMFRER5EMLg6sEW0AKzPI9llykI4wfAhSa3J9ThFHA==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr5423460wmg.149.1535980261568;
        Mon, 03 Sep 2018 06:11:01 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a11-v6sm15592098wrr.81.2018.09.03.06.11.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:01 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 01/10] serial: uartps: console_setup() can't be placed to init section
Date:   Mon,  3 Sep 2018 15:10:49 +0200
Message-Id: <08b079a26d5b5393ed58f68e55acbb1f9afe1821.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When console device is rebinded, console_setup() is called again.
But marking it as __init means that function will be clear after boot is
complete. If console device is binded again console_setup() is not found
and error "Unable to handle kernel paging request at virtual address"
is reported.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch found by testing

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e5d90611c03f..dd905c981f67 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1216,7 +1216,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  *
  * Return: 0 on success, negative errno otherwise.
  */
-static int __init cdns_uart_console_setup(struct console *co, char *options)
+static int cdns_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = console_port;
 
-- 
1.9.1

