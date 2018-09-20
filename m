Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84850C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711D21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711D21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbeITUuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:50:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53760 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbeITUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:50:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F79D2000AE;
        Thu, 20 Sep 2018 17:06:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 204DA2000AC;
        Thu, 20 Sep 2018 17:06:55 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CB4420618;
        Thu, 20 Sep 2018 17:06:54 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 0/4] soc/fsl/qbman: DPAA QBMan fixes and additions
Date:   Thu, 20 Sep 2018 18:06:47 +0300
Message-Id: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Madalin Bucur (1):
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig |  2 +-
 drivers/soc/fsl/qbman/bman.c  | 17 ++++++++---
 drivers/soc/fsl/qbman/qman.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
 include/soc/fsl/qman.h        | 27 ++++++++++++++++++
 4 files changed, 99 insertions(+), 12 deletions(-)

-- 
2.1.0

