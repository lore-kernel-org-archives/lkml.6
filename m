Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27924C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74132077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RFZkALlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74132077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeHaTKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:10:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35121 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbeHaTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:10:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so11515070wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mp7HvitQxu82nYe4ft7+MBqxeb+onsmRtvvDDm0lSqg=;
        b=RFZkALlhsB8MO62L6C4TFEM9J9+NcEG6kSb8BIknlaPZDXVFJSH8L2rhyGnIRMMzvO
         Dh2E7nsbJ4wnW2Sh0BL7F3XaoLL8WL7w9FEC3a6sCn09bhyvXVCvsEWBnF+vUW5XJJkh
         U1CwE4OaOq6bioIUwMWLQQDINew/I8ppP3u21cQuok+KmGCFeuTRmg8BoK9XeOY7B+AK
         pidh3ZshTUv8lqJP4RlXAG+cMp0FEiYsXvoHHfZfHtb1efbBCg5Vko93RE8x1t3J9FQ+
         c0pM8EtjmMjn+VgNZsuwwHmYU2sAtWn31m3hUITqstMniyd+7ycU6KhvDvMtUDjov9J6
         m+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mp7HvitQxu82nYe4ft7+MBqxeb+onsmRtvvDDm0lSqg=;
        b=KC4xGZDZuZRSFGZcEftlMEYIHRxJrHj8uNpy65WGE3GD5ZuUtFWl4WCiepnnbCmkFC
         1Rd1mU21zGbDTewj8ssebOCSvoEGh3Ho7GqHDOTZXxsBfSDj3r7Mt/A2ChdMQHtxyp+a
         961v0eQKaOCXP6NJs6WWYglSUmmsFjfpXJK0/UGcMe2U64aO7C08Dl27cTPcR2pKw1VO
         +VpxmgWNdm7bFt4j/wCuNBrSy8RHd8Z3NdSWq9pT7xwzMYCC3/qBVwnx49EBeqAmaDRe
         VK4qlOCXv0jPNTewZRX7I8+R8RciP9BgoWH2LFcfdQCbNSpyMaUNNS29B0elYO1llJV+
         wBaw==
X-Gm-Message-State: APzg51Act0C+4XY1sVqCgUUCtVwBlkzryYIyKhpDuQHlkhr2yhAczo4O
        TNvxixqz3tWBBIOK8G0ic8pcew==
X-Google-Smtp-Source: ANB0VdYa/+XLs4ZO1NIA3dzgPjloRvq5a0dUYoZy6qN+WGVWlrPJURATmbjrIz1P0hLPLasHmOSx3w==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr10905674wra.110.1535727747141;
        Fri, 31 Aug 2018 08:02:27 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm8759797wmv.6.2018.08.31.08.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:02:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: meson-axg: s400: add pdm to the sound card
Date:   Fri, 31 Aug 2018 17:02:18 +0200
Message-Id: <20180831150218.8307-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PDM input device on the S400 and it to the sound card

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index f3e16cbbc61e..92d3064d4966 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -240,6 +240,9 @@
 				"TODDR_A IN 2", "TDMIN_C OUT",
 				"TODDR_B IN 2", "TDMIN_C OUT",
 				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 4", "PDM Capture",
+				"TODDR_B IN 4", "PDM Capture",
+				"TODDR_C IN 4", "PDM Capture",
 				"TODDR_A IN 6", "TDMIN_LB OUT",
 				"TODDR_B IN 6", "TDMIN_LB OUT",
 				"TODDR_C IN 6", "TDMIN_LB OUT",
@@ -312,6 +315,14 @@
 				sound-dai = <&spdif_dit>;
 			};
 		};
+
+		dai-link@8 {
+			sound-dai = <&pdm>;
+
+			codec {
+				sound-dai = <&dmics>;
+			};
+		};
 	};
 
 	wifi32k: wifi32k {
@@ -394,6 +405,13 @@
 	};
 };
 
+&pdm {
+	pinctrl-0 = <&pdm_dclk_a14_pins>, <&pdm_din0_pins>,
+		    <&pdm_din1_pins>, <&pdm_din2_pins>, <&pdm_din3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_x20_pins>;
-- 
2.17.1

