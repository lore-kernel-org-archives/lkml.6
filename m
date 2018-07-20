Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12376ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC68206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qUwc5Nbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC68206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeGTK1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:27:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeGTK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:27:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so10707155wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=q9/+2HE4tYFkxtNlSAMJtGlNmdGcT/ar2xUpA5R0Dq4=;
        b=qUwc5Nbkn5FG0HUiBmDsFKSJUmdchf8YnFBg5LSkZDgSlEXNUFdaZ28K/rLOG8vUEX
         uiHmXLcP3frPEPreBZ3gRb5WDFVNgLl9bA1bhhDkHILUQ7krh0dUJfcQDKU+AWNJIBnI
         FxPynb40MiyVqY8wb4X4P5pSdGMXyDkKtbV4ZystCK//h80Qy6YFVXbQGZPrR2C8mrEH
         Wnoe+dLaqHWnr1i3QNixWGo7moAV9y99jNYPY1VPe3TItPSc2oJRzCaVtIuk7qSXL7nT
         nj0PeWRGgHm5JtD5fIw6uBA2h8O73GFU7cgt5ZGWJ6yBlJcGdP9K7rSuCwvdkF23N4Yy
         85Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q9/+2HE4tYFkxtNlSAMJtGlNmdGcT/ar2xUpA5R0Dq4=;
        b=BS8Al4yr3OBtYYxQUEcFrK1jticJePYCzpsIveVyHMPOIc4ifLfu0/ommTlHAdPvot
         zvGurMZfHMIbT6qrk+Ff6US9Depxl3AFWbr1tAEM+ES6cknEcNaCE1sh7ypIh0ctzZnV
         OZ9ekPp/i4RvzkmcwhzlnhrpNjydEjYl4E7YJir3fk0BuLKEi3vTcSzg7KOBPCD6Cd/W
         g3fPKFZe4UfkpKDkALsR81DANFCqbwbLxBDjskNMvOqtBUxjgBWyOUPc5TvFQg+/mCeb
         Ameier0qjGdGj52+6+myb9QrbPwKDW0jmV9P4Vsy+D41VS+nuwuASbyMx0/pro5EqbJy
         MhQg==
X-Gm-Message-State: AOUpUlEWZllhlzooD/kkA8/ucYTtuJkxner3LRE9eymmp1oXSokW6Kib
        IU+xJ+1FPTepB2Ky9eQvy8ZmtQ==
X-Google-Smtp-Source: AAOMgpcTtTuTux4Pyy7oiJ9D2afKcD5elP7ipkWoAncnVTThiqEQ1Bwr/0FH/XaDH0h4ef2h6s98rQ==
X-Received: by 2002:adf:c109:: with SMTP id r9-v6mr974593wre.233.1532079583591;
        Fri, 20 Jul 2018 02:39:43 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id z5-v6sm1917070wrv.2.2018.07.20.02.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 02:39:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: Add video clocks path
Date:   Fri, 20 Jul 2018 11:39:39 +0200
Message-Id: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial support the Video Clocks used in the Display
Pipelin from the DRM driver.
The DRM driver is in his way to finaly switch to the Common Clock Framework
to setup the clock path, this adds the clock entries that will be used
by the DRM driver in a near future.

The vid_pll programmable divider is introduced in its R/O form right now,
but will be extended to be R/W in a next iteration.

Until the DRM driver actually uses these clocks, the Gates are marked as
IGNORE_IF_UNSUSED and the MUX/Dividers as NOCACHE since the registers
will be modified directly.

Neil Armstrong (2):
  clk: meson: Add vid_pll divider driver
  clk: meson-gxbb: Add video clocks

 drivers/clk/meson/Makefile            |   2 +-
 drivers/clk/meson/clkc.h              |   6 +
 drivers/clk/meson/gxbb.c              | 667 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |  24 +-
 drivers/clk/meson/vid-pll-div.c       |  90 +++++
 include/dt-bindings/clock/gxbb-clkc.h |  17 +
 6 files changed, 803 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.c

-- 
2.7.4

