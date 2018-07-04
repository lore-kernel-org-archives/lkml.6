Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A9C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D05E21A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E8Wnd8iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D05E21A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeGDQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:55:38 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:54525 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeGDQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:55:09 -0400
Received: by mail-wm0-f53.google.com with SMTP id i139-v6so6924085wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDdOqSEbNpclYPD6AB/VNLXO2qcH9uV0htvvC9tQXp0=;
        b=E8Wnd8iJ9wuOzBdNMMSgJ8iX+x4gfaN+jr2JBFnRmdTcwkl8FMGFoGPc17JxrFDk4s
         +bHBG3Birnc7bh9TwyKoc3zqim80A1IIfHRAVupunaZBSltUKnu+mBEn0BLtYn5XwMPj
         Yb+/vGPOU17fsHTFBqD3dyKPFSh+fLn37Vg1t+vZ0h4fyQK9xRnl2gFDo3q0L1RwEn76
         K8lWaQcyg3nKdjsmj/werxgKiqWd+B97JYTce/4LSz7EFIDY6ZScysXda+I/gPgRovyV
         NOSh78B24aA0U7PCCawAHwCV8hLqr7akuPrqqkFzEbCWdqwY5yIrXtH00PwOw1I6iwQE
         cwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HDdOqSEbNpclYPD6AB/VNLXO2qcH9uV0htvvC9tQXp0=;
        b=Rxcu/ErCsCQUY86PC24OYJs5xSNzYhJ+5eEguufgh0EQgRzaQpurGayZcxxW2ZKIlC
         NwxojOTR0+jRVRpQSUsTIUmwpSStiacENad2+G1i9lXH0cnDmTrnYOtIaRUCx9Ku0EkQ
         xJBsPBWfRl2YqzdiZXKkeXFLStpzmclTN7s+An5KOutPRT8H5MOuSImaWv+I/Bo/jap5
         sH9gg0l+JFnGo8Z/v7S5GSi3hEPQWrMsNiiFm3PyUyhenSgJXHoe0dE66J1YS0N/5Pfh
         l5ej8fq6nmv3YgeZ8gX+Bgct6Q3+PHIX8heiDr7dqNuBP3GONZ1peAaWkEIW1QO2qAZ3
         uD+A==
X-Gm-Message-State: APt69E2zdpJ96WN/qQ+7AUNalcz0TCQegA/gbNLOk64Wn726Y9xZNHkq
        mvcvYVb9+B2nSrU9muDQ9kMXTg==
X-Google-Smtp-Source: AAOMgpeYikAqJl0+6nkRfd+rBEgLYC1DPfysGmim7DPsKzkyv/PwNJLb+TQle4qZzfx5KNALj5XQ2g==
X-Received: by 2002:a1c:694f:: with SMTP id e76-v6mr2030898wmc.132.1530723308365;
        Wed, 04 Jul 2018 09:55:08 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d102-v6sm7927618wma.10.2018.07.04.09.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:55:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: meson: expose GEN_CLK clkid
Date:   Wed,  4 Jul 2018 18:54:57 +0200
Message-Id: <20180704165458.24149-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180704165458.24149-1-jbrunet@baylibre.com>
References: <20180704165458.24149-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose GEN_CLK clock id

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/axg-clkc.h  | 1 +
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 70371228b7e0..fd1f938c38d1 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -71,5 +71,6 @@
 #define CLKID_PCIE_CML_EN0			79
 #define CLKID_PCIE_CML_EN1			80
 #define CLKID_MIPI_ENABLE			81
+#define CLKID_GEN_CLK				84
 
 #endif /* __AXG_CLKC_H */
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 7a892be90549..3979d48c025f 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -127,5 +127,6 @@
 #define CLKID_VAPB		140
 #define CLKID_VDEC_1		153
 #define CLKID_VDEC_HEVC		156
+#define CLKID_GEN_CLK		159
 
 #endif /* __GXBB_CLKC_H */
-- 
2.14.4

