Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097F42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FL67JfrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097F42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIHAYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:24:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52353 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIHAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:24:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id y139-v6so15632272wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vcze1pYGJmRre+gqBos2+YZh6l7eutC3oO5Gb+shdGM=;
        b=FL67JfrK0ODDs5HLs+TbZp0kZOogIDm2vrOwBcTGxeir06+H2YAgOomiWkbNtPMfda
         R695fjU7hU31QDiPJtjf0S5WXA7vkp6ngIEuS+E1ic612D8y1AwBehb27GDBQ94H9CVc
         /PAm5ukHC2kTwtO1oVHJ1itu8ID7ipNGaC95OdAQcUE69B/a0PfCkLvByHVmLZkIHJoS
         iPcqDQAK7cxN0KxPCMoKyWxXQdPwBXBPNTVcoMddzf+3wqGMLs5UWYquUZUFSmNyTyHC
         XD+kuscKC1886VCOQ6wCTsrP+p2KlavuKp+7/m92baFF30iO170WRaSD1/fxJSKR243S
         Q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vcze1pYGJmRre+gqBos2+YZh6l7eutC3oO5Gb+shdGM=;
        b=FMT7UwjzcELlcV++3LH07o/Wcu/vFHqn2GMNXu7yodpV0JUKZRrR823EvtvVNjGCI3
         Vj0LfzUua0hzri7NMMYvdwvLAuzXun61X1yHz3eO6FK7+GSlSv9Oc1N2QWQ726MGOQTg
         KyEUxhfOi8E1RTQhRxVdqmePZ6EFpylQF791fIDP23yeO6mOsK5oU5wNUF3oJDm5Kuxh
         ze0mqOLrywhekaiKj5D8ymyPcR+Q6K5SKtncDmKM0k+fQGFFKD3zQQWSF4bLepmw6sDU
         2hD6QgKzyHMF+VuvfhW6mI0/ICW17e8OyrVE/Qfi1jlVMY6qQaBDFqjFpuXgqKExkVQd
         PuMw==
X-Gm-Message-State: APzg51DDU0/Esjr/QHsTlKXJqKrxkdFapuDvfGOav5NVFQ40SoG0Xcdh
        b505Vx/8TThGe7bNIVFZAzTA4Q==
X-Google-Smtp-Source: ANB0VdYdj+Cy5q69Wxlex6Hhpbp7EmucrJPP4seuhZfgTyJjyOoew3QOv2OKbYBGb5FzHRD+/swzjw==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr5923035wmc.81.1536349339071;
        Fri, 07 Sep 2018 12:42:19 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y17-v6sm11700133wrh.49.2018.09.07.12.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 12:42:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/5] introduce setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 functions
Date:   Fri,  7 Sep 2018 19:41:42 +0000
Message-Id: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset adds a new set of functions which are open-coded in lot of
place.
Basicly the pattern is always the same, "read, modify a bit, write"
some driver already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)

The first patch rename some powerpc funtions which already use the same name (xxxbits32)
but with only bigendian values.

The second patch adds the header.
The third patch is an ugly try to implement a coccinelle semantic patch to
find all place where xxxbits function could be used.
Probably this spatch could be better written and I didnt found an easy way to add the "linux/setbits" header.

The two last patch are example of convertion of two drivers.
Thoses patchs give an example of the reduction of code won by using xxxbits32.

This patchset is tested with the ahci_sunxi and dwmac-sun8i drivers.

Regards

Corentin Labbe (5):
  powerpc: rename setbits32/clrbits32 to setbits32_be/clrbits32_be
  include: add
    setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
    linux/setbits.h
  coccinelle: add xxxsetbitsXX converting spatch
  net: ethernet: stmmac: use xxxsetbits32
  ata: ahci_sunxi: use xxxsetbits32 functions

 arch/powerpc/include/asm/fsl_lbc.h                 |   2 +-
 arch/powerpc/include/asm/io.h                      |   5 +-
 arch/powerpc/platforms/44x/canyonlands.c           |   4 +-
 arch/powerpc/platforms/4xx/gpio.c                  |  28 +-
 arch/powerpc/platforms/512x/pdm360ng.c             |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  10 +-
 arch/powerpc/platforms/82xx/ep8248e.c              |   2 +-
 arch/powerpc/platforms/82xx/km82xx.c               |   6 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c          |  10 +-
 arch/powerpc/platforms/82xx/pq2.c                  |   2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   4 +-
 arch/powerpc/platforms/82xx/pq2fads.c              |  10 +-
 arch/powerpc/platforms/83xx/km83xx.c               |   6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       |   4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   4 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |   4 +-
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   4 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |   2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   4 +-
 arch/powerpc/platforms/8xx/adder875.c              |   2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |   4 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c       |   4 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |  28 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   8 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |  10 +-
 arch/powerpc/sysdev/cpm1.c                         |  26 +-
 arch/powerpc/sysdev/cpm2.c                         |  16 +-
 arch/powerpc/sysdev/cpm_common.c                   |   4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   8 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   8 +-
 arch/powerpc/sysdev/fsl_pmc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_rcpm.c                     |  74 ++--
 arch/powerpc/sysdev/fsl_rio.c                      |   4 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   8 +-
 arch/powerpc/sysdev/mpic_timer.c                   |  12 +-
 drivers/ata/ahci_sunxi.c                           |  51 +--
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  54 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  55 +--
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  21 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  51 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  13 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  42 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  17 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  30 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  69 +---
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  11 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   7 +-
 include/linux/setbits.h                            |  55 +++
 scripts/coccinelle/misc/setbits.cocci              | 423 +++++++++++++++++++++
 56 files changed, 776 insertions(+), 489 deletions(-)
 create mode 100644 include/linux/setbits.h
 create mode 100644 scripts/coccinelle/misc/setbits.cocci

-- 
2.16.4

