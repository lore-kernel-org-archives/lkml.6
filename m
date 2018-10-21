Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B8ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1F520838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN/a9190"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1F520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJVCqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:46:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeJVCqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:46:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id w13-v6so616002plp.5;
        Sun, 21 Oct 2018 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/KJRVv0hdo/cpLDuoUFR+NtUH0S1YMHEjIvjB0eomw=;
        b=eN/a9190dtrVKjhR0gJsrNNj3i/hM+Y3hJr3uWWnafK1PYbeCjfnxenqnG7gkUcYn9
         IPKKS/vvoyTaFXJ50joEp/yo4R4/zUSr6IPWdUEM/bAn/mBd2IGwvMp5IGk/9bxLymWW
         KHzHIp3+Sv/k+OYsMRSTSFKGI5+f61Fm0dpVYsOIyoNSYarqUjRseWXTIdfPhd2pJTfN
         2+EcBbzwjAFwKWLt4McdA6IQZO468cIPubmjXNiEt3HWJmONrjvfUhRX8qS3QO9Hq+SH
         Lwy2Z0KneGVznl7dSNkn9gq/CppUVm/QwJtvibKBzqGz4eW8bk9B1ZcqqoRth36fd2/P
         HzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/KJRVv0hdo/cpLDuoUFR+NtUH0S1YMHEjIvjB0eomw=;
        b=LVUA8BvVG/IgQr+6o/BN/Wxc9nHVIqmSthO7pXLeRvu6dxqEH0LRvCYMI+8qASTQfX
         0VDlOk8fpWwapml3iqePoZHeSXA15Nmq3SK5rrOEgwZ8DLSj4bFl+CRo0X1FRfsFyxi7
         mCXiSPOwDFxhdzUyQFmxtrGdbGJxBHmsi5/vGU7/orXHok3E3KFB6j+u3/2VzfFh+EzL
         AYlWLLmOZ3dtfWmAJL2meN0SFfKv47GQxJ/bAWR7dyudhhpbhipjhF10iZf3UDtELatS
         I5DRAlXzqnUQHWGbi//C9T6K6KaBdQ+dUtcVL1aduVQlQ5Ifk7GfnQ4V3WwgaTm+zEXX
         Q1Yw==
X-Gm-Message-State: ABuFfohbOKMxKOzigPiysZ2yALmIpQUzdeUhOcObrN14ej8uPwfhHqqx
        SCI1jczf/6IZQhCQZhD1lN30mEn+
X-Google-Smtp-Source: ACcGV61W6W20yOL1Zy7jxE3biwsEmmLxF+3lU1u/KiDkHsqdhxsCSRnJqF/fbPeU8vPdyDAzTSY2rw==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr42374943plo.188.1540146697146;
        Sun, 21 Oct 2018 11:31:37 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:31:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] Tegra20 External Memory Controller driver
Date:   Sun, 21 Oct 2018 21:30:44 +0300
Message-Id: <20181021183052.32023-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v6:
        - Driver now handles "refresh request overflow" interrupt by
          reporting error message.

        - EMC rate is set during driver initialization to ensure that clock
          divider is in a proper state.

v5:
        - Fixed wrong EMC clock divider type in the "Turn EMC clock gate into
          divider" patch. It is a Tegra's fractional 7.1 divider and not a
          simple integer divider. Peter, please take a look at the change.

v4:
        - Fixed "bad of_node_put()" error which was revealed by enabling
          some extra kernel debug config options.

        - The "emc-table" DT nodes are now parsed starting from the "emc"
          node instead of the DT root.

        - Adjusted code comment in the "Turn EMC clock gate into divider"
          patch as was suggested by Stephen Boyd to the v3.

v3:
        - Handle "nvidia,use-ram-code" DT property, its handling was missed
          in the previous versions.

        - Honor "emc-tables" DT node naming which is explicitly specified
          in the DT binding, also was missed in the previous versions.

        - Two new DT binding patches: one adds the EMC clock property,
          other relocates the binding doc file to the appropriate directory.
          One new patch that adds EMC clock property to the DTS file.

        - Addressed v2 review comments from Thierry Reding. Driver does not
          preserve backwards compatibility with older device tree binding.

        - The PLL_M and PLL_P clocks are kept internal to the driver because
          after some more considering I couldn't find a really good reason why
          these clocks should be in the device tree.

        - Some minor cleanups and fixes in the drivers code.

v2:
        - Minor code cleanups like consistent use of writel_relaxed instead
          of non-relaxed version, reworded error messages, etc.

        - Factored out use_pllm_ud bit checking into a standalone patch for
          consistency.

Dmitry Osipenko (8):
  dt: bindings: tegra20-emc: Document interrupt property
  dt: bindings: tegra20-emc: Document clock property
  dt: bindings: Move tegra20-emc binding to memory-controllers directory
  ARM: dts: tegra20: Add interrupt entry to External Memory Controller
  ARM: dts: tegra20: Add clock entry to External Memory Controller
  clk: tegra20: Turn EMC clock gate into divider
  clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
  memory: tegra: Introduce Tegra20 EMC driver

 .../nvidia,tegra20-emc.txt                    |   4 +
 arch/arm/boot/dts/tegra20.dtsi                |   2 +
 drivers/clk/tegra/clk-tegra20.c               |  46 +-
 drivers/memory/tegra/Kconfig                  |  10 +
 drivers/memory/tegra/Makefile                 |   1 +
 drivers/memory/tegra/tegra20-emc.c            | 591 ++++++++++++++++++
 6 files changed, 644 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

-- 
2.19.0

