Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF96BECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF52156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjO9kjKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABF52156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbeIVFWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:22:06 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:46447 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeIVFWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:22:06 -0400
Received: by mail-ua1-f74.google.com with SMTP id g12-v6so3707332ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JWi9B+iL8DCY3FejS4XRsyuQrW0IOzG3iAq2XravX7I=;
        b=pjO9kjKnTp2PxR36xWRWHrkMcO8i2FT9y1UzxUSu+YZRCpB0qLInHnxHKldY4YnPEJ
         +XfZtzhgA+my97JEDtL94fViaRnpg1fW9gU7OIieY6wgmJqj/PsNmm1rfTwhDL0G5j30
         IDLLZbHwartCeCQZHojYU9aLQPSdXjRiw6P2SNANmksNLybPomyRZUd51d6pGS24WA0h
         CVKEAaDYCK4bwWaW8KGg+UrqZkgz8RcTsAv+TgyNSRBqzIoHMJyY6ZXIQlRUzMmjh1CI
         GOe+N11xSbvw8xyLZUB8+kkardkFf5oMC/kvXBJnAkoOi1WAlZW/j1t+XHyT64bTkfIE
         atcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JWi9B+iL8DCY3FejS4XRsyuQrW0IOzG3iAq2XravX7I=;
        b=sYbLprSmQ/bvbq4fT+mYsZ+e/zYtEkXTjsphu8KCKAbJxK7z1NmLo5KFnNj6jSLZqB
         B9xIoRrzxuiRlE1jlH9vZPA3dnq/oQJmAd9zlo15n/zEvlpX0ISIFHQpgW82VeduDMLS
         kGtB8SMjg+lt8jy+7+MXhYUWyYXIIQ4Rdv8K9uu1AKVgdGxhrzLCMz7NC2djRH7N/R+f
         ytzUyEL/n5epGcsByfv/e2smcueAaB3ydMlr1CKyGBqPOI1fCWWZ/PmOOM9Fmng3HQoc
         XS/F3pJRfCoWU033/AhBDcG5DG+h1Rue3lmb0Q+BYuRN1mYb1zkTByXvYRS83Nscqf3I
         ZniA==
X-Gm-Message-State: ABuFfoibvWM0rnXzK995cp4qK3R1y/XiH2rioSXneT2+OzidQwcBIbvM
        7Mcydjy/Qu1bpfNSD4kevs7OtqR1J8YFnea6XKkkBQ==
X-Google-Smtp-Source: ACcGV61x3tqgYnIHBP3roUoXsvaHtVuOSaqJWGn39c4+fRaM5VG5X6S6OrKHUMQv75k8OVGgH28yNByDkFejq/NnYPut9A==
X-Received: by 2002:a1f:1d01:: with SMTP id d1-v6mr689vkd.60.1537572658468;
 Fri, 21 Sep 2018 16:30:58 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:30:50 -0700
Message-Id: <20180921233050.121570-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v4] i2c: aspeed: fix invalid clock parameters for very large divisors
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jae.hyun.yoo@linux.intel.com, benh@kernel.crashing.org,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function that computes clock parameters from divisors did not
respect the maximum size of the bitfields that the parameters were
written to. This fixes the bug.

This bug can be reproduced with (and this fix verified with) the test
at: https://kunit-review.googlesource.com/c/linux/+/1035/

Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 - v2 updates the title of the patch, renames a local variable, and
   prints an error when the clock divider is clamped.
 - v3 adds a missing newline character for the new logging statement.
 - v4 fixes a cast that I forgot to update in v2.
---
 drivers/i2c/busses/i2c-aspeed.c | 65 +++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..49e682f358e0 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -142,7 +142,8 @@ struct aspeed_i2c_bus {
 	/* Synchronizes I/O mem access to base. */
 	spinlock_t			lock;
 	struct completion		cmd_complete;
-	u32				(*get_clk_reg_val)(u32 divisor);
+	u32				(*get_clk_reg_val)(struct device *dev,
+							   u32 divisor);
 	unsigned long			parent_clk_frequency;
 	u32				bus_frequency;
 	/* Transaction state. */
@@ -705,16 +706,27 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
 #endif /* CONFIG_I2C_SLAVE */
 };
 
