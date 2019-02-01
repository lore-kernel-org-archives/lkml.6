Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D435CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F59218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2UMQGp/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfBAM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:58:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54406 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBAM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:58:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so6017169wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJocF0Jbo22IO1ME0IAzs50ImWTx0z6/2nWE1aOgS/c=;
        b=2UMQGp/wdQTfPMj65J4sG1Jt3uszaS9uR8Luk9GiR2+1U0W0VHR7CxVcXz8DXFiFiO
         vMIsC+2EDvHQAj3sZV096K+13GKICypHfm8PE3n65XSCBuCg2l8UoOn/dGIlxIPhrVTR
         9pXFAcHodsAMaUWybgZXfJuK0qy3ALd3QExgpQv2Xsim3QhukNBeXeD2Oy4mVx4i2OfZ
         ur0pF6VmPYK9SExjrmiDf6A33icw05EsHrMe6jaAINK/EyJSB+Ef1sWzKNda7Es3trIh
         sdKrlmYdL90yXdQX+c8a8CIqWEEKVRAQdpduXNlP6qyxML0CYVY6AqrmvlBU2KgHuJ0z
         yTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJocF0Jbo22IO1ME0IAzs50ImWTx0z6/2nWE1aOgS/c=;
        b=kF6WB3Oy6poWRxq8+qgRwPs+b/uRRWxvZq/3/XHmYMTuef0AePrhXyCO6B2sS6A8fx
         uURZfFFO5wMuWsroI2AMRpeJ3V8J07HDhu2AHxHlVgUMgfHmANqxO0WU9xBSHb1CO1bJ
         E0TnsRL6TH1MD69mVqaqRb6Yk53XPYo9e8gS6NlcA3LOnDI6GVd1pDGCN3GeRSPABcp8
         UC4A48aFScSKJU5uqNtb8DIrLaS7p68ZOSpwbNBLsl7DTpEGfUS1Q65I6y+Y3nYxyHDH
         v1r8jiJ1WYjrmJ1KNLJ8JNhKqyneCLNPRbO0UDj+9BscdbMDqKkUR9s76uRoBmcB4Ap2
         r7LQ==
X-Gm-Message-State: AHQUAuaTJ46K2tSTpwLrLpLZm/tZFSaYYqTbujgPMU0jir2mO7lqWRnJ
        bbGE2JPMscwwC5KPc1LM62b3Hg==
X-Google-Smtp-Source: AHgI3IY3chUMWFOccpOEDA94LuKZQ7J2e9+gk15jn/UVqjadzFBC2ni+HopknzEYppWrXps01vMcLA==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr2479868wmt.9.1549025926970;
        Fri, 01 Feb 2019 04:58:46 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w16sm8709750wrp.1.2019.02.01.04.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 04:58:46 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] clk: meson: rework drivers dependencies
Date:   Fri,  1 Feb 2019 13:58:37 +0100
Message-Id: <20190201125841.26785-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patchset to clean-up the dependencies between
the controllers and the different clock drivers provided in the meson
directory. The expected result is that each controllers can pick the
the clock drivers they need, without necessarily pulling everything.

This is becoming important as we are adding more and more controllers
to support new amlogic SoC.

Patch 1 and 2 are out of the meson directory but have been acked by
Stephen.

Changes since v1 [0]:
 * Squashed patch 4 to 14
 * Sort Makefile alphanumerically

[0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com

Jerome Brunet (4):
  clk: export some clk_hw function symbols for module drivers
  clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
  clk: meson: axg-audio does not require syscon
  clk: meson: rework and clean drivers dependencies

 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk.c                             |   3 +
 drivers/clk/meson/Kconfig                     |  84 +++++++---
 drivers/clk/meson/Makefile                    |  27 ++--
 drivers/clk/meson/axg-aoclk.c                 |   4 +-
 drivers/clk/meson/axg-audio.c                 |   5 +-
 drivers/clk/meson/axg.c                       |   5 +-
 drivers/clk/meson/clk-dualdiv.c               |  10 +-
 drivers/clk/meson/clk-dualdiv.h               |  33 ++++
 drivers/clk/meson/clk-input.c                 |   7 +-
 drivers/clk/meson/clk-input.h                 |  19 +++
 drivers/clk/meson/clk-mpll.c                  |  12 +-
 drivers/clk/meson/clk-mpll.h                  |  30 ++++
 drivers/clk/meson/clk-phase.c                 |  75 ++++++++-
 drivers/clk/meson/clk-phase.h                 |  26 ++++
 drivers/clk/meson/clk-pll.c                   |  13 +-
 drivers/clk/meson/clk-pll.h                   |  43 ++++++
 drivers/clk/meson/clk-regmap.c                |   5 +
 drivers/clk/meson/clk-regmap.h                |  15 ++
 drivers/clk/meson/clk-triphase.c              |  68 --------
 drivers/clk/meson/clkc.h                      | 146 ------------------
 drivers/clk/meson/gxbb-aoclk.c                |   4 +-
 drivers/clk/meson/gxbb.c                      |   5 +-
 drivers/clk/meson/meson-aoclk.c               |   2 +
 drivers/clk/meson/meson-aoclk.h               |   5 +-
 drivers/clk/meson/meson8b.c                   |   3 +-
 drivers/clk/meson/parm.h                      |  46 ++++++
 drivers/clk/meson/sclk-div.c                  |  10 +-
 .../clk/meson/{clkc-audio.h => sclk-div.h}    |  16 +-
 drivers/clk/meson/vid-pll-div.c               |  10 +-
 drivers/clk/meson/vid-pll-div.h               |  20 +++
 31 files changed, 470 insertions(+), 283 deletions(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.h
 create mode 100644 drivers/clk/meson/clk-input.h
 create mode 100644 drivers/clk/meson/clk-mpll.h
 create mode 100644 drivers/clk/meson/clk-phase.h
 create mode 100644 drivers/clk/meson/clk-pll.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c
 delete mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/parm.h
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (54%)
 create mode 100644 drivers/clk/meson/vid-pll-div.h

-- 
2.20.1

