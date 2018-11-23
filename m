Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C7A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C7A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503228AbeKWVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:13:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60348 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393942AbeKWVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:13:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANAUFPc047025;
        Fri, 23 Nov 2018 04:30:15 -0600
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANAUF08125895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 04:30:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 04:30:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 04:30:15 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANAUDpO014204;
        Fri, 23 Nov 2018 04:30:14 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>
Subject: [GIT PULL] PHY: for 4.20 -rc
Date:   Fri, 23 Nov 2018 16:00:08 +0530
Message-ID: <20181123103008.11672-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 4.20 -rc below.

It includes tuning parameter fix in qcom-qusb2 PHY driver, dt-bindings fix
for phy-qcom-qmp and a fix for randconfig error in uniphier-pcie.

Consider merging this in the -rc cycle.

Thanks
Kishon

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.20-rc

for you to fetch changes up to c88520db18ba0b9a41326c3b8680e7c09eb4c381:

  phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845 (2018-11-21 13:13:58 +0530)

----------------------------------------------------------------
phy: for 4.20-rc

 *) Fix updating HSTX_TRIM tuning parameter in qcom-qusb2 PHY driver
 *) Fix inconsistencies between dt-bindings and the driver
 *) Add "Depend on HAS_IOMEM" uniphier-pcie to avoid randconfig errors

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Douglas Anderson (1):
      dt-bindings: phy-qcom-qmp: Fix several mistakes from prior commits

Kunihiko Hayashi (1):
      phy: uniphier-pcie: Depend on HAS_IOMEM

Manu Gautam (2):
      phy: qcom-qusb2: Use HSTX_TRIM fused value as is
      phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 31 +++++++++++++++++++++++--------
 drivers/phy/qualcomm/phy-qcom-qusb2.c                  | 20 +++++++++++---------
 drivers/phy/socionext/Kconfig                          |  3 ++-
 3 files changed, 36 insertions(+), 18 deletions(-)
-- 
2.17.1

