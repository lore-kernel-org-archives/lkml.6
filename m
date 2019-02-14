Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2139C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3EA222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ml9kyIN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfBNB2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:28:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41756 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbfBNB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:27:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so2145181pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3azZvromwKfBF/zPw4eI4tqfno+w0HHBSkhPZ62cyHk=;
        b=ml9kyIN8ZhXZYQDp/AfP2l6wRUZ9vNvCxPzrwXVvjAUVZVBeDZ3XIHQ+n8daFxt9ch
         xq5r0BENne+v8hmlvMBhhelbf4fD/ECE6azigQRDonhynMWj4Kr9mAat6PNBBX6C/Jir
         rrGAn35h6vIx0mD66VWjCwaBinmtaYuiJXIHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3azZvromwKfBF/zPw4eI4tqfno+w0HHBSkhPZ62cyHk=;
        b=rJIL413raqTC/cFwEq8Z3q/vQrAHM3oKxChoQJhXeghj+Ja9RZwU2qSCQeVrjRWlk+
         SoI1LV0mGEONd+5vSV68CJMpsCJBRTJkqFlDj4s/3Z/QPZEBi2dEMr0UVJwUjKAM8zHd
         A9Sxs0Ij+e4+kZjcbbCfVTIX4VGtjjMGKZiVLjAhWWnzj3TFB1LCqEo2kog0obSFo8aI
         QiYXo85JaIm/AnJcZKO7GCJIc6fgvHCtdFuG9FtT7rkHAXcAy08TmElHqUV2XQLRn5zI
         JIxS6vrFw9ixdnKAkFdZ156Y7ftgd62VYPT0nTW8w9Ni5031Pa8J/wQ8dzwxoObaoN+0
         fYDw==
X-Gm-Message-State: AHQUAuZSH6wfgXOKmD2OVoK72I0PDvpuhXnpcr5jomdq7gGYyHcGFc6j
        mTf0IvtzXYz7xGbcmroA1FVzwg==
X-Google-Smtp-Source: AHgI3Ia3TgEZmwxcLN2iCPx6QhFWBnfnbFgrEgWFWUY/+2wCkrlymSehvSdXBvJYfObbukQwpwJNyQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1131877pge.295.1550107676220;
        Wed, 13 Feb 2019 17:27:56 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h19sm686374pfn.114.2019.02.13.17.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 17:27:55 -0800 (PST)
Date:   Wed, 13 Feb 2019 17:27:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Graham Christensen <graham@grahamc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] exec: load_script: Allow interpreter argument truncation
Message-ID: <20190214012754.GA17326@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we want to make sure the kernel doesn't attempt to execute a
truncated interpreter path, we must allow the interpreter arguments to
be truncated. Perl, for example, will re-read the script itself to parse
arguments correctly.

This documents the parsing steps, and will fail to exec if the string was
truncated with neither an end-of-line nor any trailing whitespace.

Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Fixes: 8099b047ecc4 ("exec: load_script: don't blindly truncate shebang string")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_script.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index d0078cbb718b..3db23528bb85 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -20,6 +20,7 @@ static int load_script(struct linux_binprm *bprm)
 	char *cp;
 	struct file *file;
 	int retval;
+	bool truncated = false, end_of_interp = false;
 
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
@@ -42,32 +43,56 @@ static int load_script(struct linux_binprm *bprm)
 	fput(bprm->file);
 	bprm->file = NULL;
 
+	/*
+	 * Truncating interpreter arguments is okay: the interpreter
+	 * can re-read the script to parse them on its own. Truncating
+	 * the interpreter path itself, though, is bad. Note truncation
+	 * here, and check for either newline or start of arguments
+	 * below.
+	 */
 	for (cp = bprm->buf+2;; cp++) {
-		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
-			return -ENOEXEC;
-		if (!*cp || (*cp == '\n'))
+		if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
+			truncated = true;
 			break;
+		}
+		if (!*cp || (*cp == '\n')) {
+			end_of_interp = true;
+			break;
+		}
 	}
 	*cp = '\0';
 
+	/* Truncate trailing whitespace */
 	while (cp > bprm->buf) {
 		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
+		if ((*cp == ' ') || (*cp == '\t')) {
+			end_of_interp = true;
 			*cp = '\0';
-		else
+		} else
 			break;
 	}
+	/* Skip leading whitespace */
 	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
 	if (*cp == '\0')
 		return -ENOEXEC; /* No interpreter name found */
 	i_name = cp;
 	i_arg = NULL;
+	/*
+	 * Skip until end of string or finding whitespace which
+	 * signals the start of interpreter arguments.
+	 */
 	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
 		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
+	/* Truncate and skip any whitespace in front of arguments */
+	while ((*cp == ' ') || (*cp == '\t')) {
+		end_of_interp = true;
 		*cp++ = '\0';
+	}
 	if (*cp)
 		i_arg = cp;
+	/* Fail exec if the name of the interpreter was cut off. */
+	if (truncated && !end_of_interp)
+		return -ENOEXEC;
 	/*
 	 * OK, we've parsed out the interpreter name and
 	 * (optional) argument.
-- 
2.17.1


-- 
Kees Cook
