Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A9C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ECF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ndm7bn0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ECF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeLDQx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:53:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44185 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:53:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so16712031wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uovFhiZzGyaBQW3XHTv2xNNKBWvDbg0VR5INejAlggg=;
        b=Ndm7bn0jZb94xI58zz+oX0/gfaHf3niAB40+7cua4CjbFYIZxjCQZNEI5svNuA4n7E
         EnYSOXOXGvHCCMM0ptOoZfUn7+fWYdL1xn/1fytJXrcaBA/vn8M4sdTYZLfm9ww3Mww+
         j2JAnHJPEX1TzMwceR+QCW4QRiHMoG/UgRaJ3nNGN+tgXu66PFhoCLetTSUjsEYNpxaX
         m2Pvmz0su43yt7h+YPk0ImrMtauSDXw8X7WEpXEc0sfUFA+oA/9U9VLI03Yab7CKnQMv
         xzu+UmvdeK4uME9LoHz14ctE843hLf4poLi1Tke4S2GV6P+I8BUcEnVy1K37ZsOkAoX+
         TGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uovFhiZzGyaBQW3XHTv2xNNKBWvDbg0VR5INejAlggg=;
        b=hWPRNHT3+zEMTea4WEqzOafO29Sb6VropA/6BXRQGk/AqRhFgckYSdOYjXVEyoqrAl
         +sgqXVjDKI1LX2PdIP+XrFnSpn5QCtTM6u9IuqvpI4uQqbkq8LH5PKYJs4HCkp7WvQzy
         8xOS2/HlLucMiA/3huAWRVGz7VdUMnNUfjsrhfn+ofVRe6h8dTrzQnp7WrmlePRT63rx
         UvLJSZKA08ieF5XpEfC7joHtDnjxgruDfSUBSrokv6xGM7QlMNkFnJDJxFSxBNe6AaFB
         jTew6U2OqMOcfxItJw5uq9A/XFHV9AklUAVrAn52uJN9z7uwnxLYes+C7no2iD47RNVa
         1QAA==
X-Gm-Message-State: AA+aEWaELhwPlj4MIGWZin6VDFBAqfo/22gqwYC+nZyQsKeRF+mwIfUQ
        bKJZ1IKmefiZriZgBIxZ/RQizQ==
X-Google-Smtp-Source: AFSGD/XDdbF2gsvv4ETlkHHO+i8RPcr3Pz6l/cELoKLZ7YPov+Rz1qjN1aKrFHTPfGX1n8/T3KlUag==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr18031940wrh.317.1543942397582;
        Tue, 04 Dec 2018 08:53:17 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s66sm11581633wmf.34.2018.12.04.08.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:53:16 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: clk: meson: add ao slow clock path ids
Date:   Tue,  4 Dec 2018 17:53:06 +0100
Message-Id: <20181204165310.20806-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165310.20806-1-jbrunet@baylibre.com>
References: <20181204165310.20806-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CLKIDs for the slow clock generation path

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/axg-aoclkc.h  | 7 ++++++-
 include/dt-bindings/clock/gxbb-aoclkc.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
index 61955016a55b..8ec4a269c7a6 100644
--- a/include/dt-bindings/clock/axg-aoclkc.h
+++ b/include/dt-bindings/clock/axg-aoclkc.h
@@ -21,6 +21,11 @@
 #define CLKID_AO_SAR_ADC_SEL	8
 #define CLKID_AO_SAR_ADC_DIV	9
 #define CLKID_AO_SAR_ADC_CLK	10
-#define CLKID_AO_ALT_XTAL	11
+#define CLKID_AO_CTS_OSCIN	11
+#define CLKID_AO_32K_PRE	12
+#define CLKID_AO_32K_DIV	13
+#define CLKID_AO_32K_SEL	14
+#define CLKID_AO_32K		15
+#define CLKID_AO_CTS_RTC_OSCIN	16
 
 #endif
diff --git a/include/dt-bindings/clock/gxbb-aoclkc.h b/include/dt-bindings/clock/gxbb-aoclkc.h
index 9d15e2221fdb..ec3b26319fc4 100644
--- a/include/dt-bindings/clock/gxbb-aoclkc.h
+++ b/include/dt-bindings/clock/gxbb-aoclkc.h
@@ -63,5 +63,12 @@
 #define CLKID_AO_UART2		4
 #define CLKID_AO_IR_BLASTER	5
 #define CLKID_AO_CEC_32K	6
+#define CLKID_AO_CTS_OSCIN	7
+#define CLKID_AO_32K_PRE	8
+#define CLKID_AO_32K_DIV	9
+#define CLKID_AO_32K_SEL	10
+#define CLKID_AO_32K		11
+#define CLKID_AO_CTS_RTC_OSCIN	12
+#define CLKID_AO_CLK81		13
 
 #endif
-- 
2.19.1

