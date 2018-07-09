Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCAFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DCE20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY6DjtOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DCE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeGIJnO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:43:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34201 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbeGIJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:43:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id c12-v6so13601664ljj.1;
        Mon, 09 Jul 2018 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85O4D3Im7ZGdIr6UyDQTi5ey/7Ka1XJWMpnpdcRleeQ=;
        b=cY6DjtOo43BxOe6+0TtGpzDe9c9duXo70ONW9OGgfDGJWfNpH0iYBhsKEv1fAIdkzL
         7nskHhRiJiwcrajlQ6Ryd7vFHMKjoQYV1b/t+hSvl6QCiHLnS1jMmET9tbAHN96C9ISW
         S3CzVch52IRUs++qXcBtuNZNgt7i1AaDzhroBjhqrY2jyiCn+ysPu0K3EsBu9fhDfKj6
         pLIJEsTxod/pzxaxqrFzbF6n1L1JWrljfrwvCiLcPlYNLsf5klAAz30hkzdW0gjQHvV9
         gQWP1Zbw6Mw8DEfO8+okeDXGtk0YxEaAzmV5pyPRR73iOLS0+b+MXseOdMaB5d2lWIeF
         6ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=85O4D3Im7ZGdIr6UyDQTi5ey/7Ka1XJWMpnpdcRleeQ=;
        b=JFeAI6NuhWBkjFls8I0FkASKntO9BqQrvyBa7K5AgYYuErIINpR10kY3k6XebdCjHo
         +qOZaf9kmm222StPo3O6AKgI7N67DhrnKzk7cNCfJJoQVONoYI8Y1KIh9IUUFYyUzRhO
         eoKLswHHCgdJJgzvL17WAIEzFCXhB+7ww0ipi9QGVAZKIPvF5jfLtnWM6JRthuPbzmhY
         NhMyGv07vofLmn5YfbLubvrijL683SRWih7Nun/SDBeE60qiKsPPyaAQohpBGq/y4+AA
         y+uZBoIfKmZQQU9L+qjAokjs90MMUnPgpt8Cu1aFSqr43sN9JupZke0TR4WDPNX2upGw
         FI7A==
X-Gm-Message-State: APt69E167x1B8e3fI2IAT6zZeNFbvLRzOqMYv3Y5gkyqzLhqwd8lfZOh
        FHxjnfLiFLEHEWj3HFTtzYeTtIDlj6M=
X-Google-Smtp-Source: AAOMgpd0oQmLUjA6AkoOnZZ8XdAk5GtjlEZpOJDq+VxPrjL8stc8CnaZfsdyPWVPw++LxgF1OTs87g==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr12189910ljd.104.1531129390376;
        Mon, 09 Jul 2018 02:43:10 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id k65-v6sm839279lje.3.2018.07.09.02.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:43:09 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Esben Haabendal <eha@deif.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] i2c: imx: Fix reinit_completion() use
Date:   Mon,  9 Jul 2018 11:43:01 +0200
Message-Id: <20180709094304.8814-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Make sure to call reinit_completion() before dma is started to avoid race
condition where reinit_completion() is called after complete() and before
wait_for_completion_timeout().

Signed-off-by: Esben Haabendal <eha@deif.com>
Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0207e194f84b..39cfd98c7b23 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -368,6 +368,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 		goto err_desc;
 	}
 
+	reinit_completion(&dma->cmd_complete);
 	txdesc->callback = i2c_imx_dma_callback;
 	txdesc->callback_param = i2c_imx;
 	if (dma_submit_error(dmaengine_submit(txdesc))) {
@@ -622,7 +623,6 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * The first byte must be transmitted by the CPU.
 	 */
 	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
@@ -681,7 +681,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
-- 
2.18.0

