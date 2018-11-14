Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E237C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E6C2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K0KMlUlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E6C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKOJDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeKOJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so19128653wrs.5;
        Wed, 14 Nov 2018 14:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fU3iJUznAqxv4GxLIhJ8UE2d70EiTCopB45m9DeqKk=;
        b=K0KMlUlgRJsOMGydt4Q3whagKmW8xgSzC3F0M66q0q168BUD0gxg6pDM5TeFdbEZ2A
         RI5rWFc7cHqOAtBVyj5mnHJpJrHIwiBIpeh/YRK9ZKmhmDLKkc1INvsT6KpOQZl15XZG
         5JiiJh7IVGeyMog+cvBpcazKK2h1V7Gyrq3OFf/c33efZwsq5/g8oWsqsgIsKq12wBhx
         sj5rCmCviC8RYJzc3Z9FigMdZAHAKr7X8S2btZ+g3Bo8c2pbJc4Z/AyBwP7sQNzHPpPu
         VN0/E4Ig0z0jeaDCYTRboTLHkKqi7K3yGNPIDXZgOTAvChB7QrYkkPZLEIpqzvWi3xr9
         48OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fU3iJUznAqxv4GxLIhJ8UE2d70EiTCopB45m9DeqKk=;
        b=CC5TK2x/qxhIfVwk/hAGDR/HjTr0qha6qe4fKoTSpzi5ZR8S4c5IuU3suYwBTtO5LQ
         p8/8ycrtX5mmjnJjAzV+Z0xAfC1iwnNxXbmbEWSIOyDCnzR1llase13RA67KM4cJvJvu
         jQTgBwyWYqGy1c+bi8JmATWYfiRpYZ31u8E4AmafYuoUm4FWQgoe44wEYrpiYO3IbP9G
         FZX29aealvvHZaboyNWVwC0ijA+lSOa6gZ3MzOzo09t9p+CCFrPtjOzdWILAgN46oKG6
         8AHZzeu0MVezd2EjDREec3FP8+ty1jEdRwy6RD4fwhChMAOBghKTHT/LCHhBtpbUxuRG
         Vobw==
X-Gm-Message-State: AGRZ1gITvYIdI0eKenVHMvcFl5BM3XxqNeSayWdDqUP7gImmPnLyw7Xu
        wT1Ec7GWfIYE19Vmyzp+0mo=
X-Google-Smtp-Source: AJdET5cCqavL2fJsvJqkY1EgPSxNlGBLCl/eV2taX4lLg5xIPFUyrTrmnsdtZEAhsvOEhuXGgHDCVA==
X-Received: by 2002:a5d:40cc:: with SMTP id b12-v6mr3812260wrq.133.1542236275263;
        Wed, 14 Nov 2018 14:57:55 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 4/7] clk: meson: clk-pll: add the is_enabled function in the clk_ops
Date:   Wed, 14 Nov 2018 23:57:22 +0100
Message-Id: <20181114225725.2821-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a utility function to check whether the PLL is enabled
we can also pass that to our clk_ops to let the common clock framework
know about the status of the hardware clock.
For now this is of limited use since the only common clock framework's
internal "disabled unused clocks" mechanism checks for this. Everything
else still uses the ref-counting (internal to the common clock
framework) when clk_enable is called.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index b46cca953f4f..65eeae0989d9 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -309,10 +309,12 @@ const struct clk_ops meson_clk_pll_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.round_rate	= meson_clk_pll_round_rate,
 	.set_rate	= meson_clk_pll_set_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 	.enable		= meson_clk_pll_enable,
 	.disable	= meson_clk_pll_disable
 };
 
 const struct clk_ops meson_clk_pll_ro_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 };
-- 
2.19.1

