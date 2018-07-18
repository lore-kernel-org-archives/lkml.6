Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D7ECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B066F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bzwv22Be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B066F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeGRMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41327 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbeGRMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so4336777wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CWLazWNoMEqdQMwZSMGcvoJD2L2i6xA2epF7x4LQEQ=;
        b=Bzwv22Be3R5uUEKSYNFAwghLuxqodMDOom0+7niSO54+X01xqFcUlCR3/MD/0hUppT
         vrqMwSGe3AtQ/94MH3jo3hofaS04FpC8UUNBs8sH0vJVn/Mr79w876HCTtzZWAuoiaVn
         3pNxhqys4FDWlUTwdPLHt/4fLD9HE9bkr9U5LsrU0eBekE9m0h9D6DRJ+aqTNxgjOH+J
         1Ur1kSooiMYaxW4suPjyjZvzW9sojncey8UT5SMFgWpmL/apFVdstPb6+XVgHzbSZAGZ
         3od8gRmpOIpEtsVCqyeNQMq9mmM15bM283qk+wQxezH5ceGYBPEP5z5uIpznryAdLqUL
         41Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CWLazWNoMEqdQMwZSMGcvoJD2L2i6xA2epF7x4LQEQ=;
        b=UCCz7VA8Icc4FBk5viw1mBR66XAGCDI1QTElmnj1Ti8L7uNLxEIFhRhwvUeOvDMNdn
         V9/m89vTEgZlFr5MULmUkCKgZnkRP5tH++il1+GqZ+r9JNZFXMI7sL4tJmtyW6fVU79g
         2hSNvmX7AsWn70eIbmf0MikQTe/oBaszVTimkQTxJAreCOs9AZSekl82bAgtjkgpIafa
         g7O7g88mp2vgBbm8NXWrOnGnvLMBh3BjU+pbYwhxZz91zpzVX+l3FRWn3ajByJtAbbiW
         Z9XrRTQm3iHO0F9IV1AScDnR424zm03xuXzEfmueQSoH56sJh3pFO0M6v+c2AZo4/JzM
         kdJg==
X-Gm-Message-State: AOUpUlExkvubQBCHCX+WTYia0J9leG8i3mt5235zNLCvAyy5YFpiXdfC
        eeE3mOXk6IMjgAFyTXX2KQvi8w==
X-Google-Smtp-Source: AAOMgpdKLj0EOl/MsRCSuO5ukeUGN7ihesnOsLCB1fxK19wJvBQT5zZrLVB3P6tzmzQ+kqAF1J0mTA==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr4388068wrr.227.1531914053089;
        Wed, 18 Jul 2018 04:40:53 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:52 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/5] ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Wed, 18 Jul 2018 11:40:38 +0000
Message-Id: <1531914041-14751-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 90021f38c1ef..f0352b8da19f 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -516,8 +516,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			mdio: mdio {
-- 
2.16.4

