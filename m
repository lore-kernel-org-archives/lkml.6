Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F068920643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196900;
	bh=HJmHWlRT7E9JAVchLSOV4zQwGXe5Ze8O/aXsu6ih8ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhJWcGHluEVcq5VeFCM1TJM7OXRnlU8e4gkXCP5P1cAgwXohMDeKF2Qkocvw43OnD
	 r/sVTJiDn04xCMGgd1AR+rvpweVtN3cJ4+z7dV63yoGZa55/iobnZOS+VKe2lAIW0q
	 AWGRGjAsStfnJ+yn7fUHphvG+LaMQvnSg5+TDxZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbfBOCO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405297AbfBOCOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A91962229F;
        Fri, 15 Feb 2019 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196893;
        bh=HJmHWlRT7E9JAVchLSOV4zQwGXe5Ze8O/aXsu6ih8ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIbQO0uioWBOgtloG1dgv6UA55IMElzxYdvdsu1L7tv7IGpr9U/IeHBhgtGbZHHfi
         5ay7n9RfkBEAaCsfEwPO5eQQhM7cALDJgdPDa5dpgqMTGdWnXjo5uo/vMAL89aTw5H
         Y1p42Y4B9t6XUTDI85Ym1L/cTvdBGY/0dJP4hy+A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 15/27] serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
Date:   Thu, 14 Feb 2019 21:14:12 -0500
Message-Id: <20190215021424.178979-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
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
index e2ec04904f54..0cf4fe6cb4d1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1490,7 +1490,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.19.1

