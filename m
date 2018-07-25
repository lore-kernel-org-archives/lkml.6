Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348CBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851D620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851D620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeGYHFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:05:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:16507 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbeGYHFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:05:22 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P5t5cop
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 07:55:05 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        "Reizer, Eyal" <eyalr@ti.com>, Kees Cook <keescook@chromium.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH] drivers: net: wlcore: remove duplicate \n for some warnings
Date:   Wed, 25 Jul 2018 07:55:04 +0200
Message-Id: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wl1271_warning() already appends a \n to the format,
so adding one to the warning string gives empty lines in the log.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 3a51ab116e79..ab34d41487d3 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6065,16 +6065,16 @@ static int wl1271_register_hw(struct wl1271 *wl)
 	}
 
 	if (oui_addr == 0xdeadbe && nic_addr == 0xef0000) {
-		wl1271_warning("Detected unconfigured mac address in nvs, derive from fuse instead.\n");
+		wl1271_warning("Detected unconfigured mac address in nvs, derive from fuse instead.");
 		if (!strcmp(pdev_data->family->name, "wl18xx")) {
-			wl1271_warning("This default nvs file can be removed from the file system\n");
+			wl1271_warning("This default nvs file can be removed from the file system");
 		} else {
-			wl1271_warning("Your device performance is not optimized.\n");
-			wl1271_warning("Please use the calibrator tool to configure your device.\n");
+			wl1271_warning("Your device performance is not optimized.");
+			wl1271_warning("Please use the calibrator tool to configure your device.");
 		}
 
 		if (wl->fuse_oui_addr == 0 && wl->fuse_nic_addr == 0) {
-			wl1271_warning("Fuse mac address is zero. using random mac\n");
+			wl1271_warning("Fuse mac address is zero. using random mac");
 			/* Use TI oui and a random nic */
 			oui_addr = WLCORE_TI_OUI_ADDRESS;
 			nic_addr = get_random_int();
-- 
2.12.2

