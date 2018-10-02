Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA3BC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4952082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WuiqFg03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4952082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeJBWc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:32:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55213 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeJBWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:32:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so2767107wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKrNC4Opv9WiNj2et19+W9CzZT/iZpbvH+NmxrSDXkM=;
        b=WuiqFg03Ddtct5CI2ZImWCR/UZxjKxaxy1SVF7sRueWIWqZv8jsqNawETIKS5UdF/a
         rU0qvHx2MifnymphIMo8gzjzXul91Pe8R2GUZx8rXD4EPMtRkP3PCTvjiELuXmnXHi21
         fljvKMhKYuN9j9rdbn8PMqrXfvBRDjX2vX3FYMAzLhzRIJAe0ys74i724dxYC6gQJeK2
         QBhPPA2JatI4UdhFgZ/QYhNAvZCG3uThmG7pmU8OJkSQrQ71a0NpTRN//EtTzCTz6R01
         YeIo2uyRRZsp/lx0uDoeRBw7LMFSmsPpyMNCpj5LHFo0ILGUUnhaxyIFFZ0ecvwCD2T4
         77VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKrNC4Opv9WiNj2et19+W9CzZT/iZpbvH+NmxrSDXkM=;
        b=tL0dTJevejmB384lPMxn2nBx3O62YCDJ+1PQGV2ITqrLkjOwPXz32dcKtAJXLQ8LXu
         aMZnKOrfnNSLjDNlztTgYKis5z8dy9EpItNCxxdIcDP8lej0AsBl2BznTMxZryOXzdyd
         KoHdRzPSXxE/dfUUps4pL+XB8/8riHw9oPy8IcwmBaVbSyhN6vepu8rPiyazn+/al7Dd
         0MN41UP8yHoASuV1NzhkuygD3nSyLBzWik7OggKCZoqI0H+5mLMaJ4qBpKm4o6wyXedz
         NzG6UxTyLfQyONlIv/v7zC3D2GQPjyPYzjxMQ0obgMWW5kJDlMxbW9X1Er0+LQ5PKYmj
         C8mA==
X-Gm-Message-State: ABuFfoijDVASDDGNAsQ5Hb+1/I00asicKdC25kqWJr5M9l68UcyDeGI0
        bCJU0sRHXjINh6cc2rwWhbF9rNYsKeQ=
X-Google-Smtp-Source: ACcGV624d9rrM4AWdXxyMmXXCypT5cMlSHuc4wYTEHZP3EVChmtcTYKstlAgd/htlYXuiC3rXWXVMg==
X-Received: by 2002:a1c:9f41:: with SMTP id i62-v6mr2414870wme.53.1538495303226;
        Tue, 02 Oct 2018 08:48:23 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id i131-v6sm11520779wmg.26.2018.10.02.08.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:48:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH] clk: davinci: kill davinci_clk_reset_assert/deassert()
Date:   Tue,  2 Oct 2018 17:48:17 +0200
Message-Id: <20181002154817.10347-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This code is no longer used. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Hi Stephen, Mike

as suggested by David Lechner - could you pick this up directly
for 4.20 instead of going through David's tree?

Thanks in advance,
Bart

 arch/arm/mach-davinci/include/mach/clock.h | 21 ---------------------
 drivers/clk/davinci/psc.c                  | 18 ------------------
 2 files changed, 39 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
deleted file mode 100644
index 42ed4f2f5ce4..000000000000
--- a/arch/arm/mach-davinci/include/mach/clock.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-davinci/include/mach/clock.h
- *
- * Clock control driver for DaVinci - header file
- *
- * Authors: Vladimir Barinov <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DAVINCI_CLOCK_H
-#define __ASM_ARCH_DAVINCI_CLOCK_H
-
-struct clk;
-
-int davinci_clk_reset_assert(struct clk *c);
-int davinci_clk_reset_deassert(struct clk *c);
-
-#endif
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index fffbed5e263b..5b69e24a224f 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -303,24 +303,6 @@ static int davinci_lpsc_clk_reset(struct clk *clk, bool reset)
 	return 0;
 }
 
-/*
- * REVISIT: These exported functions can be removed after a non-DT lookup is
- * added to the reset controller framework and the davinci-rproc driver is
- * updated to use the generic reset controller framework.
- */
-
-int davinci_clk_reset_assert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, true);
-}
-EXPORT_SYMBOL(davinci_clk_reset_assert);
-
-int davinci_clk_reset_deassert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, false);
-}
-EXPORT_SYMBOL(davinci_clk_reset_deassert);
-
 static int davinci_psc_reset_assert(struct reset_controller_dev *rcdev,
 				    unsigned long id)
 {
-- 
2.19.0

