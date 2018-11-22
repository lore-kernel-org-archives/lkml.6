Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B83C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E720659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UEXDe6QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0E720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407536AbeKWIVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:21:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33341 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392303AbeKWIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:21:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so10366683wmo.0;
        Thu, 22 Nov 2018 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9M5DcWvweBjr9MSqSee+Ke/uuzQ3f30SLXtYeUgc+M=;
        b=UEXDe6QItdSuH3bNff1e1akAKk6mkD3tlHnQbqprXE8ssCVhJnqK+hHtK8fvWwWiwg
         IbH+5XXQpOyXfEKc5NJPJTIaMEWsg1yNonm+XSHQVaa8F/5Up8yPlG7w/L0t84gouf/p
         kF4xwl8ROBpFX7z9BzGo+QLuMYoxMQahf42kx196Y16L9qyBimTM5t1YCSGhJpvbAs7m
         dmAh3V8dGN+y4ae2JgqObZZ5ckn6U7zomWYSDlcoV8SFct+apl2QYwvO54DdbkWSzTua
         aBKi0ggHWbNPOqpqALq34JODwpPt616Dqq+EhyJMqR8s3dn+nOs4+dUnW4Ms0uN2kzPD
         Hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9M5DcWvweBjr9MSqSee+Ke/uuzQ3f30SLXtYeUgc+M=;
        b=BFEt+yJ7piS7x9yAPsEJeNImvxO3VE9ccdORcJV49/YtyVTExIHyQdpIATmfnL+qa4
         Q1hKPhBYNSzSBx0CEna9iix9GLAm7TIRakC1Js5Tzm1rlH/e6k8t1jByFf4uWzmmqJsS
         TQi2LPuYfzhPgaL/A+nw9yiDB44nVC6uSDMPJ8G7YLMju4090BUiuko80RwudD4ca/SZ
         t5nM3ngL41ILo9pSKGAoOYWorPL5BwxcYTnwQEV5q3xZwoG/oJ9Nm8VquohtqzROq68i
         NS5WYKiphzRqjo9LQfO/E8UH6RPDF9wtrlVTCyc29KLuL3FPMWhA35wB+iaT5FZq4on/
         0PhQ==
X-Gm-Message-State: AA+aEWZzvYoMKJCTI/po71wUrqnGBn2Qq1YufgMJYsJTnbDJ6a7hWD2t
        KRoA5f0T+Zg3vyghdCvd9jw=
X-Google-Smtp-Source: AJdET5fNiPpDlyTLDu6CgaP3zgmU4rBXdeViebX02cZkJNOM9Yl5k5LGiDklIL0DZ0gpnxw9RM9z0g==
X-Received: by 2002:a1c:cb4c:: with SMTP id b73mr12010713wmg.69.1542922827423;
        Thu, 22 Nov 2018 13:40:27 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id x14sm29755554wrm.65.2018.11.22.13.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:40:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] clk: meson: clk-regmap: add read-only gate ops
Date:   Thu, 22 Nov 2018 22:40:15 +0100
Message-Id: <20181122214017.25643-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the gate clocks are described as "just in case" bits in the
datasheet. Examples are the ABP, PERIPH, AXI and L2 DRAM clocks on
Meson8b.
The datasheet suggests that these bits are not touched. The full
explanation is:
"Set to 1 to manually disable the [...] clock when changing the mux
selection. Typically this bit is set to 0 since the clock muxes can
switch without glitches.".

This adds new read-only ops for gate clocks so we can describe these
clocks in our clock controller drivers while ensuring that we can't
accidentally modify the registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-regmap.c | 5 +++++
 drivers/clk/meson/clk-regmap.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 305ee307c003..c515f67322a3 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -50,6 +50,11 @@ const struct clk_ops clk_regmap_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
 
+const struct clk_ops clk_regmap_gate_ro_ops = {
+	.is_enabled = clk_regmap_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
+
 static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
 						unsigned long prate)
 {
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index ed2d4348dbe2..e9c5728d40eb 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -51,6 +51,7 @@ clk_get_regmap_gate_data(struct clk_regmap *clk)
 }
 
 extern const struct clk_ops clk_regmap_gate_ops;
+extern const struct clk_ops clk_regmap_gate_ro_ops;
 
 /**
  * struct clk_regmap_div_data - regmap backed adjustable divider specific data
-- 
2.19.1

