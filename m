Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeBDVHI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:07:08 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46234 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBDVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 16:06:37 -0500
X-Google-Smtp-Source: AH8x226sQGSD1r7Bxkb12Jv5JZdB4t2AL+s+yz59KHTWQBkmF+VzHAsrRqi6CmZ8wEj1PEleO1+z2w==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 2/5] drivers: bluetooth: ath3k: do not init variables
Date: Mon,  5 Feb 2018 00:06:20 +0300
Message-Id: <20180204210623.29734-2-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204210623.29734-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210623.29734-1-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not need to initialize variables, because further on the code they
fall into the snprintf.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 0a5cfea44529..b16c01a0b6d4 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -399,7 +399,7 @@ static int ath3k_set_normal_mode(struct usb_device *udev)
 static int ath3k_load_patch(struct usb_device *udev)
 {
 	unsigned char fw_state;
-	char filename[ATH3K_NAME_LEN] = {0};
+	char filename[ATH3K_NAME_LEN];
 	const struct firmware *firmware;
 	struct ath3k_version fw_version;
 	__u32 pt_rom_version, pt_build_version;
@@ -452,7 +452,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 static int ath3k_load_syscfg(struct usb_device *udev)
 {
 	unsigned char fw_state;
-	char filename[ATH3K_NAME_LEN] = {0};
+	char filename[ATH3K_NAME_LEN];
 	const struct firmware *firmware;
 	struct ath3k_version fw_version;
 	int clk_value, ret;
-- 
2.16.1
