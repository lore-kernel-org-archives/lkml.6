Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032486AbeCAPgw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:36:52 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38310 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031903AbeCAPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:25:25 -0500
X-Google-Smtp-Source: AG47ELvTFYpoJtjZ0VfAedoag/Iymu9GoXQyK7/lnC8GNkpwsUVz2SV9hvtbQKAuoq5EK4/fDWbjnw==
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: boot: add strrchr function
Date: Thu,  1 Mar 2018 09:25:15 -0600
Message-Id: <20180301152515.27004-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libfdt gained a new dependency on strrchr, so copy the implementation
from lib/string.c.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency for dtc/libfdt sync with upstream.

 arch/arm/boot/compressed/string.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
index 13c90abc68d6..ade5079bebbf 100644
--- a/arch/arm/boot/compressed/string.c
+++ b/arch/arm/boot/compressed/string.c
@@ -121,6 +121,16 @@ char *strchr(const char *s, int c)
 	return (char *)s;
 }
 
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+
 #undef memset
 
 void *memset(void *s, int c, size_t count)
-- 
2.14.1
