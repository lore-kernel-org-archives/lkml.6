Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E55C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A2420877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg3iRu7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A2420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbeGKMMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:12:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46580 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:12:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so8164196ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O2QvhBX+cdCH6CWnt0fnByer0ff07oNziAgpIghCMPs=;
        b=jg3iRu7t9bTPMubCQhj8pwF9AuOD0qV6TMr4kfd0AHOmzmuW3+gq6pw7auBPaBZ00X
         pvC9TCay3cAlfHjremAgM+BbysFlU4DF/DVdBqF1XSH3mp6Rouv12uNFLqcAnmw4ykE7
         m1CiWX9BJOpsMovyru6jJ1knpSkRB6uX6f8JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O2QvhBX+cdCH6CWnt0fnByer0ff07oNziAgpIghCMPs=;
        b=qe2doJ1AJj05IK0RqlJnu4xpm/jhFZE3vxnZqgJ1b/fqBr/cqoSnP/yd4kq0mttgBL
         bsrIYd0aLcnrItJF4BMhLSZLawOH0vruw/+L/JWd0v8cq3O/iFWUFpQEE8dku3RyDSni
         yl9OgdUgVa724Dy82fNSHo2yIVz2xS2g/p69zq6k7pK73fnBbaedKs8TZz3YsIgr1bIU
         Aeat0QhJ9bS9wADkMArxIq2S/BdsN5gIFu+mXQxiw6jfxHRiQp8PqTPEsIJk/HDhmH7/
         1hqyOt1yJfxyKRtcNWIG2LYGeVqGBDLLJECvMRFawo2jrlxc3SHVJEDKCzu/D3fHC9JK
         B0Hw==
X-Gm-Message-State: APt69E1Ly3bBxxvplHFNXuxo3goKp1h1KMCGDTUVbsQtR4Y1G/vyzKVa
        raY3gF1C9B+6XJiogisMfbM30Q==
X-Google-Smtp-Source: AAOMgpeTR35tL/QrlQZm1/eykzU0Fva6lGBbiEpv6pcvGoAs4JFJUneAhq2GrexxpAYuW9Sz2Kwy7Q==
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr17949364ljk.19.1531310898087;
        Wed, 11 Jul 2018 05:08:18 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id k65-v6sm1627781lje.3.2018.07.11.05.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:08:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.18-rc5
Date:   Wed, 11 Jul 2018 14:08:16 +0200
Message-Id: <20180711120816.13767-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.18-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.18-rc3

for you to fetch changes up to 92748beac07c471d995fbec642b63572dc01b3dc:

  mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states (2018-07-09 11:17:47 +0200)

----------------------------------------------------------------
MMC core:
 - Fixup devname in /proc/interrupts for card detect GPIO

MMC host:
 - sdhci-esdhc-imx: Allow 1.8V speed-modes without 100/200MHz pinctrls
 - sunxi: Disable IRQ in low power state to prevent IRQ storm
 - dw_mmc: Fix card threshold control configuration
 - renesas_sdhi_internal_dmac: Fixup DMA error paths

----------------------------------------------------------------
Anson Huang (1):
      mmc: core: cd_label must be last entry of mmc_gpio struct

Stefan Agner (1):
      mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states

Stefan Mavrodiev (1):
      mmc: sunxi: Disable irq during pm_suspend

Yoshihiro Shimoda (2):
      mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
      mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

x00270170 (1):
      mmc: dw_mmc: fix card threshold control configuration

 drivers/mmc/core/slot-gpio.c                  |  2 +-
 drivers/mmc/host/dw_mmc.c                     |  7 ++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++--------
 drivers/mmc/host/sdhci-esdhc-imx.c            | 21 +++++++++------------
 drivers/mmc/host/sunxi-mmc.c                  |  7 +++++++
 5 files changed, 28 insertions(+), 24 deletions(-)
