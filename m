Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDDAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt7lbEA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A95121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeK1DFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:05:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeK1DFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:05:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id j207so15323437wmj.1;
        Tue, 27 Nov 2018 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4NbTJWphuMJdohuzHDZOP0oH/Mu3HlA/pO53KFZRbc=;
        b=Nt7lbEA5p85p/aXpYA5/1MwnCfjsGhSFfpejmsYFLmJ6RBk50MfYqKJZ7e+nuQuQVK
         ceFq1Ct+Nssocpo5mVQZt2vG7pEeEf2cni33sHUATatmdM41SQxgKXiW9ofnh3dSWau8
         WAGaYNa1aOsmIsF4EIS8+R+FQD47tvnu4ffI16F00eFFwykqtWWZAkPcjbWyHjUnuWL5
         BmsMdCqpFaGaUrEsTu8jZUHbgGgC7HlAwWWQcXJ7Fcc+o2dYadHJJroqaBaFzpoHabiT
         Qi3wYbgyspzl1TDvBaQCT65T47gW1e1F2gnlD3GyQR9coG+q/zYPYg0tY5lU+acrp7ji
         viWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4NbTJWphuMJdohuzHDZOP0oH/Mu3HlA/pO53KFZRbc=;
        b=ABE549JrUIf01v8lvfjjYI/9hJFGx/UoLlWcJumcns75dgOjxD434RDfTvx4HRjnLJ
         YdvWF+xBN/qYDPz3CNWF3FO0V6CFb1sBJS7eKQQGwhBrsrUEMMamu8GlpiB+H+Cc3f3L
         eaWJQ4loGD4IrJ8a3fPyOv3mODpzwv6pOIq60AxCmh2SXJXqZkhinW8vTWC9BSRwOUkO
         7JCabnVodtsQWvzz0MvnDI7XPnBSIZrxblIZpw9RGdnKsXIrD5OZu/eKeQc5d+uI+o2h
         b/M+agdq0dJ6Pd1E8fmpRpWNvWmrqQijVyMCdaxCKtdzgGWok/LmxEloyHZpAti9g62I
         2hwA==
X-Gm-Message-State: AA+aEWYth3wBYsT+gamC+L5XCYKt4Ia4NmWzj1uuy/cgecvo3obaF6NV
        W/HZ5bpfbQ98pEOI8nj7Qjs=
X-Google-Smtp-Source: AFSGD/U0W8fE/GZhYduX6YrvQviSf81n/KELl2VQZZ4L9rhjaPx9b4znlCIus7tCa6zUz/gK13W8jw==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr2667096wmc.34.1543334842142;
        Tue, 27 Nov 2018 08:07:22 -0800 (PST)
Received: from localhost ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id b18sm3014766wrw.83.2018.11.27.08.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:07:21 -0800 (PST)
From:   Richard Genoud <richard.genoud@gmail.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mario Forner <m.forner@be4energy.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: at_hdmac: fix module unloading
Date:   Tue, 27 Nov 2018 17:06:35 +0100
Message-Id: <20181127160635.11836-2-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_controller_free() was not called on module onloading.
This lead to a soft lockup:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Modules linked in: at_hdmac [last unloaded: at_hdmac]
when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/dma/at_hdmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 1b7f0ca0d5cd..01d936c9fe89 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2006,6 +2006,8 @@ static int at_dma_remove(struct platform_device *pdev)
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->memset_pool);
