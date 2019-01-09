Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF64C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E579214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CZXvR2uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfAIHJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:09:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50366 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfAIHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:09:52 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1F40586;
        Wed,  9 Jan 2019 08:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017790;
        bh=zUjomlBSZ61UwAVRkoJo2Gm8Ulse80zorOI1fa+sXP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZXvR2uws/YGJ3Gu1ImP/G8SjeJFV3C5zWjHW3uKhxnJLr9xaD0ODqYbwXi0zo06R
         ITj1D7NO51nv6VDYqTxxkk5BMUl97iKngjUK8GktN5x6B3sh1ba21z/0UYJTwFE42G
         4c8mk5IJVAoH1S3d/5uA2sjGiJmLZZAPHz012fGk=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] usb: uvc: include videodev2.h in g_uvc.h
Date:   Wed,  9 Jan 2019 02:08:51 -0500
Message-Id: <20190109070856.27460-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109070856.27460-1-paul.elder@ideasonboard.com>
References: <20190109070856.27460-1-paul.elder@ideasonboard.com>
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
No change from v4
No change from v3
No change from v2
No change from v1

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
2.20.1

