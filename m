Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3661820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kh/eLLQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3661820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbeHAP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:26:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38226 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389408AbeHAP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:26:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so7077716wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhrrIcplKhvGFZAEbzKElBLgg626+Wi/iYjqAD2M6x0=;
        b=Kh/eLLQlIqWYDEoH2y+53cwcYDrCp9jGiO78d1HNLgMDslMnww7exyGZwZx4wmCJTs
         Py9Sw3CBdaG9PPOT6CJ6p7rLddZ8QPn5oouvhd3JBDnwkNvAy2NFF6EamBcoWnRka7oc
         /KSmGorLsd/i3aI7HKLYLDGJoZ8AidUep5KFO3XDR8de4tDUquPNYP4yrpPDlSou0W/n
         FFzowY04475AhTz869U03lgAdIQnU+BDjKQxuosFCgytTtURDHdxN2rhFFQtsee0cZ41
         ppYoFwgukYemKUgQ2NB4GbdjbrE3KM8ZlGsne/4Uc1bIIR0QgipRPKIbUjNaV05YKet0
         w4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhrrIcplKhvGFZAEbzKElBLgg626+Wi/iYjqAD2M6x0=;
        b=ZYqLdCOwkTF/PMsvSTpzGonL4g0/b5KoGxjmGY7YIt46f7SLjBmyvIYe/jGT4LcNR2
         kbcsTSocHRvQclkMXoMsHObSldjSoPcvvvzfZo5LfwHhCLQ4CrOLVDpnigMfyoAbRvhN
         nzCg/0tvqSFdSgKEmmDc7czpj8b8bjiKIn/ulkrEmWqptERtGlQLHxyA3FEPtJTFehZW
         KV39lm6VPlO4yb0vWFFNeIBf1xrTI5nWgb3lWPHOiO8vKNZe8S0hthcGRnRpXGRaIJKm
         S1n1bdNjQ2CyetQZIEAcdFmu3uYjwOqsJwlc3OzvawTxEnx6+XYsKMA2bGohdlPxHD35
         Aufg==
X-Gm-Message-State: AOUpUlHBjiSKFjio05DplYjt1DVhGB9PO7d7+uS00ZBCP5OJz4xGIoql
        kOA0D1ApwOHfuZAqmEbVZOL9HakLZVU=
X-Google-Smtp-Source: AAOMgpdwGtf2esM61NCSy6XBWoZwIl2hlXgH9jg+jibltJPh2V+boemZ12+5m3jFT+c3+m7MKPULRg==
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr2659765wmc.19.1533130854495;
        Wed, 01 Aug 2018 06:40:54 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f8-v6sm24347080wrj.9.2018.08.01.06.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 06:40:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: meson-axg: s400: enable audio devices
Date:   Wed,  1 Aug 2018 15:40:32 +0200
Message-Id: <20180801134033.21739-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the audio devices on the s400.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d5c01427a5ca..9f5d81c3ee29 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -226,6 +226,18 @@
 	};
 };
 
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>;
@@ -334,3 +346,63 @@
 	status = "okay";
 	vref-supply = <&vddio_ao18>;
 };
+
+&spdifout {
+	pinctrl-0 = <&spdif_out_a20_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmin_c {
+	status = "okay";
+};
+
+&tdmin_lb {
+	status = "okay";
+};
+
+&tdmout_c {
+	status = "okay";
+};
+
+&tdmif_a {
+	pinctrl-0 = <&tdma_sclk_pins>, <&tdma_fs_pins>,
+		    <&tdma_din0_pins>, <&tdma_dout0_x15_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmif_b {
+	pinctrl-0 = <&tdmb_sclk_pins>, <&tdmb_fs_pins>,
+		    <&tdmb_din3_pins>, <&mclk_b_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmif_c {
+	pinctrl-0 = <&tdmc_sclk_pins>, <&tdmc_fs_pins>,
+		    <&tdmc_din1_pins>, <&tdmc_dout2_pins>,
+		    <&mclk_c_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
-- 
2.17.1

