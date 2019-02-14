Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5487821872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbfBNXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:19:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:61831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728625AbfBNXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:19:51 -0500
X-UUID: 00159be361b34db5a6636f1ed69d1ed4-20190215
X-UUID: 00159be361b34db5a6636f1ed69d1ed4-20190215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1338387107; Fri, 15 Feb 2019 07:19:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 07:19:41 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices
Date:   Fri, 15 Feb 2019 07:19:32 +0800
Message-ID: <cover.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
function running on the top of btmtkuart driver.

We are through several patches to reach the goal and also wish applied
the same flow in MediaTek btusb [1] for the transport independence.
Once [1] and the series is being merged and then in next step I will
consider to add a btmtk.c to hold these independent operations among
various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.

Firstly,
in patch 1/6 to update the dt-binding document for the kind of devices.
in patch 2/6, 3/6 to fix the common error issues in the current code.
in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
MT7668U USB devices also utilize.

Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
Bluetooth and enable MT7663U and MT7668U device.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 

Sean Wang (6):
  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
    MT7668U UART devices
  Bluetooth: mediatek: trivial typo fix
  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
  Bluetooth: mediatek: update the common setup between MT7622 and other
    devices
  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
    devices

 .../bindings/net/mediatek-bluetooth.txt       |  64 +++
 drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
 2 files changed, 569 insertions(+), 33 deletions(-)

-- 
2.18.0

