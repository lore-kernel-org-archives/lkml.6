Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F40C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C748120878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sDEPrUBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C748120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeGKJVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:21:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38508 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:21:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6B9HqJ7125563;
        Wed, 11 Jul 2018 04:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531300672;
        bh=zKtC31I0g8LwG6Ni8VvG9TQ4vNKQikHOCJMVnIYmfGw=;
        h=From:To:CC:Subject:Date;
        b=sDEPrUBBCvEAWKZvconpK12NaWWkof5Tp/YzVIIDtLEK+UT51dCceSpbXKraWHNEB
         MN9nks7rcM2QzURuQxC0kuF4MvWNTatC/Zc72hQGJK+tYPIKjsICBh91RVLPICm1ge
         3TVyEt9isWTlzAyt/k/c2eglL/xaxMirE8bi+NKs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B9HquN011974;
        Wed, 11 Jul 2018 04:17:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 11
 Jul 2018 04:17:52 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 11 Jul 2018 04:17:52 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B9HokC020425;
        Wed, 11 Jul 2018 04:17:51 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     <gregkh@linuxfoundation.org>
CC:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 4.18 -rc
Date:   Wed, 11 Jul 2018 14:47:50 +0530
Message-ID: <20180711091750.2365-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I have a couple of patches to be included in this -rc cycle. One gets xhci
working after disable->enable cycle in broadcom SoC and the other fixes
a compilation warning in Motorola USB PHY.

Consider merging it in this -rc cycle.

Thanks
Kishon

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.18-rc

for you to fetch changes up to ad5003300b077bf1af15e667097b3b1f73288177:

  phy: mapphone-mdm6600: Fix wrong enum used for status lines (2018-06-29 12:00:22 +0530)

----------------------------------------------------------------
phy: for 4.18-rc

 *) Fix to get xhci working after disable<->enable cycle
 *) Fix wrong enum used for status lines (also fixes a compilation
    warning).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Jaedon Shin (1):
      phy: phy-brcm-usb-init: Fix power down USB 3.0 PHY when XHCI reenabled

Tony Lindgren (1):
      phy: mapphone-mdm6600: Fix wrong enum used for status lines

 drivers/phy/broadcom/phy-brcm-usb-init.c    | 4 ++++
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.1

