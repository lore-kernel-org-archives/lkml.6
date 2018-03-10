Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeCJOgv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 09:36:51 -0500
Received: from server1.vittgam.net ([213.239.197.142]:7631 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCJOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 09:36:50 -0500
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w2AEQEwH232108
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-kernel]
X-VittGamMilter-Outgoing-OriginalSubject: [PATCH] input/touchscreen: atmel_mxt_ts: Add Caroline Chromebook platform data.
Date: Sat, 10 Mar 2018 15:26:14 +0100
Message-Id: <201803101426.w2AEQEwH232108@mail.vittgam.net>
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: <linux-kernel@vger.kernel.org>, "Nick Dyer" <nick@shmanahar.org>
Cc: "Salvatore Bellizzi" <lkml@seppia.net>
Subject: [PATCH] input/touchscreen: atmel_mxt_ts: Add Caroline Chromebook platform data.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the correct platform data information for the Caroline
Chromebook, so that the mouse button does not get stuck in pressed state
after the first click.

The Samus button keymap and platform data definition are the correct
ones for Caroline, so they have been reused here.

Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>

---

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3031,6 +3031,15 @@
 		.driver_data = samus_platform_data,
 	},
 	{
+		/* Samsung Chromebook Pro */
+		.ident = "Samsung Chromebook Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
+		},
+		.driver_data = samus_platform_data,
+	},
+	{
 		/* Other Google Chromebooks */
 		.ident = "Chromebook",
 		.matches = {
