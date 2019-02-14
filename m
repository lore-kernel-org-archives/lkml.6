Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D808C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613B21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HtJqKpbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbfBNT0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42130 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfBNT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so3540246pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOWbOJz+q7a7Braxa6vSetV3DpRgUUln38aLV0BLFss=;
        b=HtJqKpbYpg8zKfhZ+PlLnTp/nVesVjTYGFOfafcc8PKPURO/GpUgkl01uMeHQIToDk
         ySlNaTOET+J7KmWBw29ZXEsZSmaE8rJBTwdUeTOhB34kJ/bRp9vwxxtNxwZsyJG54Ur1
         NkRXtan25VfunuZmxfAzgnipZTUUBk0VDIXkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOWbOJz+q7a7Braxa6vSetV3DpRgUUln38aLV0BLFss=;
        b=EkGkwIGFz9AMlnUNYWWvLk/bg1+9b5INiclYMiUK5pbDzxcepXRnQS6PQSTSNFabL9
         e8nKB4b1+ITI1ERdHc/FV2eOyPd8xuCa19s/npekXyBX2xZj041pw0SYEdMfa++RENp4
         KjPWO7vFkqeTLgUmSIVLDUD6n2VP5epsPFWtsInpAxMTTL2zLLj3LukguAVPhp4S2SOR
         sCEMHge3UZJduQWoNPnr7qleyU9zyKry59r4D79ue+GmJpJi4ayOAwHdKIQOfd2AuSlV
         Mx/TbmyWTxdq3LIYbsO2KMVPFc7kklljdAdjCFf9uzZyYJmlKBXnKzh0v4nMqhsZ6JVi
         hyig==
X-Gm-Message-State: AHQUAuZ55sR0o3mthj3gPzYFgdeM3yD9FBFtvTb0ocOTdt3zDfR/AaUR
        65F8I/S1pUhfP+FNNGj0t786OQ==
X-Google-Smtp-Source: AHgI3IYAFdoACBkxxZtv4EqVv6H5LD9pY1Nr6f8iwpffWOJ3mPN4W0siuDeuZwFJ2BQx1weh11akrA==
X-Received: by 2002:a62:864c:: with SMTP id x73mr5752695pfd.49.1550172365429;
        Thu, 14 Feb 2019 11:26:05 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 0/8] drm/sun4i: sun6i_mipi_dsi: Random fixes
Date:   Fri, 15 Feb 2019 00:55:36 +0530
Message-Id: <20190214192544.7314-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes are encounter in Allwinner MIPI-DSI driver while adding new
SoC support and ofcourse all these are generic with respect to controller.  

All these changes are grabbed from previous versions[1] and grouped it in
a proper order so-that it can help to review and merge easy.

Changes for v8:
- rebase on master
- rework on commit messages
- rework video start delay
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
- use existing driver code construct for hblk computation
- create separate function for vblk computation 
- cleanup commit messages
- rebase on master
- fixed checkpatch warnings/errors

[1] https://patchwork.kernel.org/cover/10680247/
[2] https://patchwork.kernel.org/cover/10680247/

Any inputs?
Jagan.

Jagan Teki (8):
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 ++++++++++++++++++++------
 1 file changed, 52 insertions(+), 13 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

