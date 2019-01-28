Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DAC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629A420856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CVlusiE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1CJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 21:09:58 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35666 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA1CJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 21:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548641394; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7+kwgUX7wf/tpEbY0Uzxr09I/Lj4s4J6Y3D3Z9/ZwKE=;
        b=CVlusiE6ExyjyKozMRQCT0mPvrlMGN2FxjgNb510BDqH29Xsnyu92yhth04yt3eTcB2etT
        I3P99YQUsE5ezL+B6OwVgWCgk84JZk0QaHpzaKeFkAq3YckKjUoexsmC4Mo5rQ5N7f/Vff
        +a1CbCF6zrVEhgj8k4F1MUFhXJr9cI4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Subject: [PATCH 2/2] clk: ingenic: Fix doc of ingenic_cgu_div_info
Date:   Sun, 27 Jan 2019 23:09:21 -0300
Message-Id: <20190128020921.16309-2-paul@crapouillou.net>
In-Reply-To: <20190128020921.16309-1-paul@crapouillou.net>
References: <20190128020921.16309-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'div' field does not represent a number of bits used to divide
(understand: right-shift) the divider, but a number itself used to
divide the divider.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Cc: <stable@vger.kernel.org>
---
 drivers/clk/ingenic/cgu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 502bcbb61b04..e12716d8ce3c 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -80,7 +80,7 @@ struct ingenic_cgu_mux_info {
  * @reg: offset of the divider control register within the CGU
  * @shift: number of bits to left shift the divide value by (ie. the index of
  *         the lowest bit of the divide value within its control register)
- * @div: number of bits to divide the divider value by (i.e. if the
+ * @div: number to divide the divider value by (i.e. if the
  *	 effective divider value is the value written to the register
  *	 multiplied by some constant)
  * @bits: the size of the divide value in bits
-- 
2.20.1.495.gaa96b0ce6b

