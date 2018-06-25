Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D4BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CF924623
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssGsH9jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CF924623
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFYQe0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:34:26 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:54012 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbeFYQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:34:24 -0400
Received: by mail-yw0-f201.google.com with SMTP id l72-v6so3904123ywc.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=5r8Qzj3yn0Oa3QmJsH3jhAdnFwG5gYoFLMbH1TiX/EQ=;
        b=ssGsH9jST1MW8KZCz8WPyb0hyKA1I0BYononff6zaZseuJ9j/Tlk17XYH+HzhUWqXO
         QjudCm+1032v2OgMTYW45p984oB1/Xk5c3qvU04QOkn4nlejVZhtLcr0SwPwcXoa09ps
         GxP3kY+nXjMWJGvoUHoDHWJu7PpEpL/MR+/X84Qv3iQCqUY9nUB3N6mHykCsb0cyZNt0
         blKA/lM17tBvPcn1wyhD+zeNaPZsPp7g6N+q81zm0re6JDvQQMtHI0QX1Nvj0A3qNxq7
         +epwF+ZovFcluX/87YsOBFRW74Kwfnq5Md2VD0QcqfOceO28MxZmUQNFHXfsemsS+kWq
         9ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=5r8Qzj3yn0Oa3QmJsH3jhAdnFwG5gYoFLMbH1TiX/EQ=;
        b=CSPRXn0/A9cbJuJr2mTpR+71h/Y/a4EpLmTHqXM8xvMFmTvkASD7OlMyv7v5V5ob8i
         J6wZHbdRhqSjCqar6G04ZtTAkNlTkUcdXmeeOZCojpOEF0KAfkTHAaSDQIHwFDYGTKDV
         1xfsEP0aFxfnsnULkSXaSImHt+uoieQQJmwStHADIWp11QkFnJXm0V1xIxXNTgrqRzTF
         G/dOTWe/+ILWLr+SVu7Jc0J0OazqhBMvxysFCCHEhkfsoksVf7SpwvtWBV7K7c5TkAah
         40YbEuWTdXZ1vurhdP3BKASgdQ+6IIoyBxe5L6nzipuMuqugX4H7dxbl5Gu6YzX3xbrp
         ngdw==
X-Gm-Message-State: APt69E1Ovgm5goWgygO0ynMmZ1QRUnykWR/rBivoBHucefo6bh8idG/Y
        dYopwCkcsBQVGDYnG1oWA5Vz1BaHtw==
X-Google-Smtp-Source: ADUXVKL1GNEKeMqmDmrudZdX+4xKiZ+n+A2i2M+EUnl3cjC6uR7hCp1WrVBDDof+G8VopoYZ0FnuNlrVGw==
MIME-Version: 1.0
X-Received: by 2002:a25:918e:: with SMTP id w14-v6mr1318930ybl.71.1529944463338;
 Mon, 25 Jun 2018 09:34:23 -0700 (PDT)
Date:   Mon, 25 Jun 2018 18:34:19 +0200
Message-Id: <20180625163419.216578-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] userns: move user access out of the mutex
From:   Jann Horn <jannh@google.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, jannh@google.com
Cc:     security@kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old code would hold the userns_state_mutex indefinitely if
memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
moving the memdup_user_nul in front of the mutex_lock().

Note: This changes the error precedence of invalid buf/count/*ppos vs
map already written / capabilities missing.

Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/user_namespace.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index c3d7583fcd21..e5222b5fb4fe 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -859,7 +859,16 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	unsigned idx;
 	struct uid_gid_extent extent;
 	char *kbuf = NULL, *pos, *next_line;
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
 
 	/*
 	 * The userns_state_mutex serializes all writes to any given map.
@@ -895,19 +904,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	if (cap_valid(cap_setid) && !file_ns_capable(file, ns, CAP_SYS_ADMIN))
 		goto out;
 
-	/* Only allow < page size writes at the beginning of the file */
-	ret = -EINVAL;
-	if ((*ppos != 0) || (count >= PAGE_SIZE))
-		goto out;
-
-	/* Slurp in the user data */
-	kbuf = memdup_user_nul(buf, count);
-	if (IS_ERR(kbuf)) {
-		ret = PTR_ERR(kbuf);
-		kbuf = NULL;
-		goto out;
-	}
-
 	/* Parse the user data */
 	ret = -EINVAL;
 	pos = kbuf;
-- 
2.18.0.rc2.346.g013aa6912e-goog

