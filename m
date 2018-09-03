Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9D3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3723020876
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3723020876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeICS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:28:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40237 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727049AbeICS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:28:54 -0400
X-UUID: d2736a3f47824afdb3558a6bdfc0a7b4-20180903
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1551560556; Mon, 03 Sep 2018 22:08:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 3 Sep 2018 22:08:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 3 Sep 2018 22:08:25 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 0/2] Bluetooth: mediatek: Add protocol support for MediaTek USB devices
Date:   Mon, 3 Sep 2018 22:08:22 +0800
Message-ID: <cover.1535983416.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v4:
* use new BTUSB_TX_WAIT_VND_EVT instead of BTMTKUSB_TX_WAIT_VND_EVT
  to avoid definition conflict and to fix bulk data transfer fails.
* use the bluetooth-next as the base

v3:
add fixes and enhancements based on [1]
* reuse flags and evt_skb btusb already had
* add ctrl_anchor and the corresponding handling
* apply mtk specific recv function
* add more comments explaining wmt ctrl urbs behavior.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014724.html

v2:

add fixes and enhancements based on [1]
* include /sys/kernel/debug/usb/devices portion in the commit message.
* turn default into n for config BT_HCIBTUSB_MTK in Kconfig
* only add MediaTek support to btusb.c
* drop cmd_sync callback usage
* use __hci_cmd_send to send WMT commands
* add wait event handling similar to what is being done in btmtkuart.c
* submit a control IN URB similar to interrupt IN URB on demand for the WMT
  commands during setup 
* add cosmetic changes

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014650.html
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014656.html

v1:

This adds the support of enabling MT7668U and MT7663U Bluetooth
function running on the top of btusb driver. The patch also adds
a newly created file mtkbt.c able to be reused independently from
the transport type such as UART, USB and SDIO.

Sean Wang (2):
  Bluetooth: mediatek: Add protocol support for MediaTek MT7668U USB
    devices
  Bluetooth: mediatek: Add protocol support for MediaTek MT7663U USB
    devices

 drivers/bluetooth/Kconfig |  11 +
 drivers/bluetooth/btusb.c | 552 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 563 insertions(+)

-- 
2.7.4

