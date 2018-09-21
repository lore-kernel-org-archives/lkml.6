Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9F421476
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5+MK1Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9F421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeIVEB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:01:26 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53173 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIVEB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:01:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id m4-v6so6117082pgq.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yWucRDssuw2ic8WU0bjQxu46rSfH55635t2vWILrZnQ=;
        b=s5+MK1Xx6S1IldqHdzazCE0GMhQUsPz1ucyAyhVERCiMt8opgy7Q/Q/d0xuZ7p/trO
         3rqCyrja3q5acq6m7o925KTGf2ilGgxLneAeZNfx/pE0RRWzNsAaJVld3WIPWXTdsjtZ
         1Q5rzYuJFkV54/tlZIqKtJ/4+QzBYIDWTNs9YsRefL2Qq1NdAcNNjl8tXYmOOhd1wkpM
         7c1HjATMpRDHAXMMrJmPyAziH7kOCOKiJSNCdDi4++NQc+/Z2I+m9+T3CAO32sTTwhJv
         dYaKxV8cdwzaC38kVS7ClVi9dz8ylQJ3Q4OQeR7Z//13b9nJuVMvdQHFKkztXZlQIPis
         USZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yWucRDssuw2ic8WU0bjQxu46rSfH55635t2vWILrZnQ=;
        b=qm5YRV/utqjKXjnTjCspIFCcYD8ngRx8D3HBf8L+yN1jF4WPfDXf7v71pceryr42O8
         D2A122QI7gzMZePH/KpvavJRssicyaM8efnlqePfxTcp+E7fiMj1AM4ALS5hjZIPHAWT
         69p0G6qgV61+XQ1laJiktOCl1/dfttZyOpCOv3kv0Gms+tINVlHsm+9Begj+HXNrqliS
         9YqudKuk7PlpVy3JicvLfy6QwQBgc+FsQRAlZqWMUFZN0TGIhCeY8X27u8XnVl9DtMxp
         C5Klq6I4zjrHoRLrQMZwKCge9IiqQmmsE/dObSnYIR7aIY4pG92E0Qr8xpqH23G47WeB
         HUgA==
X-Gm-Message-State: APzg51AXejGlyB9iYoyb/lfzLmiw0aYZMueElHfoN5A3bqpi0MZtOaLz
        HiNKpHOiNl/bo549VfHEcqAKoJXmCH72FTb+bmmWUA==
X-Google-Smtp-Source: ANB0VdadyH5lVLgj3zdujdLWbFqWLdbqHa9JIYnD5D16/jUTe1lUJiyHv8qrbLGovTWtqBuWr8b7MZ82VwniGlcc23vw4A==
X-Received: by 2002:a65:4009:: with SMTP id f9-v6mr2024351pgp.63.1537567835822;
 Fri, 21 Sep 2018 15:10:35 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:10:25 -0700
Message-Id: <20180921221025.75003-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very large divisors
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
---
 drivers/i2c/busses/i2c-aspeed.c | 62 +++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..4e946cbb7270 100644
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
+			"clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
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
 
-- 
2.19.0.444.g18242da7ef-goog

