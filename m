Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A28ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2712075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="htIFOclZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2712075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGRMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41329 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbeGRMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so4336817wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9CQedn+nQxXLEHpqSs8DpgYHPSZPQjLKCbWQA4bbA8=;
        b=htIFOclZ3MSSI3YXUdnoxxljnVZbwYqAJbtLp76LKNtdFV6/3S4sdQ5MsL64gG0d4e
         nhpLOV1l/aVd5NyEN01qHYM+2Tngn0weFIuR4z9kQ05BEcDqVADxA0DjpIackqhPnu9I
         9tQ7tDb6OpuQX+NoMpyqcAAE1GU0D+XM7gHQ/RzvRLMhUyUhSnrLd6hpAlWA0JIH96bu
         +2TEpOD8a4BoAcrxj7bsgwmqGmKp1SidWyiUoqJpCfhkxrt9inLgUBoRopK+ff8FcDo0
         QvXlHtXST/JX4/lOF/yYYnHgTB791PNOT8udPdNYE59EwMW4vyy53B8+xV8i7eAjeFY3
         t7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9CQedn+nQxXLEHpqSs8DpgYHPSZPQjLKCbWQA4bbA8=;
        b=K3Mu05pJ/rzX8UGX3AbdPNrgKC9fjbMPD/ECWhcl4Ua9fWxv8W1VF7V6TIheMaLnEE
         2nU/MbA1gIp56DCmCHypUCM1LSdEGl/Cg3fj/qDhogRnAqZnVXRhu6WA4k7S+KyBD3B5
         xEfrD+TR/PSJLHXtz6pMMuyIFAv4s7ko/EQV+NW9bLcPxrwTbH/6SCmisPKS6gRSEnI3
         oXX3LtI25XyBT+EaFPTfOQRvYi4YJzKXBw7mW9cewY0bQv8uKjr6oqL9rLPubnONFu3I
         aCcAuVE55dIzmrWu45meW0Hocbk8FH6SiYIiucVBQcnzc9Xov+BuSn6PnXRxhZjOdMCi
         l7JQ==
X-Gm-Message-State: AOUpUlGbw93N+P5RWN5LPbwB6TduYAuMqadr3iSNQeHnLZHEGBjfs7s3
        mdVfdSySLFhtu99mRoXZXhqoag==
X-Google-Smtp-Source: AAOMgpeBRKfs4K7ZAm0wEv6tTpXDOX1tc7Lvsdkzvu0EcmmycSBswc01BM0p9ZOOii1iD5ODk/Cf1w==
X-Received: by 2002:a5d:4007:: with SMTP id n7-v6mr4322942wrp.258.1531914054127;
        Wed, 18 Jul 2018 04:40:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/5] ARM: dts: sun8i: a83t: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Wed, 18 Jul 2018 11:40:39 +0000
Message-Id: <1531914041-14751-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddress-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index b047f05e690d..276c99fcfcc8 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -913,8 +913,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu 27>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			mdio: mdio {
-- 
2.16.4

