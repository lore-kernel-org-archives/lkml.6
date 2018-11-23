Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E0B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U84Y1IaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E0B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502969AbeKWU2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:28:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36289 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502586AbeKWU2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:28:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so2867772pgm.3;
        Fri, 23 Nov 2018 01:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5FHYGIEmtlrZXjtjrZO+iSL71gh3cXK60SvioGzFSG0=;
        b=U84Y1IaANgcHgHDu73NI4/YCnncJzJo32pO59b2JmRUnCrMQ/f2SS10c36G4okyyi0
         qQCmLF8NjBYZtMP8tTxGYRC7ow7LW+6B3UguVnLZx82ysnDxMg64GejXrod490+BGEFn
         6ZgsGx3mdeePwiAcBZTPIofH7sVec1JsjeQDn2wklG9INAyfw9W1qhsN0c8N5PG2iYxY
         7BSHHzI/YOOBP4ZVi9peXNk3lsZ2e3dcEZX/LVtXZwXEVJ2mqtA6ZHIVnSZ6SXiq0fvk
         oKvqo6WL8+4YCH7BjG3yc2UIGiwQM65lDNvJIeo7G7Q2l5iiUUaJ2VnU69cp8dZxURTC
         EJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5FHYGIEmtlrZXjtjrZO+iSL71gh3cXK60SvioGzFSG0=;
        b=eskuTVbbl8oLqkHDyd4tkm+e8+YgbF63yZwDKNRu65nTa1yvww/eEb6IXgSs7NXgg8
         Gct85jIhtLojfcRP0byCR29uU3WQ4w2cd/cFt5vW/d6mADDVMnJyj42O29J77t7xVB08
         9HmtKL/b1eFSHQit9UUN7iSbFu3Z4VthFvN9SWdLwIvSDp7Ib8pWiRFyfNk/C8M9ZFgS
         H6VDGiArLXmFziLl9Uoe91ELehuih4w9BWP5vU6uANNfMP6/XPHRySCPu3RJvM+AKRyZ
         QGoZO1aN/6H+7O5YZHZ2D4wWuWABK/3Uo/nRzwQBiVUX9/JUErH8rckMeEKD2mzleA0M
         8F+Q==
X-Gm-Message-State: AA+aEWZ5z2uqkdb/DREvVUC6iSbOa7WegLnjzgigYrc8VAKIJZBy1Qvl
        +Xt5AGEvxRDCBpYoZbgMDb8=
X-Google-Smtp-Source: AFSGD/XDlWSYHSI5FMbvpoQoqm+ivDPoY0K8VxP3S6xFt7W77SfVvDzVl76joxwz0dIEtVeenjOTJg==
X-Received: by 2002:a63:f241:: with SMTP id d1mr13456029pgk.2.1542966281562;
        Fri, 23 Nov 2018 01:44:41 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.164])
        by smtp.gmail.com with ESMTPSA id o189sm34059848pfg.117.2018.11.23.01.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:44:41 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 2/3] clk: samsung: exynos5420: Add CLK_SET_RATE_PARENT flag to mout_sclk_vpll
Date:   Fri, 23 Nov 2018 09:44:12 +0000
Message-Id: <20181123094413.1108-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123094413.1108-1-linux.amoon@gmail.com>
References: <20181123094413.1108-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows changing the VPLL output frequency through the g3d subsystem
clock tree leaf clocks.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34156bdfd0d2..6bf1b2e89106 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -647,7 +647,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
-	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
+	MUX_F(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1,
+			CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
-- 
2.17.1

