Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD3520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD3520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeGXXI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:08:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46280 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeGXXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:08:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F409F20005E;
        Tue, 24 Jul 2018 23:59:56 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8ACF0200047;
        Tue, 24 Jul 2018 23:59:56 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id F16B040A70;
        Tue, 24 Jul 2018 14:59:55 -0700 (MST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.99])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6OLxtdS027717;
        Tue, 24 Jul 2018 14:59:55 -0700
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, gregkh@linuxfoundation.org,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [GIT PULL] updates to soc/fsl drivers for v4.19
Date:   Tue, 24 Jul 2018 16:59:55 -0500
Message-Id: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the following tag to get updates to the soc/fsl drivers:
  Moves DPAA2 DPIO driver from staging to fsl/soc
  Adds multiple-pin support to QE gpio driver

Regards,
Leo


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.19

for you to fetch changes up to 4625210899095195600062ff8542f37a1c9f5dd4:

  soc: fsl: cleanup Kconfig menu (2018-07-24 16:19:16 -0500)

----------------------------------------------------------------
Various updates to soc/fsl for 4.19

Moves DPAA2 DPIO driver from staging to fsl/soc
Adds multiple-pin support to QE gpio driver

----------------------------------------------------------------
Horia Geantă (1):
      staging: fsl-dpaa2: eth: move generic FD defines to DPIO

Joakim Tjernlund (1):
      soc: fsl: qe: gpio: Add qe_gpio_set_multiple

Li Yang (1):
      soc: fsl: cleanup Kconfig menu

Roy Pledge (3):
      staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl
      staging: fsl-mc: Remove remaining files
      soc: fsl: dpio: Convert DPIO documentation to .rst

 .../networking/dpaa2/dpio-driver.rst               | 29 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 15 ++++++++++-
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  2 +-
 drivers/soc/fsl/qbman/Kconfig                      |  2 +-
 drivers/soc/fsl/qe/Kconfig                         |  2 +-
 drivers/soc/fsl/qe/gpio.c                          | 28 +++++++++++++++++++++
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  4 +--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 22 ++++++----------
 drivers/staging/fsl-mc/Kconfig                     |  2 --
 drivers/staging/fsl-mc/Makefile                    |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 ------------
 drivers/staging/fsl-mc/bus/Makefile                |  9 -------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  | 12 +++++++++
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  0
 29 files changed, 100 insertions(+), 63 deletions(-)
 rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (95%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (97%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)
