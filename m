Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7220C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974B02086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UMMzB81N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974B02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeKQHHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:07:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38595 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeKQHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:07:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so22161148wme.3;
        Fri, 16 Nov 2018 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwgHD3GzCpN8C5gWB8wlgvdn6/WtaXNenFgpeF3qTMU=;
        b=UMMzB81NeV6KqJKwBv4MMog5o8kRa9LEnOzUji2gNk5aqmGx0ecnXB+P9HKfqaPgqT
         F1kiUynxJ6DulpE786NXLdn8FHnu7O4G1ytBihKdWZ8wfQ0YbnKo0mBQz7JA643FLOJ1
         NC7GuaRidetaR9DX0LXUA6TzYuMMX9DiuLlYnDd2iKVPwvKuz5Cmq1oQUU6nCS42Wqt6
         Ny3EpdsWnMSdF90yXlhlUih0f2RvUO5ADRkszA0xOr9xou0MJ4CYjyMHorT4fpTXihyb
         9jhd8eILQAYyRYFJf2EcI+ieYYA2yAkSs2llDs9gHxk6CjwBdbWMENN7v1+YaeAzUhM7
         +jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwgHD3GzCpN8C5gWB8wlgvdn6/WtaXNenFgpeF3qTMU=;
        b=kE/18Evz76Xz0wGnyR2lI43iBtqET0iDY9GZUNp1N4CTQEMNbtm59Pt8E0V9eoROQR
         Yqp89/WS8ymiKfmR/SpmzDR5NjhkVX66CyjHJz1/2YIZEslXAxHPonvWS5iX2+yZZDsJ
         qx5maxP+sIX5qahg+LcMyrMawZRGFyn2kzBlG2jb8Z7FSFotrJ5EsXrBxZMY9CZmjQ91
         ppBC4fLs6NRUsWYPfDD18CpkXkrmuQSlSdH4tf6ccQ8Vah3Bqc/+/XvPzOahS4ALOJ8S
         z1JdCF7wuVHJ1sG725MEE0naVqiX/pR1dOIedkeszzZvVl/TnITyEvoejaaQoDK9v3Je
         iUGw==
X-Gm-Message-State: AGRZ1gKTXtltzQoZE41HJokxIktFreIDRl8csvyX8waltwvZNwJ6In7q
        YebYf/XDQFK4HAaFzmYlDyY=
X-Google-Smtp-Source: AJdET5drZM5ObD0OSYx1MLRPW9ct2JnNShscBOcC9dNVlCZLk8ELWlJrj9fp6HuO8XTm5jM2KIoIBQ==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr8993214wmd.29.1542401614498;
        Fri, 16 Nov 2018 12:53:34 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id z192-v6sm16610273wmc.37.2018.11.16.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:53:33 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] dt-bindings: clock: meson8b: export the CPU post dividers
Date:   Fri, 16 Nov 2018 21:53:01 +0100
Message-Id: <20181116205303.6354-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four CPU clock post dividers:
- ABP
- PERIPH (used as input for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Export these so we can use them in .dts files.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index a60f47b49231..5fe2923382d0 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -103,5 +103,9 @@
 #define CLKID_MPLL1		94
 #define CLKID_MPLL2		95
 #define CLKID_NAND_CLK		112
+#define CLKID_ABP		124
+#define CLKID_PERIPH		126
+#define CLKID_AXI		128
+#define CLKID_L2_DRAM		130
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.19.1

