Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeEVVaG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:30:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33813 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeEVVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:30:03 -0400
X-Google-Smtp-Source: AB8JxZr8IhhFprl6CY8WfoCw2I498QTFjd1R1bQ7k9LE1O2/LHV2ZTHUCZ45zK3XjIaFz3+s9M5kDg==
From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: linux@endlessm.com, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wireless: Fix format specifier
Date: Tue, 22 May 2018 14:29:56 -0700
Message-Id: <20180522212956.5433-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Paulo Rechi Vita <jprvita@gmail.com>

u64 should be printed with %llx instead of %x and cast to uint.

Signed-off-by: João Paulo Rechi Vita <jprvita@gmail.com>
---
 drivers/platform/x86/asus-wireless.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index f086469ea740..6afd011de9e5 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -72,7 +72,7 @@ static u64 asus_wireless_method(acpi_handle handle, const char *method,
 		acpi_handle_err(handle,
 				"Failed to eval method %s, param %#x (%d)\n",
 				method, param, s);
-	acpi_handle_debug(handle, "%s returned %#x\n", method, (uint) ret);
+	acpi_handle_debug(handle, "%s returned %#llx\n", method, ret);
 	return ret;
 }
 
-- 
2.17.0
