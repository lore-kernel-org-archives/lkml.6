Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE18C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A220620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e8Cns3Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A220620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbeGXN7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33391 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbeGXN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so4054107wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A4XnNFV0D4lRqYz+uc1ptkPfQ5Tx5d3XzHr45EHg8mI=;
        b=e8Cns3VltXySmcJVHDUFPzjFPWROW/GsnAXNNqSKDk3QAftiSWMgfwHlMUJYaZ3Lxs
         kE5EVfwJuR/YzauOfrjOvPWr02JEvPWxIpQ5Wqua2At5U8SbxAV939s4FwK7vZGnsibU
         y7OyOLlEIDULCD7LfoHYR4xE+Ew47MAx6gwt4hoXzq0RftDGMUJJJiKv6oD/RLity9A7
         y6TagpTDYM6o4bPj7YzHfQK5L5TSCQ6zhzI84pTXywqlLwkvd+8olmbUgseYbMQl27lG
         Ax8imfWcRHbJ89L3+8hc+3xU6yC+Odu0Og+926jEszuiTvICFpueeX7Y9gwJMbavviiA
         yq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A4XnNFV0D4lRqYz+uc1ptkPfQ5Tx5d3XzHr45EHg8mI=;
        b=jRHo+jNOQ/lbQf7Xiz7RfngKX5aSgmN5SQAYdn7qiHd7joN661jZ6u+s2MvWL+0mXi
         6VCqngESyBhu8HeVmusPjMY2jPSzwFSVGInx6jaJrZOHhCdgym8HAGPvsFbfMKwVni43
         ai19KlzEgtmcbBF60LBA+9ZvTdcTk9H8xJTvb4dgm+IUIHW/D4GWRm2MdYrdBcmqXrH8
         9t0L/GXaTzORIU+DuWXi0XwTf6ksGM7uNaQbBgjZr55yGPV6BFbqs/L3vR0cxT8HTqXN
         OQQeJaYK64+KAyv3fxOnC7azpbxHHZvD65pXb8vcXGHUfjc4llrVoUaHs6J1PuB4GBiF
         xygw==
X-Gm-Message-State: AOUpUlE8LKwmNWZXx7b3MyRCDN/Ecml1KCAo7W9Wr6ZO6wprYgWg15PV
        RLX24hFza1RFbgCSdo1YOnamog==
X-Google-Smtp-Source: AAOMgpf7yInozHfzQjR9XtKeu1ZU+XQLU//zRS9l3+NAnAay+Ou9PjkG4sRM50cN7o5d0HY4Yhj3AQ==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr11245545wrb.193.1532436781888;
        Tue, 24 Jul 2018 05:53:01 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] arm64: dts: meson-axg: add linein codec
Date:   Tue, 24 Jul 2018 14:52:34 +0200
Message-Id: <20180724125238.14567-11-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the es7241 analog to digital converter which is fed by the
lienin jack of the s400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7489b88f27d7..fb101a1c6660 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -178,6 +178,16 @@
 			gpios = <&gpio_speaker 2 0>;
 		};
 	};
+
+	linein: audio-codec@0 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es7241";
+		VDDA-supply = <&vcc_3v3>;
+		VDDP-supply = <&vcc_3v3>;
+		VDDD-supply = <&vcc_3v3>;
+		status = "okay";
+		sound-name-prefix = "Linein";
+	};
 };
 
 &ethmac {
-- 
2.17.1

