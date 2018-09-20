Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9742C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B828221532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJyVxQ7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeIUFOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:14:40 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55206 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:14:40 -0400
Received: by mail-qk1-f202.google.com with SMTP id o190-v6so8981078qkc.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0eUfEmnxFezrSWKVS8+HPs0FXoxcazz84MXUQZFdxbU=;
        b=fJyVxQ7cgqSl7e6mSUlC8lQHPTUObhfrBxGToeWQ0k1leOJcsGULvoRDU7Uw0ZNR/B
         8SM5Rr4Ckeq3EGNIxrjiWc1qyofJTfVBNLxhJWet85O6Ztv+4ZxdapPzdL9kpLJFY8z/
         GtcSOPDMFi3k8dtLNzmtonLBpQvh9/TP/lBageq0hh9jbkJPnPUbTnp7lZfUut28Vphh
         kP1kt5aZ1qRYHrO8f3SNrvSJgJKzsf2O4ubkuXLW7S7SKfSgy8a6b6s0E+IkEnm4LY8G
         K5+5x9s8Tynk3Cj7639sccDWn+ceuAPJGnE78tFx/0PZTx4/NldDUA6YF7Y4sWhrpOvb
         /y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0eUfEmnxFezrSWKVS8+HPs0FXoxcazz84MXUQZFdxbU=;
        b=Get7FeV1KAY/Ux4JKPkddvX3UHxKZ2/p8Id2DNj2adK70hHVOafOYam3jsvIkJ5iNo
         XrBG2yEwgNEl1DmlleeOoYxL/dY2f+j0knWm0Gxw9huLP6c0IqbmbqZ17LbDTZrKzLXd
         T0kIVvwHJEvA08iO4Wvo8J/dTmAF24zoyzDTzR0DG74HmFzNEntuLOITg5ROScDbFo1T
         1BEe9y6blIIlzDNrSrSkFlgW+ups6HGxlMll3T3fcI8iyYyoX2+Y5TABbhukgoHOvKKc
         vBHD4rrYgJCnN7+I2WK5UQVWchQCaFmTo3/ZIvhdjxaQPz0g+ACXrAqU3ZCQ71YEKkdM
         RD3w==
X-Gm-Message-State: APzg51CjxrwtzcNzge7lewJNj8QpV3TKYn2dGkiQ65xTUfu4/1KY+or5
        NljBhBmGDkDSvu/MyHJle6nfc95DgWn248esBFiPwA==
X-Google-Smtp-Source: ANB0VdYaDFqzF+HTdLSPr6ttW3gxWxwfA0d/he1PbJBae0J+jLvsNfF5zh0a5q0ZP93+7cC51WdyD/hWYKK5Cv/YsFaxOQ==
X-Received: by 2002:a0c:b138:: with SMTP id q53-v6mr14496850qvc.29.1537486119413;
 Thu, 20 Sep 2018 16:28:39 -0700 (PDT)
Date:   Thu, 20 Sep 2018 16:28:20 -0700
Message-Id: <20180920232820.243734-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH] i2c: aspeed: fixed invalid clock parameters for very large divisors
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
---
 drivers/i2c/busses/i2c-aspeed.c | 38 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..c1c3f0a4d805 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -705,9 +705,18 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
 #endif /* CONFIG_I2C_SLAVE */
 };
 
-static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
+static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_mask, u32 divisor)
 {
-	u32 base_clk, clk_high, clk_low, tmp;
+	u32 base_clk, clk_high_low_max, clk_high, clk_low, tmp;
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
@@ -731,15 +740,22 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
 	 */
 	base_clk = divisor > clk_high_low_max ?
 			ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
-	tmp = (divisor + (1 << base_clk) - 1) >> base_clk;
-	clk_low = tmp / 2;
-	clk_high = tmp - clk_low;
 
-	if (clk_high)
-		clk_high--;
+	if (base_clk > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
+		base_clk = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
+		clk_low = clk_high_low_mask;
+		clk_high = clk_high_low_mask;
+	} else {
+		tmp = (divisor + (1 << base_clk) - 1) >> base_clk;
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
@@ -755,7 +771,7 @@ static u32 aspeed_i2c_24xx_get_clk_reg_val(u32 divisor)
 	 * clk_high and clk_low are each 3 bits wide, so each can hold a max
 	 * value of 8 giving a clk_high_low_max of 16.
 	 */
-	return aspeed_i2c_get_clk_reg_val(16, divisor);
+	return aspeed_i2c_get_clk_reg_val(GENMASK(2, 0), divisor);
 }
 
 static u32 aspeed_i2c_25xx_get_clk_reg_val(u32 divisor)
@@ -764,7 +780,7 @@ static u32 aspeed_i2c_25xx_get_clk_reg_val(u32 divisor)
 	 * clk_high and clk_low are each 4 bits wide, so each can hold a max
 	 * value of 16 giving a clk_high_low_max of 32.
 	 */
-	return aspeed_i2c_get_clk_reg_val(32, divisor);
+	return aspeed_i2c_get_clk_reg_val(GENMASK(3, 0), divisor);
 }
 
 /* precondition: bus.lock has been acquired. */
-- 
2.19.0.444.g18242da7ef-goog

