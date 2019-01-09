Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C12620685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAIVeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:34:46 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42442 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfAIVep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:34:45 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 67B221A00CD;
        Wed,  9 Jan 2019 22:34:43 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 284421A0077;
        Wed,  9 Jan 2019 22:34:43 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.49])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 6893E40CAF;
        Wed,  9 Jan 2019 14:34:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1
Date:   Wed,  9 Jan 2019 15:34:42 -0600
Message-Id: <20190109213442.14821-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please help to look into the following changes and merge them if
they look good.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1

for you to fetch changes up to ffe9670a44674ba38b7246e6134de297adad30a3:

  soc: fsl: dpio: Change bpid type to u16 (2019-01-09 14:52:13 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1

- Clean up the remove path in the dpio driver so that successive
  bind/unbind commands behave properly
- Add the ability to automatically create a device link between a
  consumer device on the fsl-mc bus and a supplier one
- Use devm_kstrdup_const() for RO data and prevent potential NULL
  dereference on allocation failure in guts driver
- Add prefetch to dpio dequeue to improve performance
- Update the type of dpio APIs to align with buffer pool id register
  field

----------------------------------------------------------------
Ioana Ciocoi Radulescu (2):
      soc: fsl: dpio: Add prefetch instruction
      soc: fsl: dpio: Change bpid type to u16

Ioana Ciornei (6):
      soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
      soc: fsl: dpio: use a cpumask to identify which cpus are unused
      soc: fsl: dpio: keep a per dpio device MC portal
      soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io
      soc: fsl: dpio: add a device_link at dpaa2_io_service_register
      bus: fsl-mc: automatically add a device_link on fsl_mc_[portal,object]_allocate

Nicholas Mc Guire (1):
      soc: fsl: guts: us devm_kstrdup_const() for RO data

Roy Pledge (1):
      soc: fsl: dpio: perform DPIO Reset on Probe

 drivers/bus/fsl-mc/fsl-mc-allocator.c            | 11 ++++++
 drivers/bus/fsl-mc/mc-io.c                       | 13 +++++++
 drivers/crypto/caam/caamalg_qi2.c                |  6 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 ++---
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  1 +
 drivers/soc/fsl/dpio/dpio-driver.c               | 41 ++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c              | 46 +++++++++++++++++++++---
 drivers/soc/fsl/dpio/dpio.c                      | 23 ++++++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  4 +++
 drivers/soc/fsl/guts.c                           |  3 +-
 include/linux/fsl/mc.h                           |  1 +
 include/soc/fsl/dpaa2-io.h                       | 15 +++++---
 12 files changed, 138 insertions(+), 35 deletions(-)
