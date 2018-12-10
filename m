Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D5C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9522020831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="M+EvPVql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9522020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLJBXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:23:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44269 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeLJBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:23:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so8062627lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t/UBLbdynFhlbFxqKQdNUI6XlqKT8uSedEKVSAFRuYw=;
        b=M+EvPVql2IFAZHpmIgC+srA2Ar4e6TE5urPh8b9VIwzYX+mVUzTT3YKtKA8w/kZmJG
         NVYEOyEVmubFU63Qk1rwCNbZsKphdG4wc0mPkCcENdKESCAV42jHAsHJ7x9Q5xamvq0K
         P4ZBN2SpuUmezkfSRdgTVX3Vrh+PeRa0INog80+59/YGLDFSHkqTwkn1IvdCUTh5cmk1
         SP6J6cnJwhBlSF71TfPtpxC0Q50YKffd7EqaQKXT03XxvxRtO6qYQTUHR6mDqaGg5E3T
         He8rQ6gttZaKsHBoM4rjnt8zo/7iFN3KaTb74xZUn/EHUI2jgzuJAY4ySwYSu6cFCMeX
         7xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t/UBLbdynFhlbFxqKQdNUI6XlqKT8uSedEKVSAFRuYw=;
        b=LYwZmoClVhc6ss68if9gX68UznhOxITaKIex5P2Hqfjf2D4OMYrczhp0IhcKwqXbzq
         m7Pc3ss6YopTNwi4CgzLcV73w/Rc7sat77mOF5TgXMoQ6I2NFJy8yKiXQXOFQhM1+8wz
         7VN2lyoEY0XG+oNHxYsGsUtRETdBXpgxP8spfFMq5EOZhBbDCsP0cBZoO4gcXNprbl6/
         YCJ2jt3/kdGPV9rU6al5sxSd4jAahkW4B5nZTMpcl5g7VH3QryG4SKnIXSVswlqpKiON
         /T/ecvt84cuzUI46KtNhhIB7qZG3kd3jz97S6ST6iAXHUkrrKUle/pjZFbx29/KRPWP0
         50Kw==
X-Gm-Message-State: AA+aEWa4dH4x/R/3hGwRCN3ve5Cma6GmUL1VFkc2ySW0yysE3UwNE47u
        QWZH41Hr+Vs+FMf8olQy5W6nNf/EFfo=
X-Google-Smtp-Source: AFSGD/VCUuybhWj6sw1YX0xk0ZBQ6d9BNsTGliJqilFbL47+nBvrcbndU6cGHCIxiaqMw5XTFoePqQ==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr6519576lju.8.1544405032697;
        Sun, 09 Dec 2018 17:23:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id c88-v6sm1885646ljf.60.2018.12.09.17.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 17:23:51 -0800 (PST)
Date:   Sun, 9 Dec 2018 17:23:35 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181210012335.jmxsw4yyj66lrbsp@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 0603a9a84679eb12d9dadb97f4e0ba017e684c7b:

  Merge tag 'mvebu-fixes-4.20-1' of git://git.infradead.org/linux-mvebu into fixes (2018-12-09 10:28:02 -0800)

----------------------------------------------------------------
ARM: SoC fixes

The usual batch; most of them are DT tweaks to fix misdescribed
hardware. Beyond that:

 - A bugfix for MMP2 CPU detection, it's been there quite a while but
   makes sense to fix now anyway.
 - Some power management tweaks;
   + disabling of CPU idle power state on Marvell Armada 7K/8K (Macchiatobin et al)
   + Increase of minimum voltage on BananaPi M3
   + Tweak of power ramp time for DVFS on NXP/Freescale i.MX7SX
 - A couple of MAINTAINER updates; MMP has a new volunteer to look after
   it, and Mediatek adds a few keywords, IRC channel and wiki URL.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Baruch Siach (1):
      Revert "arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K"

Corentin Labbe (1):
      ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V

Fabio Estevam (2):
      ARM: dts: imx7d-pico: Describe the Wifi clock
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Lubomir Rintel (2):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
      MAINTAINERS: update entry for MMP platform

Matthias Brugger (1):
      MAINTAINERS: mediatek: Update SoC entry

Olof Johansson (5):
      Merge tag 'v4.19-next-fixes' of https://git.kernel.org/.../matthias.bgg/linux into fixes
      Merge tag 'arm-soc/for-4.20/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'imx-fixes-4.20-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sunxi-fixes-for-4.20' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'mvebu-fixes-4.20-1' of git://git.infradead.org/linux-mvebu into fixes

Rob Herring (1):
      ARM: dts: realview: Fix some more duplicate regulator nodes

Ryder Lee (3):
      arm64: dts: mt7622: fix no more console output on rfb1
      arm64: dts: mt7622: fix no more console output on BPI-R64 board
      arm64: dts: mt7622: Drop the general purpose timer node

Stefan Wahren (1):
      ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

 CREDITS                                            |  8 +++++++
 MAINTAINERS                                        | 11 +++++----
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  4 ++--
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |  4 ++--
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |  9 ++++++--
 arch/arm/boot/dts/imx7d-pico.dtsi                  | 22 +++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |  2 +-
 arch/arm/mach-mmp/cputype.h                        |  6 +++--
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  4 ----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 27 ----------------------
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  7 +++++-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  7 +++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 10 --------
 16 files changed, 67 insertions(+), 62 deletions(-)
