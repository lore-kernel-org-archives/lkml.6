Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378CDECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6812088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6812088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeIREVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:21:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIREVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:21:11 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48417CAC;
        Mon, 17 Sep 2018 22:51:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 16/56] Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV
Date:   Tue, 18 Sep 2018 00:41:49 +0200
Message-Id: <20180917213828.634336055@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hedberg <johan.hedberg@intel.com>

[ Upstream commit 6c3711ec64fd23a9abc8aaf59a9429569a6282df ]

This driver was recently updated to use serdev, so add the appropriate
dependency. Without this one can get compiler warnings like this if
CONFIG_SERIAL_DEV_BUS is not enabled:

  CC [M]  drivers/bluetooth/hci_h5.o
drivers/bluetooth/hci_h5.c:934:36: warning: ‘h5_serdev_driver’ defined but not used [-Wunused-variable]
 static struct serdev_device_driver h5_serdev_driver = {
                                    ^~~~~~~~~~~~~~~~

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -125,6 +125,7 @@ config BT_HCIUART_LL
 config BT_HCIUART_3WIRE
 	bool "Three-wire UART (H5) protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	help
 	  The HCI Three-wire UART Transport Layer makes it possible to
 	  user the Bluetooth HCI over a serial port interface. The HCI


