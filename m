Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D58C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9F2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="qfeP7iav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfAYLEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:04:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39818 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYLEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:04:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so8011981ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFwQ9Uc+RMzfvTqW37RxvKqIi88RNAVDwfx5KC3LSgM=;
        b=qfeP7iavRdrNcEkyIJLuP4y4KzLNqoei+b57Mv9h0lHfkiabTbksm50huLWE0fRKpg
         Qm+ntNxS3Gb35ZK5mZ1SZbTtqzG8zeyHhJS2zFJkDNBfYgnhVR6pJb41RR8nveURoFvm
         3VOusGgV7WnFBLi8WsTY+b8IRlfjWZA9kb3xta8pe9hOolvT2cQqCfSYt0UvRC49OaDu
         bNya8FQTAijLiYcVDGQi5hjZ9Mi2lZeBvr8cUfAQwFQmlmlx7PmmHBMS6hozH7iXw04q
         jsaehd8lfvZgPKoxmYXlDvO2FEOaK/efj1mosMUCrOu+FTNA1dJhIObxO7ffpbgooPi7
         7CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFwQ9Uc+RMzfvTqW37RxvKqIi88RNAVDwfx5KC3LSgM=;
        b=njhqw4BYYkQPvNvymdVX/iUxOi2okNMhCcw9FZQzFScp6zuoJOmFlTOFzGrxidFa1G
         xyRRSXYgRpaoMGB+o5dmcXUOnn9nK/rH7qwUxH4TQca1or2jNerj0fA/K6yvuRc74v/I
         sA0azIfXugFlTJVF9n6r4dkf7eI1m9ceRXxhFiswID1V6q0c2lZFfbyTyjutAhTEsZj+
         zvoH8ahx0iVYkje0K4cyVx/L37v8/NBzgpzG0hKIWe5wPZg4Rcd4RSa7nkXPOlgUYZqL
         RWSXovGdTQbRbljAYJMEC29x1DWT1SP6cPkHQsT+mzCH1vf8/7Bl4BwX93mmDKtCLhUW
         CgVw==
X-Gm-Message-State: AJcUukfR5dRaFy+LZvb4xWd86h/Fjf91L6TztZEkbTNQ0B4kieWYVO5t
        mV92QVvQb7DI7YKwe7RYT9uqysROrkk=
X-Google-Smtp-Source: ALg8bN40OSYemWclv0yn1OYMp7N0caZNyVQJ/a5+6M/j1jv8c3PpO7MkRjSRKUF2/0ARMBNrjVr8sA==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr8720356ljl.3.1548414252331;
        Fri, 25 Jan 2019 03:04:12 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id 11sm1426088lfq.89.2019.01.25.03.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:04:11 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 1/1] spi-nor: s25fl512s supports region locking
Date:   Fri, 25 Jan 2019 12:04:08 +0100
Message-Id: <20190125110408.8941-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the BP0-2 bits and the TBPROT bit are supported on this chip.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Marek Vasut <marek.vasut@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Brian Norris <computersforpeace@gmail.com>
CC: Boris Brezillon <bbrezillon@kernel.org>
CC: Richard Weinberger <richard@nod.at>
CC: linux-mtd@lists.infradead.org
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c80225029165..b819b12fafcf 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1880,7 +1880,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, USE_CLSR) },
 	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | USE_CLSR) },
 	{ "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
 	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
 	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },
-- 
2.19.1

