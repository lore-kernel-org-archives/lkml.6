Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A729C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588F421873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151280;
	bh=+NB+aZVCc1dKVHrotFJ9kUvFJAzLATf4ELIfDWry5EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFDTo2u8t47R9nwisvByPkVVu0FP4NNzlKvROhbnxGorxTz5FAxzQCA0GGna3DB5n
	 Bz2qaZAxbiK+GXlCWK4NAActxjPIIQqsJdN2ibT4QOo1e3jOqEPYuxxCEoc8MtFmTu
	 hR+Gv3k2msuPM81IDR3vFSp58I80uDOybqOyNuj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeLRQlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRQlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1F421873;
        Tue, 18 Dec 2018 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151276;
        bh=+NB+aZVCc1dKVHrotFJ9kUvFJAzLATf4ELIfDWry5EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZgELyEtvwZ4jsBQNSfu475CSA90Yf6ljbDMIUOsQMlhEf2Vg534NY6XGDZv1ut/I
         jGYrGWCoHY4/e6NkG2bpuiZyuPU/OK5yKyvk5PVsZFiwdi6SBGJ7goZSPZJxSluZCj
         WxqD4AlUtJw/pJiGqSWVZ//eX8aWyFOOGCKU3Uwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 08/44] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
Date:   Tue, 18 Dec 2018 17:39:20 +0100
Message-Id: <20181218163928.314767419@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit 478b6767ad26ab86d9ecc341027dd09a87b1f997 upstream.

Pin PH11 is used on various A83T board to detect a change in the OTG
port's ID pin, as in when an OTG host cable is plugged in.

The incorrect offset meant the gpiochip/irqchip was activating the wrong
pin for interrupts.

Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -568,7 +568,7 @@ static const struct sunxi_desc_pin sun8i
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PH_EINT11 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PH_EINT11 */
 };
 
 static const struct sunxi_pinctrl_desc sun8i_a83t_pinctrl_data = {


