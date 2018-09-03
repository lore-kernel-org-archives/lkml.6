Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A6C20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ri1Dz7m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A6C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeICRbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeICRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so610720wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wTOILdE9nfHQCYMiecBgy4uyHPVuopq9iik1VZDg6mA=;
        b=ri1Dz7m59TtHxVJMvmQAzX93b2miaZDK+w8fHLMXjXDn0Hik99zFO+Rt1N2CrTGna6
         /865xQZZ9F09gkGUlQcpU/UcvAJHLfFq1TlhOV3PyIcRDK6cfwn/QCMlMjva0+k+/9nu
         ZAYKWb4tGwymAuU+o5uljVd7gR26kM8ByJ3/o4hQTh15MfiKnl+ndP6vQoanLuuyAUvF
         GNKhqvZ2ZdkJ+MfZfFGF22KJp/MG5ExU7hnWSnTzFjHdzPvXOq8DMU7mBC8NBp4tMdvo
         LjFzdSfndYz/tDYqHLIZp7mV0MyHihfGMqx1S2zclXyIZIiJO70kH5EZzBGU//+dWTi8
         vzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=wTOILdE9nfHQCYMiecBgy4uyHPVuopq9iik1VZDg6mA=;
        b=shpyUxOfVQBaPnO4KfwqglRQfeAvf/CN3L0Nttee3/W2vydPislAttqgkkMuliVBhB
         uiZ97C7Gz8uQ4u7YI4YB+q4stGdiqJKN3bihgj8w2RQYZSQnUU3ZyURFgA+4hh+pdfC1
         1LzfJDEz6UNjCVKtsO4x5geOrTdMpqrcDSLjfvEiZdWFIkKHwvnUoCkJ41AkRsSdX+2x
         VP2bi8bCdFJXHbQI23gG/FRLZz0AHe7PGjphcM2W7biHy1e17+J0k+1zHvwNbis1ELn3
         AZkLkJiWB7H4YgkII9La9oC7kzN9fuzIRH2loNfSnIfYQ2rQMsxaIR5tta3wHifSlegE
         1njA==
X-Gm-Message-State: APzg51BMFLEsRBIT7kqDpzSHmEZ1FaVBrCl8ai/tGJDkJL5p9AxyXjLZ
        BP6LLDvc0rhJDD7bULqJ8sHjAwlryyOJZg==
X-Google-Smtp-Source: ANB0VdZZ1kcMQunUqBPmqO9KVMDszD/YeV47Dm/+4CSPjDx1Dh7tfIV5ksMIyifhfaG7vmxE9lt0Dg==
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr20443936wrc.125.1535980263184;
        Mon, 03 Sep 2018 06:11:03 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f132-v6sm11314920wme.24.2018.09.03.06.11.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:02 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 02/10] serial: uartps: Do not initialize field to zero again
Date:   Mon,  3 Sep 2018 15:10:50 +0200
Message-Id: <bf45db771f1f4b5bf9a006c3a1d8016bebc53df1.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing zero and NULLs to already initialized fields is not needed.
Remove this additional writes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index dd905c981f67..9a08542cec47 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1502,15 +1502,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
 	port->type	= PORT_UNKNOWN;
 	port->iotype	= UPIO_MEM32;
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
 	port->line	= id;
-	port->dev	= NULL;
 
 	/*
 	 * Register the port.
-- 
1.9.1

