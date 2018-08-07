Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A32175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQtN/Rn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A32175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbeHGSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389182AbeHGScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:32:48 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584392175E;
        Tue,  7 Aug 2018 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658666;
        bh=x/TSjX+r6qTC0avJoFrgIgw6KUGdUV1XkOTFTO1pC7k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CQtN/Rn8ZDavQFJ2D+5AyL0ZadsqJ3HlmDEjhB5XZFejogyNZHHcLfAGNUVrycmD5
         ZlEjSKapZFMgDCrSQMeE9alaj5x2KnzY0bziLfYHEyNibcRVbjX8l8E6354kBAQhUS
         dLni3Cb80PNNDD2NvFA2CV0UQivfqjncphly1wHk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] clk: s2mps11: Use existing defines from bindings for clock IDs
Date:   Tue,  7 Aug 2018 18:17:13 +0200
Message-Id: <20180807161713.28073-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161713.28073-1-krzk@kernel.org>
References: <20180807161713.28073-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock IDs must match between DeviceTree bindings and the driver.
There is already a header file used by DeviceTree sources so include it
in the driver to remove duplicated symbols.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-s2mps11.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index ebf9115dad1d..56221647207d 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -17,12 +17,7 @@
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/mfd/samsung/core.h>
 
-enum {
-	S2MPS11_CLK_AP = 0,
-	S2MPS11_CLK_CP,
-	S2MPS11_CLK_BT,
-	S2MPS11_CLKS_NUM,
-};
+#include <dt-bindings/clock/samsung,s2mps11.h>
 
 struct s2mps11_clk {
 	struct sec_pmic_dev *iodev;
-- 
2.14.1

