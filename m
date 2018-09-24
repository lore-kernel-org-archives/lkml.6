Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F520C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C15D2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uESIYksk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C15D2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIXGqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46101 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so8395567pga.13;
        Sun, 23 Sep 2018 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SI8Q6dD3CUH5YH2wzC2h9K3OfGvC4psAICvLOPR9GV8=;
        b=uESIYkskJYP59nDx43lamKjiLV5RlLmEXauKxz9GRd4gkzQHD3t/xrdx2g9CVj4/Uf
         aDMX6p8oHIFDzRrvyHh0f4ifs3H3MTiBExK49Cqh3sam7EXIvpeF8lfkxIZ3CtFbxRfF
         kC5tDBRGG912x/Dd6jh074CDsjKCLfTS22H9o1EowvoY83m8sNFZ5oc1oZzvu3JKWWaY
         A8AMu7vcJ6NO1LjamWghysweitpVwNsGwuGRpa1uE49LrSDqawI56rPhyHCQqgDnE1Xw
         1lLfjAZRRj0naT8WASnrm5Cwpe7MundUquE733fICiFtzXGbGbtz1sc+ccBHpZDzr9Uj
         y9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SI8Q6dD3CUH5YH2wzC2h9K3OfGvC4psAICvLOPR9GV8=;
        b=ZGJYHwOR4ANRg6rf8WH7l/FCVd77ikcsJl9sMTRwGS877CrU6QFrDm7tsTy5dgYwnS
         mRBtip6ihnSXq+15hkHzZvSoGRsWjdzKoeu1iDvlLL3L+OaKuaJpphk8Ho8NUzdDaAGr
         wDiR4HJ0oX66E03yweN7e1UsJw17TxXUh++HMvo5KQSaG9U0x6DrB5eS7uo4PruXcsh3
         YK7R0ivuAa0g/HksMPwVvDYlct5Vxuv8utjwhac3sv0xpkk5gTuYFK15LlP9M1sAwY+x
         Kbi7aJjyKLtdarInFzmz8RPRosJapZHGKivMXUzkLj9TM9aIjvRCwyJzMVwHIy1LCWPh
         VoPw==
X-Gm-Message-State: APzg51D5D1R9tpxxx/W+6AWm7SpABSv2wniqYO2q9gsZw3nFAqZEMeV1
        jPbS391MQHsuhkx5TCmBXP8=
X-Google-Smtp-Source: ANB0VdaUTvK/+mPu1lUdwCYZeyh08CC4BmP+roFXSVnRkhmPzRMJbsvDR4VmcVX1B9dGO74Jl717bQ==
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr8032037pfc.232.1537749999233;
        Sun, 23 Sep 2018 17:46:39 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/20] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date:   Mon, 24 Sep 2018 03:41:40 +0300
Message-Id: <20180924004153.8232-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
index 979f38293fe5..3ebaf38cc598 100644
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

