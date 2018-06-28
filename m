Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5250271B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZkHOh/vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5250271B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965300AbeF1KAD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:00:03 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39748 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeF1J6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:02 -0400
Received: by mail-wr0-f180.google.com with SMTP id b8-v6so4853707wro.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PR5Ul++Wt0+yaF+GsQHK1r7rOx2lgIvzkOT73VNADj4=;
        b=ZkHOh/vBypfa49nTPbUCBe+OJteKqwtrYXl1y/9sPs7+JhLNTeUXZroKeH5RJEuWHT
         7KwtPtgdfTZ0izMSmqkHq98EUEy39ACCUTr01Koq41Kka0aGVQDXv/kvAy6i/IP/x1Xv
         lPeizbUdO0CX8AmLPFKYgPziZWcS+GnI7IV+ydXvEnOlwGTnPBpsSbOQFl4lqHuAZ9aZ
         PzhiigkuunySvC5LSs+M9ItzgRhV5cY8Wi8UYxWELKBCwSG9axQ9GFp1slSA234ONKTq
         /EsZGknvJ9Y2ftW0EgPf64Q7J6cHanL6TTxxrQHFhiv2+s1LzwQ5ZdxtWLus36LCmwMA
         sshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PR5Ul++Wt0+yaF+GsQHK1r7rOx2lgIvzkOT73VNADj4=;
        b=iaM4kVbmG9+Zr/XkZ2v+8VrGQtVoql5dGTabDJmzZlOOLx0wNFsGNf81T6/dgKuLME
         tvdCkf/bDipNa0U2jaA0XdGXDs/cx4AppDkTgbGzQrolBKiTtXc9G8zneajSiFH6whKQ
         SZPIbjbNvZthdjU77AoELUGTFi8YpnNcLg7QXyaMYhc03UWvYEgh4s9kXtUiVZ7gFpvH
         4P5ed52I9jir5XoPyZp5lFzT1WucH5sER7qs2kvXejiQC1kucdfcxIYwMg4EdcrTNX+2
         VMOFJ8cUN9ijujhMEK0S1kLrCj9HSGSzBo3Ftcb1c2TrASkRXLMIE1o1EL4mEfOFnNxf
         q9oA==
X-Gm-Message-State: APt69E1X3E0/2P9CsOKfv1xP49S/JDshMzzX7UKbT1yeWbg5spCN/Qdu
        i/TnA/CqTfqrOxacI2l7RCU8Yg==
X-Google-Smtp-Source: AAOMgpc4T9tCklcRa6yinLPwtwmMsSRzUyhdh5SESOyKHKOaXhPm+FHHOoa51rxksY/cOWHtHlHCAw==
X-Received: by 2002:adf:8286:: with SMTP id 6-v6mr8009470wrc.175.1530179881336;
        Thu, 28 Jun 2018 02:58:01 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 05/13] clk: davinci: psc-da830: add a lookup entry for aemif clock
Date:   Thu, 28 Jun 2018 11:57:40 +0200
Message-Id: <20180628095748.4462-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use the ti-aemif platform driver for da830-evm. To make it
work we need a lookup entry for the aemif clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/psc-da830.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-da830.c b/drivers/clk/davinci/psc-da830.c
index 081b039fcb02..6481337382a6 100644
--- a/drivers/clk/davinci/psc-da830.c
+++ b/drivers/clk/davinci/psc-da830.c
@@ -14,6 +14,7 @@
 
 #include "psc.h"
 
+LPSC_CLKDEV1(aemif_clkdev,	NULL,	"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,	"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd_clkdev,	NULL,	"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,	"serial8250.0");
@@ -22,7 +23,7 @@ static const struct davinci_lpsc_clk_info da830_psc0_info[] = {
 	LPSC(0,  0, tpcc,     pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(1,  0, tptc0,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(2,  0, tptc1,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(3,  0, aemif,    pll0_sysclk3, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, aemif,    pll0_sysclk3, aemif_clkdev, LPSC_ALWAYS_ENABLED),
 	LPSC(4,  0, spi0,     pll0_sysclk2, spi0_clkdev,  0),
 	LPSC(5,  0, mmcsd,    pll0_sysclk2, mmcsd_clkdev, 0),
 	LPSC(6,  0, aintc,    pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
-- 
2.17.1

