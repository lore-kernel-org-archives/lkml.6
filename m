Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA7271BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TdeBg8V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AA7271BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965317AbeF1KAg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:00:36 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:47013 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935097AbeF1J6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:00 -0400
Received: by mail-wr0-f177.google.com with SMTP id t6-v6so4838355wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijqHp8iXB+Gl1XJvevzR732NTL+CZ+HTvorUSfSqTvU=;
        b=TdeBg8V5VLferpIzg1sJp4DTMve03x5rs15LiDXCzg+wK2wuOT4KuQ5k0VSPJGN4TX
         f2pTPWnFMlYBlUj8GlQTGEcPeqtyPttzeMA1AekyKprnNtD8Jl+imSs0T0IhilETijOY
         M8715wUUK0p1QoYzFBCdBoDngd9l+Uwui9KEpvaAmzCQdwl/pDSxgJt9ueAYlnthqMP9
         NCzZl42HbYEl3fPz8nKE5zONfc0W6UqlkyHd+5uUlKgv/5EzznTMMV4icNhXeLdY3XTs
         C2DZo8N8dbFTtJ2PeMAtgswqbFLVHxgwLNaMDh5Ae/cml9DHpnTDPRJNF6VbTpjHuFAG
         bafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijqHp8iXB+Gl1XJvevzR732NTL+CZ+HTvorUSfSqTvU=;
        b=ufMvo3U+vV8JgklDl1sGbv/33Yq7hNZ6tuf5LCe5HdcwOYnBPfpG4u43gRgpflpPio
         yRkjZCqJfBpTln/1Go1yAUWyh1AKihxoOiK39cjH4UwBpCPgMAvzQ71DwLXuMULAGmFh
         PFmrjEfd94jp3Kh/xBGaevhA91NLJLObZxY1/CGi0Coobq/GbPb+GfxaOyE8gkxhMvDX
         b/2OaXDZws+fn6hOGCREFXM4OaJFpUHnpHQg6/rwQzuVuzcUxZ+ONeoak/Sp69VyqZfk
         MfZ38sowkF6+l+xXGGutLk+zIqbSJu8fPzeOV/YYWDUJBxyrh/flE+SgLQjd0/s9MuIK
         6EJA==
X-Gm-Message-State: APt69E1ojbLs++GpO9m2EFCrMjiuY+PqghjXzOb2AENnvmLE0GMODQL8
        S4czY6cs0oc4AaBbarxjp8IAtA==
X-Google-Smtp-Source: AAOMgpdgTKcSIwv2zj7/hDiycJasNnz5qdw2yEdq2cTED/r2CuAoYDmutqZbkEQ1cEKRqrA2Q75VEQ==
X-Received: by 2002:adf:bbc9:: with SMTP id z9-v6mr7779395wrg.183.1530179879254;
        Thu, 28 Jun 2018 02:57:59 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:57:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 03/13] clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
Date:   Thu, 28 Jun 2018 11:57:38 +0200
Message-Id: <20180628095748.4462-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/psc-dm644x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
index fc0230e3a3d6..0cea6e0bd5f0 100644
--- a/drivers/clk/davinci/psc-dm644x.c
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -21,7 +21,8 @@ LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
 					"fck",		"davinci_mdio.0");
 LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
 LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
+					NULL,		"ti-aemif");
 LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
 LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
 LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-- 
2.17.1

