Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9E42054F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtzxpmca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9E42054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLGD2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:28:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeLGD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:28:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so1062055pgc.12;
        Thu, 06 Dec 2018 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oSW7qduER+Yo1hj2yqyJG7kVBaZZV80hCAN4pyjfqm4=;
        b=GtzxpmcaFOuNVVJrnSZMgq1bpWefO9MyEzUdWOEVan8RRUbAJSZf6RlXs6zY5evAPD
         4D/HBbJGvQnWmYyTKFTwadZr+9hV/BNEKXU9dVZVmf5Ne5nh1kMYR05VVAxQBjKKmOM6
         Jhrpygq/1rb6RyykO+DlJfMN7E8ToD9N8Av9yEDSwhNN+wcaOi93jco6SnKt3KmwL53E
         a/nSjz1uOnadWdHKwWNWS2HAMvWj8K3cXImfqrzTIsqdH0oDc1uSGsrdPVgGRUwMnhen
         4kC/y3k2/3kok7kLJWZHe2X3l8YuOZSxxeRlXh3hf7qq9oJkvi5DFg5WQ2jKcH73Iv6U
         kuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oSW7qduER+Yo1hj2yqyJG7kVBaZZV80hCAN4pyjfqm4=;
        b=AsAYJNy23GQHeLAcpzb+cJ0RfJRr20QOO7wu+nKMAh8kAbfZHAQz8Cz61C3FDeqOB/
         ROppdBluDFjSHZfJPG8fPWkjKBEbmAmjvdBe7nYZBj5J/tHT3JjiIP+y0Nh/E6dwWeyY
         N7iBBUUfScQVqO5q7rSay1OH307KYLuLKASh8Rd/YtskwndfpZzQpByf04PvwnHDBov/
         V0ZyFnq3G7UTz/q3WQy4bvKfboC20orXgtKPLRa18Zg2nRtsPWlehjGKyZkgEcKS8sQj
         8cWCxTcTtT7bGRVme/tjqKzr0qR/G78WHw0E1mlrbE1Xym7TnYRJ+zIFn+QsqXcHF/pV
         5mYA==
X-Gm-Message-State: AA+aEWYCkv5/edntJKnCrDRhc9IdOAx7yzfact8Rl9IzgZtI0+J6bls2
        o7HIFOZ3zNCfV0pJUOxOIqpeObYFRQI=
X-Google-Smtp-Source: AFSGD/W7UXHENyzsPwaqw3UtG0I4DMTT1RpcBjD6IKwn3jx5cz+La7FucY9b/tWxKyciEPXqtPCjaw==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr620743pfn.205.1544153326577;
        Thu, 06 Dec 2018 19:28:46 -0800 (PST)
Received: from VTX-VICTOR-WU.vivotek.tw (220-133-8-147.HINET-IP.hinet.net. [220.133.8.147])
        by smtp.gmail.com with ESMTPSA id q7sm2191386pgp.40.2018.12.06.19.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 19:28:45 -0800 (PST)
From:   shaftarger <sholchen@gmail.com>
X-Google-Original-From: shaftarger <shol@livemail.tw>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaftarger <shol@livemail.tw>
Subject: [PATCH] spi: dw: fix potential variable assignment error
Date:   Fri,  7 Dec 2018 11:28:32 +0800
Message-Id: <20181207032832.3156-1-shol@livemail.tw>
X-Mailer: git-send-email 2.12.2.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi::mode is defined by framework for several SPI capabilities,
such as polarity, phase, bit-endian, wire number. Directly use this
variable for setting controller's polarity and phase causes other
bit in register being set. Since SPI framework has its definition,
fetch required bit in spi::mode and set to register.
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2bdb8b9..c1b0ae5698ba 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -317,7 +317,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
-		| (spi->mode << SPI_MODE_OFFSET)
+		| ((((spi->mode & SPI_CPOL)?1:0) << SPI_SCOL_OFFSET) |
+			(((spi->mode & SPI_CPHA)?1:0) << SPI_SCPH_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.12.2.windows.2

