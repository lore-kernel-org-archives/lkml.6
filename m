Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C55C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1767220855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hEjORLL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBAPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:42:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38809 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBAPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:42:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so5388186lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A22uir81fxgwqEF4Bedd0Q+/lE3uOtREaGIRzGAGHUs=;
        b=hEjORLL2y5TjTB/m2fJdJpsIyDbmYRwajPlQ7vKMfRlK7+1eBUKWAE2OttAIF/8kKL
         n5KCQAjNCISCXZDpN5Vq7Ovm2ULvl2uWPZrRIN+oU7ZSCsHffP4mMwUjyv1Dory3QGnI
         hA6+T5ET+tuWihP1BBOQ+ewcRiQMJgd7/2a+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A22uir81fxgwqEF4Bedd0Q+/lE3uOtREaGIRzGAGHUs=;
        b=iZi24LvxPWsNdbtufVaoU+P05n/wrB7vpowIvZjkmvuefmnH+RV7GauEHGYQRzXFpM
         aYmEajoWoCNaK3+w3nOqNXyeQ6yPFiQ/GTjD39lj/NmIGQy07VMAIgD33SNYKQQTl/z7
         phpXFUdvvgpB9pSDMoi/176Ms3Wsuj6POMpRUDfEjauqiqhnRIEXVO7pbzdnvtZIWxJi
         cgw8/zPsBtvapw5RWw000jkgNKwyJ/BUHrRQLowvevOJN0B7ENisRVImwxp/UEnsICQQ
         9x8H4fNnLTWL4KM2w/2hM7gMFDruFHDNX0F+APvT6OI8+0QhOZtOOlsDvV8PbllHhvxX
         mvGg==
X-Gm-Message-State: AJcUukdOAwB5MtbngzvISJr8RW/YRxzq52B7/OfzUGk6WuN40G813d7W
        Okb5LnzZf4Tbs8LfhYztNpv6PA==
X-Google-Smtp-Source: ALg8bN5ZFP/gtsrvDiurWLzzUmGkalMbM7MYMtZ9gIb04Cqd7oZwM2kFyc9ClfxRUh0a3qt+n7HpGw==
X-Received: by 2002:a19:7018:: with SMTP id h24mr30782283lfc.162.1549035764223;
        Fri, 01 Feb 2019 07:42:44 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:43 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Fri,  1 Feb 2019 21:12:09 +0530
Message-Id: <20190201154232.10505-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is next version changes for Allwinner A64 MIPI-DSI support

This series grouped the changes like previous version[1] with different
sets to support three different panels types that can fit into the DSI
controller.

set:1, for 4-lane, burst mode support
- patch 0001: 0009, DSI controller changes that support burst mode.

set:2, for A64 DSI support
- patch 0010: tcon dclk divider computation based on A64 BSP. 
- patch 0011: 0017, Allwinner A64 DSI controller changes.

set:3, enable 4-lane burst mode panel:
- patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
  burst mode panel on Pine64-LTS

set:4, enable 4-lane video mode panel:
- patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
- patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211 
  panel on Bananapi M64

set:5, enable 2-lane video mode panel:
- patch 0021, 0022: DSI hfp and hbp timings fixes
- patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic

Changes for v7:
- moved vcc-dsi binding to required filed.
- drop quotes on fallback dphy bindings.
- drop min_rate clock pll-mipi patches.
- introduce dclk divider computation as like A64 BSP.
- add A64 DSI quark patches.
- fixed A64 DSI pipeline.
- add proper commit messages.
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- dropped unneeded changes, patches
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5:
- collect Rob, Acked-by
- droped "Fix VBP size calculation" patch
- updated vblk timing calculation.
- droped techstar, bananapi dsi panel drivers which may require
  bridge or other setup. it's under discussion.
Changes for v4:
- droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
  nkm min, max rate patches
- create two patches for "Add Allwinner A64 MIPI DSI support"
  one for has_mod_clk quirk and other one for A64 support
- use existing driver code construct for hblk computation
- dropped "Increase hfp packet overhead" patch [2], though BSP added
  this but we have no issues as of now.
  (no issues on panel side w/o this change)
- create separate function for vblk computation 
- enable vcc-dsi regulator in dsi_runtime_resume
- collect Rob, Acked-by
- update MAINTAINERS file for panel drivers
- cleanup commit messages
- fixed checkpatch warnings/errors

[1] https://patchwork.kernel.org/cover/10779893/

Any inputs?
Jagan.

Jagan Teki (23):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
  drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode
  drm/sun4i: tcon: Compute DCLK dividers based on format, lanes
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B
    MIPI-DSI panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |   3 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |  39 ++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  43 ++++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  39 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 ++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   7 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 210 +++++++++++++++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   9 +
 9 files changed, 367 insertions(+), 29 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

