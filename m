Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25920821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UlDs0ogz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfAIHLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:11:09 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50468 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfAIHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:11:05 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11271586;
        Wed,  9 Jan 2019 08:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017864;
        bh=a5G7l2WFn87tf48IRsdLBdFsPElClHFvUVyGvH2CEAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlDs0ogzPg/Va86jalS+ea757H7+i5W7by+NZCDfCi6dARkjQAXPK3t9FtC803gJv
         OnTb95UWwXawFKHlv57xRkMpcHpxL/yX3CBrfzGTkeuud+8Kj6NgVGrbhXeRAMOvpL
         H09meUIl9JsVc6o2LLF0UonS4wPrP4oP4bm0OYVI=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, rogerq@ti.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] usb: gadget: uvc: remove unused/duplicate function prototypes from uvc.h
Date:   Wed,  9 Jan 2019 02:10:39 -0500
Message-Id: <20190109071039.27702-5-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109071039.27702-1-paul.elder@ideasonboard.com>
References: <20190109071039.27702-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined in uvc.h, uvc_endpoint_stream doesn't exist, and
uvc_function_connect, uvc_function_disconnect, and
uvc_function_setup_continue have duplicates in f_uvc.h.
Remove these four function prototypes from uvc.h

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 drivers/usb/gadget/function/uvc.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index f183e349499c..671020c8a836 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -185,14 +185,4 @@ struct uvc_file_handle {
 #define to_uvc_file_handle(handle) \
 	container_of(handle, struct uvc_file_handle, vfh)
 
-/* ------------------------------------------------------------------------
- * Functions
- */
-
-extern void uvc_function_setup_continue(struct uvc_device *uvc);
-extern void uvc_endpoint_stream(struct uvc_device *dev);
-
-extern void uvc_function_connect(struct uvc_device *uvc);
-extern void uvc_function_disconnect(struct uvc_device *uvc);
-
 #endif /* _UVC_GADGET_H_ */
-- 
2.20.1

