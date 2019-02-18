Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D555B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498940;
	bh=kFNYqA1bBDRvIIKNcqgZ/cgX3NxNdCMgCPm83Gid1Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJnsQo1QWPcSoCjuFZ1Q1B1NvcD3/TOglo5Z7mmSX91vf3qhTVs8kXMhXTWDWSxFr
	 F1UrYsyQNDfElbkokhWzgBMjxypHzht8WMH2GL1bBeTvu999FQ8Kn2jFVjKbvYmqPg
	 DN2EslYNOiJtt/XPCgcNRVN8gSaOkTxq5mNY/2tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391052AbfBROI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390468AbfBROIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F04204FD;
        Mon, 18 Feb 2019 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498934;
        bh=kFNYqA1bBDRvIIKNcqgZ/cgX3NxNdCMgCPm83Gid1Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plLruX3M9Kie//W6y9PLOIsjeTk2i90DZypJ9d0INLWzyITbXuGjoR7buuh04zoDb
         NpDYDhwELjWq12bPsjLo2vpv2q+hfnSqyijEE1pCgKYb4wR+TgkVVfSdgWJhhxgupB
         xIUQ4SEG3XcxlAyN0ffHGCAD8VyHDSddOy1yIbpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 006/108] serial: fsl_lpuart: clear parity enable bit when disable parity
Date:   Mon, 18 Feb 2019 14:43:02 +0100
Message-Id: <20190218133519.809487299@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 92b7a5bf7c4d..839e65da4d3f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1284,6 +1284,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				cr1 &= ~UARTCR1_PT;
 		}
+	} else {
+		cr1 &= ~UARTCR1_PE;
 	}
 
 	/* ask the core to calculate the divisor */
@@ -1419,6 +1421,8 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			else
 				ctrl &= ~UARTCTRL_PT;
 		}
+	} else {
+		ctrl &= ~UARTCTRL_PE;
 	}
 
 	/* ask the core to calculate the divisor */
-- 
2.19.1



