Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE0C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229252245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KE5OgF0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229252245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeKOJDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33782 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeKOJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so14580199wmb.0;
        Wed, 14 Nov 2018 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9XbLDddSRNz8Pp8GKo015RHTfUcwsMZBJji8p3sH4I=;
        b=KE5OgF0oygUDEZtDLffHBW4PRmIGWH6ysVGZYdttZh2bDOrS6CBlrk+Gy9q8hAZQTH
         LUYbhqkvAwJ8NKYgqRPUdRRjE/Jk5qhn8+ypFINADAXxTKKc4gePb9LU/cTROQCT1vxr
         EPtThUNdHwZ4gLdmSo5gjQq8noNaTVCo3MB+h7TSfNkTlBO8geeyizwmAwzwFU5JWsvL
         FfdAlTKDeSfAGQVXe36MQ9XVC6SbEYEu4llXhQoek0hQ3OZKuHBCZOxMRw8uHwO/9ykI
         yfcQYAycTtJgSna0xM6JUGmcf87ARIe5v9zwPZi/C22c9KgvKetzjjl9wNLkBznXlImD
         C//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9XbLDddSRNz8Pp8GKo015RHTfUcwsMZBJji8p3sH4I=;
        b=Cdhd9BNmsopb/cawsM3tTZXx527K5gdl6yc3PCKs0NzpERB+GLK0a0a7qS9pzFr07s
         orVhAtVXSVAs8M82DxwYk3K1EzmHW79UAT+gMsTAuuyNUA5Gomr92RWz3ZZZ1OTX+RI9
         nHOM2YASMGheZ7MEjvB5+Ad0eOZ8DEDBkAtAUFmU9nmYZ2FIulPvXNAAGvXhW4q5cOr3
         cWuyF5cF9oFQYqnOIHgYUG8sYXgJsa2COUrWheBwqc63FY5QmaosPjEjzZJUqs1hBeQI
         bH2S0WqPvwZ4/xs3pkgIkw0oNxKe+bomTJcb0E9DHSoDqcKr3NIP2/rDa0ZZ51Dc+mko
         iqnA==
X-Gm-Message-State: AGRZ1gKQiZw/FMxjtM3n9vD5ym9Jh8MZwB57g2SxmP2VsHGiRGjIEOAQ
        KX5xpIHJzLT0saViMZy/eig=
X-Google-Smtp-Source: AJdET5c4on8n5X2RSehY+5ikgJJ/wFg/MLTQkrjIZIyFjjlkIITTdMqbDtiMVTN3QT5otmflXLjaJQ==
X-Received: by 2002:a1c:d0cd:: with SMTP id h196mr3535898wmg.13.1542236272737;
        Wed, 14 Nov 2018 14:57:52 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:52 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 2/7] clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
Date:   Wed, 14 Nov 2018 23:57:20 +0100
Message-Id: <20181114225725.2821-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_div3 clock (cpu_in divided by 3) generates a signal with a duty
cycle of 33%. The CPU clock however requires a clock signal with a duty
cycle of 50% to run stable.
cpu_div3 was observed to be problematic when cycling through all
available CPU frequencies (with additional patches on top of this one)
while running "stress --cpu 4" in the background. This caused sporadic
hangs where the whole system would fully lock up.

Amlogic's 3.10 kernel code also does not use the cpu_div3 clock either
when changing the CPU clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 40e77fe4ba7c..8a3c346e110d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -608,20 +608,27 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	},
 };
 
+static u32 mux_table_cpu_scale_out_sel[] = { 0, 1, 3 };
 static struct clk_regmap meson8b_cpu_scale_out_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL0,
 		.mask = 0x3,
 		.shift = 2,
+		.table = mux_table_cpu_scale_out_sel,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_out_sel",
 		.ops = &clk_regmap_mux_ro_ops,
+		/*
+		 * NOTE: We are skipping the parent with value 0x2 (which is
+		 * "cpu_div3") because it results in a duty cycle of 33% which
+		 * makes the system unstable and can result in a lockup of the
+		 * whole system.
+		 */
 		.parent_names = (const char *[]) { "cpu_in_sel",
 						   "cpu_div2",
-						   "cpu_div3",
 						   "cpu_scale_div" },
-		.num_parents = 4,
+		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.19.1

