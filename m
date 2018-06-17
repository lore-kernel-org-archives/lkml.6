Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F141208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2UVRlBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F141208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeFQO7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:59:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37168 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeFQO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so21003739lfb.4;
        Sun, 17 Jun 2018 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JMMmPiTvCMP/Mix7ZltN6uEW+A4Pxu7sDog1I18bxGw=;
        b=l2UVRlBpw7hiP2B/+3wPwU6xTUvOnWLw+Dhz9AjPkQORQwzlQJqXbnKVjRZq4qDfn0
         cd/ujQeqys5VnRLt08R8zX/4ffLGnXnpTA8c4lbgSH+o6TlHNpfUqoKCsntT5WYG0bAs
         GQjRciqbKQ64WMySN1A3dWCYzJ79OWWrR6h+06bjSPNm5uhSyCroWiuKPhKngsRLj/mQ
         nWVuzkMEfibXqjQdzJFOGL/TCyBGnsBd7BFLjRqx3tCWdqHamjYwcoCk+L0iR03QmGXC
         2Q5Di35qniD8Kpeekd+E2mzRtbFPd3Xe5cknEDcr7oG4lljbVcNqor2INC9YfXoSMxTU
         pSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JMMmPiTvCMP/Mix7ZltN6uEW+A4Pxu7sDog1I18bxGw=;
        b=I2GiwFJ0ddXBo9r0zP7fY1eKmvPUzi04mQ9rKrl1xzcw0U2SmDumSdX13WvhHmmuIE
         qHDhxX3s3MhiOSfAEuEP0BUPWcSnl5ODAu1CjYa37cCFUy2dRgMh9n5t09r3ETaz7/z1
         McZhQWtI0NcwFtC5KliLNLodIQ4fkcmMvP2Uy15jPxABbPwjz/yqe8WcyC5GiILRt8F/
         XGYB0wIt8vjzr8fUdGzCVwsuok7po2JIUj3+fK9wGzFA2l93iirCJNQuyr3Bx8o/vOnl
         gkd6yGGF87CgQfJjJeFECE3HJ8qGTlosgY+V1xMuqx1h457faG+ExCgtUuFS8eDTxTkl
         zn9g==
X-Gm-Message-State: APt69E0ZiLNl82kR1qFoHjnN1Qugec/sZjpY9EhRfXCFPCfawe+Vjaw0
        I4ajOtdcA4OR2TcQfT0zbls=
X-Google-Smtp-Source: ADUXVKKiNRSJ9Sw5CXtuHCtcXCjw2C2ZhM15xiDKr7MZJFZrRfq4CCzHmVeAY8gpCWJLFGmvUhzkCQ==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr5778300ljb.13.1529247578137;
        Sun, 17 Jun 2018 07:59:38 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Tegra20 External Memory Controller driver
Date:   Sun, 17 Jun 2018 17:55:31 +0300
Message-Id: <20180617145539.4758-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/memory/tegra/tegra20-emc.c            | 574 ++++++++++++++++++
 6 files changed, 627 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

-- 
2.17.1

