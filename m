Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3859ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5751921476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAIkGTZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5751921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJSGld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:41:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49291 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbeJSGld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:41:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7DAD8C6B;
        Thu, 18 Oct 2018 18:38:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 18:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=B7Hvg/WeBOGUFbpDQmtP5yryQ5lMS
        X5pWEtqx9e+CTU=; b=oAIkGTZSpJ2vTzDRYT3DtHraYV+43cN6w+YYWOVyCgW7s
        FbiRkvZlbBSFAKHjCwirpXek3AlKcM93YSDdzcjCjQkO0jZ3PF15CBlzjP/T6r/+
        GULkcehesP9rRspFX/U8rZe6qY7OzoVkh1QSr0gfkHRVXxdnEC6fHLzHOdw14UJp
        N4KpDiBUbyZbCNJCM8tKWHjPYRzjl3m3tF94GbM2PAHD9Pv+AuIP5aQqF41jKoJL
        gd6zTxHGj/WKsaqPGtnO3pC5RgmAzW4hKqPEVYZuG6QeuqgU9Hd3j1eRyap/PZJ0
        wbPUFTtoHbyO+GqBuW7MR0gDQe/vp3WEQtHyqYJwg==
X-ME-Sender: <xms:XAvJW9gJ03L1FRAtHXr6X-zG0hiu5PQlH6rcBIX2IVssZwzk46MM_g>
X-ME-Proxy: <xmx:XQvJW32wfOPIEKBg-yMizLOvt239Y7cipU0oqTvATP4PRwSwf-AOdA>
    <xmx:XQvJW42_LSQQrRim2O_L-OcihusAckg6TXYh7oGpaTlYaauO7PGm5A>
    <xmx:XQvJW0zY6_C_Fz88JeBk5ZcMERJMpL9kTii6_Cx-QOJTzOCDWqgWvA>
    <xmx:XQvJW0URzsNkrCIsk_SvMpgb1n_q8r5Xjiuy3_RAcW-TM147kMp4og>
    <xmx:XQvJWxpOTJ3A6vMjzx07G9lBONZd2G_yobawptL-nfaL5drgMkty4g>
    <xmx:XQvJWy0-2NuXVqKV5gJU-LieV02V5xY1arqGzhmNFCsglDFHbMo-LA>
Received: from localhost (124-169-31-211.dyn.iinet.net.au [124.169.31.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 450D7E4074;
        Thu, 18 Oct 2018 18:38:20 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] tty: Fix kernel-doc variable typos
Date:   Fri, 19 Oct 2018 09:37:04 +1100
Message-Id: <20181018223707.9891-5-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018223707.9891-1-tobin@kernel.org>
References: <20181018223707.9891-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few typos in the kernel-doc variables [descriptions].  Fix
these by using the correct variable name and adding a description.

Fix kernel-doc variable typos.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 drivers/tty/serial/men_z135_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index ef89534dd760..784756139935 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -173,7 +173,7 @@ static void men_z135_reg_clr(struct men_z135_port *uart,
 
 /**
  * men_z135_handle_modem_status() - Handle change of modem status
- * @port: The UART port
+ * @uart: The UART port
  *
  * Handle change of modem status register. This is done by reading the "delta"
  * versions of DCD (Data Carrier Detect) and CTS (Clear To Send).
@@ -597,7 +597,7 @@ static void men_z135_stop_rx(struct uart_port *port)
 
 /**
  * men_z135_enable_ms() - Enable Modem Status
- * port:
+ * @port: The UART port
  *
  * Enable Modem Status IRQ.
  */
-- 
2.17.1

