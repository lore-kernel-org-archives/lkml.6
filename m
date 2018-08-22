Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B7120673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B7120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeHVPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:38:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:50745 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeHVPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:38:06 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Aug 2018 21:13:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 00917600AA;
        Wed, 22 Aug 2018 21:13:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 21:13:23 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 488D21A0E11;
        Wed, 22 Aug 2018 21:13:23 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/3] ata: ahci-platform: add reset control support except for existing drivers
Date:   Wed, 22 Aug 2018 21:13:00 +0900
Message-Id: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get and control a list of resets for the device, and
add the flag indicating whether to use the reset. Existing SoC-dependent
drivers set 0 to this flag.

This series solves the issue of the previous patch [1] that was already
reverted [2].
[1] https://www.spinics.net/lists/linux-ide/msg55299.html
[2] https://www.spinics.net/lists/linux-ide/msg55379.html

Changes since v1:
- collect patches for each soc-dependent driver
- separate into 3 patches not to affect existing code

Kunihiko Hayashi (3):
  ata: add an extra argument to ahci_platform_get_resources()
  ata: libahci_platform: add reset control support
  ata: ahci_platform: enable to get and control reset

 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/ahci_brcm.c                            |  2 +-
 drivers/ata/ahci_ceva.c                            |  2 +-
 drivers/ata/ahci_da850.c                           |  2 +-
 drivers/ata/ahci_dm816.c                           |  2 +-
 drivers/ata/ahci_imx.c                             |  2 +-
 drivers/ata/ahci_mtk.c                             |  2 +-
 drivers/ata/ahci_mvebu.c                           |  2 +-
 drivers/ata/ahci_platform.c                        |  3 +-
 drivers/ata/ahci_qoriq.c                           |  2 +-
 drivers/ata/ahci_seattle.c                         |  2 +-
 drivers/ata/ahci_st.c                              |  2 +-
 drivers/ata/ahci_sunxi.c                           |  2 +-
 drivers/ata/ahci_tegra.c                           |  2 +-
 drivers/ata/ahci_xgene.c                           |  2 +-
 drivers/ata/libahci_platform.c                     | 35 ++++++++++++++++++----
 include/linux/ahci_platform.h                      |  4 ++-
 18 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.7.4

