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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A16C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF892175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mfwiNurd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF892175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKOJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeKOJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so14580294wmb.0;
        Wed, 14 Nov 2018 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpToRpzBghPIlSWFDMTCMs/livATbaezHsbunO8fvSA=;
        b=mfwiNurd87CBkFA/C87CCGI7bTZ+K1SisLRKZHceabEfVyWOJVuWqtdU8/MlBySqTL
         4R2a/szkUVtkj5akRszQRrIqAanz3qMQzkGbtyei5hzHebjhIVtudzNBGtzNFmTv0e1U
         xDEGax3vKUhrVn+GNGDoEYLn6dPjyzcoCeAwk9VVIRZAyd9I2eY8isqzw9dctG1A8G0T
         DSsn2B5tjrKbOW04DmqCoTkBbB03lJ4wSaYcGBb2Qm/WrGW88OPO/93YpSK4tkUZX1HH
         fCljtvglQKZRGsFD2qjT7xsK8nL39DY4Mstq4P+F8KfAJgkMi+8Qn0QYTwFSs9KRIy9o
         OFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpToRpzBghPIlSWFDMTCMs/livATbaezHsbunO8fvSA=;
        b=CwU7gEIzTdxCLGvoY3C2v6UFRwGmmGtS+yzZLsgOocSX052/xKJtsdGmVgqI0CJFfe
         VRzWcxWzb8lzFu/a4jKwvy/GGiuPXBVFpVeTCxpPSfndfATzYAIC1LR024vvZtCjUavH
         rB+nv0CIf2fv9LXkmjz8GHIBkomJv23QMcXmSuvP4EaYnkn1PbYqMHtG5fl8jOM76Y1F
         viEsnelGnsPkXVAe0egQetIYjoAYa1VpW+hXlU6kkmcY4gq7WwjzH4ogFuPFq6O5jpNF
         PFPCKMK4FaGuOCmS440QC6mytcCkkvCs0hmQrauB+nwsH1B4T+++64e6xLx2YPrBDpOg
         HTKw==
X-Gm-Message-State: AGRZ1gIhN7aApwy/4kk3IFpyOnkMmjNgWjZo6hG+lESAg6hcUh9Zg+f8
        yUcbz+GuYDSYNS4mInot0i8=
X-Google-Smtp-Source: AJdET5fOuZpnAt7CO3ajTrrKSSV+IFgNJfDUQZg3NGopPUo/go919dQlttxbfjiufJQtn9Ky/ZI45g==
X-Received: by 2002:a1c:bb42:: with SMTP id l63-v6mr3292207wmf.32.1542236276292;
        Wed, 14 Nov 2018 14:57:56 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:55 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 5/7] clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
Date:   Wed, 14 Nov 2018 23:57:23 +0100
Message-Id: <20181114225725.2821-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
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
---
 drivers/clk/meson/meson8b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 8a3c346e110d..d566dd5bc567 100644
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

