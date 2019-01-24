Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A5C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908F821726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K75Pm7fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfAXT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:59:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40586 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfAXT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:59:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so3378948plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu9TACan5B/DOcFtXC5jyd98RZPdMTDUQnY8jPCFqPQ=;
        b=K75Pm7fc1DU+mfT9d4Io0qXsbW/bnuhvf1mUe8L1I7PT882iEZf4T/DHGWXa14ojDn
         vmZejAqy/j877ueH7XznRHw5FvsmtO0wYwrr8bzlh3KY3A9LOw8k+fVVzPdL+MuVgBR0
         EWa6Jm/r1MV/s6SG+5tKxvNyWEhBvexUuxZcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu9TACan5B/DOcFtXC5jyd98RZPdMTDUQnY8jPCFqPQ=;
        b=AN0rd+OaPSFx+iBcdzCmE8U/RBZal6bKXRcXLyu1SscAfGlj6VVcEeIzVGCgHDJ70I
         jGhaFoxjBhAXfGFwix+B2nEPGlX1UbPfluUW9nK3FFZnnDO+4xOmnJKUqeg+J1bZCXlo
         yHm+MeiPHE2jN1eX0SSUg7dVmR4KYbJrT9P90h0FQHOweDes8KHZxueYXk9Y7JQdA+Zb
         dYeys67DYK1wiJP3xelCuSibBdkAGi0j9XKiPJMluDlXJrAV2m9+Q5lZcwzWWmBGPHkr
         iJjjCT/fAqPOZmoMlh8IL9TQ5HLZc0KAuZaKRu9WPi8UBehWqVwi/wH4c9PSi6jbL+pB
         T7rg==
X-Gm-Message-State: AJcUukdkGn6hc6Xw4Fjq2cJ3va2y3Ta6bWRn1FQeABL/onIaE/yzTBVB
        5VaYLtZcITE8dZfjwXFoAPGXSQ==
X-Google-Smtp-Source: ALg8bN4AIIreI3usHTCXC4Y+jWxwZbpBisd2jm45fBSoZpaIjRI/Zz60hUXWrRxkojSHxgfzXxmH4A==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr7937832plr.15.1548359956988;
        Thu, 24 Jan 2019 11:59:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:59:16 -0800 (PST)
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
Subject: [PATCH v6 00/22] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Fri, 25 Jan 2019 01:28:38 +0530
Message-Id: <20190124195900.22620-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is next version changes for Allwinner A64 MIPI-DSI support

This series grouped the changes from previous version A64 MIPI-DSI[1]
along with burst mode[2].

Though the series seems to have more patches, but all patches are ordered 
in a way that the review process is as smooth as possible.

Overall the series is grouped into four different sets to support three 
different panels types that can fit into the DSI controller.

set:1 for 4-lane, burst mode:
- patch 0001: 0009, DSI controller changes that support burst mode.
  all the patches fixed the previous comments along with proper commit message.

set:2 for A64 DSI changes:
- patch 0010: 0011, PLL-MIPI changes related to A64
- patch 0012: 0013, VCC-DSI supply change on DSI controller
- patch 0014: 0015: dt-bindings patches for A64 DSI and DPHY documentation
- patch 0016: A64 DSI pipeline patch
- patch 0017: Overlay patch that enable Feiyang FY07024DI26A30-D burst mode
  panel on Pine64-LTS to validate set:1 changes

set:3 for 4-lane, non-burst mode:
- patch 0018: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
- patch 0019: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211 
  panel on Bananapi M64 to validate set:3 changes

set:4 for 2-lane, non-burst mode:
- patch 0020: 0021, DSI hfp and hbp timings fixes
- patch 0022: patch to enable Techstar TS8550B panel on Amarula A64-Relic
  to validate set:4 changes.

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

[1] https://patchwork.kernel.org/cover/10721509/
[2] https://patchwork.kernel.org/cover/10686655/

Any inputs?
Jagan.

Jagan Teki (22):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: sun6i-dsi: Add A64 DSI compatible (w/ A31 fallback)
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  arm64: dts: allwinner: a64: Add DSI pipeline
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B
    MIPI-DSI panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |   5 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |  39 +++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  43 +++++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  39 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  47 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                |   5 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 165 ++++++++++++++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   4 +
 12 files changed, 337 insertions(+), 16 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

