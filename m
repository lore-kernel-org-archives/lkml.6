Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF420C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A72147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tBbZ2BK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfBDJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:59:02 -0500
Received: from onstation.org ([52.200.56.107]:51388 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbfBDJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:58:56 -0500
Received: from xilitla.corp.homestore.net (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 686DA17E;
        Mon,  4 Feb 2019 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549274335;
        bh=+ofySgnOmc3kbIqs61R1JSx+oM6/RKMpkCHAI5puzO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBbZ2BK6chS8S+emOfFBTi2txutJxXDz5BNtVYvic5ZKn6A5U5v+MCdYw22jnyDO9
         07sgbEh4dHsqb+Z3LPuRx2BhO348n9dbitlWAQFGdUThnG3VVHCL5hmQ9togFN968y
         rQsq5YOkfuGa47qJzUm2VTCKobQck5nwYtjkGW4g=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com
Cc:     andy.gross@linaro.org, sboyd@kernel.org,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: [PATCH v2 -next 2/2] pinctrl: qcom: spmi-gpio: select IRQ_DOMAIN_HIERARCHY in Kconfig
Date:   Mon,  4 Feb 2019 04:58:53 -0500
Message-Id: <20190204095853.12212-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190204095853.12212-1-masneyb@onstation.org>
References: <20190204095853.12212-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IRQ_DOMAIN_HIERARCHY for spmi-gpio in Kconfig since this driver
is now setup as a hierarchical IRQ chip.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- None

 drivers/pinctrl/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 836e9f3eae4c..93efbffcd3a4 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -137,6 +137,7 @@ config PINCTRL_QCOM_SPMI_PMIC
        select PINMUX
        select PINCONF
        select GENERIC_PINCONF
+       select IRQ_DOMAIN_HIERARCHY
        help
          This is the pinctrl, pinmux, pinconf and gpiolib driver for the
          Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
-- 
2.17.2

