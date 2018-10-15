Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDD2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f4PM9RPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFDD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJPAOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:14:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeJPAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:14:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so22097412wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eXycmWv4/YSgM20PwhnetExzSgEMuwDfaJY/spL27UM=;
        b=f4PM9RPrtH39FeI9DhSFAPxrqe+xpB8dyZCE1gAXktR49AOU41v77ohMNmG3zka5IJ
         ZgARpJm4Gkj0orM7sV/P3A2pLhhvF7yXsWqa4LHkg2vEZnv/vcnibn6CgJ5iU08IXtte
         c1K2AC7jtipTPlS+nx8yFl4Yos+ZlJLaB0jKn5AtA+2e0d22kDi8qlwdcCs4mTAwu3eg
         rC+Cs2Lr9JnJLsiLiCRpojVACEjN+r17Rthn0+lOrutjjMhyscTZHMi7Nu2vfwpOVRGN
         wbqPUFGi5SBRSBZnEI2PGiOSI+K76Ft/yi6h4A2wOiLEkpNgqTmY4lQhpovG+9wwkYkj
         qLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eXycmWv4/YSgM20PwhnetExzSgEMuwDfaJY/spL27UM=;
        b=XF7D9NkpoB7m5G4n3N5/aZViGo9kjW05MsqdRljGyoc37KbEH8pVQ2maU9lYcswg+B
         MIJOFub5wOovWWg6VWbUemjpeMR/M9TVEOmMbYCt8apRiRWJv/QMMVjybChPHb5npz8N
         zP/2tjg4DgHaEqbklyedfXUSSqH4PEDY3XKTus6dFCX6jRkuPTJrXzdJ1r5YqwxqYfn/
         db8A50a8f4cA2ymJIXsjbt3s1bJSS2Y+ZC9p6nVzBeCOqE3Xuo1CPLn9NusdaGX4OWY0
         MO7H/nYwJulhHbgG+ORLmJir3Rum9Gp3UePt3J6cd5DWWbUaTtaM82edxZ8hFszpTOaP
         TnRg==
X-Gm-Message-State: ABuFfog/YfLWec7E1pJHEgsuX8nZL79bGivaz21/GbJ/Uss0TatVr8nE
        96QyZ32bJ1NuKTLvaNndYQ7/9Q==
X-Google-Smtp-Source: ACcGV61xlLh0dbNUWNrramcTqd55VK8KDy2MzkW/JhpY/Os7vOCH1MWsB6QGNv+BOlwWBOBgbcdKWQ==
X-Received: by 2002:a5d:4ec8:: with SMTP id s8-v6mr14144300wrv.32.1539620920122;
        Mon, 15 Oct 2018 09:28:40 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c8-v6sm14045926wrb.6.2018.10.15.09.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:28:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
Date:   Mon, 15 Oct 2018 18:28:32 +0200
Message-Id: <20181015162833.7544-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181015162833.7544-1-jbrunet@baylibre.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
was merged Amlogic's boards using mainline u-boot started showing the
following warning:

WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : reserve_memblock_reserved_regions+0xd8/0x144
lr : reserve_memblock_reserved_regions+0xd0/0x144
[...]

This is due to u-boot setting some /reservedmem/ region while our
dts declares reserved memory on the same region with no-map.

The conflict produce the warning. This is fixed by using /reservedmem/
in our dts as well, which is probably something we should have done from
the beginning.

Cc: stable@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Kevin,

I would have liked to put a Fixes tag above but I could not figure out
which commit to pick, considering how much we changed those regions in
the past. If you have suggestion, I'll be happy to repost this patch.
If you prefer, feel free to amend this patch directly.

Cheers
Jerome

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 24 +++++--------------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
 2 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 178d8e8c56b8..06a06f11f114 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,6 +13,12 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
+/* 16 MiB reserved for Hardware ROM Firmware */
+/memreserve/ 0x0 0x1000000;
+
+/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x05000000 0x300000;
+
 / {
 	compatible = "amlogic,meson-axg";
 
@@ -115,24 +121,6 @@
 		method = "smc";
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		/* 16 MiB reserved for Hardware ROM Firmware */
-		hwrom_reserved: hwrom@0 {
-			reg = <0x0 0x0 0x0 0x1000000>;
-			no-map;
-		};
-
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon@5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 676a995fb912..23e879b29b1e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -13,6 +13,15 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+/* 16 MiB reserved for Hardware ROM Firmware */
+/memreserve/ 0x0 0x1000000;
+
+/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x10000000 0x200000;
+
+/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x05000000 0x300000;
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
@@ -23,24 +32,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		/* 16 MiB reserved for Hardware ROM Firmware */
-		hwrom_reserved: hwrom@0 {
-			reg = <0x0 0x0 0x0 0x1000000>;
-			no-map;
-		};
-
-		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon@10000000 {
-			reg = <0x0 0x10000000 0x0 0x200000>;
-			no-map;
-		};
-
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved_alt: secmon@5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-- 
2.17.2

