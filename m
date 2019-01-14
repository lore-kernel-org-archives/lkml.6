Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A61C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F53C20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htpt4yDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfANGMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:12:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45077 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANGMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:12:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so8993133pgc.12;
        Sun, 13 Jan 2019 22:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt6AaUzE5JeuNjhdFsMJIMTlGothvrSQNRnBfrCYoSg=;
        b=Htpt4yDg66zmoVG5oKL0wQ22uPfuzl3IDK0S/IdxC4ewePP9huqK1HDTdOi14u+DRe
         Zm7bsLTR48RR6tMD++97mi/5CWJ7LWd6kz0f/wUGfeBDsox08am91O5JV9PQnwdMTV1L
         hT5SyohuT5wxRYqV/5Dyt5d5tL4R5Jq2HZOAXNbykGxTcfdJESOP9Uo8WtF4RYI1vG0e
         e5FJuk+qLlyq2HtR93+Zr41lmwrmBhDE16dn+hGsLqN4eEHYk5tgUEXhc3tzMxW/8eGn
         xlq3emJZUGMmOXAB1G75D/vfyIsQeu5uiQ+fltf15Q2P5q5iQly+4dH+iljxcyAWet3d
         mMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Bt6AaUzE5JeuNjhdFsMJIMTlGothvrSQNRnBfrCYoSg=;
        b=VjZatdzS2LrQYBP8ULLmXR8AL0HDhdnHeF3HqOazWo6w47rgD5GKg++vOo6d79cGPF
         p9JV0WUCr1PslZzJLZByCXoq04X+inNDUcFWObjcjWF8aDkmk7SEXRpPT2UISQvrFIYa
         HvSHYxqG/FWmNAWBAY4SBOxyEkYVY/kUg0cMMSQ/lkvzB/FewFqSkY1b5YWLt63c5Xnv
         GMPiK0I9M0/RJYYlbiw+gLf7rtfXWwUS3Kop8+UmyfURTf4qEvJs8gh6T342xG+MT/WS
         nqueWEKCWOHAbq69F0QW+BRy08ABE+Da/GbU5bLovkqWYE+XGTuzbv6q2qp+FbAw1Ff1
         gh0Q==
X-Gm-Message-State: AJcUukdkCzKQTzsn06tm9wk0E9jn9fAIs+HUDJG277veOg5mpsoVjxm5
        bkSqty4hcnSv9gZTOgOj/RkNhtTJb5I=
X-Google-Smtp-Source: ALg8bN5NiZCgNvqCDNtsz+SF8D6ZKHmxedwKIrbMmT/3XjIwRygpO9uSPZd6B6fS4376j26tXsqICw==
X-Received: by 2002:a63:e247:: with SMTP id y7mr18592332pgj.84.1547446349309;
        Sun, 13 Jan 2019 22:12:29 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id v15sm120195307pfn.94.2019.01.13.22.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 22:12:28 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 14 Jan 2019 16:42:21 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] docs: Bump version to 5.x
Date:   Mon, 14 Jan 2019 16:42:21 +1030
Message-Id: <20190114061221.30494-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows up in the index of https://www.kernel.org/doc/html/latest/ so
I figured it should be updated.

Fixes: bfeffd15528 ("Linux 5.0-rc1")
Signed-off-by: Joel Stanley <joel@jms.id.au>
--
We could also remove the version number instead of applying this patch.
---
 Documentation/admin-guide/README.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 0797eec76be1..a09baa324951 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,9 +1,9 @@
 .. _readme:
 
-Linux kernel release 4.x <http://kernel.org/>
+Linux kernel release 5.x <http://kernel.org/>
 =============================================
 
-These are the release notes for Linux version 4.  Read them carefully,
+These are the release notes for Linux version 5.  Read them carefully,
 as they tell you what this is all about, explain how to install the
 kernel, and what to do if something goes wrong.
 
@@ -406,3 +406,4 @@ If something goes wrong
 
    gdb'ing a non-running kernel currently fails because ``gdb`` (wrongly)
    disregards the starting offset for which the kernel is compiled.
+
-- 
2.19.1

