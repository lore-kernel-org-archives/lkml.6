Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51444C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B62420811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299016;
	bh=Ii6QAzlt89bchmAyK7rIzhU0EuI29AehlqN+mfEt+iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffiKtt/o3rNrxKEY2VMs17uTzpMacuehQbpAmdabnVltCo9cp6sOdeHBtLcAh8sWz
	 tc6zD1xiL18+w4/Ci5UOei7AwqeKF1SItAFyvOq1Q3F4lvv/P7txYSOSP7AeWICJ76
	 dvev4BaQ0lBCgFhVhgfQqv3euNBNIRZuVPf6vKsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeLTJnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbeLTJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FFBC2177B;
        Thu, 20 Dec 2018 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297750;
        bh=Ii6QAzlt89bchmAyK7rIzhU0EuI29AehlqN+mfEt+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMsuEVeTP24Ejtc9zQcI4V7CH/ciCQyC8kg6t1Wn3rqHjXxYjiHodEvGPCqG0n0jt
         fslmHcThq7pSUYPb6nyoPTGJeFyQ4NQb+AdCnJ1n87mKEErUeDF1fGnDzntmRRRzia
         2E7900Wn78ZI3qsBaWAYblPpfrGpGRq1fCo6lgQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 08/40] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
Date:   Thu, 20 Dec 2018 10:18:20 +0100
Message-Id: <20181220085826.815635923@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


