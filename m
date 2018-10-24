Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D4EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B25A2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REeRlbuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B25A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJYAGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:06:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44310 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:06:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so2592413pff.11;
        Wed, 24 Oct 2018 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Iq14mvPfPo0QV8UWdjTypdYY45acRuUN2qXbiQi55jU=;
        b=REeRlbuEJk+wP1NdxobfSnj2102uNGy6ecjH8I1un4Sgi4H94XGRp0TVFuDwrQttij
         pqkkOFz+pXkxS8VDq72XQuaopLnF4ao/uXOIkua9lyoQA1CpAMVRsSaVbU7j9RK4BBZV
         TS7dkDXvX69Dz8/EOnMxfU7zezdrrniUqBNTjR4mIeAyWojNlS2+L9rx0vOfaUTOQxEi
         5pTN++Q09taaFI3AVlARrxAQMmypACUkGaNuWNgZJ4an3Kzl4ySRT7gdGCkDNZjJ2vWd
         qHuxfo1SJnSQ77QjPV6MHrS9//Vx1TUYBDEoS239WsBlAl1vZKZepM4XHKd7G6k+qcmI
         yhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iq14mvPfPo0QV8UWdjTypdYY45acRuUN2qXbiQi55jU=;
        b=VOWmOPge9bFcb9XHRZbXpkUgaBzUJjLxdmiI2OUMzGP2elOktRe2kXm+xTXJFcHVRB
         umY5Nqs/3G2qPFQYSKJk+1oYMWvwsezg8j7B97hRKIQBd/pKgSJUDG+r44CzLeFDj0ND
         1DQPNtxGg0jr+UPUZQjlWFqXDI+Zz4mpGVssuN68ft5Qj0QMqUN99tfCK7Cm62XqOWiO
         m1Q0Qy7AqKPW39ZQW/svaRSisSJHGSQLLM2lyXzKKlGzTx4dUqrmMvuDQG/q0m5Z2pIa
         zaklQWiso2WOcT3SKKCAAHr3GtI+abRhjF8t1gaLQlNY5XCDHFjw94JNPMMIDtrZieNk
         x/uA==
X-Gm-Message-State: AGRZ1gKHhrWLc5bsGqV3alU8UjdPO9B739lKMGkXlLKax1gppqosIkP8
        S82uy8JQ6Yvuha2PHVf7E2c=
X-Google-Smtp-Source: AJdET5eFE2kB44kdLoAJRUeLeomyY8Uux7nfSo8Aor7Ik+ybNOqTolj6m16Q9noMtFwKAgD7zWZfmw==
X-Received: by 2002:a63:db04:: with SMTP id e4-v6mr3017772pgg.280.1540395464015;
        Wed, 24 Oct 2018 08:37:44 -0700 (PDT)
Received: from localhost.localdomain ([49.171.224.30])
        by smtp.gmail.com with ESMTPSA id d29-v6sm5494826pgm.56.2018.10.24.08.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 08:37:42 -0700 (PDT)
From:   Jaewon Kim <jaewon02.kim@gmail.com>
X-Google-Original-From: Jaewon Kim <jaewon02.kim@samsung.com>
To:     Mark Brown <broonie@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: fix buffer end address
Date:   Thu, 25 Oct 2018 00:37:17 +0900
Message-Id: <1540395437-6623-1-git-send-email-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer address can be NULL, if user does not want to receive TX/RX data.
In this case, driver should not set the rx/tx_end value with len.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-dw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2b..34e6fca 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -293,9 +293,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->dma_mapped = 0;
 
 	dws->tx = (void *)transfer->tx_buf;
-	dws->tx_end = dws->tx + transfer->len;
+	dws->tx_end = dws->tx;
+	if (dws->tx)
+		dws->tx_end += transfer->len;
 	dws->rx = transfer->rx_buf;
-	dws->rx_end = dws->rx + transfer->len;
+	dws->rx_end = dws->rx;
+	if (dws->rx)
+		dws->rx_end += transfer->len;
 	dws->len = transfer->len;
 
 	spi_enable_chip(dws, 0);
-- 
2.7.4

