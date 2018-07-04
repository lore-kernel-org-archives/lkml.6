Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA725C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E3223B5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bJBojjhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652E3223B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeGDRET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:04:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55890 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeGDREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:04:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so7013629wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+A1FHRVyiPySfJMqP9JEOfnM/rmeWLvtOeT4v9Qg4Zc=;
        b=bJBojjhnscez1aZwj7htbA7aBt/eFYtBGZtc7wrMxGQqO9jydRBXkZMtD+AxXIcL+W
         i9IY+KpFgDyefoeyeaJhhGjmjDT5KZp/9+Ocus2urP9Eis+agwL3BHG9KQdvHZcL0vZv
         OiA+0s9yuHGN4x63eOfen6BSB7m9BBa72g+4Is8PSyCL94Xu6KY+intrPZQWqZgDJyNP
         CGNkNkMfvaLKmXT3ozdT5PDNyEGb3AbEe+49tLSluJfZx7E3JRBdlwndvzmvP+hce9aW
         M2zsompPCa0mMBzMDSr/Y5EA5v8klovNfaMlKDBqFpzwQWk8wu7h6a/y83m/wvXJTo/w
         p3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+A1FHRVyiPySfJMqP9JEOfnM/rmeWLvtOeT4v9Qg4Zc=;
        b=CpSlkOYV6SDkZkTf0p5iknOR6/CIDiUrsUluhL1FtwM8QCvihZ6ylp11sSao/udU3u
         USsoPuLX/7h2z3YZqCG9YNUf6Ars8Kk7lEaIRavXm48mdfEkZ+pjLBDXmx1Sio85Sk6K
         jFPLWsb0DDH2v2QGy6NXuW8n62froYmg/68tDhfx8CH4vDYc4+WzrCWxq++LkaZ7mXCu
         9bnPaKw2+wD803geBqiQpFkpv3yQBaCbETWCAd7hNe+rvYu9gn8Sr6A1IbHgYoznLMTc
         f0kBOyNJrEhM7F1wE0o1g7aqL59PXSssuow9r0bnLJmIqvLQTCeo/uTY9brtzUBSdQA9
         FP9g==
X-Gm-Message-State: APt69E3Ou1p0a49TfpOfum2EhH6vWI+cwd12UJCtSkOucFIHXRPbxv23
        OxSBYtHhb5w4tXGH6bPyCB1lLg==
X-Google-Smtp-Source: AAOMgpfPplK+4pF6+wr2Vj3jdDhDysJ4K80qP5HU8oGtj5jQNadRapJrNLRaVqCduSfWYxxUIqb/pg==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr2115621wrb.215.1530723855838;
        Wed, 04 Jul 2018 10:04:15 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b15-v6sm4955682wrs.96.2018.07.04.10.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:04:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: add spdif output pins
Date:   Wed,  4 Jul 2018 19:04:09 +0200
Message-Id: <20180704170409.25809-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the different pin configurations for the spdif output

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 67d7115e4eff..aa1a42407466 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -561,6 +561,48 @@
 					};
 				};
 
+				spdif_out_z_pins: spdif_out_z {
+					mux {
+						groups = "spdif_out_z";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a1_pins: spdif_out_a1 {
+					mux {
+						groups = "spdif_out_a1";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a7_pins: spdif_out_a7 {
+					mux {
+						groups = "spdif_out_a7";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a11_pins: spdif_out_a11 {
+					mux {
+						groups = "spdif_out_a11";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a19_pins: spdif_out_a19 {
+					mux {
+						groups = "spdif_out_a19";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a20_pins: spdif_out_a20 {
+					mux {
+						groups = "spdif_out_a20";
+						function = "spdif_out";
+					};
+				};
+
 				spi0_pins: spi0 {
 					mux {
 						groups = "spi0_miso",
-- 
2.14.4

