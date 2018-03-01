Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032155AbeCAP1s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:27:48 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33324 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032087AbeCAP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:27:46 -0500
X-Google-Smtp-Source: AG47ELuesFR0QFgbNPnYTtWm5YbhZmllHVdDLlNOToGyS9ds+D1FZrCvnZumHd/dZHSotPNfxO42/w==
From: Rob Herring <robh@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: add strrchr function
Date: Thu,  1 Mar 2018 09:27:44 -0600
Message-Id: <20180301152744.30718-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libfdt gained a new dependency on strrchr, so copy the implementation
from lib/string.c.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency for dtc/libfdt sync with upstream.

 drivers/firmware/efi/libstub/string.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index ed10e3f602c5..c1a7e58a5af7 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -56,3 +56,20 @@ int strncmp(const char *cs, const char *ct, size_t count)
 	return 0;
 }
 #endif
+
+#ifndef __HAVE_ARCH_STRRCHR
+/**
+ * strrchr - Find the last occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ */
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+#endif
-- 
2.14.1
