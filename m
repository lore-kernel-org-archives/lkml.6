Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AFFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AFF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="aQuIRetU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AFF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGZQ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:57:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57632 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbeGZQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:57:56 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 29DF75C1D1B;
        Thu, 26 Jul 2018 17:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532619630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBpQlZrS3NsT5adBpKcjYb5QhHLdxnVa9BAbeh7nDx4=;
        b=aQuIRetU1J/KTOAF3hHueKqUTfb5fF0Y6X9vjGoSVvCjmzCv+rJ+7VwEHyzMdJeS7PcuPa
        s9QF3fffnf1j3BS4rf3bHruY7n7Hhh7E9PQZJ80X5hRcCRJMKZSXj+7BjNWWZIZfY0XLme
        6nRUciOEv95MP/4IxdswbGaOsubnLQc=
From:   Stefan Agner <stefan@agner.ch>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linus.walleij@linaro.org
Cc:     pdeschrijver@nvidia.co, digetx@gmail.com, keescook@chromium.org,
        marcel.ziswiler@toradex.com, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
Date:   Thu, 26 Jul 2018 17:40:25 +0200
Message-Id: <20180726154025.13173-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726154025.13173-1-stefan@agner.ch>
References: <20180726154025.13173-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The properties have been commented out to prevent a regression a
while ago. The first regression should be resolved by
commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").

The second regression is probably addressed by
commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
and/or maybe others. Readd the gpio-ranges properties to see whether
regressions still get reported.

This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
("ARM: tegra: Comment out gpio-ranges properties").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 --
 arch/arm/boot/dts/tegra124.dtsi | 2 --
 arch/arm/boot/dts/tegra20.dtsi  | 2 --
 arch/arm/boot/dts/tegra30.dtsi  | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 84c4358dacac..39253450a974 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -240,9 +240,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 246>;
-		*/
 	};
 
 	apbmisc@70000800 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 174092bfac90..47b51376ed36 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -263,9 +263,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 251>;
-		*/
 	};
 
 	apbdma: dma@60020000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 983dd5c14794..cdf018a7568c 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -258,9 +258,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 224>;
-		*/
 	};
 
 	vde@6001a000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 09087b9c5e26..b80f35411d72 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -380,9 +380,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 248>;
-		*/
 	};
 
 	vde@6001a000 {
-- 
2.18.0

