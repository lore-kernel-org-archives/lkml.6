Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506AA22507
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c81J09fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506AA22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeKOJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeKOJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so19085960wrx.6;
        Wed, 14 Nov 2018 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0RIdbj41WMBGlBYmwnCzpr3eDQ3vT6i3efI49BspNg=;
        b=c81J09fZIRIfQ3NXnELmVnJBBeVW9yr3GcO4eY70fRJyu2oo53KuOcd1nYvYGZTc3G
         WzU0VhYZhnxKO1bFdT75qNyTGZK554yaewi/4Erf/C84yrbpiPrTR9ATte1b8LF0mGjH
         IPj+6fOuOrfguo5xyJK+NNjvRMygYKRyH7dYkm87Bft4U9Ld0BI/uG5AC9r3J3zuxCSD
         k7IMaoVO9ncLBbcclmNS0/AIRuXKOzcZNcvXlJIe3uU9d6axl9kh3vJQJiSgj+KO9pVr
         OZgDY+3AQ1vEEOSu2Qlnj45x7YUNb77jiBmJMjdc2jN3kIL2kt6+jmm+9dsJoy48TuYZ
         fyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0RIdbj41WMBGlBYmwnCzpr3eDQ3vT6i3efI49BspNg=;
        b=Lh92qfelOEDZq8w5aJblKRXvf5o8c4FDhl+FtECP/9YGX/JSsXwHHbpQmDV6cIw3Ds
         /p341FPBahsdtjDjyUn+ks/+wHqWO77+wjkgDLoABDbAGym2tiBpA7OyQ7vEQk1YLmDg
         7H4CmwwCWy2QXd84aPaqgjxIkDt31YQVW/NiD+MjpeCGAdq38HC3dLfVPaznUqzCNh/P
         zRZK9ngbPnfUrXwTPrOPRDuYfFWEDDr+mjYwIpL06nNX/Xb5we7J1FUBQqMKyiQ5KqSr
         YA1nUjp9CtEPcmL63sQBSKogGaW2jcev/PMqN2InZLlxICNIcaMCo90R19isvMWh9JG5
         U1mg==
X-Gm-Message-State: AGRZ1gLGzJFaFifbUeL955e2m0VymHtYM19ikCrmgjZ9d+Xaqt95OHMx
        wXMwxUgJ1mkagQG3uNztZcA=
X-Google-Smtp-Source: AJdET5eXn94wuy/HY2p2+zPnGKIkkOJNDJlBio7vB/a+cY6KAKooRd7/MSGfpBV2ShZooSMr/5oRmw==
X-Received: by 2002:adf:8264:: with SMTP id 91mr3625837wrb.312.1542236273997;
        Wed, 14 Nov 2018 14:57:53 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:53 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 3/7] clk: meson: clk-pll: check if the clock is already enabled
Date:   Wed, 14 Nov 2018 23:57:21 +0100
Message-Id: <20181114225725.2821-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") our
PLLs also support the "enable" bit. Currently meson_clk_pll_enable
unconditionally resets the PLL, enables it, takes it out of reset and
waits until it is locked.

This works fine for our current clock trees. However, there will be a
problem once we allow modifications to sys_pll on Meson8, Meson8b and
Meson8m2 (which will be required for CPU frequency scaling):
the CPU clock is derived from the sys_pll clock. Once clk_enable is
called on the CPU clock this will be propagated by the common clock
framework up until the sys_pll clock. If we reset the PLL
unconditionally in meson_clk_pll_enable the CPU will be stopped (on
Meson8, Meson8b and Meson8m2).
To prevent this we simply check if the PLL is already enabled and do
reset the PLL if it's already enabled and locked.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f5b5b3fabe3c..b46cca953f4f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -200,11 +200,32 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	}
 }
 
+static int meson_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (meson_parm_read(clk->map, &pll->rst))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->en))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->l))
+		return 0;
+
+	return 1;
+}
+
 static int meson_clk_pll_enable(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
+	/* do nothing if the PLL is already enabled */
+	if (meson_clk_pll_is_enabled(hw))
+		return 0;
+
 	/* Make sure the pll is in reset */
 	meson_parm_write(clk->map, &pll->rst, 1);
 
-- 
2.19.1

