Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E699C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1455D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eTQKXXem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1455D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeJXQC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:02:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53574 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeJXQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:02:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f8-v6so1838502wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=++AfYWWrLqJTxzNSR1D5w/4MmESVT6V4dLevIoAsDqs=;
        b=eTQKXXemhvSI/pK7zTKaD+mADiv2JMTOOJqMt7IrXJHBUl/Vvj15p9uAg/h2aa1PyA
         8IjvpCq3NO2p/AVJieeA/Yb+uQt/jajn+Z9VCbq4KPFFOQ9wFBqfENpV8Wv7UlJ6AiWn
         +shG771dN4vpxm5glqVE6w6O9PeuBgHsKK1lFg/M/sqLW+5gb7FsnJDYVkNJXSvuJmnC
         ryPCDjm9m095pSV7Do4eXUYVFjCO+jLtSJ6se2KZvZxhuN+zb0g7KxWFnd/UgrD2ityy
         Tqr15Iezn0e8AliCFw3xvV9TfdiWAvEZq7HBsMoh/hCkC5lOS9uloU8eK0asYLeSLgU+
         tbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=++AfYWWrLqJTxzNSR1D5w/4MmESVT6V4dLevIoAsDqs=;
        b=QkWzmsZU0ZJg87SOLYK19yL2INXV1h6UcD6nstX49PH4GFIlQjyWBr4Ax3dNo4q7nZ
         DZjGLE6x60jVo0JlyvxI2j6eBv0VtuX14/b70bGXm+v1wTaNzdHjqYPEd0GvTTlph3lO
         VnTSWdxzkxnajAWZrpwndngQx9xiuHjU0fBPa39waj0Re5Ss+Wqsee69iEdqzbTh84vi
         eXIQh0tSat2VoFxLQTX+m3DRdR82wUsYFak9n7J6TX1UhUnhUClVHQ4JQhN3rTM1FLjr
         mNxSVOXiiw2t+a1SctWwQQ7ChpsTAyXvl2+Wx0kfGZWYw8LdNOGKfUbXaqXQl0ByUREe
         aU7g==
X-Gm-Message-State: AGRZ1gIaQXZUVq9olCRHgSznnLRrU4JLnDA80g1uFRHx20ffPNpfFRp9
        ch5UtngVIpvAhZpQo5nkuLWfBQ==
X-Google-Smtp-Source: AJdET5ecwasJrJmZYl29u6UbjMcKiY18v+XaQw7sjr2pJnkPVWhVoZuN/SqjF1g+GlxU+ZeQz1BkxQ==
X-Received: by 2002:a1c:a345:: with SMTP id m66-v6mr1497386wme.104.1540366561516;
        Wed, 24 Oct 2018 00:36:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b139-v6sm6254351wmd.36.2018.10.24.00.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 00:36:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/7] include: add setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Date:   Wed, 24 Oct 2018 07:35:46 +0000
Message-Id: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
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

The first patch rename some powerpc functions for being consistent with
the new name convention.

The second patch adds the header with all setbits functions.

The third patch is a try to implement a coccinelle semantic patch to
find all place where xxxbits function could be used.
It should not be merged since it is un-finalized.
For the moment, the "add setbits.h header" is not working and need a future
coccinelle version.

The four last patch are example of some drivers conversion.
Thoses patchs give an example of the reduction of code won by using xxxbits32.

I would like to thanks Julia Lawall for her help on the coccinelle
patch.

Note that I dont know which maintainer will take the linux/setbits.h include patch.

Regards

Changes since v2:
- Fixed patch title
- Fixed style problems
- shorted macro arguments name

Changes since v1:
- renamed LE functions to _leXX
- updated coccinnelle patch with JLawall's comments

