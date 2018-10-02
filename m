Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6336C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB242089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M494Zddo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB242089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJBOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:04:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42593 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJBOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:04:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so786829lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x8Js6xHzx1DMaSTnqugU+McL3FydQgF97vstUN7I03c=;
        b=M494ZddoDkafdChuE5GP1VekxhR05hP7+ftyvz1j3WFBzXM6wT5/oTQ6YGZCMxvQjw
         YSeRFxAmmVbHgIXHB3JF+YJ7J0KvxYn6NBNpbiVap0srDuLRlicPWP9S6EfvJ8oa7S4M
         +lCeAzRAijcNISGBIJvHcTx+haR3Yg1Twe2ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8Js6xHzx1DMaSTnqugU+McL3FydQgF97vstUN7I03c=;
        b=tv/Ti5iGwF1Q4WzZJfLt1LvzWgI9Q0tprFBN5fzJ/7zhGJhGFncPdH2YpYWtTCwIz+
         X7UYRilubbj/CHG+QTJbVJLI8EZzP8vYToZVOXLpMXxvuw0Dp7gD5YxMf1/1ApMo6tZ+
         OdKBQx7PwFkX5+uGe9jnLCO9Wv+KuDlFgTaKUhAJaGWac015SN3Y8QNfQFmu9Aie69RO
         fPpJZB13mBj0gvOCD813puxQgk1fNmS9XW9PEKa17LA0FbOwkv3v1M9mSI1PUDAoClWA
         Qa0NvQLS3zvjTuMdZaTpfxnLbE4ysbWGAtdlChukfwg/X9D3v3FkDQSzkL54Amoy3mVn
         ekGQ==
X-Gm-Message-State: ABuFfoiGkr6lg+MFkR/y4F+aaKHQfbruHurpuNjdZTwHaL2pOpOnur6I
        np0JQI9F901CD3NDfwjueVCJkQ==
X-Google-Smtp-Source: ACcGV61qNTdsiOR8MIoGJVJzXEIWsbR2Fo6KbGhbTkFsIyGZLWUSoI8e1L+5ZsW3HNLe2OQGAa/heg==
X-Received: by 2002:a2e:9c59:: with SMTP id t25-v6mr4323001ljj.107.1538464955448;
        Tue, 02 Oct 2018 00:22:35 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v4-v6sm2861878ljd.86.2018.10.02.00.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:22:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus <torvalds@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc7
Date:   Tue,  2 Oct 2018 09:22:33 +0200
Message-Id: <20181002072233.2814-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a PR with a few MMC fixes intended for v4.19-rc7. Details about the
highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc4

for you to fetch changes up to 1b09d9c232cdaea59fb50ac437d3921ed1f1eafb:

  mmc: slot-gpio: Fix debounce time to use miliseconds again (2018-09-28 17:43:48 +0200)

----------------------------------------------------------------
MMC core:
 - Fixup conversion of debounce time to/from ms/us

MMC host:
 - sdhi: Fixup whitelisting for Gen3 types

----------------------------------------------------------------
Marek Szyprowski (1):
      mmc: slot-gpio: Fix debounce time to use miliseconds again

Tony Lindgren (1):
      mmc: core: Fix debounce time to use microseconds

Wolfram Sang (1):
      mmc: sdhi: sys_dmac: check for all Gen3 types when whitelisting

 drivers/mmc/core/host.c                  | 2 +-
 drivers/mmc/core/slot-gpio.c             | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)
