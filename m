Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C3C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912262082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ql+oyCc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912262082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbeLBTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 14:23:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37402 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLBTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 14:23:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so7544650lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oWQtvkC4jHttd2nA6F2crVgTyhj04+H6PphOVG/w+WY=;
        b=ql+oyCc3yWJmFc78BznASs8JcwcNFrwZ0XfjEhI4FloGXA5eoCYsxMQjx2IwyII1AY
         T6rZDrksaDcuT5mivIvgqTpdpG7CeoF3O98YJxZiL66SXiKWuYIIW+6EFa1H4g007Z9f
         8E9qzcSAFGbKkEaIrvpyqUpU+r3DRTTYLGTMuzDDtJY5Jqe42pn2ofjLYyxbV8OGn/My
         vAA914jW550Fc7NdeTMrLiSLK1oD1Q9yBfRA6xvc1Z9VTaaczAa+4OWfQC77eYXDyQFI
         lcwCcScgjwer7m5L2Ly+XE3HOezxuZIZGBiJOaTtodDY1E5XbkK6oClVT5vPRcxXdvZ5
         Gj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oWQtvkC4jHttd2nA6F2crVgTyhj04+H6PphOVG/w+WY=;
        b=hZLDNGPfX+Xia9FFEwnHBqYQwav7Obf3Fn0ko44zbHJcXMQcoJmvXnoiCPMXiMrOO1
         htjFh5Bsy6bxPr4zqzd02CIo5gXtdGkM1YfxVjOb4a6YKUW2uNZ7s8vAiokAIAc7sk7X
         2VF2XTtO/89/ywnMTGyc8EN/poNdp6p/XlkGLuC7j9QzA/Mlkv9+6tDuvgvJj9Z08sum
         xP3lbtzBnDdfTwrB8mOXkkc4s7TawxtfAwx4dy6w2lqXG+xbvLCvzU7zUZAlGdLCIsGR
         /w72loPogW+4mkuK91ipHkT4GIk6YusmMl4/Ir50mCPNCJNrzKn5Ki+8+WTKmVcIaazQ
         4n3w==
X-Gm-Message-State: AA+aEWaqqQHDa+vQkgpG4pL5Q7jLO9K46XVbvPAvgOlLkh4ZYtQLx+V0
        FpXiPCTGwlGo8D0lhfvPsS3vAQ==
X-Google-Smtp-Source: AFSGD/WX+byf3moCVQCy/p8tfthpqhgtl5ILD9a6mLljbtXlEnm2H2XeIOx7Ex1Zp5nrSC2iJau8Uw==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr7599071lfg.13.1543778590176;
        Sun, 02 Dec 2018 11:23:10 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p67sm1942529lfe.14.2018.12.02.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 11:23:08 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:23:01 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181202192301.wty5dpqayobx3i67@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit a89f84a56ec95fd66b839bf9c545f8a59a4ffcd5:

  Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into fixes (2018-11-07 08:09:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to bfed4d730823440d0da0cd21554efc2de831627d:

  Merge tag 'imx-fixes-4.20-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2018-11-30 11:57:53 -0800)

----------------------------------------------------------------
ARM: SoC fixes

Volume is a little higher than usual due to a set of gpio fixes for
Davinci platforms that's been around a while, still seemed appropriate
to not hold off until next merge window.

Besides that it's the usual mix of minor fixes, mostly corrections of
small stuff in device trees.

Major stability-related one is the removal of a regulator from DT on
Rock960, since DVFS caused undervoltage. I expect it'll be restored once
they figure out the underlying issue.

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: am3517: Fix pinmuxing for CD on MMC1
      ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
      ARM: dts: am3517-som: Fix WL127x Wifi interrupt

Andy Gross (1):
      MAINTAINERS: Remove unused Qualcomm SoC mailing list

Bartosz Golaszewski (12):
      ARM: davinci: da8xx: define gpio interrupts as separate resources
      ARM: davinci: dm365: define gpio interrupts as separate resources
      ARM: davinci: dm646x: define gpio interrupts as separate resources
      ARM: davinci: dm355: define gpio interrupts as separate resources
      ARM: davinci: dm644x: define gpio interrupts as separate resources
      gpio: davinci: restore a way to manually specify the GPIO base
      ARM: davinci: da850: set the GPIO base to 0
      ARM: davinci: dm365: set the GPIO base to 0
      ARM: davinci: dm646x: set the GPIO base to 0
      ARM: davinci: dm355: set the GPIO base to 0
      ARM: davinci: da830: set the GPIO base to 0
      ARM: davinci: dm644x: set the GPIO base to 0

Bjorn Andersson (2):
      arm64: dts: sdm845-mtp: Reserve reserved gpios
      arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP

Christoph Muellner (1):
      arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Daniel Lezcano (1):
      arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues

Fabio Estevam (1):
      ARM: dts: imx51-zii-rdu1: Remove EEPROM node

Heiko Stuebner (1):
      ARM: dts: rockchip: Remove @0 from the veyron memory node

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Jon Mason (1):
      MAINTAINERS: Remove self from Broadcom SoCs

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Olof Johansson (9):
      Merge tag 'qcom-fixes-for-4.20-rc1' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'am654-fixes-for-v4.20' of git://git.kernel.org/.../kristo/linux into fixes
      Merge tag 'arm-soc/for-4.20/maintainers-part2' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'at91-4.20-fixes' of git://git.kernel.org/.../at91/linux into fixes
      Merge tag 'v4.20-rockchip-dts32fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'v4.20-rockchip-dts64fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'davinci-fixes-for-v4.20' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'omap-for-v4.20/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.20-2' of git://git.kernel.org/.../shawnguo/linux into fixes

Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

Tony Lindgren (1):
      Merge branch 'fixes-dts' into omap-for-v4.20/fixes

Vignesh R (1):
      arm64: dts: ti: k3-am654: Fix wakeup_uart reg address

 MAINTAINERS                                        |  3 --
 arch/arm/boot/dts/am3517-evm.dts                   |  2 +-
 arch/arm/boot/dts/am3517-som.dtsi                  |  2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  6 ----
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  6 +++-
 arch/arm/boot/dts/sama5d2.dtsi                     |  2 +-
 arch/arm/mach-davinci/da830.c                      |  4 ++-
 arch/arm/mach-davinci/da850.c                      |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c              | 40 ++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c                      | 32 +++++++++++++++++
 arch/arm/mach-davinci/dm365.c                      | 37 ++++++++++++++++++++
 arch/arm/mach-davinci/dm644x.c                     | 22 ++++++++++++
 arch/arm/mach-davinci/dm646x.c                     | 12 +++++++
 arch/arm/mach-omap1/board-ams-delta.c              |  3 ++
 arch/arm/mach-omap2/prm44xx.c                      |  2 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  4 +++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |  4 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   | 12 -------
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |  2 +-
 drivers/gpio/gpio-davinci.c                        |  2 +-
 include/linux/platform_data/gpio-davinci.h         |  2 ++
 24 files changed, 176 insertions(+), 33 deletions(-)
