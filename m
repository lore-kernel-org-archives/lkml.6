Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD349C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA12719F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iNjjtkwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFA12719F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935201AbeF1J6B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:58:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54260 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeF1J56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:57:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so2794649wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l7oO174CH9dyNVcYLBoLq+bVs3JdeUpSqH3ZvJoY2m4=;
        b=iNjjtkwfcrmmFsup8iFqVgyu5YGZoZLnR7LSY/efz3eaHvPATUfrTlU+CxR4ydE8oO
         91oLStxbFSRpeNI6wOv1sBvUe7E4p8AFIV+nB5+KLryS3FwWa305HuvfxbPDH4TEWbIx
         S60rjD8yk5UXajPL/AC92FMtajyWYaJXaoFbB52/EdSDJuisG57m8E7AQo3zs4bpoNYQ
         5y5cBCnQq3xpT5Cb/BT3z8x+sVjUXBNkHNIA17uxmTnL8ZQ9FK8NSLSdir13bojjxRpX
         w1M/uWTKeTsGX5A3oaE8k2E2XEp+qrOw64pdDXdknIDiG8p5Ns55r/oeCS5NK11jv12p
         4OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l7oO174CH9dyNVcYLBoLq+bVs3JdeUpSqH3ZvJoY2m4=;
        b=SWx6VRWsdEU7SeSeLS6o62JLNv/T0jV2Ohli2emds1+cHjWgXRkT4I872rgVteOGQd
         Mp4EOOw0dsW5K7RE+jTxo9WHuNsvx6reEXyUI8n4bVUEwo7IEY4u9218pgNqlECW7Y1t
         ZRadONA35yNXJEHGyT4xB8qHxG3teDn/9JJGpK0MOwjK+L3ASisvWbXA+FzjUSarq9jZ
         BXnqOj3foTIHawZAWAOB0KgHhLG6EL7vhkU9d1RJ+2YbDxEHU40N0E4oSYyjHfoCh7ta
         0x080j/0Od8eOTYgq7u+jHQekX+m/Nsxg7FbZJ7IcuUTveaDItPFfCoigT3MqzPsb5EG
         Mj2A==
X-Gm-Message-State: APt69E3S+5zfjXFRpVk+iyXfyFuXi1cu+H9r/qyOOSwagPtZ0V3Ug+f2
        m4zThFWhZ5l1udr+UvBvEvNmQQ==
X-Google-Smtp-Source: AAOMgpcZWFlq/62DDglb8Mqq/KdpdVFCq7sUHy6ZeS24pv/247gH64t9dT3NuzuTx9d697RKsf5iAg==
X-Received: by 2002:a1c:90c2:: with SMTP id s185-v6mr4609822wmd.5.1530179877143;
        Thu, 28 Jun 2018 02:57:57 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:57:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 01/13] clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
Date:   Thu, 28 Jun 2018 11:57:36 +0200
Message-Id: <20180628095748.4462-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit a8e3923ab571 ("mtd: rawnand: davinci: don't acquire and
enable clock") we no longer acquire the aemif clock from the davinci
nand driver - we only do it from the ti-aemif driver. Remove the nand
entry from the psc lookup table.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/psc-da850.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index d196dcbed560..5a18bca464cd 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -16,8 +16,7 @@
 
 #include "psc.h"
 
-LPSC_CLKDEV2(emifa_clkdev,	NULL,		"ti-aemif",
-				"aemif",	"davinci_nand.0");
+LPSC_CLKDEV1(emifa_clkdev,	NULL,		"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,		"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd0_clkdev,	NULL,		"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1

