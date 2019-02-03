Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64037C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35966218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ZguLBKQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfBCMbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:31:44 -0500
Received: from onstation.org ([52.200.56.107]:49396 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfBCMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:31:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5B95B627;
        Sun,  3 Feb 2019 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549197101;
        bh=UVgHSUmeIlDINs+wXWcp/GfbQZ9kaoUTJLRb4rUulBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZguLBKQwVWgKxh+3kKagDauU+d7xXsxjg0kWfch49E3rXIrUtkGTHNQIOE/3/7Fuf
         3PrhPl3NhBzjN2wQvfqYnSsOb2DWKKfd1a//uxNDrC3C4yzVK1fFgQ04kkeUF3ru7Z
         b5v9nHy0F4hjwdbsL97ZQJLkoJIbsqR9pUfDqMEc=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com
Cc:     andy.gross@linaro.org, sboyd@kernel.org,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 2/2] pinctrl: qcom: spmi-gpio: select IRQ_DOMAIN_HIERARCHY in Kconfig
Date:   Sun,  3 Feb 2019 07:31:31 -0500
Message-Id: <20190203123131.28323-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190203123131.28323-1-masneyb@onstation.org>
References: <20190203123131.28323-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IRQ_DOMAIN_HIERARCHY for spmi-gpio in Kconfig since this driver
is now setup as a hierarchical IRQ chip.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
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

