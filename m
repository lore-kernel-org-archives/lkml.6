Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA2B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2LsgblgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA2B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbeGXN7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeGXN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so4022833wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azOuaUqMZk0xUFz8dZr+kVxbhyFqH20DyfFkWEm9Ipo=;
        b=2LsgblgNyzPBYDtqkncue94OJsJBicD91bAgUE6yRkIKZe0cPn6c2rnSG0sNI6T4AF
         4byIfiW9LYWeNT/l7AjXZth6aX6sRaGt3IMdp8SCwlAsOndLFdJ/bsPMvkJa6tDptyz7
         Ba0m6wEQTtubJg0v6Q3L326A14yiHpd0ScnH1AmancYTVHrxlNW0uIAGjS10Ewg2FzXg
         /wR6fFOTfps9kIgTNnuYnt6a6ScExS0kjwd9eB2yAM27clOZ7CGM98LvrfSH79McSIW1
         NL8q4nboXFdh5wY+ir9kU/KLj8YprHy9IZ2JjEuKLzzh3J4BsY9hE0TGHqfPF4R6kwId
         CKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azOuaUqMZk0xUFz8dZr+kVxbhyFqH20DyfFkWEm9Ipo=;
        b=P4/hLh9SeljFdcRUfOCrReTPunnfRyTI9+S3hLIp+QP2vxAMs38gSnaVPX5UL59aDL
         iZmDy3PVvRl0fc7FYJsRUSKkEdFEEt9pZk27wCkM/BGr50KoUV/GW8z8gP7LmEZn9jN/
         XquLAb2Kc5tvGqAJF3wvjBZ6sljwPmlGesDnAHgLL7NkOGReqOpGYPYoSU3D8tbR6N2z
         mYbOu5h2rnYkoi3pxo3Zk4SKMOLgaIyBvcBUM1KmS9b+lFi8QvqRDkzxEerNkM7W40UF
         s6U/nMfKBPX0FfJechO0JVyvd1zkc70c7eeQJLVSqB4FdLzrEY4VYsck4aafXQQk2mg6
         Fu/Q==
X-Gm-Message-State: AOUpUlH44COUfqp90CSp0n5Mzk/sTbsV526c/dtlnZ2Qm/RXzsHBj6d+
        kTiKb45QJYfSnh0lgse3cHeJBQ==
X-Google-Smtp-Source: AAOMgpc5w4cbmQ23CP/f7FnF5cxjRhMD7myQEDntqmNAC3ytXvGayeVLRIU6mdHRd5Tu3IbtWxmmdg==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr11377913wri.199.1532436771511;
        Tue, 24 Jul 2018 05:52:51 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] arm64: dts: meson-axg: improve power supplies description
Date:   Tue, 24 Jul 2018 14:52:25 +0200
Message-Id: <20180724125238.14567-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the parent supply of the s400 power supplies.
Also add 'regulator-always-on' property on the regulators which can't
be disabled

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index fd90fa4a282c..09c7909a78ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -65,6 +65,7 @@
 		regulator-name = "12V";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
 	};
 
 	vddio_boot: regulator-vddio_boot {
@@ -72,6 +73,8 @@
 		regulator-name = "VDDIO_BOOT";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	vddao_3v3: regulator-vddao_3v3 {
@@ -79,6 +82,8 @@
 		regulator-name = "VDDAO_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
 	};
 
 	vddio_ao18: regulator-vddio_ao18 {
@@ -86,6 +91,8 @@
 		regulator-name = "VDDIO_AO18";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	vcc_3v3: regulator-vcc_3v3 {
@@ -93,6 +100,8 @@
 		regulator-name = "VCC_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	emmc_pwrseq: emmc-pwrseq {
-- 
2.17.1

