Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0062C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D0E21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdHsJj89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeLTJ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:58:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41700 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeLTJ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:58:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so970095ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=34qDGTyqKjGSdYqKws3irLv5MhzZT5AO71EuEmzpzj8=;
        b=KdHsJj890nG/hrzpQrhTLR9R05Qt/JY5Hgcz24+4ZtJPL393UhDUbVXdWcZDTQGBxY
         QtlVgBkNl932M7e5Gmo1+jhHOsDlDSCNpkpNRzx5RcXIc0uHsCCN2yHMkiqlRl9wAK+1
         mVGjHb3Bpt8QGpwBiaj9Skj1M5oEYxaUvMqhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=34qDGTyqKjGSdYqKws3irLv5MhzZT5AO71EuEmzpzj8=;
        b=YrDTRT9K8/eg/0lpHY9Sdv+wK9lBrAlcsZyJsyUdQnGoBlHhm32agAO2vvv5Iyzm0T
         SGCbxDjXXNMafvSWrsCV8i7WRWd1rPvyls1Z3KjhMR0GKYRV2U4F9u7CHsU2TzG9nlTd
         zKf2WjqV/bifUmcRijjpCcfLU5Ni17TgrEauzKjlCkWNAnsQLwraH2fvBbX07ASuhCL4
         AJ63Qm0Cx6eBoRoB1vgjBKDcdQbpkrTcTuyqsO8tO1X5EL30eKujP5uw5Nh3A/6o/ckd
         pOfznGrVSLvZxmP6fxkav6tn0R8CJU/jCZTJldvdXfzhPe3kzmlIXtHQJOh9Dl4IbkAW
         XFWA==
X-Gm-Message-State: AA+aEWbpJYdNjhJ95p0cFeHmJZHYpYqR9AmJbKtrgoN+3WTGxNLJoWbw
        Xzp6yIrAPAQBVqOROd4yAqkZUg==
X-Google-Smtp-Source: AFSGD/UpLRB3Q1vF1+oZG8of74knKa0pzotnTUcnunuExWsF1AhRULQsBt3DTgzhOuRsQvUA9lgU+Q==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr14253262ljf.127.1545299914365;
        Thu, 20 Dec 2018 01:58:34 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n16sm4281186lfl.35.2018.12.20.01.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:58:33 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc8
Date:   Thu, 20 Dec 2018 10:58:32 +0100
Message-Id: <20181220095832.7375-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.20-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc7

for you to fetch changes up to e3ae3401aa19432ee4943eb0bbc2ec704d07d793:

  mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl (2018-12-17 08:59:42 +0100)

----------------------------------------------------------------
MMC core:
 - Restore code to allow BKOPS and CACHE ctrl even if no HPI support
 - Reset HPI enabled state during re-init
 - Use a default minimum timeout when enabling CACHE ctrl

MMC host:
 - omap_hsmmc: Fix DMA API warning
 - sdhci-tegra: Fix dt parsing of SDMMC pads autocal values
 - Correct register accesses when enabling v4 mode

----------------------------------------------------------------
Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sowjanya Komatineni (2):
      mmc: sdhci: Fix sdhci_do_enable_v4_mode
      mmc: tegra: Fix for SDMMC pads autocal parsing from dt

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of errors
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

 drivers/mmc/core/mmc.c         | 24 +++++++++++++++---------
 drivers/mmc/host/omap_hsmmc.c  | 12 +++++++++++-
 drivers/mmc/host/sdhci-tegra.c |  8 ++++----
 drivers/mmc/host/sdhci.c       |  4 ++--
 4 files changed, 32 insertions(+), 16 deletions(-)
