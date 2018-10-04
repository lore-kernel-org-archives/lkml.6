Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D73C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0B2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF0B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJDXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:41:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59628 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbeJDXlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:41:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90FB81A015D;
        Thu,  4 Oct 2018 18:47:16 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BB991A0007;
        Thu,  4 Oct 2018 18:47:16 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.178])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 9C79C40A63;
        Thu,  4 Oct 2018 09:47:15 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] for-next updates for soc/fsl drivers for v4.20 take 2
Date:   Thu,  4 Oct 2018 11:47:15 -0500
Message-Id: <20181004164715.14646-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the following updates for next.

PS.  One of the patches is depending on the last pull request for fixes to build
https://patchwork.kernel.org/patch/10622883/
I didn't include the fix patches directly in this pull request to prevent a
complicated merge.  Please let me know if there is a more preferred approach
to deal with dependencies between pull requests.

Regards,
Leo

The following changes since commit afa86d264a7ce62ba214bc7c6012e2129141421e:

  soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v4.20-2

for you to fetch changes up to aeaf982954849e9d2bccffab138703be28edd2ae:

  soc: fsl: qbman: add interrupt coalesce changing APIs (2018-10-02 15:04:19 -0500)

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
 include/soc/fsl/qman.h              | 27 +++++++++++++++++++
 7 files changed, 113 insertions(+), 15 deletions(-)
