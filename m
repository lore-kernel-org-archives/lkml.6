Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798ECECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JNLybOwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285D320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbeGXN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36354 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbeGXN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so2449991wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhrrIcplKhvGFZAEbzKElBLgg626+Wi/iYjqAD2M6x0=;
        b=JNLybOwn6vRuzPrP37W4MX/FrfsfugO7W6itZPdJ0ViYJWndkcpQjJahS1LJuZrUmI
         t+7oSjPZRB51KmFL+pLQOtY2WInIDF6Bv8AB74leBtYC2q7X9pg92VaDc25JgSowTXyT
         hWZkZxW1PCoRaVp9/gthp9L50CiE1CyVqqFSG39CCMROIfXSlKPr8IVdUG6rilEQb3Yd
         /i6Zhthx0kIbNqp+0SnxLMJ0W+uSUfz3GOPgeE/zck9P9NJuUZINyInIqJU+8yuyqr30
         XABPCbgD51gPdAltiBqq+M2hcBu+77vp4Pg61vu9pJ3WnH4nqv7NcmUMg+KXkSdCJDJN
         w4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhrrIcplKhvGFZAEbzKElBLgg626+Wi/iYjqAD2M6x0=;
        b=MlkULm1ffuT6eWzMkOqs+520ACEc/3aSHbZfK4MyAhdi7pTQZXMR5SybrBo+GnkXhm
         xBK2W81/s5ljczpsbqWh65CWq13VR13daGs8o2+8BPuX+E4p4ijnLYE876rLNu0zBPjO
         qmyBkideEDmSoQuiog8EZ6lrLfi2mkdSUPtLE2O+jBp2u+vk33maf6XVWYuG7VFghEn1
         uSrG0xeL2cM0PR23ES5+VOnxKVf6XbuTmvF0FCM4XABhUlaCa1jbM6dVJUxxgW9bkJJA
         7lxJAA73njPOYQUgG6Cf+gMt/mGr37JSmJ767zuchjWL8JrcslMFzN/vF/p89oeeihgp
         CxsQ==
X-Gm-Message-State: AOUpUlHQ9KmsGILHKnoT4je5WI/3TABrzJN9tFtJBknM7chL8u2eO7NX
        gZxdk9OPV9KJbLrj8kh8zZARLg==
X-Google-Smtp-Source: AAOMgpeP+tNWtj0OZOU2nCVUHLfprPBnnfu0+/gn3SipY1Fh0nVuS0FdLVj5Ym+YTgXSaOOFRKg7kQ==
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr1842498wme.54.1532436785292;
        Tue, 24 Jul 2018 05:53:05 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] arm64: dts: meson-axg: s400: enable audio devices
Date:   Tue, 24 Jul 2018 14:52:37 +0200
Message-Id: <20180724125238.14567-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
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

