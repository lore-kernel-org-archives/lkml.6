Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE455C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3820835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAUp9Mt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB3820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJJQXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41659 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJJQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so3360620lfi.8;
        Wed, 10 Oct 2018 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TA2hMcCsbnh1Gd9P/xX1f3LeZx7iF3o9MbmxqKWAyAk=;
        b=GAUp9Mt9TeIwF5R3rhnYGJUHDiV1Qz/t25mpiYrjA7PbOKKMSHW7EKhtkKOpWCUhAf
         PgXHrmRcHzz/LkNWkS0Zkh7Ip7iuvohCFqt6tYxsCXYLJWI2G+hSjPwuaoYZAAuLc8d8
         2bzul8GgZQpSk99e0+gRxhVqAs7Gkm8N3ogKc7HjOhktzC37/It4mMM109Vkeo4f5rG3
         cTrhEBW6eEf+rPrhaJRpd+YyvvKyVkCpvBipg5TlFCICCqGH1ZoAUqnfQeEOAzEUtXqv
         6tSMzRpzKvIuxBH2LPEAhxPEHQQitXWv6dMYnlC3031bXaoRn35v6V3TwLKH1W9zJ9dh
         wyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TA2hMcCsbnh1Gd9P/xX1f3LeZx7iF3o9MbmxqKWAyAk=;
        b=HMTBQ7GJvEGFFttIA9x9tHDOUc3o6A6MJvkKE7KJL/V744LmDwYrFKxzkUMUmXR9be
         /VIvdiGUPWyiqS/I40yD8QYSv0bmSSVoSNZUTUhsdI5+Hj//L9U9DvQUQ62AEtINhjNd
         RYqczrFq5kliUtgf657JAKcbPRtmsF1h53xrYmnDTlHR7onP/N/U531oBl+oWe/8avvt
         LwYmS82u6iwyJwTedRV0GMia2l16DpLpkvajbHqh76IJz7YXze74KLqlFY98zp5utyny
         YJEhhQ6RURQ2WdLbJkKIi2K1CdSzZku0ju/L11Wik+oLfLqxNEcdYM2HQPaCNZ0FSh0s
         EVAw==
X-Gm-Message-State: ABuFfojaEoSCvvw3a3pgCzURWdPvnqAkPnonC49ZCWMsbPR9csgyt+lg
        lxsvPCSqNDZdzFgWgka2Fn4=
X-Google-Smtp-Source: ACcGV60ge1yDJBedeGV3xpRir0WlnArmlOXWPzpPwkVMFxN7nAgLmV0NdMd+s4oszuybspptIpmt7A==
X-Received: by 2002:a19:5205:: with SMTP id m5-v6mr17373907lfb.68.1539162114515;
        Wed, 10 Oct 2018 02:01:54 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:53 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 5/7] spi: rockchip: mark use_dma as bool
Date:   Wed, 10 Oct 2018 11:00:36 +0200
Message-Id: <20181010090038.20834-6-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver data has a u32 field use_dma which is
only ever used as a boolean, so change its type
to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 85358f96f78f..1d8bf45304a5 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -202,7 +202,7 @@ struct rockchip_spi {
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
-	u32 use_dma;
+	bool use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
@@ -631,9 +631,9 @@ static int rockchip_spi_transfer_one(
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = 1;
+		rs->use_dma = true;
 	else
-		rs->use_dma = 0;
+		rs->use_dma = false;
 
 	rockchip_spi_config(rs);
 
-- 
2.19.1

