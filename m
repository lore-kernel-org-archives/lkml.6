Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AADB2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AADB2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeI1PGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:06:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50580 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeI1PGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:06:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A18A200032;
        Fri, 28 Sep 2018 10:43:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E48620000A;
        Fri, 28 Sep 2018 10:43:36 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B2DF120621;
        Fri, 28 Sep 2018 10:43:35 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions 
Date:   Fri, 28 Sep 2018 11:43:19 +0300
Message-Id: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Changes from v1:
 - change CPU 0 with any online CPU to allow CPU 0 to be taken offline
 - move common code in a function
 - address all places in the code where the portal interrupt was affined
   to CPU 0
 - remove unrelated change from patch adding 64 bit DMA addressing
   requirement

Madalin Bucur (2):
  soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig       |  2 +-
 drivers/soc/fsl/qbman/bman.c        |  6 ++---
 drivers/soc/fsl/qbman/bman_portal.c |  4 ++-
 drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
 drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
 include/soc/fsl/qman.h              | 27 +++++++++++++++++++
 7 files changed, 104 insertions(+), 14 deletions(-)

-- 
2.1.0

