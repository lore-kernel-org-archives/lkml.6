Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706EC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B2E20659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7soYLxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B2E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJOGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:22:09 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35944 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:22:09 -0400
Received: by mail-wm1-f51.google.com with SMTP id a8-v6so17666275wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PXY1nCXJkUhuJYpS72IxBDqjLMCrjSA8ckLlC7gMCK4=;
        b=A7soYLxbvnm249AVP/ZvgL7czWvJKksOg7YVTTDIgarml4xkLVZg7wVP/8hCvkC5/n
         QS9zWTQ0YedLycm0usEIi/tqEJ1uAwrr+y3PE+tgSMFQueTRJYFXXlGrSwm4bJxhh3m8
         DRvwZ3hAmnAoNYVZFXQ+SIEGblwiHtTaKbZjF/5P/G/3483EQ2CZ9viOPY5qaZl5xaab
         6isHjk5QzGQRcYZ4mJcO29teT1h4ypeByt1+aKJ48spnoH+qCtQKaoW+dQn/PydTs9SJ
         bq9TabTRxEUiclj5NdLHPkHCJgZSiVhnZVY7VquaD9DUXIwlzNNzIBajSm+y4SlaPLnq
         5zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PXY1nCXJkUhuJYpS72IxBDqjLMCrjSA8ckLlC7gMCK4=;
        b=mLT7rT52ZVxpJRTr85t+/ZRFK1ipuyDhWWMFmXWPRFnuHajPynvNDGNCznLcKgDON2
         11aCWd4P+U5VixY2oe8yEcKk4rDhWBDmoDUurvocTlDM4W5F8T8juiTm/Fs/3K9TzIj2
         NS4R7j4HYkN9bDzvjHGeMMg7gMnRE22VkDRILZwEGY8NMtIRorTk8Xa5AtuKOquv5EEO
         avVyFqoL9dZIQqzsMcAbJ0A19tHWJYhauDPmbiia+hgZvxCmPCbpqGyw9yGfvWRgqtcb
         Z1IUrhIJuBoZT2Sr/fYKAbJkcwQmt7xUegQSYZPd42hbSJZTqIeGjc3pEikm9Zvsfo7g
         ve2Q==
X-Gm-Message-State: ABuFfoj3FbC9TzPNTlLhU++J89RvgWt53KOSOiQ21w7msZZIJZlNoOCE
        N87jVgbs7Cw1RT3fEdMF+4GlUE0=
X-Google-Smtp-Source: ACcGV60e+RZTqdVn5hv5J7h/5NSDFMUZniWC94m43EkV3+ooL0aKAA3toOlV+rm53GJRYI58kC6GcQ==
X-Received: by 2002:a1c:3ad3:: with SMTP id h202-v6mr11243027wma.120.1539556777171;
        Sun, 14 Oct 2018 15:39:37 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id g8-v6sm7229102wmf.45.2018.10.14.15.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:39:36 -0700 (PDT)
Date:   Mon, 15 Oct 2018 01:39:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kstrtox: delete unnecessary casts
Message-ID: <20181014223934.GA18107@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implicit casts to the same type are done by the language if necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/kstrtox.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -175,7 +175,7 @@ int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
 	rv = kstrtoull(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (unsigned long long)(unsigned long)tmp)
+	if (tmp != (unsigned long)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -191,7 +191,7 @@ int _kstrtol(const char *s, unsigned int base, long *res)
 	rv = kstrtoll(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (long long)(long)tmp)
+	if (tmp != (long)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -222,7 +222,7 @@ int kstrtouint(const char *s, unsigned int base, unsigned int *res)
 	rv = kstrtoull(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (unsigned long long)(unsigned int)tmp)
+	if (tmp != (unsigned int)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -253,7 +253,7 @@ int kstrtoint(const char *s, unsigned int base, int *res)
 	rv = kstrtoll(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (long long)(int)tmp)
+	if (tmp != (int)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -268,7 +268,7 @@ int kstrtou16(const char *s, unsigned int base, u16 *res)
 	rv = kstrtoull(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (unsigned long long)(u16)tmp)
+	if (tmp != (u16)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -283,7 +283,7 @@ int kstrtos16(const char *s, unsigned int base, s16 *res)
 	rv = kstrtoll(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (long long)(s16)tmp)
+	if (tmp != (s16)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -298,7 +298,7 @@ int kstrtou8(const char *s, unsigned int base, u8 *res)
 	rv = kstrtoull(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (unsigned long long)(u8)tmp)
+	if (tmp != (u8)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
@@ -313,7 +313,7 @@ int kstrtos8(const char *s, unsigned int base, s8 *res)
 	rv = kstrtoll(s, base, &tmp);
 	if (rv < 0)
 		return rv;
-	if (tmp != (long long)(s8)tmp)
+	if (tmp != (s8)tmp)
 		return -ERANGE;
 	*res = tmp;
 	return 0;
