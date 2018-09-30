Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC11C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3723206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNVsSCkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3723206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJAFZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:25:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33637 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJAFXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so1307224ljz.0;
        Sun, 30 Sep 2018 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=in1IHH5Z5QVstKfc+wM7AYUa0H//VLMIGKx74XBEHPs=;
        b=DNVsSCkPFyvVKWeRNgC5eqv8WVEftKrXcF2tdtB9mO3yVEH21tvV3dD5DB6u8WqY11
         zw5LwhdPzkqbKRiLMQMaQDa/53B5VUe8CyHEEjY/jbWLBSHik9PxGxpo/OstcbGciQ46
         anQZEe2fb9cFtaKP18zP/0TVBWWLGuBcq4HpO1qDt2V5A7p5NdiUAr/fs+epxohsNY9T
         6zZO4MdWFmDp8e5bFPwywGJEXz/ZlmZgMKB51Fpop1WH1jud6UWMUWmxsCzHVVMw+Vn7
         Und3/7eEzB7zgBs2reE78vB/NH0Ve/TyGPkPikcVrVEbAyPVxht3Cz+kdQeXxWA8hNlE
         uzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=in1IHH5Z5QVstKfc+wM7AYUa0H//VLMIGKx74XBEHPs=;
        b=jyHMBs0Dopn1z3PowPnmcuxW0cWhOVu6s7CsMxpcUkOZ2a/UMyhUXI9X8uJNUqs1o2
         bTGn57zMPtAu4LSa4RxvXX8GU3tJX1QLRWdWNOL6Xh4LIFCWaAZ4GyFw6+FNlsbHeaN2
         SfwCTChGL/a4IxWfEwsk0whIrspDdugpNNcDngEzd2G5R0nVl8pD9b38ZyA12W5DhGQ5
         Be8j2pWg1GgajaTndnTn4R/4j9JyEB9zHEZBbT6O7lizHfmXJipy6ujggeI6+9Jooesk
         MLiH+H2ZpKxC4Ke+p3HmJmLTEFd5sAqgb+K+7aDDS8Haqcx67A0FuKeyyBETWkTLGkcO
         46zw==
X-Gm-Message-State: ABuFfojQZtrlubX6Ardx/TvmYpziZsIMRX9bta+0TvGowgSbQ5fuVQ6o
        gHB/9ocKE1+e1p+rq9emUi0mYCgM
X-Google-Smtp-Source: ACcGV61MG6l/S1lpLwQEzloZjuYHzKujzt5D3HH+24TCGR5fdmNRZrh48BfxrwFsf7Gm6RRkI4STwA==
X-Received: by 2002:a2e:5859:: with SMTP id x25-v6mr5036918ljd.7.1538347740732;
        Sun, 30 Sep 2018 15:49:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/21] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date:   Mon,  1 Oct 2018 01:48:19 +0300
Message-Id: <20180930224833.28809-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree binding of Memory Controller has been changed: GART has been
squashed into the MC, there are a new mandatory clock and #iommu-cells
properties, the compatible has been changed to 'tegra20-mc-gart'.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index dcad6d6128cf..8c942e60703e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -616,17 +616,14 @@
 	};
 
 	mc: memory-controller@7000f000 {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		compatible = "nvidia,tegra20-mc-gart";
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
-	};
-
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <0>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.19.0

