Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93271C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B82171F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lLLQzzf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLYWRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 17:17:20 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59056 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLYWRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 17:17:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 3C96DB00
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j34ICfSHdfgh for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 16:17:18 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 08D0CAFC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 16:17:18 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id o205so17068570itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 14:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=28yUJ68ZGFPT4ZcistSK2mL3T2X59hDZT0xXbwmNw/A=;
        b=lLLQzzf80arwKtEAVd9ly9P0RrssIDpIAC6PsZ9QRfUgQhqK6JMdfTEguXTb9o0pz0
         +qwbW46W4t0nMip53UJo1LLua0e0LEBho3eYUwxKMUlxnXtHcxBuVhuqoePIokNVZy0S
         w2DzBmzttnSxlW8zKBXB7RRvhC8X2uCkdtOOVYYiZtFPmahQxTsmgVI+0KbAjHg3B+nz
         6JOylIjKYB+GDaP35vOTkND2CI7YTj7aUQEOZjVEqXvOj9xWSPfo1/Nz30XGj/ejVGO7
         hSAO4qKLhl9jWLPBGJ69P2FggrPztqA13EZpI0yOfuV4untdLHRokhpVcWymnlgwrzxN
         juuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=28yUJ68ZGFPT4ZcistSK2mL3T2X59hDZT0xXbwmNw/A=;
        b=USWtTgdMu5pTcOThz/xH7/JTJKlPWNKyKSGNxNwOw/H599STQ0lRxCnR0J12r0Pjvy
         IOvlV/3977zQO33pUOad29O6BacKjlis4riOjT4BCcUiPKgrweHUnYRI41wJ7VMHgVDO
         Z/W6IBh8FbpW6Sn4pm23oVKGuZtKf0sNFBLvX7Cc8CC2FT2upyoNrVxk1otoAQysRqrR
         R0pymTsxdI8OqqMhKT/v13fypRgbTp+bveOAYJ5VNxdDZ2dB9o//zTadxQ1ymuNevqEU
         CR7RJ6hkiG3c51dbX4Rq/Ut6KM9PTWhVPptm872lIZ88cXj7XMLiZQo2FmAbr4iS5626
         CBNg==
X-Gm-Message-State: AA+aEWZ4bbMS6ppViCVfbw6M2mkUMbotDfxYy6FfKFmSQTTFQIdyLx4W
        +bGiBdlK1Tj1q3hQ3AvAXmwIR62rR75ksm/ZyUrldF9EyRzDLVOBPZoIvL8IS7Y595lH6ytNEs5
        i/Md1f8nUSOvvaueMYPhVd4g8kk5r
X-Received: by 2002:a02:6a16:: with SMTP id l22mr11436595jac.139.1545776237613;
        Tue, 25 Dec 2018 14:17:17 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Vb2trp9vW+yEx2FgZSLop4Wp1iYTAuHLGld7rTRJOx/QGfxQjnUi5o+pbiwfjaX2sAvg9aCQ==
X-Received: by 2002:a02:6a16:: with SMTP id l22mr11436587jac.139.1545776237309;
        Tue, 25 Dec 2018 14:17:17 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n129sm13511801itb.20.2018.12.25.14.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 14:17:16 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: fix a potential double-fetch bug in sched_copy_attr
Date:   Tue, 25 Dec 2018 16:16:47 -0600
Message-Id: <20181225221648.70069-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"uattr->size" is copied in from user space and checked. However, it is
copied in again after the security check. A malicious user may race to
change it. The fix checks if uattr->size is ever changed after the
check.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 kernel/sched/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a98581..0a55bdce9a42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4447,7 +4447,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
  */
 static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
 {
-	u32 size;
+	u32 size, size_cp;
 	int ret;
 
 	if (!access_ok(VERIFY_WRITE, uattr, SCHED_ATTR_SIZE_VER0))
@@ -4460,15 +4460,17 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return ret;
 
+	size_cp = size;
+
 	/* Bail out on silly large: */
 	if (size > PAGE_SIZE)
 		goto err_size;
 
 	/* ABI compatibility quirk: */
 	if (!size)
-		size = SCHED_ATTR_SIZE_VER0;
+		size_cp = SCHED_ATTR_SIZE_VER0;
 
-	if (size < SCHED_ATTR_SIZE_VER0)
+	else if (size < SCHED_ATTR_SIZE_VER0)
 		goto err_size;
 
 	/*
@@ -4483,7 +4485,7 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 		unsigned char val;
 
 		addr = (void __user *)uattr + sizeof(*attr);
-		end  = (void __user *)uattr + size;
+		end  = (void __user *)uattr + size_cp;
 
 		for (; addr < end; addr++) {
 			ret = get_user(val, addr);
@@ -4492,13 +4494,17 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 			if (val)
 				goto err_size;
 		}
-		size = sizeof(*attr);
+		size_cp = sizeof(*attr);
 	}
 
-	ret = copy_from_user(attr, uattr, size);
+	ret = copy_from_user(attr, uattr, size_cp);
 	if (ret)
 		return -EFAULT;
 
+	/* Sanity check if size was changed in user space */
+	if (attr->size != size)
+		return -EINVAL;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
-- 
2.17.2 (Apple Git-113)

