Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C095BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F6020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gWgzuCk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F6020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGRMS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42771 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbeGRMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so4341393wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=69uNaljqYuJQVk405x1+/6YkpV8yYvxSa4sLANM19Xo=;
        b=gWgzuCk0cyv+D6ANFp0MY9XHkPB/dmWXjoPXot0pllephW5utsLDin1z7QmHGppmqX
         0TqLJrhevHe78OlwPv341TlUxTIIhkwUrKWVQHRfpfXOnTXJVtQrKDQt+3iGpcp3UYmb
         aSiYkEWppRXJ+xVhLws9jV7gnJUWrx23KSmrAi1P1lBBS9xwhr0k20tcUNUzKFiV71jD
         ZqgNleN8ajgBShvcYKX/UQQWfGxdf8LfTtYji65cNgrZr6fu15Xaxwm5f7Syk0PD8slF
         qRWttSFkthDRIP0Og71x5NEcldRaBqr3ikFOcLuKpC9hDsi6GuV3d6wBGJRj+yBUJdwf
         avkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=69uNaljqYuJQVk405x1+/6YkpV8yYvxSa4sLANM19Xo=;
        b=msdAWRhankP542ynStiituc8kGphhxbBl9vtYDo52d7MvyjKL3dt6foXRChKC8fXFn
         NmSuiAGh8fjUw4Q5NbEEnTaZIdu7AS+EF4LxuVL6XdEhnF3dZdMkxwEuYq3ObuSvN5Bt
         iD5KSAlmCa4wsHJAy/3OwFxMBwvZPMZa3gdyxGkOJCIS6aAetjNY/PcLN4liPvX728eH
         CxzK998SlBtOZa43bD0BiIfkUY+aVxl1CHAJ/k/zj4k7vQI9uzoEfb9oXNmB5z4L6cjF
         PfFqk6Dsir6rHw1tsPivJB0oB0SXZt9ILxwkZps9OGdnXGrphQDd9kzXF2Bihm98f1Kc
         MxDQ==
X-Gm-Message-State: AOUpUlHDBaY+dcnoyTTCh+6pH6alVjkal+jktbVCJa5+ug7Gnl6/FKMr
        w/gtFIfKfC/6vc12QUPvVQz5gw==
X-Google-Smtp-Source: AAOMgpdWezHesQT7YrIwtIjkuGyOAjY94PyQCo4gnRpfjWoXqjSUqyOm5sxIHGXNRoYXXvsXYE5ruQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr4343960wrs.137.1531914052143;
        Wed, 18 Jul 2018 04:40:52 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/5] dt-bindings: net: dwmac-sun8i: Remove unused address-cells/size-cells
Date:   Wed, 18 Jul 2018 11:40:37 +0000
Message-Id: <1531914041-14751-2-git-send-email-clabbe@baylibre.com>
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

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index cfe724398a12..5bb3a18cc38d 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -19,8 +19,6 @@ Required properties:
 - reset-names: must be "stmmaceth"
 - phy-mode: See ethernet.txt
 - phy-handle: See ethernet.txt
-- #address-cells: shall be 1
-- #size-cells: shall be 0
 - syscon: A phandle to the device containing the EMAC or GMAC clock register
 
 Optional properties:
@@ -86,8 +84,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&int_mii_phy>;
 	phy-mode = "mii";
@@ -137,8 +133,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
@@ -191,8 +185,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
-- 
2.16.4

