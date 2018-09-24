Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E4D2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E4D2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbeIXS3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeIXS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08064108B;
        Mon, 24 Sep 2018 12:27:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erich E. Hoover" <ehoover@sweptlaser.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 016/235] usb: dwc3: change stream event enable bit back to 13
Date:   Mon, 24 Sep 2018 13:50:02 +0200
Message-Id: <20180924113106.134912444@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Erich E. Hoover" <ehoover@sweptlaser.com>

[ Upstream commit 9a7faac3650216112e034b157289bf1a48a99e2d ]

Commit ff3f0789b3dc ("usb: dwc3: use BIT() macro where possible")
changed DWC3_DEPCFG_STREAM_EVENT_EN from bit 13 to bit 12.

Spotted this cleanup typo while looking at diffs between 4.9.35 and
4.14.16 for a separate issue.

Fixes: ff3f0789b3dc ("usb: dwc3: use BIT() macro where possible")
Signed-off-by: Erich E. Hoover <ehoover@sweptlaser.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -25,7 +25,7 @@ struct dwc3;
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)


