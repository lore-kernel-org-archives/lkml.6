Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25302086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="iWasvqAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfBUK4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:56:19 -0500
Received: from chill.innovation.ch ([216.218.245.220]:50854 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:56:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 8FC676401CB;
        Thu, 21 Feb 2019 02:56:17 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id o1mQMtG4FYRI; Thu, 21 Feb 2019 02:56:15 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 59D066400C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1550746575;
        bh=YMB44jb+0g+nd4Og7l02NGHm++mcOMMfpBshErHT638=;
        h=From:To:Cc:Subject:Date:From;
        b=iWasvqAy2bCBFx6Gr9MY868GPHp/GKu0BtIWkzrxVHaOrK3wcmcLWj6v9RUlxlXFk
         8mBepxHZ4qA3aMtqFiZGrusRsKjDiRLP2T/Ci/i+wswOgXD/9TIDE9r85sodcS3l4Q
         5BEyp68+wC95TDXUbZDQx2iFez6oZ7jT6BUDCFL+C8oLYOHFAeKKoH5mzIlRX7Dqb4
         9DNmWk3FrTxxoIJxWH5QUvKbhQNRzETr44kQohgLAO+12EGKZz0X9XJ/yFLhamySvl
         cTxP2qI/ekD8Ns6QJTjti1PKUX8nLgaNqgqGUGf7vs5hLNY8oGg6HtEJ3x6v5Q8yIt
         lT9oyGGx/HFDg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Apple SPI keyboard and trackpad driver
Date:   Thu, 21 Feb 2019 02:56:07 -0800
Message-Id: <20190221105609.5710-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch is just a placeholder for now and is provided in case
somebody wants to compile the driver while it's being reviewed here; the
real patch has been submitted to dri-devel and is being discussed there,
with the intent/hope that I can get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

Changes in v2:
  Applied all feedback from review by Andy Shevchenko, including:
  - reworked logging to use dev_xxx() everywhere
  - split 16-bit model_id field into 2 8-bit fields
  - factored out several pieces of code into separate functions
  - many code style improvements and cleanups
  - Kconfig dependency fixes
  The full set of changes (except for the Kconfig) can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits a651bb9..f832caa in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig    |    2 +-
 drivers/input/keyboard/Kconfig    |   14 +
 drivers/input/keyboard/Makefile   |    1 +
 drivers/input/keyboard/applespi.c | 2003 +++++++++++++++++++++++++++++
 4 files changed, 2019 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/keyboard/applespi.c

-- 
2.20.1

