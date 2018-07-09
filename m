Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C546C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD220873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="euPimfjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFD220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeGIPVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:21:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41564 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933446AbeGIPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:21:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so4891562wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=by9C2i6XfXl1651RFiSyGNvZSdidS1Z6P9wUbdVAAG8=;
        b=euPimfjcd7qmPMa3bqoFO6lt3+HEaVxDLLx+u8ECOA5qtbpKl80xrOVeTD7geTeXzA
         /HXFp0vb8oFU4t0DbfJ+rc48cQOGl+8ZlIQ539dvtr1qxVRHPoBS/mzKS8szbhmVj1zj
         UUaQhgPNDXnA1Dv1aoQkRkoMIe9rrBmzsERgY9BLkffoggPPE30vLn5hGhKfpyO/t4vv
         8OlyARzTVw91fOmGkrKw2CA8BZv1a8kXV5/gYJggy57rMpSKDdQX9ehzTOI1f0/r2tIL
         CJS5/ZNRXZ56toQ6XM4FytCA3yHBR0ZyCMNe3nl4QlaooHXp3Nwdxipo2zlIq2JQyIBT
         Lmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=by9C2i6XfXl1651RFiSyGNvZSdidS1Z6P9wUbdVAAG8=;
        b=bT/VDnY2b/kExqVOmi1vkvXIuSxT3XfpZgpeXf8V5Q/OymohGK3U9WAOwqCv0Azl0c
         clO2yG8TWDRZuKK49EYp8jIRWB8a/FTpIxEBrVhwo5+UwNqrS7Kw+rO+brcGgYVh1gKb
         ATUsMcMMP+JDaHHLP6Z3LTvoAXLNb2rOdu5VZkx95uQdDZEdAF2znhOf+X0YVmZhfiSU
         qTB5CvVBmBMx6mFSfHR6ESBz+8OYjFLTg7/3QpxgDzw2vwiqmSKiZAPTuMaydU2gK7/A
         TEJk/SxAZ9HSkv0mX10YS2ieV1Ta5HAq8bbJO6WnmG5INo+iDy2rG8QcYCyXsJlZhct0
         8sCQ==
X-Gm-Message-State: AOUpUlHDbycQ9/n+pnfW6YAFNHK5I1GrnZTUehrq0nAOC+twlfCUrv+n
        bp0ytPlvYPCaBLoffTyVvsTU6w==
X-Google-Smtp-Source: AAOMgpfFBzQEsKVUSdKc4KZNjjh8tlURZhEx4ecdE9SiJ08ATY/jMtY+5nXLEq/6yCN6bwL7LbZGLw==
X-Received: by 2002:adf:acf6:: with SMTP id o109-v6mr1860958wrc.34.1531149676629;
        Mon, 09 Jul 2018 08:21:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm14468474wrj.71.2018.07.09.08.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:21:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 4/4] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
Date:   Mon,  9 Jul 2018 15:20:58 +0000
Message-Id: <1531149658-27030-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 4f3d583183dc..ceb38739f1d8 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,12 @@
 	};
 };
 
+&ahci {
+	vdd1v2-supply = <&reg_dldo4>;
+	vdd2v5-supply = <&reg_eldo3>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -251,6 +257,18 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
 &tcon_top_hdmi_in_tcon_tv0 {
 	remote-endpoint = <&tcon_tv0_out_tcon_top>;
 };
-- 
2.16.4

