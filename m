Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38491C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23B120866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxA+ioG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeL1Ide (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:33:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44693 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbeL1Idd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:33:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so9808941pgr.11;
        Fri, 28 Dec 2018 00:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jbdjvXet2QTTMjWProjmiOYAfiU9h68Jk+iO6bYtLew=;
        b=nxA+ioG30egVKDRSoxaAWMImQpkc1BbJ/Kix7u/uxF/gyFqiRQEhchjkRYodXu0CPD
         WZk7Ar/xX0Y2ODD95ZJayd+wmzDHLWtt6VDsYyPHo27I+HPiXXvbOcNRtOOR2Y9NBDjY
         d+l5cscHK9WlcSOG9g6rs24gQSq0VQzQYT40xNDYC/eabUV0B3fURPOUH0edey11mH/e
         SZ5H8+NJwt8TKcCWCR7vXXN0lm0VEEFw0nTJOcOZYJPMRngOZGN3q9gOXnzNK9UQ7R+k
         3bUbPOsik78BTuduEcpNytAHPmP78DQPNIFFXVTPD2wVtCf3K9AxfiliFc/ygx1Z1yeU
         DkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jbdjvXet2QTTMjWProjmiOYAfiU9h68Jk+iO6bYtLew=;
        b=UQrlQU5/BGnIIpd2b7ebDXhlYCCcl1UqRbCD0+b4ve/OJCDTITazqf6+wzCqHo1+Rr
         XNYSNK/47OLBbRT0Ee3RFimVttcu6TYlFuAJhR/C16stBF+EN3ga/SGA1jq01O0R191n
         p0cLA5h4wwDtgnunCDfuBGudiHUwFjYLhZv43EZknl17hJTHmemWLeW3rq6HkIjYNbfT
         ggPXwmp/ycKHAnC1rBn4BtzFMcasyQpeII2eTI2G5Ua0bfFLBrMYH2eua7kAkX7voWZl
         +vfkojqNlfUf1vUhgoymTB64Tx/0DMJJdu2qvMMO5RMn7BP6nwNu1L5ocIUA5kamS25I
         +mgQ==
X-Gm-Message-State: AJcUukc0uDu4SQNIgnCyyXU+qrYpwokfU3VbYH6Ay2mFffiLpfPxbi6J
        fZSJg6VeweU5ggvLzvr9r/g=
X-Google-Smtp-Source: ALg8bN7Ptw3VFHqzMB0Da7w88nZjB6k7XOUIXX7Z+5qNO/JMdkEax7KcMzJT5lHPowolp9h1uIawRg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr26196337pgv.438.1545986012950;
        Fri, 28 Dec 2018 00:33:32 -0800 (PST)
Received: from VTX-VICTOR-WU.vivotek.tw (220-133-8-147.HINET-IP.hinet.net. [220.133.8.147])
        by smtp.gmail.com with ESMTPSA id p6sm54806961pfn.53.2018.12.28.00.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 00:33:32 -0800 (PST)
From:   shaftarger <sholchen@gmail.com>
X-Google-Original-From: shaftarger <shol@livemail.tw>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shaftarger <shol@livemail.tw>
Subject: [PATCH] spi: dw: fix potential variable assignment error
Date:   Fri, 28 Dec 2018 16:33:12 +0800
Message-Id: <20181228083312.14928-1-shol@livemail.tw>
X-Mailer: git-send-email 2.12.2.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi::mode is defined by framework for several SPI capabilities,
such as polarity, phase, bit-endian, wire number. Directly use this
variable for setting controller's polarity and phase causes other
bit in register being set. Since SPI framework has its definition,
SPI_CPOL and SPI_CPHA offset may be changed by framwork change.
Instead of just mask off the relevant bits,
fetch required bit in spi::mode and set to register.

Signed-off-by: shaftarger <shol@livemail.tw>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2bdb8b9..1c4cb6e8c5a1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -317,7 +317,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
-		| (spi->mode << SPI_MODE_OFFSET)
+		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.12.2.windows.2

