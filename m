Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465E222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196942;
	bh=226GcEeyS5X4PIn/uicHkd8PxTesjprMuyOqaM0X03Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zm6is7MDp4P5MbIju0MuaGrW0SHPen0pxlIKwPJzN2J0JdBAqnRYDyHRVKbKfDu7H
	 nCi1HBXnDx08FaP9YY3IzhoP13t+yaTs8S6IdUkpejvyuYI7UVw2qn4drm6Y2KKypv
	 vrAnd8NkZFACLvpLFN9fBtbuUZ4Tkn/qqI+vAc9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405864AbfBOCPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:15:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392018AbfBOCPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFFD222D0;
        Fri, 15 Feb 2019 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196934;
        bh=226GcEeyS5X4PIn/uicHkd8PxTesjprMuyOqaM0X03Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDoa+xJX3TSSPyWbgNGKqbvsxc1U6dJax/CUPUcAHSFqNUVb4ijFLPx7VIQQmXJZ6
         oOu21r2FLx3NQJSJLUrCfatOBFL+KMjoUcbm4cqNqeTT24kjfqVXcO/P0WRyfkc7+M
         fPBRy27JgfUfTGcBaoRs+9krf6sAW1loOblutDk4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 12/20] serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
Date:   Thu, 14 Feb 2019 21:15:03 -0500
Message-Id: <20190215021511.179333-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021511.179333-1-sashal@kernel.org>
References: <20190215021511.179333-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomonori Sakita <tomonori.sakita@sord.co.jp>

[ Upstream commit 815d835b7ba46685c316b000013367dacb2b461b ]

Using over-sampling ratio, lpuart can accept baud rate upto uartclk / 4.

Signed-off-by: Tomonori Sakita <tomonori.sakita@sord.co.jp>
Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 01e2274b23f2..ceb0829384df 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1405,7 +1405,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.19.1

