Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeDHPyB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 11:54:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44734 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeDHPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 11:53:59 -0400
X-Google-Smtp-Source: AIpwx4/CXAfsnOQv4VFPEL7rXNV5qrNqeNNmBp/KWXFYKFPrQIQX0FGd5XyxoLPzPFjCIJHJlm/gpQ==
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: alps - Fix reporting pressure of v3 trackstick
Date: Sun,  8 Apr 2018 17:53:21 +0200
Message-Id: <20180408155321.10433-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation, all 7 lower bits represents trackpoint pressure.

Fixes: 4621c9660459 ("Input: alps - report pressure of v3 and v7 trackstick")
Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0a9e6a3a2f9f..1e28d9fc5492 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -583,7 +583,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 
 	x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
 	y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
-	z = packet[4] & 0x7c;
+	z = packet[4] & 0x7f;
 
 	/*
 	 * The x and y values tend to be quite large, and when used
-- 
2.11.0