-static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
+static u32 aspeed_i2c_get_clk_reg_val(struct device *dev,
+				      u32 clk_high_low_mask,
+				      u32 divisor)
 {
-	u32 base_clk, clk_high, clk_low, tmp;
+	u32 base_clk_divisor, clk_high_low_max, clk_high, clk_low, tmp;
+
+	/*
+	 * SCL_high and SCL_low represent a value 1 greater than what is stored
+	 * since a zero divider is meaningless. Thus, the max value each can
+	 * store is every bit set + 1. Since SCL_high and SCL_low are added
+	 * together (see below), the max value of both is the max value of one
+	 * them times two.
+	 */
+	clk_high_low_max = (clk_high_low_mask + 1) * 2;
 
 	/*
 	 * The actual clock frequency of SCL is:
 	 *	SCL_freq = APB_freq / (base_freq * (SCL_high + SCL_low))
 	 *		 = APB_freq / divisor
 	 * where base_freq is a programmable clock divider; its value is
-	 *	base_freq = 1 << base_clk
+	 *	base_freq = 1 << base_clk_divisor
 	 * SCL_high is the number of base_freq clock cycles that SCL stays high
 	 * and SCL_low is the number of base_freq clock cycles that SCL stays
 	 * low for a period of SCL.
@@ -724,47 +736,59 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
 	 *	SCL_low	 = clk_low + 1
 	 * Thus,
 	 *	SCL_freq = APB_freq /
-	 *		((1 << base_clk) * (clk_high + 1 + clk_low + 1))
+	 *		((1 << base_clk_divisor) * (clk_high + 1 + clk_low + 1))
 	 * The documentation recommends clk_high >= clk_high_max / 2 and
 	 * clk_low >= clk_low_max / 2 - 1 when possible; this last constraint
 	 * gives us the following solution:
 	 */
-	base_clk = divisor > clk_high_low_max ?
+	base_clk_divisor = divisor > clk_high_low_max ?
 			ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
-	tmp = (divisor + (1 << base_clk) - 1) >> base_clk;
-	clk_low = tmp / 2;
-	clk_high = tmp - clk_low;
 
-	if (clk_high)
-		clk_high--;
+	if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
+		base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
+		clk_low = clk_high_low_mask;
+		clk_high = clk_high_low_mask;
+		dev_err(dev,
+			"clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.\n",
+			divisor, (1 << base_clk_divisor) * clk_high_low_max);
+	} else {
+		tmp = (divisor + (1 << base_clk_divisor) - 1)
+				>> base_clk_divisor;
+		clk_low = tmp / 2;
+		clk_high = tmp - clk_low;
+
+		if (clk_high)
+			clk_high--;
 
-	if (clk_low)
-		clk_low--;
+		if (clk_low)
+			clk_low--;
+	}
 
 
 	return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
 		& ASPEED_I2CD_TIME_SCL_HIGH_MASK)
 			| ((clk_low << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
 			   & ASPEED_I2CD_TIME_SCL_LOW_MASK)
-			| (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
+			| (base_clk_divisor
+			   & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
 }
 
-static u32 aspeed_i2c_24xx_get_clk_reg_val(u32 divisor)
+static u32 aspeed_i2c_24xx_get_clk_reg_val(struct device *dev, u32 divisor)
 {
 	/*
 	 * clk_high and clk_low are each 3 bits wide, so each can hold a max
 	 * value of 8 giving a clk_high_low_max of 16.
 	 */
-	return aspeed_i2c_get_clk_reg_val(16, divisor);
+	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(2, 0), divisor);
 }
 
-static u32 aspeed_i2c_25xx_get_clk_reg_val(u32 divisor)
+static u32 aspeed_i2c_25xx_get_clk_reg_val(struct device *dev, u32 divisor)
 {
 	/*
 	 * clk_high and clk_low are each 4 bits wide, so each can hold a max
 	 * value of 16 giving a clk_high_low_max of 32.
 	 */
-	return aspeed_i2c_get_clk_reg_val(32, divisor);
+	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(3, 0), divisor);
 }
 
 /* precondition: bus.lock has been acquired. */
@@ -777,7 +801,7 @@ static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
 	clk_reg_val &= (ASPEED_I2CD_TIME_TBUF_MASK |
 			ASPEED_I2CD_TIME_THDSTA_MASK |
 			ASPEED_I2CD_TIME_TACST_MASK);
-	clk_reg_val |= bus->get_clk_reg_val(divisor);
+	clk_reg_val |= bus->get_clk_reg_val(bus->dev, divisor);
 	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
 	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base + ASPEED_I2C_AC_TIMING_REG2);
 
@@ -893,7 +917,8 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!match)
 		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
 	else
-		bus->get_clk_reg_val = (u32 (*)(u32))match->data;
+		bus->get_clk_reg_val = (u32 (*)(struct device *, u32))
+				match->data;
 
 	/* Initialize the I2C adapter */
 	spin_lock_init(&bus->lock);
-- 
2.19.0.444.g18242da7ef-goog

