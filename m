Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD8E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM6zTM9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD8E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeLMK5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:57:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46987 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeLMK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:57:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so1342888ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vah1f6kbIZq5Epk/XM4inLSjlK/6NYlpt1jzz6S2CPY=;
        b=iM6zTM9qb+M0jCo/okPT5Wz6+HwI+PbIj4rViJ8qWtdwqk7NhXHWJNXLyiy37hL9bj
         57Q5kgi3hjIRXCzFaoRDwpMZWCVvk+FDizzROACf4L/5IK4LMXwbcIsqOKJCW3qcqFUG
         y10S+jLQNNCEqzt66kOglVN2hbrMKs7c8vzKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vah1f6kbIZq5Epk/XM4inLSjlK/6NYlpt1jzz6S2CPY=;
        b=S3r25lZAbNEfZhNW+FZFFlGK1cDwHM//E16ExawWDDDAOgYx5uUTkDSDP/lTvz1K9t
         kdr7c3LNtYAst962DGV8nwOt9V2b84ItX/7wl+Rf7R0zvbZtFmVWgH+UEYQCkqBW0xbz
         O/4dh/q3vdW625E5NarWbAZT9t3Ef73oxBhKagwVne/ZjpgOZNxt/yNsD/iGpEIZz5Jv
         d66g7jdL8vcyGZfWwOILYN4Jrgx6nVT442QP8Vd0btrsPmfaORQHdLbwcuVUb8pDbieK
         V+4i/emopiDbLtZE4z7wWysepW78LcchpzQ2dN6kPhUDr5M0xPk9U6vr4LbtoZQOJLPS
         kixg==
X-Gm-Message-State: AA+aEWbWT2lI4gflv123KeSC43WL9x/num/YRQPeA+Wimxuxqyluvypn
        bmdESZ8IMgElHFfTC31Je5vAtgOMusA=
X-Google-Smtp-Source: AFSGD/V8KPUZi/KmuexWKHcNJdCWTA+ZNz/yLOzlyW3YRiY6rp/DeCbr9JXGmFKwqBWZOZhnI89qvA==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr14281875ljd.45.1544698650339;
        Thu, 13 Dec 2018 02:57:30 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id m77sm283586lfg.3.2018.12.13.02.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:57:29 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc7
Date:   Thu, 13 Dec 2018 11:57:28 +0100
Message-Id: <20181213105728.32426-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.20-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc5

for you to fetch changes up to b704441e38f645dcfba1348ca3cc1ba43d1a9f31:

  mmc: sdhci: fix the timeout check window for clock and reset (2018-12-06 11:22:00 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup RPMB requests to use mrq->sbc when sending CMD23

MMC host:
 - omap: Fix broken MMC/SD on OMAP15XX/OMAP5910/OMAP310
 - sdhci-omap: Fix DCRC error handling during tuning
 - sdhci: Fixup the timeout check window for clock and reset

----------------------------------------------------------------
Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Alek Du (1):
      mmc: sdhci: fix the timeout check window for clock and reset

Faiz Abbas (1):
      mmc: sdhci-omap: Fix DCRC error handling during tuning

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB

 drivers/mmc/core/block.c      | 15 ++++++++++-----
 drivers/mmc/host/omap.c       | 11 +++++++++--
 drivers/mmc/host/sdhci-omap.c | 12 ++++++++----
 drivers/mmc/host/sdhci.c      | 18 +++++++++++++-----
 4 files changed, 40 insertions(+), 16 deletions(-)
