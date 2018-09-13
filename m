Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B467C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1020881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W5AqyHJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED1020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIMMUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:20:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIMMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:20:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so4462412wre.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=xefkRwVwK694SBCVhjwZZgQkRxdmtQDKiXGOuG46uGw=;
        b=W5AqyHJyaYnhpBi1DnN2m+4+D+6G2JXmYIu/3zVNN+rAuh4f4eC2fmMKhfw3kodGV8
         oas+QsqWiPCNPPQBGYLMOBr0ONvWHxFVE7Q4y0vXyhEomXa8Z3adxF2734L8sZSqFClR
         yBJPDSzinM7n+X82kee7BT8OdnNwOlQVz3LPi3TFfdC85ujdvriY9WfQSxs1NP5l9Sht
         TzdXEvDgF7j75TBqQYTYyOAJcVIQCajw0IQ/m4wFZZsT/tQhYW4xYlB5W7/RAyhSRJP7
         /iKhf338rRODDA0XnJ/3uWRUkRrmz5Q1c3hczvRJ+8aDwnw1JvtzXEr5/2V1RzbI08QI
         +KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xefkRwVwK694SBCVhjwZZgQkRxdmtQDKiXGOuG46uGw=;
        b=ZSbT/zIwUlSOk0VmEpMdc6Bxr2nWMTe9kYKsLo2xUf3oZ4QCmbYXt+AEnyFBKDbhb3
         Mbtntka9ens3duocZT7qH/35yHE04LLHmg/IW8SBWvRgFYO2mZvmZxyf6DrQtOzV7pEC
         ZFAgYMQct4cwD24t+/6JFu0bNXXYY3mtOmDsKQzwIOroP5dJ4k2D1O0kbgx/9f9t4aGv
         einSqJEhul0IoZiazanO0tq89z1UAAuiLHUeNQrmsHC0j6ZfEotgs/fqwwqZIg5kK7K6
         rL8v9jrFhmbZWtOyJ6zpmEfLPt13b/lUqtd0P0VQI2pB926MXDiA4EmkSHxAuErP4Fjp
         6QJw==
X-Gm-Message-State: APzg51A1SjQzYF/q3iwAh8zoGCspSTG+DEWDpa6DZHxJc1E4QVDxbfXo
        3xjuFbrQneUED0j/H/921dmWQw==
X-Google-Smtp-Source: ANB0Vdap7yMkLS9l8TH1bISSZN/iBqjdlmB+Fo8Yvri/QysyRVYAhXEponf5GTxHuC2eBw2owzW9rg==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr4070610wre.12.1536822749983;
        Thu, 13 Sep 2018 00:12:29 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u40-v6sm5375606wrc.43.2018.09.13.00.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Sep 2018 00:12:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: dts: meson: Switch simple-mfd and syscon order
Date:   Thu, 13 Sep 2018 09:12:27 +0200
Message-Id: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order between "syscon" and "simple-mfd" is important because in these
particular cases, the node needs to be first a "simple-mfd" to expose
it's sub-nodes, and later on a "syscon" to permit other nodes to access
this register space through the "syscon" mechanism.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Kevin,

I rebased the patch on top of your v4.20/dt64 branch.

Neil

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 9f61407..df017db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -965,7 +965,7 @@
 
 			sysctrl: system-controller@0 {
 				compatible = "amlogic,meson-axg-hhi-sysctrl",
-					     "syscon", "simple-mfd";
+					     "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 
 				clkc: clock-controller {
@@ -1209,7 +1209,7 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl@0 {
-				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 49c22f2..f1e5cdb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -344,7 +344,7 @@
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl@0 {
-				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				pwrc_vpu: power-controller-vpu {
@@ -444,7 +444,7 @@
 			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
 
 			sysctrl: system-controller@0 {
-				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 			};
 
-- 
2.7.4

