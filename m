Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBVWXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:23:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVWXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:23:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so4356559qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZGifS54bNf5zXXkOg4B/RrcUFeN3oxMfoG5A2oZa5kA=;
        b=ZDcD3SVp+sFYwNDTW0H7YAScq1DCdoO0D5KgMVAethlKR6x0XgaStTtxgJRiTKvKYP
         HZdAgjNmQ7wh2C0jg1VGq7aEc/vog2oL9FzKf3/r80JMXfeeoyUCGXol3cXtVWPstdBW
         475yD7i5hGGV0lJurVcaWJavwpEL3KQrRSEDX8AiVVgmjxpejcgLrBfBWE9e6OBRS9hS
         e9/eCKWVcp5Oxk8Y43xZ0MtvCuqiQAs60Vr6ziwKxxOoqgqOaMmeg1gu8oXgRV88p6zx
         CYcKg3KR61/dLXK+/6r8mSgnEphKlOfqxXAmTXuzmpSHCuoWPFRTkfqV9p2CcjtNF199
         9yNw==
X-Gm-Message-State: AHQUAuYIjjKBAJx2PQ983/Np6SHkzY/ofOM6qW4+k/7C6MQdok4ZMyGf
        ex0BqHh0BIQn9iyrfa0OuKY0P5btQDDJYByI+2mRqj/M
X-Google-Smtp-Source: AHgI3Ibwppi4MVqZhb6qRVVg+LL6tEM+cl0hJIclw6j8T/1qTDncK5AY9WA5lNXQb3SSJdeyS4pg0Y+1ZeLK0KeU8TQ=
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr4929954qvc.40.1550874230273;
 Fri, 22 Feb 2019 14:23:50 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Feb 2019 23:23:33 +0100
Message-ID: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 2f8b1ce19ebdaffa0f3f11d178b387b60e29c0fc:

  Merge tag 'mvebu-fixes-5.0-2' of git://git.infradead.org/linux-mvebu
into arm/fixes (2019-02-22 14:58:41 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 5.0

Only a handful of device tree fixes, all simple enough:

NVIDIA Tegra:
 - Fix a regression for booting on chromebooks

TI OMAP:
 - Two fixes PHY mode on am335x reference boards

Marvell mvebu:
 - A regression fix for Armada XP NAND flash controllers
 - An incorrect reset signal on the clearfog board

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'omap-for-v5.0/fixes-rc7-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'mvebu-fixes-5.0-2' of
git://git.infradead.org/linux-mvebu into arm/fixes

Baruch Siach (1):
      arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Thierry Reding (1):
      ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

Tony Lindgren (1):
      Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2

 arch/arm/boot/dts/am335x-evm.dts                           |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                         |  4 ++--
 arch/arm/boot/dts/armada-xp-db.dts                         | 46
+++++++++++++++++++-----------------
 arch/arm/boot/dts/armada-xp-gp.dts                         | 13 ++++++----
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts            | 85
++++++++++++++++++++++++++++++++++--------------------------------
 arch/arm/boot/dts/tegra124-nyan.dtsi                       | 17 +++++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts |  2 +-
 7 files changed, 96 insertions(+), 73 deletions(-)
