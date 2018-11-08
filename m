Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87037C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283F62081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nNQCYeOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F62081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeKHWnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:43:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37902 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeKHWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:43:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so21185214wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMANpgw3nwcwWTbuyAAxjzE/eF1CssOReOoXUx3LoKo=;
        b=nNQCYeOfYYQt63bplmqDiT+aO28GZA2R8b/GEF7XDaaUpplruh0HWNh9xn3fy1nB+J
         sEKuo1hlZPQMzjqUcOoay0JpvegjTS5v6NxxfRMK6/syEutcw3wsnVJjxWjc4L0QUQ6e
         n+Rpx3Uz1oSnfPhwJdoLNPPtGKnaATXaRbdfEb6hlUO+c/hE4h0qTeBwoHHVCp53xj5B
         XCvtKtcPDj+/TztDxmijcR/Lol2sRduJRK8MsP+pZfp1KUU8n3VaKMFtnZYDqJQume0J
         pSC/c3nxRoJC5ITiG4TRc6VD0TS/AgZ+cQueGJXLLUY9q98Kr0//x2PvpABypDeCU70e
         ocuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMANpgw3nwcwWTbuyAAxjzE/eF1CssOReOoXUx3LoKo=;
        b=A2WNokHzUurKjjWBU5DPl16tlDjAEOaQ1HsRW3X2uK3I8LWCvqmJv224dKv3ZY+2dT
         xF2jwcyxGcQWCzSWvIeuhrioeY0rkbdaK2WQA+sQyqz8E3IzvdK6ENieq3IRtgYTpOW3
         gJs8OuVLJ+nfTPERrT1OT6XXsiiM/6cJheVgOZQfsYNhk1T8E7YF7j5e8nlG6JdqkC7W
         dRG5iucAO0wXVEumj4a4z0E5WdU+PfWJFPhSYygtVVyrWPTdrNgS8g3MC82XlnqEcUBq
         t/DUdDpkXLIZpEnZQZpfKVxrMh4C9CTUPBcQgNE8DrFCChrIW8zRoPwNGtJa8N581hB0
         YO+Q==
X-Gm-Message-State: AGRZ1gIRIEYpzdEhs3dCjponXdYB4PJKMdlOLGo98En2SIQZkeUxrYrV
        k0T/wP0Fjb3Hidm/jVAjZBrGrtC9GAA=
X-Google-Smtp-Source: AJdET5fcYq86ss3tPTM1DZ24HTInam8bGUeXPCUeKSzIrqjMqWqK7hnhVLrAXB1zpvKiMt1PdD1w9g==
X-Received: by 2002:adf:a31c:: with SMTP id c28-v6mr4115303wrb.195.1541682476843;
        Thu, 08 Nov 2018 05:07:56 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y83-v6sm2916138wmg.13.2018.11.08.05.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:07:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg: add secure monitor
Date:   Thu,  8 Nov 2018 14:07:44 +0100
Message-Id: <20181108130744.32323-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the secure monitor device to the axg platform.
With this, we can read the SoC serial number.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index e0139f174726..3cc0044d3468 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -110,6 +110,10 @@
 		};
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.19.1

