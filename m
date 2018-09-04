Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7683620652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFBgFb5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7683620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDTLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:11:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55920 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeIDTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:11:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so4714883wmc.5;
        Tue, 04 Sep 2018 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kSQFdFbhzbWFla0CuYEWzeUaA5/Osp/Fep7KHPZ3Px8=;
        b=rFBgFb5zysZPSSWyHMk8dU5vWUSRAh8UZgUISxQ4JohtkjVnAei1WsjFfcZsBWGk1u
         yhwTsNLVfn29KYd9u1CIc+PZi52mS3K37LYFgk6aMEyvniMttK3Dz9606cIA3V2kPXnN
         9+0gepUMKvgJ1kRFbiF4CDtNtd4TOa4FoTpEawTa7V4Z3956gzkAV9M/P9Ul4hM7sDqh
         PXYJkN6y40Ip6n40fYgnAasT05NeT0HEKUK2rFSmfGDzW8BWpfVomlC4xJ/1j9bfNhxG
         d40h/vTYukXBswUjkAhrfbFlFnQ4x78Gy0R57LZc5aSojyKyqsvN5c4JXIrqPAYeDYoA
         WLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSQFdFbhzbWFla0CuYEWzeUaA5/Osp/Fep7KHPZ3Px8=;
        b=uDFxbZBE4hfkrXWsSZ3S5E3yQp5vIOkNfOEMrp0e6ZBQYmkEZdC+KEV2I+3Ndsxv+e
         JTlOWR2+yDOd+F7kgovEEdjbkaqebd5BJEBhQcwL5GQYNqhzF7dj4lL4PML0uW1vfjOY
         oFSE6o3jwAwKS9GCBN+HHvTAywI21eNMSvf/bRW2qjPL8nrvDNXGDFbuVD2y8ZH3PPlx
         X02FzYLjHl+hQn+VRt4KwBP5fX2/kQP9FtnELmsDercBeyrPBxxZ3PzetnS+r00ZzMNM
         HsETGSnfKL3hUgmPEapVJAgMDkKLnkc741Hced+nm0I60kpQhWSe59QtVqTINYo338xw
         0JAA==
X-Gm-Message-State: APzg51BheeMNXYFVGHbvdd0zif1l+Q94YU19v09xoJryNDvFcW2avg+r
        Lyo39TrjDBgjZp3PQACa5PE=
X-Google-Smtp-Source: ANB0Vdb/2V7tOPhXFs5mb4ajeHMSMcjJZhwlP8FbbLfZ8J0I8TeUXuRafosG6NynGYF7ok5YEVKdNA==
X-Received: by 2002:a1c:3b56:: with SMTP id i83-v6mr2534849wma.66.1536072340632;
        Tue, 04 Sep 2018 07:45:40 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id f13-v6sm22061830wrt.9.2018.09.04.07.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 07:45:40 -0700 (PDT)
From:   chewitt <christianshewitt@gmail.com>
Cc:     narmstrong@baylibre.com, christianshewitt@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
Date:   Tue,  4 Sep 2018 18:44:50 +0400
Message-Id: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the ttyAML1 uart used by the brmcfmac sdio module in
the WeTek Hub and WeTek Play 2 devices.

Signed-off-by: chewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b2..9476868 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -10,6 +10,7 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 		ethernet0 = &ethmac;
 	};
 
@@ -239,6 +240,13 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+};
+
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
2.7.4

