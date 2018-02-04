Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeBDVKe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:10:34 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34920 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeBDVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 16:10:06 -0500
X-Google-Smtp-Source: AH8x225Bp72TUtjBXIXh+fGjBtFwYSCq+wkSkCyZD1MAyEiRs5KD7qoEQUYIIfsIN1ES3hQ9+fSzpQ==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH v2 1/5] drivers: bluetooth: ath3k: replace hardcode numbers with define
Date: Mon,  5 Feb 2018 00:09:43 +0300
Message-Id: <20180204210947.31002-2-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204210947.31002-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210947.31002-1-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced the numbers with a readable define.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 204afe66de92..0a5cfea44529 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -227,15 +227,16 @@ static int ath3k_load_firmware(struct usb_device *udev,
 		return -ENOMEM;
 	}
 
-	memcpy(send_buf, firmware->data, 20);
+	memcpy(send_buf, firmware->data, FW_HDR_SIZE);
 	err = usb_control_msg(udev, pipe, USB_REQ_DFU_DNLOAD, USB_TYPE_VENDOR,
-			      0, 0, send_buf, 20, USB_CTRL_SET_TIMEOUT);
+			      0, 0, send_buf, FW_HDR_SIZE,
+			      USB_CTRL_SET_TIMEOUT);
 	if (err < 0) {
 		BT_ERR("Can't change to loading configuration err");
 		goto error;
 	}
-	sent += 20;
-	count -= 20;
+	sent += FW_HDR_SIZE;
+	count -= FW_HDR_SIZE;
 
 	pipe = usb_sndbulkpipe(udev, 0x02);
 
-- 
2.16.1
