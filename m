Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938397AbeE1LnP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:43:15 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:43896 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbeE1LnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:43:01 -0400
From: KT Liao <kt.liao@emc.com.tw>
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw, aaron.ma@canonical.com,
        josh.chen@emc.com.tw
Subject: [PATCH] Input: elantech - Fix V4 report decoding for module with middle key
Date: Mon, 28 May 2018 19:33:02 +0800
Message-Id: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchpad has middle key and it will be indicated in bit 2 of packet[0].
We need to fix V4 formation's byte mask to prevent error decoding.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index fb4d902..f39dc66 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -799,7 +799,7 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
 		sanity_check = ((packet[3] & 0x1c) == 0x10);
 	else
-		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
+		sanity_check = ((packet[0] & 0x08) == 0x00 &&
 				(packet[3] & 0x1c) == 0x10);
 
 	if (!sanity_check)
-- 
2.7.4
