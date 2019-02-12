Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCDF2229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBIrEpUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfBLSHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:07:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfBLSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:07:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so1599592pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Orczz7OzGsol9BSTi3enSHRqZox7M6jz44V37KHUss4=;
        b=nBIrEpUBqKJ6uy8d9GEQpKeHVfNWOuexJcGisSwO/2YBJBXA3AcIhQQ9yCVkiocJ6I
         4DXxFIT4ILIHWFMsHBdprfM5uaRQs871OoIkIoxghQcnvONQ34Fm9nau0ExtxpmjKdfq
         ymozvuG2rlJmHIFBRPQ5n6xRZaBaI7qzyjMAnbs7qt6NPOXp8fR++L1+n6B1sJWx1gww
         Sm39qn+01E3mv6QiwBne+3IcoiF+opfB5u7J0mZyEcrO2zHTt4uGAmxNCu9DReBlPXNW
         +wrLCqqADis2txKVpCn45b/wznnJeaVpmuIBaHbLr0C4LiuLMfz9T5DHAI852g4YNQpJ
         fxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Orczz7OzGsol9BSTi3enSHRqZox7M6jz44V37KHUss4=;
        b=YhLDti3TWaYrl+7mEkcQhXynmI4TthVfxh2KpNjhBN9mG4D0LkddUlD0OfALMhF0Ub
         xVDaKGLEaRuW0hXjCmE6NbV/Ka7ruGmfR4Qc5oPwg8/g6HPRG/POr5RdiJ1ANRvSfKM1
         BfrYKvH449IEfctFKIsVfk2CxPDb5TVnZBGeObh0rxXoht9IYV7Y6xfHJ5lJlFfnV+RG
         WCjzFrBYg220/PDbaH5BdeD6hKtqVd3X0JSDqvK8OPkMyunBAyig5i5jCebcFNelfbPS
         TxOBSjatodhSTL4/t+x9YkZ6ZYeQal3+RteD7wwPm9J119AXS9yUtwP8bgABrDB5/9wG
         H9Gw==
X-Gm-Message-State: AHQUAuYapS044bVjgJXdkb9r7vVtgLnZEx62Jg+f0omTD44yFd0htgAS
        39ZVigoQqdkQZc+XEFT2L3o=
X-Google-Smtp-Source: AHgI3IYc+gpPdAGLkHYYG31vqJed8SLr64mBh37V5iqHL5UH0HjSBMvMZvWjQ8PWA4SAOmnETK7eWA==
X-Received: by 2002:a62:ca03:: with SMTP id n3mr5255803pfg.241.1549994839828;
        Tue, 12 Feb 2019 10:07:19 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id u5sm16857510pgp.2.2019.02.12.10.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 10:07:19 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] lib/string: add memrchr function
Date:   Wed, 13 Feb 2019 02:06:49 +0800
Message-Id: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the detailed description for memrchr:
https://linux.die.net/man/3/memrchr

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b87..f380f4b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 	memcpy(dst, src, cnt);
 }
 #endif
+void *memrchr(const void *s, int c, size_t n);
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
 
diff --git a/lib/string.c b/lib/string.c
index 38e4ca0..92914f6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -964,6 +964,27 @@ void *memchr(const void *s, int c, size_t n)
 EXPORT_SYMBOL(memchr);
 #endif
 
+/**
+ * memrchr - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the last occurrence of @c, or %NULL
+ * if @c is not found
+ */
+void *memrchr(const void *s, int c, size_t n)
+{
+	const unsigned char *p = s + n;
+
+	while (n-- != 0) {
+		if ((unsigned char)c == *--p)
+			return (void *)p;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(memrchr);
+
 static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
 {
 	while (bytes) {
-- 
2.7.4

