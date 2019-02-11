Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387AC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A01C2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896907;
	bh=xom11xpwxKrdYw40XGVEPJXMLg9TjV0H5F2+FHbkzxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYiWt3fazdV02pYeoSMvMqR7bSZ41bFku5WPg/8RlV9J/GP1YMHHxehAT1wR+qWbU
	 QLLVvbKRDeBtX0Ie1j3ph5FneO+k9hWKoMPkpqOS+6RoAb6FFh7qRNdy7cbK7j2och
	 FpozCgHKd2SuMQlENI/rGcXii1DjwLAEMpmtw0Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfBKOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbfBKOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371002229E;
        Mon, 11 Feb 2019 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896902;
        bh=xom11xpwxKrdYw40XGVEPJXMLg9TjV0H5F2+FHbkzxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilz7o2UJ/nyf9IEkIs33OxnzUvsY4hDfl99Y6ds+H2P4GGzp3t8TASCXT2c2S01d6
         C2OI5dg2I0gGgnAKgRxKvFVLIhLjSuHLGeiVI7JquZoJtZo92lcGdxqK9UAREPuU6t
         Ul2C576pBcwkVuHEMiyLHlTC7Y6/y/cgbKPE1Ioc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 018/205] serial: fsl_lpuart: clear parity enable bit when disable parity
Date:   Mon, 11 Feb 2019 15:16:56 +0100
Message-Id: <20190211141828.345526949@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 397bd9211fe014b347ca8f95a8f4e1017bac1aeb ]

Current driver only enable parity enable bit and never clear it
when user set the termios. The fix clear the parity enable bit when
PARENB flag is not set in termios->c_cflag.

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andy Duan <fugang.duan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fd64ac2c1a74..716c33b2a11c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1482,6 +1482,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				cr1 &= ~UARTCR1_PT;
 		}
+	} else {
+		cr1 &= ~UARTCR1_PE;
 	}
 
 	/* ask the core to calculate the divisor */
@@ -1694,6 +1696,8 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				ctrl &= ~UARTCTRL_PT;
 		}
+	} else {
+		ctrl &= ~UARTCTRL_PE;
 	}
 
 	/* ask the core to calculate the divisor */
-- 
2.19.1



