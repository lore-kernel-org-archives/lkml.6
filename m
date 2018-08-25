Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566920652
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 21:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iNqz6gKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0566920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeHZAv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 20:51:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38476 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeHZAv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 20:51:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so9128778lfh.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dvd4Ml9kGEKoh6mxbHvryBDCiZLfRpN9NBpPfZ4qgTA=;
        b=iNqz6gKu+CkN4tr41eYSMcyCZ9ilXEkFOMYyDdYUZ0r6snzYCjYu51Ounvf4a0sDLb
         wbb+3w9CCiDNtPG7bDx1KVmNYhDtGsjTFC3QbQ1zr1aKv01VTLGz/bsNJOUxT54AMrVF
         Zq4505blxpAkJb6rTUMzzXNbWl5VFCsdPemApKSAS/Bnt3+16FF4Bz38rfiEF0UmUsLB
         s9bvM/0EvlkyLDw3K8DpXbATauWvx3flwrXxUhbJQCQy+6vwwCdNYv3DOCduFuGthRzn
         mhHdJWUwY11GKf/POZTKKVWbzfyR1f4t/YIu2sohX5prnztZYsAsM8IF767CDD4+lKTG
         ngKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dvd4Ml9kGEKoh6mxbHvryBDCiZLfRpN9NBpPfZ4qgTA=;
        b=EPR4bbac78gaVPvi2nnpGi2a2QaIZdwHXv6HtTgEDTY/hGyrTRk20i1qZpOKOQizi9
         dtOSvyx6WmKSD880IOvvNAvK0woHppKrRyLEs/fnE0XuF+MZ0LurDXWtG3xhTiKTlCJU
         2kLGigNqOO3MO8Q/QLcEqeHCtLC8NG0Biw3tiBa/qXaVWv3EUFUc+bTNgH9qv6Yb3m+F
         GgqFR/lxdF002HsSv8FWbfzqgUEvE2oG1jG+jUxM9wfKxq0enfCONaq9BGud/gH/GKsD
         2KhQ5JybdAdECyWb3UQsuRe05W7EVAie4+chRp+ImeIHjG8fLNlkGYZtMXoX3nFN9NI5
         PWhw==
X-Gm-Message-State: APzg51Ap8Xwo/23py8zR+VbJp6UKorskByMTu4G/lCD/g9N2PBf9E/r/
        tW+rWLHtSqXJsB//nssib4yUjw==
X-Google-Smtp-Source: ANB0Vdav71E+cGoou49zrAl5o6J3/pZ64OYTXjnnZLPLWx2QIjC3nsqjj5lIZ0wntZALf2wlYYGLaQ==
X-Received: by 2002:a19:9355:: with SMTP id v82-v6mr4423493lfd.134.1535231480389;
        Sat, 25 Aug 2018 14:11:20 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d6-v6sm1976016lfb.30.2018.08.25.14.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Aug 2018 14:11:17 -0700 (PDT)
Date:   Sat, 25 Aug 2018 12:29:27 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC late branch
Message-ID: <20180825192927.votock3x5zpwplzo@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 29ed45fff05899f6f39d05fe1c32b1bc51f8926b:

  Merge tag 'v4.18-next-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into next/drivers (2018-07-26 13:08:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 1aa55ca9b14af6cfd987ce4fdaf548f7067a5d07:

  iommu/rockchip: Move irq request past pm_runtime_enable (2018-08-24 08:50:32 -0700)

----------------------------------------------------------------
ARM: SoC: late updates

A couple of late-merged changes that would be useful to get in this
merge window:

 - Driver support for reset of audio complex on Meson platforms. The
   audio driver went in this merge window, and these changes have been
   in -next for a while (just not in our tree).

 - Power management fixes for IOMMU on Rockchip platforms, getting
   closer to kexec working on them, including Chromebooks.

 - Another pass updating "arm,psci" -> "psci" for some properties that
   have snuck in since last time it was done.

----------------------------------------------------------------
Amit Kucheria (1):
      arm64: dts: Fix various entry-method properties to reflect documentation

Jerome Brunet (2):
      reset: meson: add dt-bindings for meson-axg audio arb
      reset: meson: add meson audio arb driver

Leonard Crestez (1):
      reset: imx7: Fix always writing bits as 0

Marc Zyngier (4):
      ARM: rockchip: Force CONFIG_PM on Rockchip systems
      arm64: rockchip: Force CONFIG_PM on Rockchip systems
      iommu/rockchip: Handle errors returned from PM framework
      iommu/rockchip: Move irq request past pm_runtime_enable

Olof Johansson (2):
      Merge tag 'reset-for-4.19-2' of git://git.pengutronix.de/git/pza/linux into next/late
      Merge tag 'reset-fixes-for-4.18' of git://git.pengutronix.de/git/pza/linux into next/late

 .../devicetree/bindings/arm/cpu-capacity.txt       |   2 +-
 .../devicetree/bindings/arm/idle-states.txt        |   4 +-
 .../bindings/reset/amlogic,meson-axg-audio-arb.txt |  21 +++
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                |   2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                |   2 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   2 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  45 +++---
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-imx7.c                         |   2 +-
 drivers/reset/reset-meson-audio-arb.c              | 168 +++++++++++++++++++++
 .../reset/amlogic,meson-axg-audio-arb.h            |  17 +++
 20 files changed, 257 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 drivers/reset/reset-meson-audio-arb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
