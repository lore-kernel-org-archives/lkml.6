Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3DECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CAA20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb7HrLpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CAA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeJVFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45580 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeJVFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so35091802ljc.12;
        Sun, 21 Oct 2018 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkDap+qcbtZbEt0ZyaZbCjkQ8PjFr9vE0vYyJtZByfQ=;
        b=Jb7HrLpOoR3e7SoAlWp5Sa20WF2gFhi/oBAV1LuFqpt40gZcviDL3TgCCus/elXaxJ
         EpwFvZHWaO242afDMLlo9tuiofdYxFDwQYigWNrs7MMoKKgu1Frjfz8Kh03yJGxlpv6L
         NQbqw+wJejbF+lZNWRz/xm2UnSRfrqhi0XQeC0BIKoLizAthK6zUG57oV1op7xgilAC+
         h2yv33NjAUOxTMklMvMkrHmja7A8mTiLd9s4Cx3Rq56WJ0W2shsMo92Vpd/KtqpbkEqz
         DB7USG/LEdPMJEPH9wXYaHSzVL3W+P4XNeUJZO3TpwF0VK4GF8Ms9B/qJ6a94UYBos8L
         zE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkDap+qcbtZbEt0ZyaZbCjkQ8PjFr9vE0vYyJtZByfQ=;
        b=XfZoTZZJPfWWDYW/ROP0PrFR4TJ+xIcO2/JMA2BeLv+8RiFxL2tUUs5nHmm1X4PYRD
         KEpAY6Nj1o/jmYU9Qye3ygymPdpUww15lurEoGF8YRHFTyT5N5BASN8p6HAdcP3Plkzs
         +RfVbnKqilrOqEkynxWy6SVJj0QHuGvhnPIVBWgRgbkvb8YBeQfMDnwMcLJQcN9dHQJT
         A2FgLA+SfGeqAJqbbwU9TE1HsbvgFdfZnlAOF0EPiFKBny3lmEI3lQigmTm5D9DzTbqk
         ssVP5CCEHFqcmMYDvJzIEkAjEHvkxWiqopzCx951riDj0sLCLXXZDrnb2JFvgZbBzum8
         mCpA==
X-Gm-Message-State: ABuFfojpLsv6Z9ys7ftdKescus6ajmfJkgdA+ZNwK/WyS3trNT+s/I5b
        s4u2ANiRMSxgp5/kRLGAOh8=
X-Google-Smtp-Source: ACcGV61lc188n9b7kL0VrGBCYHB/nd+jgi18yoMlL4PGgOun2Bo1EBstCY1TCp2VbZTJy53QDgUixQ==
X-Received: by 2002:a2e:1615:: with SMTP id w21-v6mr28051837ljd.33.1540155491438;
        Sun, 21 Oct 2018 13:58:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/17] ARM: dts: tegra30: Add CPU Operating Performance Points
