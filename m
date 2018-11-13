Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83395C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD7223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CD7223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeKNC2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:28:55 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40352 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbeKNC2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:28:54 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8290420023F;
        Tue, 13 Nov 2018 17:30:04 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80FCD20023B;
        Tue, 13 Nov 2018 17:30:04 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 19AA2205E2;
        Tue, 13 Nov 2018 17:30:04 +0100 (CET)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     leoyang.li@nxp.com, roy.pledge@nxp.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2 0/2] dpaa_eth: add ethtool coalesce control
Date:   Tue, 13 Nov 2018 18:29:49 +0200
Message-Id: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add control of the DPAA portal interrupt coalescing settings from
ethtool.

changes from v1: added range checking for the QMan APIs

Madalin Bucur (2):
  soc/qman: add return value to interrupt coalesce changing APIs
  dpaa_eth: add ethtool coalesce control

 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 49 ++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c                       | 33 +++++++++++----
 include/soc/fsl/qman.h                             |  8 +++-
 3 files changed, 81 insertions(+), 9 deletions(-)

-- 
2.1.0

