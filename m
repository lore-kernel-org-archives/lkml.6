Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F7121A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbfBPUVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:21:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33600 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbfBPUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:21:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so15029473qtz.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 12:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OAYI86GP7FBxDrkNOtDB+j4T8A5VXyFEaWAq+fHWQ0k=;
        b=jUqEXhuiVwtwobn8h1SVW3GJLUYj8TFXc/qaEB8hoPGkF9ZsIRB1zQNotAbRot3h45
         4TNKCKFJ2ijk4xY9iP1D2siN8bQtV8UfRY7O1h1XnTEjK9CiOMOQQxvuumwbw/ES+WmD
         mzGBn9Xa/VwB78k75ai/J4jOqldoVF1uqEKN0NuilkakOqaxhe98XOLKUFOqZicel7AU
         lMyFjKaPmsW8ysJa3h71GQjBp3OfQmnVYOJPz2IE8vht0AEtgTpVX9HZyxlnoR5Qgaoc
         7mtFdSY0YFOOJg26o5i+rts70l4mWj7yciFKFL3qFiw99HagO7lf8OO/iXgv+wMaTUJ8
         B0Lg==
X-Gm-Message-State: AHQUAubsk2aA+R1oaBVZnxxceC6uJKF886YPt8UHtozGVghJZx49hWuh
        ezOb9FtSMFa1ApsPf9BLgfxbWGwWEe3g3lk5e88=
X-Google-Smtp-Source: AHgI3Ia/2rsWZ8K/2zWyynt4pkoPhVdkNlUkukzVf6+l9kZ2DcdzJfacPmVF8o7JBsFlpp7UcyJdnPYTp0KubJa/xKs=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr11897047qve.180.1550348465878;
 Sat, 16 Feb 2019 12:21:05 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 16 Feb 2019 21:20:48 +0100
Message-ID: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 410d7360541c0e21b58e56b64e5bcdbec9c1d285:

  Merge tag 'omap-for-v5.0/fixes-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/fixes (2019-02-15 20:39:46 +0100)

----------------------------------------------------------------
This week is a much smaller update, containing fixes only for TI OMAP,
NXP i.MX and Rockchips platforms:

 - omap4 had problems with lost timer interrupts
 - another IRQ handling issue with OMAP5
 - A workaround for a regression in the pwm-omap-dmtimer driver

 - eMMC was broken on the new imx8mq-evk board

 - a fix for new dtc graph warnings and a regulator fix for rock64
 - USB support broke on rk3328-rock64

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'omap-for-v5.0/fixes-rc4' of
git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'v5.0-rockchip-dts32fixes-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
      Merge tag 'v5.0-rockchip-dts64fixes-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
      Merge tag 'imx-fixes-5.0-3' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc5' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Carlo Caione (1):
      arm64: dts: imx8mq: Fix boot from eMMC

Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin
and excavator

Johan Jonker (1):
      ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain

Russell King (1):
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug

Tony Lindgren (5):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra
      Merge branch 'pwm-dmtimer-fixes' into omap-for-v5.0/fixes-v2

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads()
could be uninitialized

 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 11 ++++++
 arch/arm/boot/dts/omap5-board-common.dtsi          |  9 +++--
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 12 +++++-
 arch/arm/boot/dts/rk3188.dtsi                      |  1 -
 arch/arm/mach-omap2/cpuidle44xx.c                  | 16 ++------
 arch/arm/mach-omap2/display.c                      |  7 +++-
 arch/arm/mach-omap2/omap-wakeupgen.c               | 36 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts       | 44 +++++++++++-----------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  2 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  2 +-
 drivers/bus/ti-sysc.c                              |  6 +--
 drivers/clocksource/timer-ti-dm.c                  |  5 ++-
 15 files changed, 109 insertions(+), 48 deletions(-)
