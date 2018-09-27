Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27033C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D418021531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BZhVmDCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D418021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI0SHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI0SHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so1776971pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fk58cSXZTK0sAssbOY4VE2UzZCdh2VtQSbb4Fk1bPPw=;
        b=BZhVmDCBpu/cOLTg39WherWiBUE6I4GhV8dT1Rt0KW51XoLNaNELkDUTq0xZs6MOtN
         Y5vtAnLPOq79JjQnKL71+k5roGIy6+STszuunhJk8gOMb2hafWekfksXKMjmWrmY2gPG
         sbZGjrZt3RUSt8VhYf1mqEkCXZyUQJDJgwJe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fk58cSXZTK0sAssbOY4VE2UzZCdh2VtQSbb4Fk1bPPw=;
        b=tSi8xbsGAte85fqR5MNdWTwe0d/7sCjUnsQy2UBNXNAgf5BixRbQVwXJQiWYy6GEZD
         vnG5gUaks9TKcboB/9q6NjD2TAoaqhBxjbDaASJygA5nRJDPk9zxH1wlYO/1NJjHS7sE
         Tf8WtqAQq4X9WRZ+4dNKk00WLNaBQnQbnwB6AiLXZWBsh9NFzolucZjF1ZMXenpatExW
         /E6uWXu5OkNWuoeOJbNL06k4TTYdlNX9gjI9Kh8GKCB0/l2PhMdexvi1Mrkg6RKcr84V
         L7ZK2HkpUJYElJzKdBa2GT91Yi4xWOTf0W2Fw97hCXfrf/zBWpGxdmyK5LIqe5GrpMq3
         LBLA==
X-Gm-Message-State: ABuFfojOeaq5vlwxfspqyaOSFsXGj7r6LLWBeYGr1jjvuK/vFfAN5S5l
        EnhFPfxOkCcugQrYuBSjfjyZ3Q==
X-Google-Smtp-Source: ACcGV62SJhxEAY/YSd58yNgq3ARi2LleHW2CdJBGFxNeS8nNVNL4hE5eg8Z3/LCMZe39UApoo5CbKA==
X-Received: by 2002:a62:5343:: with SMTP id h64-v6mr11043928pfb.226.1538048954532;
        Thu, 27 Sep 2018 04:49:14 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/12] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Thu, 27 Sep 2018 17:18:38 +0530
Message-Id: <20180927114850.24565-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add MIPI-DSI support on Allwinner A64. The same A31 controller
is reused and tweaked for A64 since the register space for both SoC's look same.

The current clock rate (270MHz) with nkm (5,2,11) from PLL_MIPI is unable to work
with A64 DSI block. I've tested with few changes to verify desired nkm divider
values (1, 2, 5) but with existing nkm divider logic(ccu_nkm_find_best) I'm unable 
to figure out the desired clock rate, anyone suggestion please let me know here.

Bananapi S070WV20-CT16 DSI panel with BPI-M64 board works fine,
but will figure out and fix the clock logic in next versions.

Thanks,
Jagan.

Jagan Teki (12):
  clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
  drm/sun4i: sun6i_mipi_dsi: Enable missing DSI bus clock
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  dt-bindings: panel: Add Bananapi S070WV20-CT16 MIPI-DSI panel bindings
  drm/panel: Add Bananapi S070WV20-CT16 MIPI-DSI panel driver
  arm64: dts: allwinner: a64: Add DSI pipeline
  arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel

 .../panel/bananapi,s070wv20-ct16-dsi.txt      |  21 ++
 .../bindings/display/sunxi/sun6i-dsi.txt      |   1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  42 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  44 +++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   2 +-
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-bananapi-s070wv20.c   | 336 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  78 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   5 +
 10 files changed, 522 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20.c

-- 
2.18.0.321.gffc6fa0e3

