Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90134C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cw3Mmw+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeLQGDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:03:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53990 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbeLQGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:03:49 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20B2D59;
        Mon, 17 Dec 2018 07:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026628;
        bh=Se4Tgc37Q/8dnORwKkohpEXEdSHorwY3VSXwv8nJ8zU=;
        h=From:To:Cc:Subject:Date:From;
        b=Cw3Mmw+t7s4pfeWywACBwpy2tH7TG7yd6qFPgs0d34oVG9vDYzZkTCpnsIUWFJ3Uu
         SIFuaE0O1N/exn8GkDmK2Yglyf+5ZQt0574SWY1uOuiN1Bs/koVNx36UmIVN8tyUn3
         AJ6c50HSgRXrenJLbcXSx51j1FknCd5KwY+SBdVE=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: add uvcg_warn macro
Date:   Mon, 17 Dec 2018 01:03:40 -0500
Message-Id: <20181217060340.26813-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only have uvcg_dbg, uvcg_info, and uvcg_err, so add uvcg_warn macro
to print gadget device name and function name along with format.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 drivers/usb/gadget/function/uvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 1d89b1df4ba0..c381ce9bbbbe 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -56,6 +56,8 @@ extern unsigned int uvc_gadget_trace_param;
 	dev_dbg(&(f)->config->cdev->gadget->dev, "%s: " fmt, (f)->name, ##args)
 #define uvcg_info(f, fmt, args...) \
 	dev_info(&(f)->config->cdev->gadget->dev, "%s: " fmt, (f)->name, ##args)
+#define uvcg_warn(f, fmt, args...) \
+	dev_warn(&(f)->config->cdev->gadget->dev, "%s: " fmt, (f)->name, ##args)
 #define uvcg_err(f, fmt, args...) \
 	dev_err(&(f)->config->cdev->gadget->dev, "%s: " fmt, (f)->name, ##args)
 
-- 
2.19.2

