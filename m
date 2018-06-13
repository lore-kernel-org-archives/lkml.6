Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3AC8EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED08208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MLzk5GRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED08208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbeFMMU2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:20:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42979 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935373AbeFMMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:20:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so2524032wrk.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VXMObLkaRdtZ5xIrVEFfsDP8NaYCnE9HLQjsV/6p7wE=;
        b=MLzk5GRdof6PHZDjr5c6b42CTniqL/DAa+w+uVMEzwlS2aGOc39iyLjNAd7/ZR4VgK
         WDaXWDIRWOjFnmO2xrxjSgLj0a0wmXK1fcY2ufK4cF/pDRDLiUqE7fC5rSN0jFCY5igl
         mKNvmeBjl6Wp8rkZtWxbjCj+wwrYZy9JQyuHLU869VIQZSu4P09UNvWW0ycM8HaNukrA
         FjXIf802h879OQTw3v3VwX/U9CbU26/XTMfLS0JqsWwK/MKOLpjf4h5th7cENbeFZ9fu
         Jw0UuqoNUK+Q6RBkjR+icTntWAxniopQf4ljePEzNd52EjXWaNk+nns95dNysbdE6IYp
         LbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VXMObLkaRdtZ5xIrVEFfsDP8NaYCnE9HLQjsV/6p7wE=;
        b=WX8gAWH8HsT+Er+DN+OIss2TeHWjkqeGItz1U9406/Fez3HxQhmQcCvl2gjp/iznDb
         jt8Vs4v8Mm+GFxn6m+gEBnm7URBvnrXzcg+P4w94hPr9LNgXEPmmV2sckV7vMtP/X/nM
         TKgsnjQEzR3zmDLwjVTl2poP9+hsXiv2hfDIenPseR3trUrAD1yogoKtDhv3pqgyR7uP
         zZEjDNZcw7n5f99CEBljEivmj5P/8hQiRWSKbcm/gPN4KAet0thl7N5hru4zBeTiugNT
         sXeIZivewXF/DxFg3yyDaYj27S9gXIrokyZX6lp4VoBy5d75a84DGoD889vkNeIsZ4hu
         9+2g==
X-Gm-Message-State: APt69E2scjmsPLCtgUyUxoIRRw+5glHcpvcvox/UcRw4NdRpHF7t1jnb
        QLDeapzzCSUg4EriyqKp3JcSdA==
X-Google-Smtp-Source: ADUXVKLthqDp2dg3qYvaRvzpn43+gfXwpq4S72HAe6Oa9UcmlMS1EHbaF69pHJSz3G5UNC41f41YBA==
X-Received: by 2002:adf:a6ca:: with SMTP id t68-v6mr3876410wrc.215.1528892424885;
        Wed, 13 Jun 2018 05:20:24 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g11-v6sm3202829wrr.46.2018.06.13.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 05:20:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, sboyd@kernel.org, mturquette@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
Date:   Wed, 13 Jun 2018 14:20:21 +0200
Message-Id: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
seems to be dependent on the FCLK_DIV2 to be operationnal.

The issue occured since v4.17-rc1 by freezing the kernel boot when
the 'schedutil' cpufreq governor was selected as default :

  [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
  domain-0 init dvfs: 4
  [   12.087757] hctosys: unable to open rtc device (rtc0)
  [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
  [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'

But when disabling the MMC driver, the boot finished but cpufreq failed to
change the CPU frequency :

  [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5

A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
the first bad commit.
This commit added support for the missing clock gates before the fixed PLL
fixed dividers (FCLK_DIVx) and the clock framework basically disabled
all the unused fixed dividers, thus disabled a critical clock path for
the SCPI Co-Processor.

This patch simply sets the FCLK_DIV2 gate as critical to ensure
nobody can disable it.

Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index b1e4d95..0e053c1 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -511,6 +511,7 @@ static struct clk_regmap gxbb_fclk_div2 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div2_div" },
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.7.4