Date:   Sun, 21 Oct 2018 23:54:51 +0300
Message-Id: <20181021205501.23943-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU's Operating Performance Points to the device tree, they are used
by the CPUFreq driver and allow to setup thermal throttling for the boards
by linking the cooling device (CPU) with thermal sensors via thermal-zones
description.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 688 +++++++++++++++++++++++++++++++++
 1 file changed, 688 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 790d3fa7e6d2..0aefc8d9efab 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -980,6 +980,670 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000_800 {
+			clock-latency-ns = <2000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0xFF 0xFFFF>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-suspend;
+		};
+
+		opp@460000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <460000000>;
+		};
+
+		opp@480000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <480000000>;
+		};
+
+		opp@520000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <520000000>;
+		};
+
+		opp@550000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x18 0x31FE>;
+			opp-hz = /bits/ 64 <550000000>;
+		};
+
+		opp@550000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <550000000>;
+		};
+
+		opp@600000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x1F 0x0800>;
+			opp-hz = /bits/ 64 <600000000>;
+		};
+
+		opp@650000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <650000000>;
+		};
+
+		opp@680000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <680000000>;
+		};
+
+		opp@684000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <684000000>;
+		};
+
+		opp@700000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <700000000>;
+		};
+
+		opp@770000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x18 0x31FE>;
+			opp-hz = /bits/ 64 <770000000>;
+		};
+
+		opp@780000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <780000000>;
+		};
+
+		opp@807000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <807000000>;
+		};
+
+		opp@817000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@820000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <820000000>;
+		};
+
+		opp@860000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <860000000>;
+		};
+
+		opp@883000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <883000000>;
+		};
+
+		opp@900000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x1F 0x0400>;
+			opp-hz = /bits/ 64 <900000000>;
+		};
+
+		opp@900000000_912 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <912000 912000 1250000>;
+			opp-supported-hw = <0x1F 0x0200>;
+			opp-hz = /bits/ 64 <900000000>;
+		};
+
+		opp@910000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <910000000>;
+		};
+
+		opp@931000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <931000000>;
+		};
+
+		opp@940000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x10 0x31E0>;
+			opp-hz = /bits/ 64 <940000000>;
+		};
+
+		opp@948000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <948000000>;
+		};
+
+		opp@970000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <970000000>;
+		};
+
+		opp@990000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <990000000>;
+		};
+
+		opp@1026000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1026000000>;
+		};
+
+		opp@1039000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1039000000>;
+		};
+
+		opp@1040000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1040000000>;
+		};
+
+		opp@1040000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1040000000>;
+		};
+
+		opp@1050000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1050000000>;
+		};
+
+		opp@1080000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1080000000>;
+		};
+
+		opp@1100000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1100000000>;
+		};
+
+		opp@1102000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <1102000000>;
+		};
+
+		opp@1102000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1102000000>;
+		};
+
+		opp@1117000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1117000000>;
+		};
+
+		opp@1149000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1149000000>;
+		};
+
+		opp@1150000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1150000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1150000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1160000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x10 0x31E0>;
+			opp-hz = /bits/ 64 <1160000000>;
+		};
+
+		opp@1171000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1171000000>;
+		};
+
+		opp@1178000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1178000000>;
+		};
+
+		opp@1187000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1187000000>;
+		};
+
+		opp@1200000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1206000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1206000000>;
+		};
+
+		opp@1206000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1206000000>;
+		};
+
+		opp@1216000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <1216000000>;
+		};
+
+		opp@1225000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1225000000>;
+		};
+
+		opp@1230000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <1230000000>;
+		};
+
+		opp@1240000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1240000000>;
+		};
+
+		opp@1240000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1240000000>;
+		};
+
+		opp@1250000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1250000000>;
+		};
+
+		opp@1280000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x18 0x307C>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x04 0x001C>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0182>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1282000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1282000000>;
+		};
+
+		opp@1300000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x18 0x0181>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x0C 0x0183>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x0E 0x018F>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x06 0x019E>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x01 0x0182>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1320000000_1175 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1175000 1175000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1320000000>;
+		};
+
+		opp@1330000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x08 0x3070>;
+			opp-hz = /bits/ 64 <1330000000>;
+		};
+
+		opp@1330000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1330000000>;
+		};
+
+		opp@1340000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x04 0x0010>;
+			opp-hz = /bits/ 64 <1340000000>;
+		};
+
+		opp@1350000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x08 0x000C>;
+			opp-hz = /bits/ 64 <1350000000>;
+		};
+
+		opp@1350000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x04 0x000C>;
+			opp-hz = /bits/ 64 <1350000000>;
+		};
+
+		opp@1360000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1360000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1360000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1370000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x08 0x3070>;
+			opp-hz = /bits/ 64 <1370000000>;
+		};
+
+		opp@1380000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x04 0x0010>;
+			opp-hz = /bits/ 64 <1380000000>;
+		};
+
+		opp@1390000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1390000000>;
+		};
+
+		opp@1400000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x08 0x307C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x04 0x000C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x02 0x000C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1175 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1175000 1175000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1470000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1470000000>;
+		};
+
+		opp@1470000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1470000000>;
+		};
+
+		opp@1500000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x18 0x3070>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x0C 0x3070>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1237 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1237000 1237000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1520000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1520000000>;
+		};
+
+		opp@1540000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1540000000>;
+		};
+
+		opp@1590000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1590000000>;
+		};
+
+		opp@1700000000_1212 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1212000 1212000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1700000000>;
+		};
+
+		opp@1700000000_1237 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1237000 1237000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1700000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -988,24 +1652,48 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.19.0

