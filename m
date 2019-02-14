Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19177C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8226222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LXix7LMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436517AbfBNTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:32:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42342 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389635AbfBNTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:32:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so3584458pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZL+CSDR6gHJLSLkIhVG72Bv6twb5BsbEPP+vcprd2o=;
        b=LXix7LMmfq5hGoeLnzxUxHoG533C7LuIgqDL7NApe5c+M+1Uc1ynmH6s5H3b+AQ195
         oWYIeUgb4+PqwiXn+BkH+KNlznPKqcf5brlcsdNswCUyT2Gqw/9GnNk2aO2u1KeI9u8/
         jNZAyNDEioj/JaQ+u2v2/0nf0s5qw5UuBq9ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZL+CSDR6gHJLSLkIhVG72Bv6twb5BsbEPP+vcprd2o=;
        b=ifVCv32Cy/zTj3dHcesPPCWzLyJNB6OsU5W93la1WuKYn0Q8jFq4CdZXEpBAissApG
         MyawRaeIBtFVq0Wf1AuQYrjuD/uCbqOMdAVddWs4xodYU+SBNUyUN3hR3Nt3IcDeOBSs
         HniJ9xrDAdht1yspm3IM4pfdbWrVrJTefNj0spsodqin682UjKpwlv8JYihysNreJEs+
         SKonJ2l6X2Xu0Tu63/F7PUOg6UcSFfQ9FCGKMhGQmSmYjvYUO4tMib5ETCuRq7c7RW1y
         C1yBYQyZiUE5U4yBATpRzLJmyHcRz+gXnVUDeHTnn2EKwbqJt0w5HxBakMf67O3d/kQ5
         xMSQ==
X-Gm-Message-State: AHQUAuZgeVZehyrNeVP0vjUwIyElZemQCyY+mcxteUEIdLQFkBJN8SF5
        HU45KhwXPPcAlDES4WYEzx92Fw==
X-Google-Smtp-Source: AHgI3IbV+bc8nAxVayJcVao6/02seww1jKGdVVMBFBYG8yi7ZxWKrnPjnOexYpCyI6YSZIosvpTPHg==
X-Received: by 2002:a63:2e06:: with SMTP id u6mr1471903pgu.71.1550172771021;
        Thu, 14 Feb 2019 11:32:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:32:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 00/10] drm/sun4i: Allwinner MIPI-DSI Burst mode support 
Date:   Fri, 15 Feb 2019 01:02:27 +0530
Message-Id: <20190214193236.7504-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is next version changes for Allwinner MIPI-DSI Burst mode support.

All these changes are grabbed from previous versions[1][2] and grouped
it in a proper order so-that it can help to review and merge easy.

Changes for v8:
- rebase on master
- rework on commit messages
- include drq changes from previous version
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use proper return value for tcon0 probe
- add logic to get tcon0 divider values
- simplify timings code to support burst mode
- fix drq computation return values
- update proper commit messages
- rebase on master

[1] https://patchwork.kernel.org/cover/10792981/
[2] https://patchwork.kernel.org/cover/10686655/

Any inputs?
Jagan.

Jagan Teki (10):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
  drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode

 drivers/gpu/drm/sun4i/sun4i_tcon.c     |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h     |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 149 ++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |   1 +
 4 files changed, 138 insertions(+), 16 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

