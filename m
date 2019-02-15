Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7828320840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197932;
	bh=fN2XnFGzLwwH3E2ehx6lmj7EfzP0FMi4IijoSizqSHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Al97XCgzzcz6U93ppLN2sgHu/wOdLcWxcM2i/vV2JBJcrXBg5tdCI96B4UoG47Kwp
	 GoNP8sjySYgmsSedH/4WQI1jXL/swSQ/Evfu5QewSvq6OoG9n2l5XMWSyg7Z6f9mSU
	 e6swqfAgqcT2z8DvUgql1ZRQelfho38LBJrDttxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfBOCcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404248AbfBOCMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86D621934;
        Fri, 15 Feb 2019 02:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196742;
        bh=fN2XnFGzLwwH3E2ehx6lmj7EfzP0FMi4IijoSizqSHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIn+XxKUu9VJ532gbrHVTPdiKUp2H00WGX7tYt2zCoLtO/kmVslF8OG8CAc1FD07S
         /HqQ7yEG8zeGjdCzJBZ9xNECpqBLhSopN48Q7gwW90u035Mhd7GrmJ6n4cvKXDRVTU
         H4FURZQL6l7bYIcA8Dd67hDMF0p9eE21TQF7Uv7A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/65] serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
Date:   Thu, 14 Feb 2019 21:10:53 -0500
Message-Id: <20190215021121.177674-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index 3f8d1274fc85..61003eedd7cd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1691,7 +1691,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.19.1

