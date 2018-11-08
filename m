Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AA920892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rn8Z6gvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AA920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKHX3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:29:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKHX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:29:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so21347224wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Trob3Eu4mkFDnpfZtYiuy74jOX9CM+snY60wneQxcg=;
        b=rn8Z6gvPJwy21I71vry5wevhZl3tSLH4x64kk8GfqPKCxQ5DKjr3sqJwd0vy6yo/aq
         tHyfHWdWWa/iVpQfHRkYvlOUsyLhjAU5JM5W1IbXkkYyP2G8C50xXE080VefudtJ/z/y
         2C6NEXgjREeNK7scfGWhQu+1QoDWXC9HGebtEM2fogK1iPyBCswcaljIymOUFc/iSBCE
         25004+HuJ4SIjJKkUCf8Ywb0QmYLCIc7hY0yQue0VXHjvuKMVJzut39f+No7EbTXDltA
         oqa7Z5KAx2Ik3oqZWDas6OO3vQb/Jin1Fp75JrNpzb5FNW3CO/X8WRU7sFewrqtnBelp
         4BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Trob3Eu4mkFDnpfZtYiuy74jOX9CM+snY60wneQxcg=;
        b=q5kjezPT3Mz7r4J/PIKT/gEpcYWOk3c1mRbD0+lgQBxM55ihzfnRlBLNqNp4jzLbuA
         sMp/eaCwzt6qGHwJMz0SgbVYi7x8vOoIpV3GR+3p7oxqPxx1EouLpfWXX/OaVWMjeC/N
         7RYd+nSRfdT4HoG5wddJB6OZZHRznR85xO/F/rT7lQHRiXuPO4zxGZofbkeuIqWoD/Qd
         NbhZc19wYEND7Cj/TsWWL8u71vLV+TvSNurWeEV4aKK5pQwnVbGaEHx7bWyvMgE3JmDz
         rrWiHInzyGM3IGm8OttY+pCKhQC+VBtmieaX74gt2PS7WBCjt8UZUm5stHfiKlvnBoSZ
         LY3A==
X-Gm-Message-State: AGRZ1gL+PTuoodRCifS5pak/HOeN/MrMLCnaO+Mmy5JjsyxGZ/Rmvnvh
        idTtp5Q3qIeQ//Mu9R4xGonmeQ==
X-Google-Smtp-Source: AJdET5ea+Zkph+ibbRJhDUu2cq9DMyFvl8YtEenTUNYTIAxjv8LCUX0zDxqGmchM+usPZpaVq1lotQ==
X-Received: by 2002:a5d:4e83:: with SMTP id e3-v6mr4523972wru.187.1541685243602;
        Thu, 08 Nov 2018 05:54:03 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p6sm2740329wrx.39.2018.11.08.05.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:54:03 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm64: dts: meson-axg: enable SCPI
Date:   Thu,  8 Nov 2018 14:53:52 +0100
Message-Id: <20181108135352.8459-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SCPI on the axg platform, with cpu clock and hwmon
(core temperature) support

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b8893675e39c..5f512c91471e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -79,6 +79,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu1: cpu@1 {
@@ -87,6 +88,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu2: cpu@2 {
@@ -95,6 +97,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		cpu3: cpu@3 {
@@ -103,6 +106,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		l2: l2-cache0 {
@@ -137,6 +141,28 @@
 		};
 	};
 
+	scpi {
+		compatible = "arm,scpi-pre-1.0";
+		mboxes = <&mailbox 1 &mailbox 2>;
+		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
+
+		scpi_clocks: clocks {
+			compatible = "arm,scpi-clocks";
+
+			scpi_dvfs: clock-controller {
+				compatible = "arm,scpi-dvfs-clocks";
+				#clock-cells = <1>;
+				clock-indices = <0>;
+				clock-output-names = "vcpu";
+			};
+		};
+
+		scpi_sensors: sensors {
+			compatible = "amlogic,meson-gxbb-scpi-sensors";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.19.1

