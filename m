Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A404520989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfAaBvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:51:46 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52648 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaBvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:51:46 -0500
X-UUID: 875ac2aab762494ead53e751355843b0-20190131
X-UUID: 875ac2aab762494ead53e751355843b0-20190131
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1980038337; Thu, 31 Jan 2019 09:51:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 09:51:37 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 09:51:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] usb: xhci: remove unused member 'parent' in xhci_regset struct
Date:   Thu, 31 Jan 2019 09:51:30 +0800
Message-ID: <1548899490-19065-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member @parent of xhci_regset struct is not used in fact,
so remove it

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: remove Change-Id
---
 drivers/usb/host/xhci-debugfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.h b/drivers/usb/host/xhci-debugfs.h
index ac5bc40f5c3a..f7a4e2492b00 100644
--- a/drivers/usb/host/xhci-debugfs.h
+++ b/drivers/usb/host/xhci-debugfs.h
@@ -80,7 +80,6 @@ struct xhci_regset {
 	char			name[DEBUGFS_NAMELEN];
 	struct debugfs_regset32	regset;
 	size_t			nregs;
-	struct dentry		*parent;
 	struct list_head	list;
 };
 
-- 
2.20.1

