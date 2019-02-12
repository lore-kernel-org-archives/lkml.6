Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4135EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9EE222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyRhdG2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfBLSzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:55:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36562 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfBLSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:55:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so1734355plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i3gc5E2H5s0Z0cU1Rtar6FigVqhI90HZ+Cw+llye4LQ=;
        b=JyRhdG2M++y73EuFdk+qw423DPq0SZe7Zi2/PDKmsnH9A7eaWIK85CJC0eKLQr6nPS
         LBuGVSzhwg2Ho+xwQIMvxrqZpseMPXz1WxogW65pFWNh3XFyXdPeWRLJPMgxgEL/RBL8
         IrtTNaIku3F0KI+hkcTSeAf0StsujnhoejyjnUs/BA5GnYJEKxUbXDZKlwVKXtEDRWfn
         ouMuHpMZnWTmVATRGZ71Cd5l1MVDbBwU/g2nu7JhJHz4reQTGD7Zcg8TRHqwK5LBcExZ
         Fw2IkW/20g1hWYpxHAsCrKmBvK003LRlw5YRFMfodVthvom4cIlpDNJOGvBsg8sWBhSN
         Uu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i3gc5E2H5s0Z0cU1Rtar6FigVqhI90HZ+Cw+llye4LQ=;
        b=bqkIPVvJytfe2PGd+ZniNa4K3r/jQDvRg6zXeaayUroTMz4ap3S7IaspAz6FKkjTYH
         LnkDjSk95NlPQlJowLMwOFdAaP798549QKRIjus8d2TN1Rc57QYwAZxamAxH2NC+LYax
         F/Y1kKH47peZZ0UZD7JJB7VLX8IA175ojr8QWUwWyWv9D/zlyD0+kf8ynqK389MCAgOB
         ekDKODc00ghp5+7CZim8KZznR4u1K4huBg1RwFLKjJU30ONBH5cJEpn0j7cajZVy2TwQ
         pYsX49WiU/drN15sWQp5lKGbHgJDr/GoYSYsMvdGAyWaB1z8TCgReEgrP8/9n10Keepq
         1FYA==
X-Gm-Message-State: AHQUAuaLDE8yzzzt0JUDKSGLhn3JTtbJZA2VtSGrTR24fkzr6UAG8zok
        8eNWSs1MIEcKr2zAGRLXjMDljs6cg0vF+A==
X-Google-Smtp-Source: AHgI3IamXCnkwWu7CG9XLc8IJIvUjcbEPXsnumRzd5xKHjrZ/7702zSOZmlrHo8twVg5cDx72wtIkQ==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr5452013pla.267.1549997708301;
        Tue, 12 Feb 2019 10:55:08 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q187sm601003pfb.128.2019.02.12.10.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 10:55:07 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [v2] lib/string: add memrchr function
Date:   Wed, 13 Feb 2019 02:54:43 +0800
Message-Id: <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the detailed description for memrchr:

void *memrchr(const void *s, int c, size_t n);

The memrchr() function is like the memchr() function, except
that it searches backward from the end of the n bytes pointed
to by s instead of forward from the beginning.

The memrchr() functions return a pointer to the matching byte
or NULL if the character does not occur in the given memory
area.

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

