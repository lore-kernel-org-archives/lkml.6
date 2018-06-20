Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ABBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="liXoFx26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5A720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeFTKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:06:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeFTKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:06:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so4996561wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UfJCxoIz0mhDDFNPbe5wyBlsnGtctJC3btPJ4F7FFrI=;
        b=liXoFx26Kc9itPprWM1k7p6DNaNdOngkq/KJW5fywjdFrSJ1zONBdbLCMuCJIecA2f
         sakg3Sgw5/HdN9U1QoEv8usGrB+bOhi8ZS4oi+OtcBmasLcXYO7d1AXyaY9IWSFgwwyD
         Mmo6eozdPcGOvUVulZ7sJPMdnmf6P9G6GBkxXE6fTtR8+4wu7KcRVixjvVoDw8IAQsea
         IV6m2ltijqeGJSe4/+eoUtTL+LNa0fP2Et4EY3h96eEJ4ppb6aH99k+BK1she8xKTr/E
         bCtW2huA3tYOUhCJCOSqY6JGSuhcFtCDit8pr7mxk2rr7ngtjzeJnFKH6yUilCC818SI
         T+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UfJCxoIz0mhDDFNPbe5wyBlsnGtctJC3btPJ4F7FFrI=;
        b=ah4CWYqRoAlDyHRvA/isXndXPRTxbKJhmK50CE7ziNrU9wT57kTPTsPFaD+bZ0xHDW
         JnkL2zB9mjbVP9var8Q8Nt8mvRm8nL52FlMT5kr9ZuxM2XkhzNc3n3XZLv/f7VN0DOIx
         P9QvBJdHvtiIzLclVwrb/YzeLtMDXSmOZiAcFmGWLO66M+wZM/RRNg/vOVp+pxZBBp7H
         cujtGyqF0LfZnmcBUQ7Rv6rYg2V3M/sgKpfQUdGO05aqjuUGpWTkYFGE7thAr0UoOCK0
         an7PvYmrwSjKhxRfYYM3iB54jT9OFUq4i0LWb6066f73Q4On1hSixzMXQgIqQpB+oV62
         EwRw==
X-Gm-Message-State: APt69E1ao/wYPunL1FjeKNcGlSwSfDbZ15U+qgykmcr0mqAyh26LDKYc
        f3Zg+KZxscjwiCebpn2kdr0YIw==
X-Google-Smtp-Source: ADUXVKJ2BJeQVIV6WpkOM4AiRv412P5fey6soJEJHfZ2/SSVg/+DkQkZEd1OWkE6NMaNCXxgnAyoDQ==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr1225764wmd.35.1529489178983;
        Wed, 20 Jun 2018 03:06:18 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m10-v6sm2685852wrq.56.2018.06.20.03.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 03:06:18 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: drop clk-audio-divider
Date:   Wed, 20 Jun 2018 12:06:08 +0200
Message-Id: <20180620100610.29010-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in the commit descriptions, clk-audio-divider was a poor
solution to make sure PLL rates would be high enough while using CCF
rate propagation to determine audio clock rates.

Stopping rate propagation before the PLLs is actually simpler and provides
better results. It also allow to get rid of clk-audio-divider.

Off tree sound cards using these clocks should add the following to the
sound card DT to properly setup the PLLs:

	assigned-clocks = <&clkc CLKID_MPLL2>,
	                  <&clkc CLKID_MPLL0>,
	                  <&clkc CLKID_MPLL1>;
	assigned-clock-parents = <0>, <0>, <0>;
	assigned-clock-rates = <294912000>,
	                       <270950400>,
	                       <393216000>;

* MPLL2: 294912000Hz: 192Khz * 32 * 24 * 2
  used 24, 48, 96, 192Khz

* MPLL0: 270950400Hz: 176.4Khz * 32 * 24 * 2
  used for 5.512, 10.025, 20.05, 44.1, 88.2 and 176,4Khz

* MPLL1: 393216000Hz: 64Khz * 32 * 24 * 8
  used for 8, 16, 32 and 64Khz

Jerome Brunet (2):
  clk: meson: stop rate propagation for audio clocks
  clk: meson: remove unused clk-audio-divider driver

 drivers/clk/meson/Makefile            |   2 +-
 drivers/clk/meson/clk-audio-divider.c | 110 ----------------------------------
 drivers/clk/meson/clkc.h              |   7 ---
 drivers/clk/meson/gxbb.c              |  16 +++--
 4 files changed, 8 insertions(+), 127 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-audio-divider.c

-- 
2.14.3

