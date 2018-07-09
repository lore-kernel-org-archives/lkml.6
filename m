Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53885C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59720854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1nQl/1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E59720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGIJn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:43:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34207 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeGIJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:43:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id c12-v6so13601894ljj.1;
        Mon, 09 Jul 2018 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACdevhe59HqxDEaM7CGxNaIQFaq7aeM3wEmuzAxHDTs=;
        b=T1nQl/1gaBDHAqWSDEmbsvhq1ItVAsZPJjCYhqW0JCTcSpkRO81BTs8kN3XnfLFr02
         uLfb9Tg5J0ZRtCsAD8vVHpE6McwB3crmtydYSuJo0iV5iWZmEPnKR2nE2dJm37Obo3oB
         LpNNQ7BvEGpXGWbb/sEvLfquBmZyfbHi7xFsvCxk8WPA9HB/OyiykXJGOyb5pOl9d88Y
         oJnteeWsHpL7dDmGM9Wwkf2AIsU4C852qqVGVG9htk0h5eRMWHsQmhiTMJqngm4jEf2Y
         uiaD3WXfvQKfVcUk1TZTEdlzEmHPSbB6ed1ounQrGCS+KbmiIV5araYE66/mOg2M1Dyr
         R4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ACdevhe59HqxDEaM7CGxNaIQFaq7aeM3wEmuzAxHDTs=;
        b=kS9jgoxhjlJeUyAKoP5tIB6PuqsHnvJvBMPHK/9z4ir6fmzx8RDP9M+iUyysshuFc6
         VxJaS89dyX6+SLHDfBJngmaROsxZJFfAWs20J/PDOrWS4a8iFWDHpPGlmgd2s11mSL7T
         1CPo3jHK/AiEnde4uo9IXANcGj5slZ4pvRmNHvXGJ/m+COtBdzeyxZpHz32IDzqBC3qu
         BL3mTmeM1bNRFOJIUbbXbYTBxfDrpgXjvhvYWD8ZntFirEcF9QpHAn4dxZVWtTL3BvTQ
         M4fBNfkVLdCODOHN+/vm52mOwPZtGdrrr6TqG0D7S8FC/LK0lSqPNtgM4cP1HiwqcUon
         cWuw==
X-Gm-Message-State: APt69E2nGMzRxiZ8IO7ykLNZpINrASTjbnPK/HIkY0uvuPZ/OXUlwi/E
        cpkpFuEcHI4wpfS8MB6reOa4tViGw80=
X-Google-Smtp-Source: AAOMgpf77IhVGvK4Rina4pMwzz7VUmAqskSBpSUtQQrKgHpmn9/KYsv5BhXBCm6l3uDFLxKs5XfAvg==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr11774508ljc.71.1531129397465;
        Mon, 09 Jul 2018 02:43:17 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id e20-v6sm3856684lff.41.2018.07.09.02.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:43:16 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Esben Haabendal <eha@deif.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Date:   Mon,  9 Jul 2018 11:43:03 +0200
Message-Id: <20180709094304.8814-4-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Always update the stopped state when busy status have been checked.
This is identical to what was done before, with the exception of error
handling.
Without this change, some errors cause the stopped state to be left in
incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
i2c_imx_xfer().

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d86f152176a4..1db8e6790afc 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			return -EAGAIN;
 		}
 
-		if (for_busy && (temp & I2SR_IBB))
+		if (for_busy && (temp & I2SR_IBB)) {
+			i2c_imx->stopped = 0;
 			break;
-		if (!for_busy && !(temp & I2SR_IBB))
+		}
+		if (!for_busy && !(temp & I2SR_IBB)) {
+			i2c_imx->stopped = 1;
 			break;
+		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
@@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
-	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
@@ -569,7 +572,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 
 	if (!i2c_imx->stopped) {
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	}
 
 	/* Disable I2C controller */
@@ -724,7 +726,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	} else {
 		/*
 		 * For i2c master receiver repeat restart operation like:
@@ -852,7 +853,6 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 				i2c_imx_bus_busy(i2c_imx, 0);
-				i2c_imx->stopped = 1;
 			} else {
 				/*
 				 * For i2c master receiver repeat restart operation like:
-- 
2.18.0

