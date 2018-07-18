Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D420652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34D420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGRQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:48:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGRQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:48:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5966F279675
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, kernel@collabora.com,
        lee.jones@linaro.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/2] mfd: platform/chrome: some more cleanups between these subsystems.
Date:   Wed, 18 Jul 2018 18:09:54 +0200
Message-Id: <20180718160956.19864-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lee, Benson,

This is another patchset to try to cleanup a bit more the interaction
between the mfd subsystem and platform/chrome.

The first patch moves some cros-ec include files from include/linux/mfd to
platform/chrome. They are specific to the lpc transport driver and are not
related to the mfd subsystem, so, there is no reason to have them living
in include/linux/mfd.

The second patch tries to cleanup and fix some kerneldoc commments in
the remaining mfd/cros-ec include files. For now I only improved a bit
the documentation and fixed the warnings reported by kerneldoc. I think
that there is still a lot of improvement pending, specially in the
cros_ec_commands.h file, but this is something I'd like to have the
agreement of the chromeos folks as I know this file is used as interface
for the EC firmware. As far as I know the kernel doesn't cares about this,
but I know this is source of conflicts for the chromeos folks.
Usually, in the chromeos kernel, the cros_ec_commands file is synced
with the version available from the EC firmware but maybe we should
reconsider this and have a well documented file in the kernel and sync
in the other way. I am just thinking out loud.

Best regards,
 Enric


Enric Balletbo i Serra (2):
  platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
  mfd: cros_ec: Fix and improve kerneldoc comments.

 drivers/mfd/cros_ec_dev.h                     |  13 +-
 drivers/platform/chrome/cros_ec_lpc.c         |   3 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c     |   3 +-
 .../platform/chrome}/cros_ec_lpc_mec.h        |   6 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |   3 +-
 .../platform/chrome}/cros_ec_lpc_reg.h        |   6 +-
 include/linux/mfd/cros_ec.h                   | 214 +++++++------
 include/linux/mfd/cros_ec_commands.h          | 295 +++++++++++-------
 8 files changed, 322 insertions(+), 221 deletions(-)
 rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_mec.h (96%)
 rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_reg.h (94%)

-- 
2.18.0

