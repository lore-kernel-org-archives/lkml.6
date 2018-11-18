Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C864C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4562080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PJOOpV0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4562080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeKSANk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:13:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36907 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:13:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so15045232wru.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6warBK4AjkYFZ7MKEhC6ZGCgZpodJEII/OqLNckPO8=;
        b=PJOOpV0XoYz4KtqrUJunrRuwREBRs5gmFWyBXXCJExjL20NXJZ1Nyay8Qt1Y0MqoLJ
         9oIATxhOyPn4ihlQeObmG9lYL4d/m4bhnrdOyvaP2MloARjxvRwxFsg7E2Fz3Iqpz12p
         oYFCK0jA9NGOATRv37ksxGHa0i7dRYFiYfQq2TIKvM0Ruknf3BzQZtSajReSTJozZcvB
         PlnDqnFxspmfrbEPTRTI48TpzJ14Cex2vx1xXA6C/WMXTWXvf/SeQhWsKzkLWRzX11RU
         mro3nQIDnnVEf31uzMMEBq53bbrAZFCkun/OhPjUZg/GWRg5a/Xj8ULT3DjzmRmOllKe
         zm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6warBK4AjkYFZ7MKEhC6ZGCgZpodJEII/OqLNckPO8=;
        b=TvJFAXm0c11IBJNqPM2IvFQpW/vbEVar0/EoSSzzOYmXAoOwi/hfEIMvsinDYsrWAA
         5CAXJCcHCg2YMSz9A9I1rNRvKNyNLaF7QvBKMT/CkAKLV/UQdUKR5iKBgfP/8Seucx4t
         tnPyaq2LuyEmaixtR0Lq2Ivc3T4pghGTgV0uQEOq76ee8icvh1HhpbSugfzbgGXPzncs
         Yu5Tw55lqg+2uSMmAraxDhlMUUYwqcWFjzV8Ks7YE0ImAEqEsiUtgcrcssrp5NAAQkRv
         Au9welv6JE+mHZ8inAVM4M4bswXji1g+91NxqjEcliK1SZHW0yxkz4ggfQ2MrjT63qep
         iDuA==
X-Gm-Message-State: AGRZ1gKoYwuBiBxDHHhj9d8Oeb9ZgvV2Z4TUDTjc1XXO9rfT1omqjlms
        JlvinKbtnGLP2bH156nuwjDQz2wFzdNszA==
X-Google-Smtp-Source: AJdET5dX7zsWYM4SnCkA9mURcIl6V8Wq1v+aQe9gZzIfaRSan0/n6p3e0EYZmFUR+xGnQQ3n5OmbTg==
X-Received: by 2002:adf:f04d:: with SMTP id t13-v6mr14727273wro.170.1542549195111;
        Sun, 18 Nov 2018 05:53:15 -0800 (PST)
Received: from bender.home (lfbn-nic-1-84-209.w2-15.abo.wanadoo.fr. [2.15.173.209])
        by smtp.gmail.com with ESMTPSA id t5sm14906385wmd.15.2018.11.18.05.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 05:53:14 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: amlogic: Add Internal Clock Measurer bindings
Date:   Sun, 18 Nov 2018 14:53:10 +0100
Message-Id: <20181118135310.31458-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Rob,

I didn't take your v2 Reviewed-by since I changed the compatible list,
tell me if i can still keep the tag.
 
Thanks,
Neil

 .../bindings/soc/amlogic/clk-measure.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
new file mode 100644
index 000000000000..205a54bcd7c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -0,0 +1,18 @@
+Amlogic Internal Clock Measurer
+===============================
+
+The Amlogic SoCs contains an IP to measure the internal clocks.
+The precision is multiple of MHz, useful to debug the clock states.
+
+Required properties:
+- compatible: Shall contain one of the following :
+			"amlogic,meson-gx-clk-measure" for GX SoCs
+			"amlogic,meson8-clk-measure" for Meson8 SoCs
+			"amlogic,meson8b-clk-measure" for Meson8b SoCs
+- reg: base address and size of the Clock Measurer register space.
+
+Example:
+	clock-measure@8758 {
+		compatible = "amlogic,meson-gx-clk-measure";
+		reg = <0x0 0x8758 0x0 0x10>;
+	};
-- 
2.19.1

