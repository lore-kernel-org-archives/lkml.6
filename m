Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wAeaHak6GltbJAAAmS7hNA
	; Fri, 08 Jun 2018 08:18:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4B5D6089E; Fri,  8 Jun 2018 08:18:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRi1eyFw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58A6760590;
	Fri,  8 Jun 2018 08:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58A6760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeFHISx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:18:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40906 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeFHISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:18:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so7844663plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ynREAb8J460H3KB3El0lvkcMpoVil9SAoa2TrCeuB+w=;
        b=BRi1eyFw1rj4kB9r0PBU4Zrd+RiKaPaswEmSra3Gxg8SYSDAU0TvTDGqIJRrIlM3Ux
         wpQJzUAtLDQsTovkuCAl8yUGO+svLNfJeAgioAskESe+XFj423DmCwKyW2crn1XU/s8n
         fPYVnwH4A5FeSq51VK0GoqPVgIv4lkL6fTbQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ynREAb8J460H3KB3El0lvkcMpoVil9SAoa2TrCeuB+w=;
        b=ZelFte+kkop3Z2lvMw4fL0/QLhQNIbxC35u++In//ycYELIAoEMIzQx+ASkavUWPR7
         4z7jNKRH+8rUjPSoCNPozsHqcpxhLWEiQkfrO23qQ+R9ACYqBCOaWXy4I004ZIudfzf9
         /3xv/Fqk710F9LmfN7qCD6OeTiDdjIv7TsVSziEflKkBy6lPSjgItcQjbs1LTiKeRkFC
         moqis36mF9H/7OHBgYIBbUVN+fmu0jpfFBOSAZ9VHTUr0+CUyb+Ar/KE9c8ug+tIDlzG
         WYP3RpiwJGKNMjMe/aUzImLcyMPPhrzkBX8b+X9pPvV1MoXjpYHvWcjOPsBNWqkStSRJ
         ig9g==
X-Gm-Message-State: APt69E3OuHmYglCVcew36AQ1hlCYSq4KCaq+z8CD1wWggcEHafcHorlm
        i754V1/XEoGjFvEb9clfknP74A==
X-Google-Smtp-Source: ADUXVKLhFKqvYdv4PCWAw5qKpax0ipW042p5VZFDuBYA2U5aldEqe7o36mCET1zG9M136spinbKyow==
X-Received: by 2002:a17:902:784d:: with SMTP id e13-v6mr5664123pln.197.1528445926948;
        Fri, 08 Jun 2018 01:18:46 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:18:45 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 0/6] mmc: add support for sdhci 4.0
Date: Fri,  8 Jun 2018 16:18:07 +0800
Message-Id: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

Chunyan Zhang (6):
  mmc: sdhci: add sd host v4 mode
  mmc: sdhci: made changes for System Address register of SDMA
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add CMD23 support for v4 mode
  mmc: host: sdhci-sprd: added Spreadtrum's host controller R11

 drivers/mmc/host/Kconfig          |  13 ++
 drivers/mmc/host/Makefile         |   1 +
 drivers/mmc/host/sdhci-sprd-r11.c | 472 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  85 +++++--
 drivers/mmc/host/sdhci.h          |  31 ++-
 5 files changed, 580 insertions(+), 22 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-sprd-r11.c

-- 
2.7.4
