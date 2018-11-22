Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C60020659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="unhWHO96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C60020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407521AbeKWIVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:21:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37056 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392318AbeKWIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:21:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so10283936wmc.2;
        Thu, 22 Nov 2018 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c35wEySsf8pHFZUenvpaQ26wiyDQ3+mASoSpr1z00aE=;
        b=unhWHO96JHXhR6zCO/TRUi9gnUx205dtNDO6NlEiNLn6dzfSOO9jq48q+r2zdhNiLG
         DFc4AcTx1F3Nz15i+SaBi24K1L55yM61DRKVsofQYLCYT0jUkBDi+0V4zTPdqdKiNgBI
         nt3st8GaRbgOsMhY5wCMXHQpBtfJiQiSQyQlpf+Zvg3aEfyzNYhEQqvuEtbrRqwh3hS/
         KbZICVWgkxVMY5RBM1SS/16Sf97tCJBwLUYKsQnZCjo8BvQ7+umSqc95mkqR5F2l8e8D
         TYkCeEkvKZf841GmXdnSDbzZfYReUiZZ/rsCIADc4putukj7mXasfYcpxx4FQeNTvRLx
         bo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c35wEySsf8pHFZUenvpaQ26wiyDQ3+mASoSpr1z00aE=;
        b=jYAmvitCDcY3O+DuqRlj0PvVTbB6jX21TZHK7vDl5QgS5KoSeg6/CIimmrLUJFLaCx
         dgMCI6KHeiZ25Sls4ZUmcNWUr/aII+sUuczxogfmgkDKjRFGybEbX4MoaB3eWTW4r8qb
         B+Pdy6nZ3pBCB4MhqliKjuqAWvUEvrHXvVKxUs2B0mcSdN6lIG5DGH2fTjqINoVEoaAn
         5rqQhI3Te5M6l5mAtr3nHlUYoB8Tkqxbe4uDRWVvwKRHwFEBikAKoOFMwCc6L/UDsxUy
         menDiYRSQ1VlwZlxDrl9e/KCreosN9deqbE0lGX5IGtCCyKBM1iCFquSLYSxCFcT2UP0
         KeoA==
X-Gm-Message-State: AGRZ1gKZwZcFgNQPd4ZYFrPy4Xi2a71KCN4FclBzmr+FjGQc2KVcXXLQ
        VILepKyjX8Axd5XEYwBR29E=
X-Google-Smtp-Source: AFSGD/XdGcWblshyY+GHZ6J5PRI+qWtybkR9dWixf6Z90dRcmpWAmZjn4/a9x4jdf5YiAtc9G37yug==
X-Received: by 2002:a1c:ccb:: with SMTP id 194-v6mr11794328wmm.102.1542922826150;
        Thu, 22 Nov 2018 13:40:26 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id x14sm29755554wrm.65.2018.11.22.13.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:40:25 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the CPU post dividers
Date:   Thu, 22 Nov 2018 22:40:14 +0100
Message-Id: <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
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
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
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

