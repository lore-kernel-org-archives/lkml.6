Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798120842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="yINUIa+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAMTsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 14:48:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43204 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAMTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 14:48:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so14133161lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=re7/aNLLQBL9zd8wPf1h0I9182Lzz9Ue94vXz/CzSN4=;
        b=yINUIa+rixKEqRCJLqW16A5uuIOB1M8pQ+L8BYWtAIbs6H2XcYifSIRHE0XK6fGykC
         cYqGTsv6JopuRey4JDO7HyVMR5rSNvB/syWQ5jjgqetDBU1esaCSiCfj861USxEEbnQW
         VjmSkAbeiegXRAUT87e1RRq3wIJ6D8TO7s7s2o28cNshl7PWqApmxfU2ZDQYTyuA1QO+
         SnwnYd6+pFUcI5VZbr/kKyNrnHiSxq5qWeOZTu2zDx4Z5rCVYw8zrmk5OJPxaJuQKRo7
         c/AlYoKY4F8x2JIj0+Dn9MBT3mKvRZz1H/5I+FpPRvO8x2Vb6kgHLcL/clk+8s/hITn/
         Uzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=re7/aNLLQBL9zd8wPf1h0I9182Lzz9Ue94vXz/CzSN4=;
        b=FFqMXRz//LCQp8uOfjTGqQ9rsylWZ1+WJd3qQo1vdc0gijEaW0HBrUlHIPVUPlexY9
         idsoimLqbrkNnXhXtjuiRxR1beQDyzlmIfF85jO4zQWxi9KsYlDCZ/Q5a48GcIa79Oh7
         IdNPhdkaLJ20YElrjo8uBU6ZGYWZU4H+CahsLITy6RZXdm3Mc+uvpaHiHS6a0MDCVNFG
         V9PfvItlevCWtCxxbuduvy+E+40rxWU56IWUUIoi+b1zyQiscUmRUaBr+Zk/O8npFK6/
         3Ol+xvb34T76+jrQroIsBVVveajVjPrAo466v/4BPoOJooTgLiWMEumh3aYn5Jj+b2rC
         vL0A==
X-Gm-Message-State: AJcUukc1N0Om5rNWJuSkwgIJOUy4Co54/+/U5fl1TFM5c3SQnShoqqTW
        o8z2KlRHg9mXuUpB1vYC6zLEn57L4w8nKw==
X-Google-Smtp-Source: ALg8bN6L29b9ZMog+JySw768nPCe7xx+9zJeR6LoSAjubJev9aH00Albcfvm5SYF1vHiqK86n9susw==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr11432625lfd.74.1547405315768;
        Sun, 13 Jan 2019 10:48:35 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v64sm15619026lfa.48.2019.01.13.10.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 10:48:33 -0800 (PST)
Date:   Sun, 13 Jan 2019 10:48:25 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190113184825.ogv3cmshi63hxlgj@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 465612178b44840b2066e62c3bcfae80862011d4:

  Merge tag 'reset-for-5.0-rc2' of git://git.pengutronix.de/git/pza/linux into fixes (2019-01-12 22:06:54 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A bigger batch than I anticipated this week, for two reasons:

 - Some fallout on Davinci from board file -> DTB conversion, that also
 includes a few longer-standing fixes (i.e. not recent regressions).

 - drivers/reset material that has been in linux-next for a while, but
 didn't get sent to us until now for a variety of reasons (maintainer out
 sick, holidays, etc). There's a functional dependency in there such that
 one platform (Altera's SoCFPGA) won't boot without one of the patches;
 instead of reverting the patch that got merged, I looked at this set
 and decided it was small enough that I'll pick it up anyway. If you
 disagree I can revisit with a smaller set.

That being said, there's also a handful of the usual stuff:

 - Fix for a crash on Armada 7K/8K when the kernel touches PSCI-reserved
 memory
 - Fix for PCIe reset on Macchiatobin (Armada 8K development board, what
 this email is sent from in fact :)
 - Enable a few new-merged modules for Amlogic in arm64 defconfig
 - Error path fixes on Integrator
 - Build fix for Renesas and Qualcomm
 - Initialization fix for Renesas RZ/G2E

 + A few more fixlets.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: fix build regressions

Bartosz Golaszewski (5):
      ARM: davinci: da830-evm: fix label names in GPIO lookup entries
      ARM: davinci: da850-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
      ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

Baruch Siach (1):
      arm64: dts: marvell: mcbin: fix PCIe reset signal

Biju Das (1):
      soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}