Corentin Labbe (7):
  powerpc: rename setbits32/clrbits32 to setbits_be32/clrbits_be32
  include: add setbits_leXX/clrbits_leXX/clrsetbits_leXX in
    linux/setbits.h
  coccinelle: add xxxsetbits_leXX converting spatch
  ata: ahci_sunxi: use xxxsetbitsi_le32 functions
  net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits_le32
  drm: meson: use xxxsetbits_le32
  net: stmmac: dwmac-meson8b: use xxxsetbits_le32

 arch/powerpc/include/asm/fsl_lbc.h            |   2 +-
 arch/powerpc/include/asm/io.h                 |   4 +-
 arch/powerpc/platforms/44x/canyonlands.c      |   4 +-
 arch/powerpc/platforms/4xx/gpio.c             |  28 +-
 arch/powerpc/platforms/512x/pdm360ng.c        |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c  |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |  12 +-
 arch/powerpc/platforms/82xx/ep8248e.c         |   2 +-
 arch/powerpc/platforms/82xx/km82xx.c          |   6 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c     |  10 +-
 arch/powerpc/platforms/82xx/pq2.c             |   2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c  |   4 +-
 arch/powerpc/platforms/82xx/pq2fads.c         |  10 +-
 arch/powerpc/platforms/83xx/km83xx.c          |   6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c  |   4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c        |   6 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c       |   6 +-
 arch/powerpc/platforms/85xx/t1042rdb_diu.c    |   6 +-
 arch/powerpc/platforms/85xx/twr_p102x.c       |   2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c    |   6 +-
 arch/powerpc/platforms/8xx/adder875.c         |   2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c       |   4 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c  |   4 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c  |  28 +-
 .../platforms/embedded6xx/flipper-pic.c       |   6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |   8 +-
 arch/powerpc/platforms/embedded6xx/wii.c      |  12 +-
 arch/powerpc/sysdev/cpm1.c                    |  26 +-
 arch/powerpc/sysdev/cpm2.c                    |  16 +-
 arch/powerpc/sysdev/cpm_common.c              |   4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c         |  16 +-
 arch/powerpc/sysdev/fsl_lbc.c                 |   2 +-
 arch/powerpc/sysdev/fsl_pci.c                 |  12 +-
 arch/powerpc/sysdev/fsl_pmc.c                 |   2 +-
 arch/powerpc/sysdev/fsl_rcpm.c                |  74 +--
 arch/powerpc/sysdev/fsl_rio.c                 |   4 +-
 arch/powerpc/sysdev/fsl_rmu.c                 |   9 +-
 arch/powerpc/sysdev/mpic_timer.c              |  12 +-
 drivers/ata/ahci_sunxi.c                      |  62 +--
 drivers/gpu/drm/meson/meson_crtc.c            |  14 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  33 +-
 drivers/gpu/drm/meson/meson_plane.c           |  13 +-
 drivers/gpu/drm/meson/meson_registers.h       |   3 -
 drivers/gpu/drm/meson/meson_venc.c            |  13 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c       |   4 +-
 drivers/gpu/drm/meson/meson_viu.c             |  65 +--
 drivers/gpu/drm/meson/meson_vpp.c             |  22 +-
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   |  56 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  62 +--
 include/linux/setbits.h                       |  84 +++
 scripts/add_new_include_in_source.py          |  61 +++
 scripts/coccinelle/misc/setbits32.cocci       | 487 ++++++++++++++++++
 .../coccinelle/misc/setbits32_relaxed.cocci   | 487 ++++++++++++++++++
 scripts/coccinelle/misc/setbits64.cocci       | 487 ++++++++++++++++++
 scripts/coccinelle/misc/setbits_dev.cocci     | 235 +++++++++
 58 files changed, 2172 insertions(+), 395 deletions(-)
 create mode 100644 include/linux/setbits.h
 create mode 100755 scripts/add_new_include_in_source.py
 create mode 100644 scripts/coccinelle/misc/setbits32.cocci
 create mode 100644 scripts/coccinelle/misc/setbits32_relaxed.cocci
 create mode 100644 scripts/coccinelle/misc/setbits64.cocci
 create mode 100644 scripts/coccinelle/misc/setbits_dev.cocci

-- 
2.18.1

