Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84D12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SHNCJWdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84D12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbeKPIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55132 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbeKPIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so20408343wma.4;
        Thu, 15 Nov 2018 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgKwrWYvBpPwZu+JHqxzLiLOxskcy+PR9OfxhhLd1fo=;
        b=SHNCJWdyrTxI/X9eUqSIzECcQzWO/j6cBNxO5ayG3BjhBzczB7ufloPaBI+32YCU1M
         gmyxghnapEAlt7T5OxhBOrD+4axSydnqulwLBQa0rloZRYCdWse86wX4F1HCPLpzSsMr
         GQoDwXdfqrnt1hhQ5MNeWMlvzsducyPNcqbOb3LVNmVC/GiUz3PJqRxC90PwMJtvt8BB
         e34zQ8KuxtS3ugMTsgVhrqaeWp5RR0n8vFpNLqU0zPpcMyao5kAqrIaq5vYk9T69cTiE
         1nCnpPA9KUSPjEPEjT8So2ZisqKhJQLvO61b6s+DoKCy+5TeaiIomH3+h5UOLS4m6aEF
         desA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgKwrWYvBpPwZu+JHqxzLiLOxskcy+PR9OfxhhLd1fo=;
        b=N1z3h6lQixAZfURebr5oSOfvD2GUZoYzLFcV/sMEF06VKPE4b9a+7qvhNSAuWmoRkD
         6I6aaw1oENW8l/KkcyXD1pE7/PF9sF6dspAw/X4N9QbEIFeYGL08621ND/uQW8E1t5BZ
         cUuDaFBbSjhv1pHSoleyeCRGIJwFsVREQjBqjwNwEgQqx3huaLUvscjn+vmXzLDX92ec
         TLC/bs5KPPkfG/tks/HukKdCQSntOjOo4B3FsQqigaQ4wMX6120EGj675zpRh9EhOm8b
         M3DvWKy+VEHJtp5KWTDzc2Ye6Ngu1bznwG64uFs1z/mnmIBw366M1EfuJryfQvxHWKdN
         TSzw==
X-Gm-Message-State: AGRZ1gJaFlciA4NZCJb3d5biL9CWABjdOtB5WV/iohv1cwZ2/FgCV1F5
        NIHE4reTY/IWTOS+ReXEn1M=
X-Google-Smtp-Source: AJdET5cPbHQqh4dqF/sRbQymwaCkpgtWXSON8bLvuhgQinRizG3akn8pQbQXPvi+SP3Rez37ZVRkVg==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr7004135wmb.145.1542321678962;
        Thu, 15 Nov 2018 14:41:18 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:18 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/6] clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
Date:   Thu, 15 Nov 2018 23:40:45 +0100
Message-Id: <20181115224048.13511-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want the common clock framework to disable the "cpu_clk" if
it's not used by any device. The cpufreq-dt driver does not enable the
CPU clocks. However, even if it would we would still want the CPU clock
to be enabled at all times because the CPU clock is also required even
if we disable CPU frequency scaling on a specific board.

The reason why we want the CPU clock to be enabled is a clock further up
in the tree:
Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") the
sys_pll can be disabled. However, since the CPU clock is derived from
sys_pll we don't want sys_pll to get disabled. The common clock
framework takes care of that for us by enabling all parent clocks of our
CPU clock when we mark the CPU clock with CLK_IS_CRITICAL.

Until now this is not a problem yet because all clocks in the CPU
clock's tree (including sys_pll) are read-only. However, once we allow
modifications to the clocks in that tree we will need this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a96bfee58a61..41a5025364f9 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -646,7 +646,8 @@ static struct clk_regmap meson8b_cpu_clk = {
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
-			  CLK_SET_RATE_NO_REPARENT),
+			  CLK_SET_RATE_NO_REPARENT |
+			  CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.19.1

