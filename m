Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245A20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="WYQgD8Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeL3L5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:57:48 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:58698 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3L5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:57:47 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Dec 2018 06:57:46 EST
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id AADDE405AC; Sun, 30 Dec 2018 12:24:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org AADDE405AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1546169085;
        bh=jEYhZ7NuBnTccO+pSB6NQmLCKgEaz+55LqWKLGz3Leg=;
        h=Date:From:To:Cc:Subject:From;
        b=WYQgD8Qr5WCpW4Y+Y5XKnQvPQ674IZUbonKpASgwOYvEVcwTxLfFixU/feQwzmryF
         MsEIi17eyuRCR/QzAPzkp9mQRVwT0/hBmmf531f4W08dOh0E6s3AYh5K8i+uDcSNFp
         OCrOhR+4XwXOe1g+GEVnT9ztEBz9FQTTNxPLTaIA=
Date:   Sun, 30 Dec 2018 12:24:45 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Colin Ian King <colin.king@canonical.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL REQUEST] watchdog - v4.21 Merge window
Message-ID: <20181230112445.GA12489@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.21 release cycle.

This series contains:
* add TQ-Systems TQMX86 watchdog driver
* add Qualcomm PM8916 watchdog driver
* w83627hf_wdt: add quirk for Inves system
* renesas_wdt: several improvements and document r8a774c0 support
* mena21_wdt, mtx-1: Convert to use GPIO descriptor
* bcm281xx, ie6xx_wdt: convert to DEFINE_SHOW_ATTRIBUTE
* documentation: add PM usage and kernel-api: don't reference removed functions
* update bindings for MT7629 SoC
* several small fixes

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.21-rc1

for you to fetch changes up to e3c21e088f8936a004a3d9f2f4e14b3f2bdd6ea9:

  watchdog: tqmx86: Add watchdog driver for the IO controller (2018-12-24 13:15:07 +0100)

----------------------------------------------------------------
linux-watchdog 4.21-rc1 tag

----------------------------------------------------------------
Andrew Lunn (1):
      watchdog: tqmx86: Add watchdog driver for the IO controller

Colin Ian King (1):
      watchdog: asm9260_wdt: make array mode_name static, shrinks object size

Fabrizio Castro (2):
      watchdog: renesas_wdt: Fix typos
      dt-bindings: watchdog: renesas-wdt: Document r8a774c0 support

Hardik Singh Rathore (1):
      Watchdog: remove outdated comment

Jean Delvare (1):
      watchdog: w83627hf_wdt: Add quirk for Inves system

Jerry Hoemann (3):
      watchdog/hpwdt: Exclude via blacklist
      watchdog/hpwdt: Do not claim unsupported hardware
      watchdog/hpwdt: Update driver version.

Linus Walleij (2):
      watchdog: mena21_wdt: Convert to GPIO descriptors
      watchdog: mtx-1: Convert to use GPIO descriptor

Loic Poulain (2):
      watchdog: Add pm8916 watchdog driver
      dt-bindings: watchdog: Add Qualcomm PM8916 watchdog

Ryder Lee (1):
      dt-bindings: watchdog: update bindings for MT7629 SoC

Tomer Maimon (1):
      watchdog: npcm: Modify npcm watchdog kconfig arch parameter

Wolfram Sang (4):
      watchdog: renesas_wdt: don't set divider while watchdog is running
      watchdog: renesas_wdt: don't keep timer value during suspend/resume
      watchdog: add documentation for PM usage
      watchdog: docs: kernel-api: don't reference removed functions

Yangtao Li (3):
      watchdog: cpwd: add of_node_put()
      watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
      watchdog: ie6xx_wdt: convert to DEFINE_SHOW_ATTRIBUTE

 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   1 +
 .../bindings/watchdog/qcom,pm8916-wdt.txt          |  28 +++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 Documentation/watchdog/watchdog-kernel-api.txt     |   4 -
 Documentation/watchdog/watchdog-pm.txt             |  19 ++
 arch/mips/alchemy/board-mtx1.c                     |  18 +-
 drivers/watchdog/Kconfig                           |  22 ++-
 drivers/watchdog/Makefile                          |   2 +
 drivers/watchdog/asm9260_wdt.c                     |   2 +-
 drivers/watchdog/bcm_kona_wdt.c                    |  16 +-
 drivers/watchdog/cpwd.c                            |   2 +
 drivers/watchdog/hpwdt.c                           |  15 +-
 drivers/watchdog/ie6xx_wdt.c                       |  16 +-
 drivers/watchdog/mena21_wdt.c                      |  73 ++++---
 drivers/watchdog/mtx-1_wdt.c                       |  19 +-
 drivers/watchdog/pm8916_wdt.c                      | 211 +++++++++++++++++++++
 drivers/watchdog/renesas_wdt.c                     |  24 +--
 drivers/watchdog/tqmx86_wdt.c                      | 126 ++++++++++++
 drivers/watchdog/w83627hf_wdt.c                    |  38 +++-
 include/linux/watchdog.h                           |   3 -
 20 files changed, 529 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
 create mode 100644 Documentation/watchdog/watchdog-pm.txt
 create mode 100644 drivers/watchdog/pm8916_wdt.c
 create mode 100644 drivers/watchdog/tqmx86_wdt.c
----------------------------------------------------------------

Kind regards and best wishes,
Wim.

