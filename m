Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF63C5ACCE
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218BC21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ucg4eXWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218BC21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJQHO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:14:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47623 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQHOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:14:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4051022075;
        Tue, 16 Oct 2018 19:22:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Oct 2018 19:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=ql0Ah+TZCdzTMcj7O9bwrTPiDqGl9
        4a7onJeqGv0s8c=; b=Ucg4eXWIKVneU1ZQ5eTwYWJaP1qWett40vq83SUT9gDDs
        heI0eTSUFEVLDZz1j+JrYvYpegn1CNEDhFW3Fn74VDIs2o0A45he419jvDSwGEB1
        o74j4SJoKLUgFYiPy8FFffdcUbQZtHJ4mEMcc+gcR2GKSyg94Mcfu/JMcFL1BgYD
        kXt8sTodTTMm0+dKvA/cp/NkwkhEhEm6yYIU/iagUp0yxWyoLCaDocVQp3ocDUGY
        YFBpzu0s0BTvhQQxIL+RtFW/MkCYIddvPio7XoO1bcJ1Yzv76cHrSJFqxvsA2fcd
        4rOCw5Nzn9BrHHiIevLK8q/38B41GiBDRu0zgvDXw==
X-ME-Sender: <xms:oXLGWx42K-DovwWJYtB5BsD0VOaBxPVOHqCH__9RSOg96h6XJJywGw>
X-ME-Proxy: <xmx:oXLGW95GHrTkPLB2B1Rr2A-c4a-1idAURKgZeUTB3wQdHVWfy4Simg>
    <xmx:oXLGW3BwY7I-dFxe24WwLCBNJ55hETE76cM5VdoGfe7Zm4pWq1vd5w>
    <xmx:oXLGW6Z34q1a6urQlYC8M45Sh1KRUorBnb_EADag-SMYb2Ah_8fkHg>
    <xmx:oXLGWzcyiiQu8mwMPNX0HAoZHe95duibIaPVLTC3gf6rGGkAjbPsUg>
    <xmx:oXLGW97bd8VdYJLgtq3YMiI9b_1SVeDBLkTBeHZ5PoB1nFAOKaRcHw>
    <xmx:oXLGW-xCUXmEWLeVuqetW2rTKgEF6n_uR2AshrloHf2h_IK4hKwo-Q>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D6F5E4074;
        Tue, 16 Oct 2018 19:22:08 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 4/7] tty: Fix kernel-doc variable typos
Date:   Wed, 17 Oct 2018 10:21:27 +1100
Message-Id: <20181016232130.728-5-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
References: <20181016232130.728-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <me@tobin.cc>

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

