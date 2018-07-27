Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC77C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5DB208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5DB208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbeG0OV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:21:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57518 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbeG0OV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:29 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fj2LG-0008VU-Hc; Fri, 27 Jul 2018 13:59:34 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     jonathanh@nvidia.com, thierry.reding@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Subject: [PATCH 0/4] ASoC: Tegra30 TDM support
Date:   Fri, 27 Jul 2018 13:59:27 +0100
Message-Id: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for TDM audio on Tegra30 hardware.
It adds the DAI's `set_tdm_slot` callback and enables a tegra
pcm to have up to 8 channels.

It also includes support for other audio formats supported by
the Tegra30 HW and fixes a broken macro needed for setting the
TDM on the registers.

Based on Linux 4.18-rc3 tag.

Edward Cragg (4):
  ASoC: tegra: i2s: Fix typo/broken macro
  ASoC: tegra: Add a TDM configuration callback
  ASoC: tegra: Allow 32-bit and 24-bit samples
  ASoC: tegra: i2s: Add support for more than 2 channels

 sound/soc/tegra/tegra30_i2s.c | 72 ++++++++++++++++++++++++++++++++++++-------
 sound/soc/tegra/tegra30_i2s.h |  2 +-
 2 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.11.0

