Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeEALM2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:12:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41515 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbeEALM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:12:27 -0400
X-Google-Smtp-Source: AB8JxZoMYrQuZtW27ckEglmsQ7Zf8KWsJudhW4ALvBf2KuSg5+4kUH5FL5gdcum/fpZrVjHRgVFYEA==
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Henk <henk.vergonet@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dell-wmi: Set correct keycode for Fn + left arrow hotkey
Date: Tue,  1 May 2018 13:11:54 +0200
Message-Id: <20180501111154.9244-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henk <henk.vergonet@gmail.com>

Fn + left arrow hotkey combination is used for enabling/disabling automatic
display brigthness based on integrated ALS sensor. For this purpose there
is standard linux key KEY_BRIGHTNESS_AUTO so use it instead of KEY_UNKNOWN.

Tested on Dell Lattitude E6500.

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
Reviewed-By: Pali Rohár <pali.rohar@gmail.com>
Reviewed-By: Mario Limonciello <mario.limonciello@dell.com>
---
Changes since v1 by Pali
* Update commit description
---
 drivers/platform/x86/dell-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 8d102195..7c918e37 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -233,7 +233,7 @@ static const u16 bios_to_linux_keycode[256] = {
 	[18]	= KEY_PROG1,
 	[19]	= KEY_BRIGHTNESSDOWN,
 	[20]	= KEY_BRIGHTNESSUP,
-	[21]	= KEY_UNKNOWN,
+	[21]	= KEY_BRIGHTNESS_AUTO,
 	[22]	= KEY_KBDILLUMTOGGLE,
 	[23]	= KEY_UNKNOWN,
 	[24]	= KEY_SWITCHVIDEOMODE,
-- 
2.11.0
