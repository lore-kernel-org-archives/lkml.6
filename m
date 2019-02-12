Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E600FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE79C222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993871;
	bh=ZZhDk/cs5E7cdc6G2U0UHD3UnGmDAktYf+dZuZUYFY8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z6ogibiLXPcrnsRdMSQ9wUbZgxZZaYoeUNtiJuGhRuAOFw3mR1X6OdX1pDIoIyI8x
	 QWoT5rg8wD5BoMSg354/BtjTwEMfy5ccKCLX9VL2sq+HR2uYrbiNsQikFyUXGqRguz
	 N1/8zb+iSJC+jgAf4xbKuXYGZaYhz3P50TNyRvlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfBLRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfBLRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:51:08 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43DC222C5;
        Tue, 12 Feb 2019 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993868;
        bh=ZZhDk/cs5E7cdc6G2U0UHD3UnGmDAktYf+dZuZUYFY8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=0SlodYO/uTt6kRaV4K3cr6E0Q3+zhWYT/xh1i/+/KcEcG2/z0MDq2Xbqa5lzsC6Ah
         3+ApPx8aamQdu02lB6QdIs4NYKXSNNl+kpzVgtWPPOyqwdnskkjHulGkw017BY/f5v
         woQ6J1XyckiD2B3kVm6A1aY+yTUzkdnBsPexLbXg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: clock: exynos: Add ADC clock ID to Exynos5410
Date:   Tue, 12 Feb 2019 18:50:50 +0100
Message-Id: <20190212175052.6310-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
References: <20190212175052.6310-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID for TSADC clock to Exynos5410.  Choose the same value of ID as in
Exynos5420 to make it simpler/compatible in future (although clock
driver code is not shared).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/dt-bindings/clock/exynos5410.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 5b911ede0534..86c2ad56c5ef 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -45,6 +45,7 @@
 #define CLK_USI1		266
 #define CLK_USI2		267
 #define CLK_USI3		268
+#define CLK_TSADC		270
 #define CLK_PWM			279
 #define CLK_MCT			315
 #define CLK_WDT			316
-- 
2.17.1

