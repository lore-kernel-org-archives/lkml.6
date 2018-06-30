Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB80AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728C025387
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="EFsFEYLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728C025387
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeF3TdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 15:33:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37365 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeF3TdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 15:33:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so9144014lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XQQVbe7WjMMgPqR5Uj9hCyXP8h5tJXalFOTPJ+fMQhE=;
        b=EFsFEYLC7Lgbv21Y5F+ZnDUtGgpI2lRxXfefz6wCazr/uVADTeWOKrfNVW9J5v8lML
         98a2H31V7Hf/2vAYTGDISLV+v3VSqAaU+kDgqR/rGo2TCteGp1C7/V7z6nD0Ea57A4on
         jrOI+ByiYnQLY7Lba41MWp59y2fVwYJl6J5HY1hjs34AnjNNaAIrWa4dYMsyfMxV3Vld
         Ciylxfdv0EcecRPvEV9AqKKcWRkcIOlNNNkd8yzg+EIYdscUeEmGUTiWmulwM4ySwIkZ
         7KEXjMH9SirjkmNTt4RdFwGsOADZ71gZ95m21nNukaz1kQ4W6isIqxX9DQ0jPHXz/Mhy
         2UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XQQVbe7WjMMgPqR5Uj9hCyXP8h5tJXalFOTPJ+fMQhE=;
        b=WhMGLOXAddioDTxoZnrCTh0Pges6CJ1IdCwGG1thpa9Rdyt4Ywwpt8qAH3TocgnQfp
         zi77SbKcoC5iL7d25mxt3+Fxi/MDR9i1hSOXGR8HrRU7GMAX2zJPVaLgyGKSwjl4otNc
         s1+gjcQ1vPYozVxJCFFuVV1xVk3ZotpzDH22LGQZPeHzXqIuQq24iuzihZo095U5cXMR
         BJw0o+gOZ3kxPkFKEiiJkW9o0ldK4FQmmGmY/cjgZoHFBDEqRFHsuSOnnSa+KqOZsu89
         6eRq+B8sMmlIMnzd3DyejELLavAs+D0sjzFZyX3nP3ZTc/JLWld9FwAR+UXSuUSKSvNl
         bzYQ==
X-Gm-Message-State: APt69E3ZIJGsDOVmIRfyyiSr7g87aBx9xCy+tWSf0Vtpz8j6b3xqXhlu
        yTSpku4mOkENbrdExoUH8H3YHA==
X-Google-Smtp-Source: AAOMgpcMgGPPuF2PzyIARbaifiMeKlaYClkPkhN1kUGF+mhatW1bYiy1RGu/njBgpE49JSu18ju+CA==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr3254486lfg.142.1530387187248;
        Sat, 30 Jun 2018 12:33:07 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p75-v6sm1548725lfg.42.2018.06.30.12.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 12:33:04 -0700 (PDT)
Date:   Sat, 30 Jun 2018 12:32:54 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180630193254.irrglaxamez7ryt2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


The following changes since commit 86676c4685f774d818f7a6c401c925bbf2a92903:

  arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards (2018-06-27 07:14:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 4ca2f0b945fad835959fa596df47817797987cd2:

  Merge tag 'davinci-fixes-for-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into fixes (2018-06-29 14:08:27 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A smaller batch for the end of the week (let's see if I can keep the
weekly cadence going for once).

All medium-grade fixes here, nothing worrisome:
 - Fixes for some fairly old bugs around SD card write-protect detection
   and GPIO interrupt assignments on Davinci.
 - Wifi module suspend fix for Hikey.
 - Minor DT tweaks to fix inaccuracies for Amlogic platforms, on of
   which solves booting with third-party u-boot.

----------------------------------------------------------------
Adam Ford (1):
      ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD

Jerome Brunet (2):
      ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
      ARM64: dts: meson-axg: fix ethernet stability issue

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kevin Hilman (2):
      ARM64: dts: meson: fix register ranges for SD/eMMC
      ARM64: dts: meson-gx: fix ATF reserved memory region

Martin Blumenstingl (1):
      ARM64: dts: meson-gxl: fix Mali GPU compatible string

Neil Armstrong (1):
      ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

Olof Johansson (3):
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'hisi-fixes-for-4.18' of git://github.com/hisilicon/linux-hisi into fixes
      Merge tag 'davinci-fixes-for-v4.18' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes

oscardagrach (2):
      arm64: dts: hikey: Define wl1835 power capabilities
      arm64: dts: hikey960: Define wl1837 power capabilities

 arch/arm/boot/dts/da850.dtsi                              |  6 +-----
 arch/arm/mach-davinci/board-da850-evm.c                   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts            | 15 ++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                 | 12 +++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi           |  2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts     |  3 ---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                |  8 --------
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts         |  2 ++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts            |  2 ++
 11 files changed, 39 insertions(+), 24 deletions(-)
