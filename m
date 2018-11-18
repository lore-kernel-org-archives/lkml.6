Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B954C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3C82080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZYTs2W/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3C82080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeKSAK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:10:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53751 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeKSAK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:10:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id g131so2382761wmg.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6byBe9Al5tAC5NstU3tZ5zh348CSZIw2l0zT1ZAN88=;
        b=ZYTs2W/TcQ3RFOb6c5F4SLjBfUpVX0gMS4GKl4c8y/HzIX3wnFf8URxkQ8bC/CMAi/
         tZIZVtDO8VSwW3Twu+AG+JIfRXyTwztoAzFTn8NkMHYCYR8HIZ6/hg2bL0vkoBTZawem
         OBelggp4cux+WKC7WloPLJ17OfQFv2PaXRkCAp/Hp02cYokynOygIheC/Zo6/E+B3zbL
         ceGUNpNVw9/qLHqs3WSS937gKP5CD5TL5DXapgaSt9kmQlnBB2NdO7T5pJiX1yT7eOFK
         pCTmHkpebGb8dtD8lSIN3obSNeVUNVjE6/NKEUvmQhinMXAifqYLe65n6RqusdyX0yPY
         GiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6byBe9Al5tAC5NstU3tZ5zh348CSZIw2l0zT1ZAN88=;
        b=KuD3kIcglvQhUnQEva/jiA+IhG1mnCLM6Uj1WpEu0tPDVCxpxg78bR7P2QW8LT+/DL
         3puFG+tAO64sob7pou1P2K+Vf2orNOkNXxddYuD9RFDqZtKWNqJjuxYWGM6uc6Il50fN
         wheFV4rLRhFkZMCnRmJAQxmp5+XkUdvZkySWoW2ovFePs7WPcOkt0P9MgdX25Nk4aWv7
         xMxklySXTm+MR14rXjvgSnnrLH7UNP8TmtK/MVDQoyQFO8D8KX6cqP5IwGKREcP9ZYim
         AleS00/TEN3JShq0ovvrIzB3jgMDFZj5TA2utAUi/mpwRb5rq3gg7QjNM0C7UPxBt5sQ
         gSPw==
X-Gm-Message-State: AA+aEWZYyGMs4hHA3kO8q50IjYMtYXi+DYGPflFafpSNbiNaR3BEO+j0
        RLpNMrQPxYoKd1GVah90JFVBCw==
X-Google-Smtp-Source: AJdET5dELMzl2U6sF4ce+R7m7aS7S7427SG7AvCT9KvAFO2HbREctYwAZDKVyYBAOf/9kMueTeyk7w==
X-Received: by 2002:a1c:cb84:: with SMTP id b126mr3816967wmg.64.1542549032591;
        Sun, 18 Nov 2018 05:50:32 -0800 (PST)
Received: from bender.home (lfbn-nic-1-84-209.w2-15.abo.wanadoo.fr. [2.15.173.209])
        by smtp.gmail.com with ESMTPSA id y9sm4491721wrq.55.2018.11.18.05.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 05:50:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
Date:   Sun, 18 Nov 2018 14:50:24 +0100
Message-Id: <20181118135024.30720-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
This patch adds the node in the top-level meson-gx dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f1e5cdbade5e..ed336c7a98a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -262,6 +262,11 @@
 				status = "disabled";
 			};
 
+			clock-measure@8758 {
+				compatible = "amlogic,meson-gx-clk-measure";
+				reg = <0x0 0x8758 0x0 0x10>;
+			};
+
 			i2c_B: i2c@87c0 {
 				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087c0 0x0 0x20>;
-- 
2.19.1

