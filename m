Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C823C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12820989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KwEUk1u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfAUHb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:31:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45902 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfAUHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:31:30 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72581B60;
        Sun, 20 Jan 2019 20:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548013317;
        bh=M5/euAy6dX0wJeOW7nGNoT6yPzv7tpxo8hKP2n5rlK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwEUk1u7bxxd2dTW7bqH6riMx4gX/2DVPejji8OqFIstRhWRiaa/IIOvRWRzfEUgE
         oOJdRBffKbes2JNRlSpxiHmjZbH+ta92aC9UFHjl2EQtC1M52sg+ARgN54hn9yGL8j
         F4Y6NOlCZPMfaL+azX1Owz4tZb7MMQ6Fp+ZpH5NE=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/6] usb: uvc: include videodev2.h in g_uvc.h
Date:   Sun, 20 Jan 2019 14:41:31 -0500
Message-Id: <20190120194136.21870-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120194136.21870-1-paul.elder@ideasonboard.com>
References: <20190120194136.21870-1-paul.elder@ideasonboard.com>
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
No change from v5
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

