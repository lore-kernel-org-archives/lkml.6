Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F992C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A682082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxxNQwRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLKJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:13:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42278 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:13:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so6822555pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C8aXLhdbAkcSLAq4wUpP1AsonwJYLIIKjoAc4XvvsqE=;
        b=jxxNQwRf4Z7VdT47DLCUWcCaBhOboriLEzwBMBZFlpmMzXE7Xxy7W5ZZ03NU9INxAn
         eu7r25WXNr/ZDry7yHvtQ8B+LkcZN9XZDCZaaK+n+n5JkxCKLQsHKXkFB7xD6I5c02uv
         RPNoeRV9vbCQ0apFisuPgszDCCREL61LCffKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C8aXLhdbAkcSLAq4wUpP1AsonwJYLIIKjoAc4XvvsqE=;
        b=OyadyH6CABZig1KgMXCKkIE8WzdY5GkfuvjxuGbZ8219QBqJcS88zlJuHrITDcSlbD
         OgO00/qxLgSNVLSj3U2t8Gvf6Te/GMSIBiQTGvZFjhdlezJ6IQC7aho31q4QxQgBuh8Q
         R8Ggf3iooPYwC+016jLj/hlqZSObXvhUGEVAYC/ab9iyQDsmhuFM5VZtUu6Mjj2XVgVO
         /2XCMTFK0Ii4wLk/EnNNNc+qse1WHNrBSmvKf8afTLtqWsxP5QkcHciGJMWxmmF2NSaR
         SvlyngxHBrLCpAew7QARWNjn91AnhsTSfDdQpgcYSWVVlZwth6Jn2G5zZM/4niifND//
         vHzQ==
X-Gm-Message-State: AA+aEWY4eVd+M9VbA2XMl9uVcYSNedfW6Csl43dBUgLEXiNfFWG8O2fg
        pMyItt/B8SNt5+X5fUjnj7NdZw==
X-Google-Smtp-Source: AFSGD/U5W6NCZuYhDctOpfD+Srmv9HxMw3jKfl2VSHwZbVQ7lukzR9kGSt3AIvkdkpU94c1zEeJsgQ==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr14180703pge.433.1544519585359;
        Tue, 11 Dec 2018 01:13:05 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a90sm27202214pfj.109.2018.12.11.01.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 01:13:04 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V4 0/3] Add support for using external dma in SDHCI
Date:   Tue, 11 Dec 2018 17:12:49 +0800
Message-Id: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the generic SDHCI code in the Linux kernel supports the SD
standard DMA integrated into the host controller but does not have any
support for external DMA controllers implemented using dmaengine meaning
that custom code is needed for any systems that use a generic DMA
controller with SDHCI which in practice means any SDHCI controller that
doesn't have an integrated DMA controller so we should have this as a
generic feature.

There are already a number of controller specific drivers that have dmaengine
code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
in their specific driver for sending command with external dma using dmaengine
framework, with this patchset, them will take advantage of the generic support.
TI's omap controller is the case as an example.

Any comments are very appreciated.

Thanks,
Chunyan

Changes from v3 (https://lkml.org/lkml/2018/12/4/74):
(The code only on patch 1/3 was revised since v3)
* Moved the check for command data from sdhci_external_dma_setup() to sdhci_external_dma_prepare_data();
* Cut a copy of prepare_data() for external DMA instead of using sdhci_prepare_data() to
  avoid the host use ADMA rather than external DMA;  In this way, if failed to setup external DMA, host
  can fall back to ADMA/SDMA/PIO which standard sd host controller supports.
* Added dmaengine_terminate_sync() when finished transfers or some error occured;
* Adjusted print message in __sdhci_add_host() for the case of using external DMA.

Changes from v2 (https://lkml.org/lkml/2018/11/12/1936):
* Remove CONFIG_EXTERNAL_DMA prompt and help graph;
* Add checking for cmd->data;
* Select MMC_SDHCI_EXTERNAL_DMA for MMC_SDHCI_OMAP;
* Add checking if there's 'dmas' in device tree before decide using external dma.

Changes from v1 (https://lkml.org/lkml/2018/11/5/110):
(The code on patch 1/3 only was revised)
* Address comments from Arnd:
- Release channel when failed to request it unconditionally;
- Skip warning message if get EPROBE_DEFER;
* Address Andrian's comments:
- Replace extdma with external_dma;
- Add release dma resources in sdhci_cleanup_host() and sdhci_remove_host();
- Release dma resources once dmaengine_submit() failed.
- Put rx/tx_chan in struct sdhci_host, and removed unused structure.
* Fall back to the DMA/PIO which standard SDHCI supports, if sdhci_external_dma_setup()
  or sdhci_external_dma_init failed;

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using external dma

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 +
 drivers/mmc/host/Kconfig                           |   4 +
 drivers/mmc/host/sdhci-omap.c                      |  10 +
 drivers/mmc/host/sdhci.c                           | 250 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |   8 +
 5 files changed, 278 insertions(+), 1 deletion(-)

-- 
2.7.4

