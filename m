Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43797C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144F4218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EvH0kx6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfBAM64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:58:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35440 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbfBAM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:58:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so6179753wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxiL0ybfHeOFIjwNJisaDSjhHM5fwBbvxrHh17glkpo=;
        b=EvH0kx6NzUysm5g/OyjTfpqeD0GnPwARjW6io+ERpbh2QyFfQmh7Cn3kV2aBhDE9nS
         PKOWv/E60KLEhInMo63S9dDv3hSxSIhPK9KIolcvNUpf65A0ECZ92ytm2L9+6+oiD03x
         /lpXe2uzD3PpkHlKOEUfb9JOpfo3QtZmxU1MVh5ay4iI+L7UbCsHxPcj7ODh4Vg0nkHa
         vJHe69/kyk684oKZcZ5hYp5RDBdV49NJsAoyt2HixQ4AyfcfhcV3klOj1qx/iw/Js9rP
         Pvv5KJiX+aRSydqhOEpvpfC7w2WTjEMRbdgQj4xeXjGBthIKVXI0h8vGlCp/fc9QXre5
         R0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxiL0ybfHeOFIjwNJisaDSjhHM5fwBbvxrHh17glkpo=;
        b=GjkFbr6/bfURjY1LxnKtg/6XelOl7OEjO9Q/3+79/oSINsnjgCUW9NIaLHVXOTA2xv
         JLR326AI9RouwxQcIGjjbrPTsk/8+DDdVt90J6X2B1kWVCdTkyxxfBt7buSuTpUkENVt
         2WhzG1tZh80/KJ7IVBDKep9ziX4fzrRPOcyCvqevzLOwE3o4dwGxNnjyVfDmtzngpBMg
         cbtWAob4xnbbQsfiib/zCiTi/szZ9AtihvIUmkkRbpiEHpf4P56xgPGCvzqx589/Smog
         z2mFZsReN3RnuojJE1WNMdYMJk/U+aHRKitKs1roSckTBsXZvcY2Ql0nNwUhM+7kNwkG
         6Plg==
X-Gm-Message-State: AHQUAuaaadWu2WldQSvZ+ZvrTwUgHw2KzVVNQX7oTL3+e+CpvJT++F+A
        pLDyofWlwzZgE8gaxveV2J9DhQ==
X-Google-Smtp-Source: AHgI3Iaqd7wlIJoDhSsf/qPPHdLn8s4GYcdwmD2BRthRXsDRPsH/3S1SbyGD6WMUTGopt49vdm/xSA==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr2439120wma.85.1549025931524;
        Fri, 01 Feb 2019 04:58:51 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w16sm8709750wrp.1.2019.02.01.04.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 04:58:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] clk: meson: axg-audio does not require syscon
Date:   Fri,  1 Feb 2019 13:58:40 +0100
Message-Id: <20190201125841.26785-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
References: <20190201125841.26785-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axg audio clock controller uses regmap mmio, not syscon.

Fixes: 1cd50181750f ("clk: meson: axg: add the audio clock controller driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index efaa70f682b4..2479dab09d70 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -50,7 +50,7 @@ config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
 	depends on COMMON_CLK_AXG
 	select COMMON_CLK_AMLOGIC_AUDIO
-	select MFD_SYSCON
+	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
-- 
2.20.1

