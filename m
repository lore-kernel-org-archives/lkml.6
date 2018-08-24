Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0346C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FBE21710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC1FLX8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FBE21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHXMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41234 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeHXMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id p4-v6so850890pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f/whnT45VLYYT7w6rFBlzxRiuaWu7shxKSHq6DL46Lo=;
        b=QC1FLX8NO+5Z5Qx4mk2qc2OYS/dPke18g604agAfWM8KHjicg8oxmog4sc0LIQOy+p
         uxORZiwVSpvou8xnClCjeXyG5MDXN5oXwj2QUd0UKlN7Knf6p3Nr3W29zN90d5DzZXCL
         whquSrHXHlpWrkvkRzNqunFjWQaXKVWFi4sII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f/whnT45VLYYT7w6rFBlzxRiuaWu7shxKSHq6DL46Lo=;
        b=FDGd3QRW65/6NOglS8Nc6m/H7KoBV4prdXmO6VjsGNaHE1ZQgMMOeULIkPm7T9eVl8
         xKcyLBeKZNN+mu9n//sIvtXgHhyP7zgoy7SzezEIgSSKHng74YWwK3U1NR5aBSWD3obe
         aGD8ScwkgCxQR8kipVuqofyoOv5M6NdzAT10yIkO1b89NAjvA9p7pPxWIGXiszaYzDsk
         b+F63SDc6Djs8SYwniW6JLPnCk+ei0F/aL3XzUN6THxVHIaLX/jJLfz7Q7dnrotQ9hhr
         R0Z9kIjcvMXJHYat7V/cL40cZlbJ6ZifHqmdeDsgVxzqU0eJ0SYjpe/OEOkej27p/FEi
         mjyA==
X-Gm-Message-State: APzg51C/Cf77dVzdM2ITN8KjRHhukVP5uVuSYr/+Y8pOWKhDYyb+p7ia
        B2V37Nx7aglHjr366nAmqLeJxQ==
X-Google-Smtp-Source: ANB0VdZCabWDlP9qEEmSf1dxbCk/NQ4AHBBc1ktAG8lcJgLIExw+rg39lZqjQDlmFrisNq/CfFh4kQ==
X-Received: by 2002:a17:902:7246:: with SMTP id c6-v6mr909938pll.38.1535102444372;
        Fri, 24 Aug 2018 02:20:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:20:43 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V6 0/9] mmc: add support for sdhci 4.0
Date:   Fri, 24 Aug 2018 17:20:19 +0800
Message-Id: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

This patchset is based on the unmerged patch: https://lkml.org/lkml/2018/8/20/140

Changes from V5:
- Added SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT;
- Removed sdhci_enable_cmd23();
- Added setting SDHCI_ARGUMENT2 for CMD23 in v4_mode;
- Clear SDHCI_CMD23_ENABLE when not using CMD23;
- Moved disabling auto-CMD23 to sprd sdhci driver;
- Added sdhci_sprd_request() function to hook to mmc_host_ops.request.


Previous patch series:
v5: https://lkml.org/lkml/2018/8/16/122
v4: https://lkml.org/lkml/2018/7/23/269
v3: https://lkml.org/lkml/2018/7/8/239
v2: https://lkml.org/lkml/2018/6/14/936
v1: https://lkml.org/lkml/2018/6/8/108

Chunyan Zhang (9):
  mmc: sdhci: Add version V4 definition
  mmc: sdhci: Add sd host v4 mode
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: Add 32-bit block count support for v4 mode
  mmc: sdhci: Add Auto CMD Auto Select support
  mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
  mmc: sdhci-sprd: Add Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 485 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 225 ++++++++--
 drivers/mmc/host/sdhci.h                           |  23 +-
 6 files changed, 738 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

