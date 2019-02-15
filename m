Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8948BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D382070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG5M+idO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393432AbfBOJtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:49:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44728 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388842AbfBOJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:49:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id g2so6688689lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Uzpry+/9Js3eJNlxjo2TetYuAEidr9of5zgup35RucU=;
        b=FG5M+idOiOmvNfstF5kPet1N7Z8YzL6Lh7xtYDwPPvRvawk8KktXZTd2CVVqn3Npnr
         CJsexyeAw3FCybqhKUK63CKWR/JODr91Flq2yS+JkBgTKQS39BAg04fLhLt7YuaUIIYp
         6etmWy++HCdEmH5D5W66U1SiOBmplTgjrYpn6CKnucuNUWrVRKfOU8z2QC1dcAUDeg0f
         o4kQ5CPCziPFumEPAC0x0TMW3wP1XEKD7bMwQvXCdtjN2z+m72v5sht0pTXzmM+XjwyM
         7NXvC7KIxmf3FI6LW0qLUnGnBeqAmeuSTZbOnuWfKP5gHDGsS/B3V51lv4tud7/HHaDQ
         x52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uzpry+/9Js3eJNlxjo2TetYuAEidr9of5zgup35RucU=;
        b=irkFY+aMVTru8ex+Kj6LLQ15Xn3RDIuf60/DXHjt7l6QWXhZ+oE/11/dfjp4yIaVbB
         W+soaLX+Ct3LTZUv2jkwY6F5aCJW2fmW00nigIadp7j9t0Q9VRK3vaD4zDwYmLN8Ryb/
         nQwfsSo4YIIAvjxn7nvU74EVI4Cew8bUPI7YVMoVzMWRjrxbzZ/61Npu7nYHbjSVmizd
         Y5zIiE5P8Kv4/nM7/2EbZpPdaGUpm1HDTYsnkSq+FFvk+V/v9zxbLk8kEhGsnI7T7eYR
         +6cPiqZYWBjMcxSGeK0R4lY35aTd6t89nL15tXDmmE1NW0o7f3m9LYMBbs5+3VoRFrWM
         7cjQ==
X-Gm-Message-State: AHQUAuaCeKOmftcknM5ym0dTYQ0VvTulCUsU1GhztvgMh3SlWP7asQYW
        oh62367dDIhvEVmpyVtPnEF4jA==
X-Google-Smtp-Source: AHgI3Iauj2Eob39lEvFU4HNqBiI0ZCuN4ljVzPsWoA/M3dtnYNEgadVMjpndmRqQjyErOy966b7Obw==
X-Received: by 2002:a19:5013:: with SMTP id e19mr4942988lfb.89.1550224143892;
        Fri, 15 Feb 2019 01:49:03 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id k131sm1184411lfk.12.2019.02.15.01.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:49:03 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc7
Date:   Fri, 15 Feb 2019 10:49:01 +0100
Message-Id: <20190215094901.27471-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc5

for you to fetch changes up to 83e418a805d880a8b18add07f94d19b2a5a80307:

  mmc: meson-gx: fix interrupt name (2019-02-13 08:41:15 +0100)

----------------------------------------------------------------
MMC core:
 - Fix deadlock bug for block I/O requests

MMC host:
 - sunxi: Disable broken HS-DDR mode for H5 by default
 - sunxi: Avoid unsupported speed modes declared via DT
 - meson-gx: Restore interrupt name

----------------------------------------------------------------
Chen-Yu Tsai (2):
      mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
      mmc: sunxi: Filter out unsupported modes declared in the device tree

Martin Blumenstingl (1):
      mmc: meson-gx: fix interrupt name

Zachary Hays (1):
      mmc: block: handle complete_work on separate workqueue

 drivers/mmc/core/block.c        | 10 +++++++++-
 drivers/mmc/host/meson-gx-mmc.c |  3 ++-
 drivers/mmc/host/sunxi-mmc.c    | 26 +++++++++++++++++++++++++-
 include/linux/mmc/card.h        |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)
