Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476122146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oNnMo9Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476122146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeKPIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55129 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so20408268wma.4;
        Thu, 15 Nov 2018 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBmjvcaHmhREoczRD+ZJjpcgQEWa7HVdYQV7xZ1p9X8=;
        b=oNnMo9HtZmfmuyukR/sGSk+L/Als8N3WvlTH0aNjQNb8dM+iy/pkcMDWlzCbTv+DwN
         GcMLqRv7eRMdYZ1Y2qDZGcOwYfNUh4eG8pJ+MdI75dcDw0XOsiPPAIZw7dwc38/6sdDo
         lT0U2KYkdfzEUxnarevFXcBJvJbiAWL6RpXu/gahr6o/fIVAwjB6QfzYZRcl08VWx6hm
         TFE0Sg8HaBaF898R6mH73jM8Ka07iPcyktQI3Xdey1wht6+7hXfRg/p6eOoQ4DqH9cCH
         M3xU8DRZVJb9/x2ZvaOFW2u1U4ubnCtnIXae/DOs411gVhZsB5nnrHKI0uAUpu08vXLb
         CEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBmjvcaHmhREoczRD+ZJjpcgQEWa7HVdYQV7xZ1p9X8=;
        b=pDZtZldTGF3mlj3aDvi1mF08X5lFKlzcuZnrQuNm0xHEqkhL3K3dVQk4QKT7xYH/zn
         SJhMXXVGN4Lcdj0Fkj6IgfFdDdQcsdgUNX4Fqd2WbFRTWoB850mNg/tm5q3fpeLQHBPO
         Gik+iS0lfnqGprCThMu2PwSLq8mnzxTlPThwf/Bk5EcJrw3jZ7E3Qcim1wj2ST1PJGWi
         8R35wuoXCGD9edM6UsgO6mo4bok53Y4Uh3v9WKkXuuKIKJNDXa7nUA6wRK2bE65p2ggx
         +jZC8XZCwLlJoEzxttjMUc9mGmZEuUQDdat3NEd3lL9l833+QsGF4LKOqC4Cb/7k7Ln2
         Fh3A==
X-Gm-Message-State: AGRZ1gKN6euoPFtFqGnWXb4WSJSnf9bHwv5TDP2o1NicMkaVaj20xFEG
        9kgdFds1e7/poAfMiX2z79N3bAwd
X-Google-Smtp-Source: AJdET5dqT8jWFi5ieLab45zKx3nVBVs3bm04Nuoj/1PdpFAO61IY3f2y+O/0dw5cRFN5sCTCMHDNxA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203-v6mr6332449wmf.97.1542321676658;
        Thu, 15 Nov 2018 14:41:16 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:15 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/6] clk: meson: clk-pll: check if the clock is already enabled
Date:   Thu, 15 Nov 2018 23:40:43 +0100
Message-Id: <20181115224048.13511-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
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

Now that we have a utility function to check whether the PLL is enabled
we can also pass that to our clk_ops to let the common clock framework
know about the status of the hardware clock.
For now this is of limited use since the only common clock framework's
internal "disabled unused clocks" mechanism checks for this. Everything
else still uses the ref-counting (internal to the common clock
framework) when clk_enable is called.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-pll.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f5b5b3fabe3c..afffc1547e20 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -200,11 +200,28 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	}
 }
 
+static int meson_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (meson_parm_read(clk->map, &pll->rst) ||
+	    !meson_parm_read(clk->map, &pll->en) ||
+	    !meson_parm_read(clk->map, &pll->l))
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
+	if (clk_hw_is_enabled(hw))
+		return 0;
+
 	/* Make sure the pll is in reset */
 	meson_parm_write(clk->map, &pll->rst, 1);
 
@@ -288,10 +305,12 @@ const struct clk_ops meson_clk_pll_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.round_rate	= meson_clk_pll_round_rate,
 	.set_rate	= meson_clk_pll_set_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 	.enable		= meson_clk_pll_enable,
 	.disable	= meson_clk_pll_disable
 };
 
 const struct clk_ops meson_clk_pll_ro_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 };
-- 
2.19.1

