Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B631C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E2420883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cF/lbiPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E2420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeIYBID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:08:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46456 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbeIYBID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:08:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so8956899wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CXzqLYDJT5LdMFeEVSUl94tAA+pEPy0TinYRdbAL5OE=;
        b=cF/lbiPGCIm7zb0NVTJvQjrQ9jblElUxUkPR4HtQI/bDqOKaRR9z7UkXu3p73+r8KZ
         1Jc46oQNZgXVmFFfoS40heI0CzECi/qlA824Mf96eNp86XXpQ5rmvcnvN+JsH9hJy4Cp
         ASrRuZDJ3DASjxVbwhVJU4kA+F0humbTfWDWRBa7uFD7CJhJbIiX3c1Oi/u3WbHevqzT
         TNdv9eQslFnprUr0b6qo7471XaniQDeWda0IHjY5qF6ZEpyqlZtzG/N+clJnaS8jT067
         rCl+COO5AWVGo1/YMxpnI/QmJugKzoOhSKPxE6eToiLPvNBr4bcQMelt/PU8CcBTFddJ
         NMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CXzqLYDJT5LdMFeEVSUl94tAA+pEPy0TinYRdbAL5OE=;
        b=Y6k1IR1qRPYAyXEI5lYxt7vq4geSYtEuTT5SXi3UiLMCfzd5uykcUndF3QjBo/NWnZ
         ppXKG6FDMjVDKYSq/fA2LYx3K2q8nm6qXFi+7VXXBPRU88B3IJ/DMoaPsJIaBRWwyx5r
         9BDMOmYhOCGuxSKYQlnFOApxiLslGqEdG0keO3OqX3JcpwXxwaB3IZwVr2fMdsDvmHNp
         s27qL+ECl1uTGOdaiVz3YkRUm8rE22AI7+1SnNJ5VHmeOgoukO6nICLFMFYW79z3YEwy
         K+lcXipj/cjRgoMYdalitsGNTcIuB9fzuHZVJOH3Id2Lz0zwp3ZO0V175oBzUuMF3w0L
         tadA==
X-Gm-Message-State: ABuFfogQr54EIESkMJ2Na/QtewzqjEjypyEQF0j+pcsPNfSv69FqKmYF
        CQwSiwbmNdWkfWWfPXcrqOiXLw==
X-Google-Smtp-Source: ACcGV60KCy6nkmSpa7hOv1wUwZrswRGOY6XMgZUvZa+g+cjcwIWEpGy5m62J0o/pDoqgzJxexJDMmQ==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr140270wrc.45.1537815866454;
        Mon, 24 Sep 2018 12:04:26 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm27721433wmd.32.2018.09.24.12.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 12:04:25 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/7] include: add setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Date:   Mon, 24 Sep 2018 19:04:09 +0000
Message-Id: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset adds a new set of functions which are open-coded in lot of
place.
Basicly the pattern is always the same, "read, modify a bit, write"
some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)

The first patch rename some powerpc funtions for being consistent with
the new name convention.

The second patch adds the header with all setbits functions.

The third patch is a try to implement a coccinelle semantic patch to
find all place where xxxbits function could be used.
It should not be merged since it is un-finalized.
For the moment, the "add setbits.h header" is not working and need a future
coccinelle version.

The four last patch are example of some drivers convertion.
Thoses patchs give an example of the reduction of code won by using xxxbits32.

I would like to thanks Julia Lawall for her help on the coccinelle
patch.

Regards

Changes since v1:
- renamed LE functions to _leXX
- updated coccinnelle patch with JLawall's comments

Corentin Labbe (7):
  powerpc: rename setbits32/clrbits32 to setbits32_be/clrbits32_be
  include: add
    setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
    linux/setbits.h
  coccinelle: add xxxsetbitsXX converting spatch
  ata: ahci_sunxi: use xxxsetbits32 functions
  net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits32
  drm: meson: use xxxsetbits32
  net: stmmac: dwmac-meson8b: use xxxsetbits32

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
 drivers/gpu/drm/meson/meson_crtc.c                 |  14 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  33 +-
 drivers/gpu/drm/meson/meson_plane.c                |  13 +-
 drivers/gpu/drm/meson/meson_registers.h            |   3 -
 drivers/gpu/drm/meson/meson_venc.c                 |  13 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |   4 +-
 drivers/gpu/drm/meson/meson_viu.c                  |  65 +--
 drivers/gpu/drm/meson/meson_vpp.c                  |  22 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  56 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  62 +--
 include/linux/setbits.h                            |  88 ++++
 scripts/add_new_include_in_source.py               |  61 +++
 scripts/coccinelle/misc/setbits32.cocci            | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits32_relaxed.cocci    | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits64.cocci            | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits_dev.cocci          | 235 ++++++++++
 58 files changed, 2159 insertions(+), 377 deletions(-)
 create mode 100644 include/linux/setbits.h
 create mode 100755 scripts/add_new_include_in_source.py
 create mode 100644 scripts/coccinelle/misc/setbits32.cocci
 create mode 100644 scripts/coccinelle/misc/setbits32_relaxed.cocci
 create mode 100644 scripts/coccinelle/misc/setbits64.cocci
 create mode 100644 scripts/coccinelle/misc/setbits_dev.cocci

-- 
2.16.4

