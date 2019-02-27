Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A578F217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfB0UwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:52:14 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60756 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbfB0UwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:52:14 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C72B2001FF;
        Wed, 27 Feb 2019 21:52:12 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26CD82000ED;
        Wed, 27 Feb 2019 21:52:12 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.161])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 6167140C8A;
        Wed, 27 Feb 2019 13:52:11 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1 take4
Date:   Wed, 27 Feb 2019 14:52:11 -0600
Message-Id: <20190227205211.32425-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Since we are having a -rc8 for v5.0, please help to merge a few additional
patches for the upcoming merge window.  Thanks

Regards,
Leo

The following changes since commit bd3bd3b36df725645036748e58a8c35c8d2cbf91:

  soc: fsl: dpio: fix memory leak of a struct qbman on error exit path (2019-02-19 14:59:39 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-4

for you to fetch changes up to f8b995853444aba9c16c1ccdccdd397527fde96d:

  dpaa2-eth: configure the cache stashing amount on a queue (2019-02-26 14:53:30 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1 take4

DPIO driver
- Add support for cache stashing and enable it in dpaa2-eth driver

GUTS driver
- Make fsl_guts_get_svr() API internal in favor of more generic
  soc_device_match()

----------------------------------------------------------------
Horia Geantă (1):
      soc: fsl: guts: make fsl_guts_get_svr() static

Ioana Ciornei (3):
      soc: fsl: dpio: enable frame data cache stashing per software portal
      soc: fsl: dpio: configure cache stashing destination
      dpaa2-eth: configure the cache stashing amount on a queue

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  7 +++-
 drivers/soc/fsl/Kconfig                          |  1 +
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  5 +++
 drivers/soc/fsl/dpio/dpio-driver.c               | 52 ++++++++++++++++++++++++
 drivers/soc/fsl/dpio/dpio.c                      | 16 ++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  5 +++
 drivers/soc/fsl/dpio/qbman-portal.c              |  4 +-
 drivers/soc/fsl/guts.c                           |  3 +-
 include/linux/fsl/guts.h                         |  2 -
 9 files changed, 88 insertions(+), 7 deletions(-)