Colin Ian King (1):
      reset: fix null pointer dereference on dev by dev_name

Dinh Nguyen (2):
      reset: socfpga: add an early reset driver for SoCFPGA
      ARM: socfpga: dts: document "altr,stratix10-rst-mgr" binding

Eugeniy Paltsev (1):
      ARC: HSDK: improve reset driver

Fabio Estevam (1):
      qcom-scm: Include <linux/err.h> header

Geert Uytterhoeven (2):
      reset: Improve reset controller kernel docs
      reset: Add reset_control_get_count()

Gustavo A. R. Silva (1):
      ARM: integrator: impd1: use struct_size() in devm_kzalloc()

Heinrich Schuchardt (1):
      arm64: dts: marvell: armada-ap806: reserve PSCI area

Jerome Brunet (1):
      arm64: defconfig: enable modules for amlogic s400 sound card

Kunihiko Hayashi (4):
      dt-bindings: reset: uniphier: Replace the expression of USB3 with generic peripherals
      reset: uniphier-usb3: Rename to reset-uniphier-glue
      dt-bindings: reset: uniphier: Add AHCI core reset description
      reset: uniphier-glue: Add AHCI reset control support in glue layer

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Olof Johansson (7):
      Merge tag 'renesas-fixes-for-v5.0' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'davinci-fixes-for-v5.0' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'qcom-fixes-for-5.0-rc1' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'integrator-fixes-armsoc' of git://git.kernel.org/.../linusw/linux-integrator into fixes
      Merge tag 'mvebu-fixes-5.0-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'reset-for-5.0-rc2' of git://git.pengutronix.de/git/pza/linux into fixes

Peter Ujfalusi (4):
      ARM: dts: da850-evm: Correct the audio codec regulators
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the audio codec regulators
      ARM: dts: da850-lcdk: Correct the sound card name

 .../devicetree/bindings/reset/socfpga-reset.txt    |  3 +-
 .../devicetree/bindings/reset/uniphier-reset.txt   | 25 +++---
 arch/arm/boot/dts/da850-evm.dts                    | 31 ++++++--
 arch/arm/boot/dts/da850-lcdk.dts                   | 38 +++++++++-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  4 +-
 arch/arm/mach-davinci/board-da830-evm.c            |  4 +-
 arch/arm/mach-davinci/board-da850-evm.c            |  4 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |  4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |  4 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  4 +-
 arch/arm/mach-integrator/impd1.c                   |  8 +-
 arch/arm/mach-socfpga/socfpga.c                    |  4 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 17 +++++
 arch/arm64/configs/defconfig                       |  4 +
 drivers/reset/Kconfig                              | 20 +++--
 drivers/reset/Makefile                             |  3 +-
 drivers/reset/core.c                               | 42 +++++++++++
 drivers/reset/reset-hsdk.c                         |  1 +
 drivers/reset/reset-simple.c                       | 13 +---
 drivers/reset/reset-socfpga.c                      | 88 ++++++++++++++++++++++
 ...reset-uniphier-usb3.c => reset-uniphier-glue.c} | 50 +++++++-----
 drivers/soc/renesas/Kconfig                        |  2 +-
 drivers/soc/renesas/r8a774c0-sysc.c                | 23 +-----
 include/linux/qcom_scm.h                           |  1 +
 include/linux/reset.h                              | 15 +++-
 26 files changed, 321 insertions(+), 93 deletions(-)
 create mode 100644 drivers/reset/reset-socfpga.c
 rename drivers/reset/{reset-uniphier-usb3.c => reset-uniphier-glue.c} (73%)
