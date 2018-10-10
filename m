Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A522C32788
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58127214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dijQyiF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58127214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJJKJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44274 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJJKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:19 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54CE21BF9;
        Wed, 10 Oct 2018 04:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539139760;
        bh=OCP1C/Jq1hJ1n1s1Bpzhzc8kEnIB9upcUwlguoJnu3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dijQyiF4D7tGEr3qQGXJNFCCh1CjbLr4KKAVdt7OmLvARLU74Wd/WHiTn9wqRqx9n
         q3+W+a57HFy8ndYGKIN7rO+7qFE0tnbXt727trreEDoDhaBJ2IgpQOcBddIA5r+LOD
         cNZEKaZc3GbpPtXpAZPjqj7OTfxsE1o4upKN5a9I=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: [PATCH 1/6] usb: uvc: include videodev2.h in g_uvc.h
Date:   Tue,  9 Oct 2018 22:48:58 -0400
Message-Id: <20181010024903.1633-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2_EVENT_PRIVATE_START is used in g_uvc.h but is defined in
videodev2.h, which is not included and causes a compiler warning:

linux/usb/g_uvc.h:15:28: error: ‘V4L2_EVENT_PRIVATE_START’ undeclared here (not in a function)
 #define UVC_EVENT_FIRST   (V4L2_EVENT_PRIVATE_START + 0)

Include videodev2.h in g_uvc.h.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/uapi/linux/usb/g_uvc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/usb/g_uvc.h b/include/uapi/linux/usb/g_uvc.h
index 3c9ee3020cbb..6698c3263ae8 100644
--- a/include/uapi/linux/usb/g_uvc.h
+++ b/include/uapi/linux/usb/g_uvc.h
@@ -11,6 +11,7 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 #include <linux/usb/ch9.h>
+#include <linux/videodev2.h>
 
 #define UVC_EVENT_FIRST			(V4L2_EVENT_PRIVATE_START + 0)
 #define UVC_EVENT_CONNECT		(V4L2_EVENT_PRIVATE_START + 0)
-- 
2.18.0

