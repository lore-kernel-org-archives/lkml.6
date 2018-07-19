Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F79C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387832084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fke954JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387832084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbeGSOFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40756 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeGSOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so7452849ljc.7;
        Thu, 19 Jul 2018 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MnzjYlrH9DudEx4Y6CDcuSq2nPn0jDnTQ9CabFBeEdA=;
        b=fke954JRAUqwURp13ZzWcpeRdj5BOdiKRQfTEKzcpJN5VLraqLcWRSekHawmwzzXQL
         8UgyJxoxhkj9UfLtt76eWLnl0Vbte+ZaKiJjNHDhOEocdjM8lYHsBNE9YXekA6q02YrU
         YqTLK0L7JqbVXYKq/50TJK7H7JzzFrzvYWMYg6VXM9nEM2n7ZivVvGoLgQFhwg4STdIg
         GYG6NQ37MyRLTEdn1mIJkDesjTVWitVBtkKsHRbWte/ru/nEPCL4Sno3TEUWe1UIQa1W
         qDFcuwlTze2apWtahv7V9feton6RKpGT8noaD5BWm3Y1ba2+hHfGHX/tfXs8dI7nAXlK
         t38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MnzjYlrH9DudEx4Y6CDcuSq2nPn0jDnTQ9CabFBeEdA=;
        b=IlK8DxMfE889lUpLmdnCb9XlvF1vcTcvqfpO+XyNKlkUjLlqRfadb4Es3fk+a3YMB1
         Cv0+hV2zrHZ4chrAOonw5mvZ4oN4lLlkDgFTXESS4tVKLQabcQMZ4Mki/PvfpikX2Eqb
         LqpWY+T3Aty+iek+HLhrNOqXbkWmU2rPQNDC/6lCAocQVaxxUh5CzhdgNV0V7ZrA0sJF
         4kP5nDfFCSpZV8xUdsMGSFWVMJ6Mdo56AFI+RXcPvkhjIV7kpQCc+vTLNWti/sGYxsmc
         3F1OvFWq8J+PdyvX/pvHZtuwASHLYDO6SPfRsuy4Cq2C6pD52wSn4gB0fFWOqOTDQoxs
         qXVg==
X-Gm-Message-State: AOUpUlE0YDn7tv46Xp4JeqyMFpzyYVUvGbnI95m8wPgA0oEI1gJAfeBF
        MIDLZ7EstUh6Ioq0IuHG7Qk=
X-Google-Smtp-Source: AAOMgpcIJVlvUlRuKaHMQ20D2TqF7DqP/4Jc/RWy1hGc0EvoOJ+gLHHGkIhaxSbf6EVopldNWdVDoA==
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr8225425lje.146.1532006551068;
        Thu, 19 Jul 2018 06:22:31 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:30 -0700 (PDT)
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
Subject: [PATCH v4 0/8] Tegra20 External Memory Controller driver
Date:   Thu, 19 Jul 2018 16:21:24 +0300
Message-Id: <20180719132132.16153-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Couple years ago the Tegra20 EMC driver was removed from the kernel
due to incompatible changes in the Tegra's clock driver. This patchset
introduces a modernized EMC driver. Currently the sole purpose of the
driver is to initialize DRAM frequency to maximum rate during of the
kernels boot-up. Later we may consider implementing dynamic memory
frequency scaling, utilizing functionality provided by this driver.

Changelog:

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

