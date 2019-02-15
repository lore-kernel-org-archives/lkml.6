Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B243D222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196616;
	bh=e/h8C4M3EzC/+wvYTgQB3vp9NjAx6Ohx09kOImO2ogc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xl+EzLEzKz8BL1e48YkhGCWeyJihGjbnpKzECwTp58aEU4UUemj3jxN4+3IvaQ3jY
	 U1hgBrdxjTaKRv9GESNJJdSQlYfXcX2Zpgt6Y2k8aCvcvFUNUyZlJ0CPudqdADuvkI
	 6lQf8/vq287+/JEq6wvanUerUkUmC09cREZOS3d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbfBOCKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbfBOCKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260DD222D4;
        Fri, 15 Feb 2019 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196611;
        bh=e/h8C4M3EzC/+wvYTgQB3vp9NjAx6Ohx09kOImO2ogc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaTe6fJRHHLNxwIGSR4R83WgsS5cQh/Uz9kEWJlo30r61efrwG8BzjWOF60+vQdjr
         1IdXgrko9sGWY6RPoGQBkwE6iDvcDggrl5+MmyzsFBAHYyCGnaXfgwhPTC6g+/Lmu4
         a3+GD5kw1yPVGOriWvkWeQUO0rWQmNNU8G6Qo/qY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 44/77] tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled
Date:   Thu, 14 Feb 2019 21:08:22 -0500
Message-Id: <20190215020855.176727-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit e8a6ca808c5ed1e2b43ab25f1f2cbd43a7574f73 ]

The geni set/get_mctrl() functions currently do nothing unless
hardware flow control is enabled. Remove this arbitrary limitation.

Suggested-by: Johan Hovold <johan@kernel.org>
Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..76e0ad7251e1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -221,7 +221,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
 	u32 geni_ios;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport)) {
+	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
 		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
@@ -237,7 +237,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 {
 	u32 uart_manual_rfr = 0;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport))
+	if (uart_console(uport))
 		return;
 
 	if (!(mctrl & TIOCM_RTS))
-- 
2.19.1

