Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4085ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969A3208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EKxJ5bC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969A3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGPKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbeGPKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so31290267wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sq4KOrWUhuaUYt3p8jh3EFDOu51CPtcgjydndAfpBFM=;
        b=EKxJ5bC5y7ie/eZwFOQzsnW0sH/dEthm1sdy82V/FLmyOL/CXfevYjYm5g0idVfY7q
         5mhCUMGxogjwg86ngRPIiYTQT3VuVbxYx7JLZ1Z7lqIJ7r5ZR5mPoBvYd2lnx0YF/cgP
         CepoQWeZ78gqjWoGp+048MAPVJTwTjcStm91QSfmd6eDkkr8iIKT9UhU4oZaO/PeeW2H
         852Ia11tUBYDrmmREktZd3dyg56DIn9P2xCyp2NGaLS/Uxoc7yJWk7/61UnxEVFEXCqy
         FJ0nXSGYZp67/hy7PqRdDZK0k/UCz4fcF300I2UuJ1EFzOLGhrxxUdn7vPG1JcZw8hs3
         EMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sq4KOrWUhuaUYt3p8jh3EFDOu51CPtcgjydndAfpBFM=;
        b=Q0sHf3SWMJEmU0YHBITO5vxCb5fxs8/x2XlXIccKj/lFLsblJtSmPzzUucfNB0rhgo
         +zskyXyrQNYgVM/tfS6PIeM2y/fddOdO91FukpSJ88YP38a0GFFidNfrJWiag7AqqSvJ
         6S6thQqmh0zn+84cvsj9PG1AbqYqkYm+9cLsxVrdTDA0c8EtTQ3L6Qc9w8q8OH2Biyzw
         DjXE5yPyLDByZEDEMwANrBKtHHW2Bhfs5OusvgV5d5F9ydWtVfGjRHspt5B/yYEsG5kh
         GZG+vXXE4PaQioaaOC+GNn7IaZyJo8pXIRncvlDpAlDzZ1bi7Fj7LErw7Br26p+N8hCH
         KvDA==
X-Gm-Message-State: AOUpUlHe5gf0yoKunc8r7HeK4MKVSY/O9PeDvYfPaYvwvFeUQ5vr3Upi
        ch5f417HpCKKEW67aGf28x/wXQ==
X-Google-Smtp-Source: AAOMgpfSPo6Mj9KTOgbfQHiRbIoy1zUNbLLBlnoTCSbOoWJWQtlUVHl72USAfHbFIH4aelRdRTl3qQ==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr12216417wro.160.1531735919627;
        Mon, 16 Jul 2018 03:11:59 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:11:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/6] ARM64: dts: meson-axg: add spdif input pins
Date:   Mon, 16 Jul 2018 12:11:49 +0200
Message-Id: <20180716101151.31109-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spdif input pin definitions to meson AXG

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index cc908c9b5306..277958ff516a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -561,6 +561,41 @@
 					};
 				};
 
+				spdif_in_z_pins: spdif_in_z {
+					mux {
+						groups = "spdif_in_z";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a1_pins: spdif_in_a1 {
+					mux {
+						groups = "spdif_in_a1";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a7_pins: spdif_in_a7 {
+					mux {
+						groups = "spdif_in_a7";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a19_pins: spdif_in_a19 {
+					mux {
+						groups = "spdif_in_a19";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a20_pins: spdif_in_a20 {
+					mux {
+						groups = "spdif_in_a20";
+						function = "spdif_in";
+					};
+				};
+
 				spdif_out_z_pins: spdif_out_z {
 					mux {
 						groups = "spdif_out_z";
-- 
2.14.4

