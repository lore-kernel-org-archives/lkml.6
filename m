Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C6320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bIcJLR4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfARJ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:28:41 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49974 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:28:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0I9SddV119459;
        Fri, 18 Jan 2019 03:28:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547803719;
        bh=mve14iIo6L5nOdDpw9nsGx2p4TOjlIJIaiNJl3a95nM=;
        h=From:To:CC:Subject:Date;
        b=bIcJLR4qDq5pZMDT+kFOQpstI/CpIIWu82A/buucqv5MaxJvCmt30W8XuA5DS3PYj
         UkU/0iNNs0P/gPhVqGcYxznA768NosFtngnq50lmkDhl74QCfjcWYz6CzQPQiGcZ+2
         9t5ZP3vMpenjqOnJOFMxKvpbeH6BZ4ZERsMJ4fTM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0I9SdOd093436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 03:28:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 03:28:38 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 03:28:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0I9Safq029839;
        Fri, 18 Jan 2019 03:28:37 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.0 -rc
Date:   Fri, 18 Jan 2019 14:58:12 +0530
Message-ID: <20190118092812.26148-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the PHY pull request for 5.0 -rc below.

It fixes a build issue in ahci platform driver caused due to a patch
merged in libahci_platform.c before a dependent patch merged in PHY.
The ahci platform driver patch was merged after -rc1.

Others are relatively minor fixes seen only on error scenarios. Please
find the complete list of changes in the tag message below.

Let me know if I have to make any modifications.

Cheers
Kishon

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.0-rc

for you to fetch changes up to 827cb0323928952c0db9515aba9d534fb1285b3f:

  phy: ath79-usb: Fix the main reset name to match the DT binding (2019-01-16 18:00:57 +0530)

----------------------------------------------------------------
phy: for 5.0 -rc

 *) Fix de-reference before null check in TI's phy-gmii-sel driver
 *) Fix build breakage in AHCI platform driver (patch was merged in AHCI
    before dependent patches were merged in PHY layer)
 *) Fix the power on error path in ath79-usb PHY driver
 *) Fix the reset binding name to match the DT binding documentation in
    ath79-usb PHY driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Alban Bedel (2):
      phy: ath79-usb: Fix the power on error path
      phy: ath79-usb: Fix the main reset name to match the DT binding

Colin Ian King (1):
      phy: ti: ensure priv is not null before dereferencing it

John Hubbard (1):
      phy: fix build breakage: add PHY_MODE_SATA

 drivers/phy/marvell/phy-berlin-sata.c | 5 +++--
 drivers/phy/qualcomm/phy-ath79-usb.c  | 4 ++--
 drivers/phy/ti/phy-gmii-sel.c         | 4 ++--
 include/linux/phy/phy.h               | 1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.17.1

