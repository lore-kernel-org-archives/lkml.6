Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9260C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D06121477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJFCaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:30:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45704 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbeJFCaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:30:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D8A3E1A008F;
        Fri,  5 Oct 2018 21:30:41 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A2A071A0181;
        Fri,  5 Oct 2018 21:30:41 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.178])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id DD13340A63;
        Fri,  5 Oct 2018 12:30:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take 2
Date:   Fri,  5 Oct 2018 14:30:40 -0500
Message-Id: <20181005193040.28598-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the following updates for next.

v2: updated tree to include dependency patches by merging soc-fsl-fix-v4.19-2

Regards,
Leo

The following changes since commit 56740a7167cbbbda99ebfd3e8b4e4d51ae39bd06:

  Merge tag 'soc-fsl-fix-v4.19-2' into HEAD (2018-10-05 13:58:35 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v4.20-2

for you to fetch changes up to 6d06009cb216d071e955b3814086595851627910:

  soc: fsl: qbman: add interrupt coalesce changing APIs (2018-10-05 14:06:56 -0500)

----------------------------------------------------------------
NXP/FSL SoC drivers updates for v4.20 take 2

- Update qbman driver to better work with CPU hotplug
- Add Kconfig dependency of 64-bit DMA addressing for qbman driver
- Use last reponse to determine valid bit for qbman driver
- Defer bman_portals probe if bman is not probed
- Add interrupt coalescing APIs to qbman driver

----------------------------------------------------------------
Laurentiu Tudor (1):
      soc: fsl: bman_portals: defer probe after bman's probe

Madalin Bucur (2):
      soc: fsl: qbman: replace CPU 0 with any online CPU in hotplug handlers
      soc: fsl: qbman: add interrupt coalesce changing APIs

Roy Pledge (3):
      soc: fsl: qbman: Check if CPU is offline when initializing portals
      soc: fsl: qbman: Add 64 bit DMA addressing requirement to QBMan
      soc: fsl: qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig       |  2 +-
 drivers/soc/fsl/qbman/bman.c        |  6 ++---
 drivers/soc/fsl/qbman/bman_portal.c | 14 ++++++++--
 drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
 drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
 include/soc/fsl/qman.h              | 28 ++++++++++++++++++++
 7 files changed, 114 insertions(+), 15 deletions(-)
