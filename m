Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4017ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C8D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5NUZwtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C8D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeGXRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45535 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbeGXRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so1948328pll.12;
        Tue, 24 Jul 2018 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tzrW9ejOqpWdsHVHQf74ACgQexq0T9gCeqOrW2WIdFo=;
        b=b5NUZwtLs4mNBfMy5vsgCdW2HMzuqSydnuItm0J4wgYMiytm1l3pXgYPmFFLP1Ashq
         QcLDP6q+p86D9MPudjWllTm5rW5R/GDAKCV1F4kKrlUigFAWuUNTWOSQjW23YuDfXACm
         vBSOLYqUcAwB7u0RN+boj+QBuNfdyHJHQFi3UZAF6CXWZI0I5XWJ4mr+rI044CRQRQQ+
         rM4LvuEse4Ez+fSLkgt3fRReKvYRoBemcgRAXNk7/hfV4DlQhk18dyZ/14dMcsX1zaBj
         fwHR6H6JMMptR94NAitfDAl1j6C0/xsE/oTNIk5f5wTktLODLKDTC8UW9y0Ju+qB/aIs
         1OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tzrW9ejOqpWdsHVHQf74ACgQexq0T9gCeqOrW2WIdFo=;
        b=sT2EvofIZHD0KLc7ot6A53pFRU/gOtt7ozyfaRhhvV/qQCF8LFn6QAz7ldU9PIpyNL
         9Vvtg8MguS2PsQi7SnYzyi7mdAxDM/zg8yj8c/CYDOh4MjJui5Cn4HjxQ32SQCpfsChF
         6wupUXVeIiB3zrLg8FL/p3l81RoR1OJyzLZByIbM7cOuTaXodWbKL1p9wj8vaETgvA/u
         vBX99vqqTnpBMJY9dZNsjnDqg4yHYUwy1fmCyBIx447W8662THJCe1PtfmphFtvxOdGb
         vlr8ynfGyCMlZjiZTXYfnVk46kYpWgCHM0kl19SlqOpk/mlKRbMY2Z+VvDsyHn7CtiqK
         TIMw==
X-Gm-Message-State: AOUpUlF8TGsobY78moF6qoWJe20DqpJSrPqkNbxDUG08pYbJfEIcuvb3
        YwV7PrRqVUcB3UvCcj4vzZI=
X-Google-Smtp-Source: AAOMgpds+NE99mX4LvEp51DIjfLnwJ6NUfJXDwA4IKVRj4+vesoFY9dntGshtyo4GrUKmwVgSENkMg==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr17776045pld.205.1532450575739;
        Tue, 24 Jul 2018 09:42:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:42:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Tegra20 External Memory Controller driver
Date:   Tue, 24 Jul 2018 19:42:13 +0300
Message-Id: <20180724164221.3307-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

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
 drivers/memory/tegra/tegra20-emc.c            | 575 ++++++++++++++++++
 6 files changed, 628 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

-- 
2.18.0

