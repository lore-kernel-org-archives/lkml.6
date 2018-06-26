Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B554FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1F267B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cTFc/E1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB1F267B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934238AbeFZJ2R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:28:17 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35904 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933814AbeFZJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id u18-v6so1018334wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ghUy5TlXuvvU+RkeY4Dj9uZWBV9etfW6ILIQGD+aumE=;
        b=cTFc/E1a4WmlsChlhIbmCbEElH8qPz4sAlUt0DEPlaY/FJEsU1wAlIP6HjCdIuorUv
         iHQm4XBSoVPw39ZcNY/o6ksbCS1n3JfsXMa4ZqbP0wbMy1svnc+ix98ShLv05soaKLxu
         d7rBXMUjmP7dlgkdl2Bk3VrIFF3DSQUq3JLff9+/L3nCURvIL2aS6HI5pZ6yE6tQnR9F
         wIr7OH24FUlFcO9SgnqEMKJbPXQqBhaFdwzRIX46D1vCe4kG5CL4n3dTrSmRE/QmVvZl
         4xGfiakz9dWJNxFPJxIMwpouoqTCaCcq67YHlfa/U8d4GXmCvG4chWCljZq+XQKzI5G3
         D2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ghUy5TlXuvvU+RkeY4Dj9uZWBV9etfW6ILIQGD+aumE=;
        b=T5PTvXvSEA2LyLGdfr6xVaFSR/cr74Q4GvSl5FyNLsduZUEFePg5+iAtJ8kxinOwiz
         1PLlOvZZ5r2NeMhXtV+VhlZe5sQIupT73u9OQqwy1iNGftOx2dWetVSRNSTsvGqpqbHM
         YrlINGDTdG1+qmVnv+2lrhz5HDoF1D+Y9rX1PSvd++sB/jZhzz9/VIhZtUaSKVMMrSXI
         xJTW98V3iU9bKsq734zI8T/DGTDR1lOJRajhvhyCCkgPGJDj0ZYVTm79ZjblqGFv05Bz
         Cb2z7fe5K3kqsri/c0SVQjK3Cw2hMhSLCOKVANAgwCvnYW9eXgoXDrJ478Zfra4YF10G
         B15A==
X-Gm-Message-State: APt69E2NDDkdMRmRAdgck9/Jf8Rjjs1l4saX4O719WQtB7Fec68QGLuY
        iiR9DmgX9FgXmgDXlmbsWw0fDn+r1JU=
X-Google-Smtp-Source: AAOMgpdTFn4U5axrrUFQAswH5LfTCY5UYUCZwQA2wvG47rVUUAb7GLRPaj6SaVPvPgOhymLPo57z9g==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr909015wmd.37.1530005146371;
        Tue, 26 Jun 2018 02:25:46 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
Date:   Tue, 26 Jun 2018 11:25:28 +0200
Message-Id: <20180626092537.6737-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-dm646x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
index c3f82ed70a80..20012dc7471a 100644
--- a/drivers/clk/davinci/psc-dm646x.c
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -18,7 +18,8 @@
 LPSC_CLKDEV1(ide_clkdev,	NULL,		"palm_bk3710");
 LPSC_CLKDEV2(emac_clkdev,	NULL,		"davinci_emac.1",
 				"fck",		"davinci_mdio.0");
-LPSC_CLKDEV1(aemif_clkdev,	"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,	"aemif",	NULL,
+				NULL,		"ti-aemif");
 LPSC_CLKDEV1(mcasp0_clkdev,	NULL,		"davinci-mcasp.0");
 LPSC_CLKDEV1(mcasp1_clkdev,	NULL,		"davinci-mcasp.1");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1

