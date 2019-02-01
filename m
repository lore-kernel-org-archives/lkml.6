Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB4B214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWtlQOf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfBAVzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:55:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38315 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfBAVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:55:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so3874347plb.5;
        Fri, 01 Feb 2019 13:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NWV0/MkQD8wm4D8WdJgA8Ao1Dly2o2dkq1lRefkWuhA=;
        b=IWtlQOf0bS2UwUETfIdYd9fo93fsmpq67NhspXWzbmYr9QT2Sjg88S036mNwwSh8zS
         UAvdb9/Rqzm7D0RHeqecXEY7HqYg1Yv/m+vhJWm4S0K2HHkgrSgWTbk4y+PYZbCNZHbd
         ofr9EYz8BnzjSv5b7wWdUq4PnkknlMMc7x19n9OEdHgw1UMPlt/j87andHsRBKUZjdQT
         ITdHCHJFK4mwiK19VIfv+Mq0/YPVTL0AAoR4+eM5fXrGtWV4WZGbpFoXGu08sgSruxOH
         lFfdLwpBeZarpedxQxLC5Dwq9jCsu2yZYSwAXlXquqSBDGN+7Gg7V9+EhFSJIXQDTCm8
         NXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWV0/MkQD8wm4D8WdJgA8Ao1Dly2o2dkq1lRefkWuhA=;
        b=bQe2CWaWzdz2L4KuQ8AlFWA/xuVzNDBV+XQeYyIzsOqZqANGlYw9y9lu9PlnWtYX8N
         W9O7nJoIkPBdNoQP5087eKQHBxnU++WHaswVZWmHjkoaMEQHZ5+Xb3oJcph4bH18aIez
         mLq1pjWndYMUF8d4NM8fIC9dw4gq4cEOIJYzTe4pBr6C1jhtF7RQhqM0f/99TTh4D/wN
         5s0swRtkAakTW6aDREOJoZJGvDuuqRXvfe/Jraj2shpc2edkx5tzXZdl3XIrY3C0DHEa
         3s0ud8UgRePlBTNQQ+AWJJH6UcW7EI3on2eYD6Bet1IteeGBCBE3BUowvfPmHujX7aG8
         R6qg==
X-Gm-Message-State: AJcUukd5l87BRCzGV1xOJs5iW3+NW839Bv7xFo1+L+LC8Xk0WQ1VxDFG
        IuYyT7+/bCqbNDWvUDHITM9h41uK
X-Google-Smtp-Source: ALg8bN7XN5DWIA2v/lRy8EwKgqXpFm1LZJWPhLttzPZwY+8eBQDgRiuH9O9IrQY5wuRjyRZ/iR02Wg==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr41980398pll.215.1549058119557;
        Fri, 01 Feb 2019 13:55:19 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m20sm10561851pgv.93.2019.02.01.13.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 13:55:18 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kernel-doc: update commands to generate man page
Date:   Fri,  1 Feb 2019 13:54:39 -0800
Message-Id: <1549058079-10582-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

(1) The command to generate man pages is truncated in the pdf version
of the document.  Reformat the command into multiple lines to prevent
the truncation.

(2) Older versions of git do not support all variants of pathspec
syntax.  Provide commands to generate man pages for various
alternate syntax.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/doc-guide/kernel-doc.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 51be62aa4385..450ac634e92e 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -517,4 +517,17 @@ How to use kernel-doc to generate man pages
 If you just want to use kernel-doc to generate man pages you can do this
 from the kernel git tree::
 
-  $ scripts/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
+  $ scripts/kernel-doc -man \
+    $(git grep -l '/\*\*' -- :^Documentation :^tools) \
+    | scripts/split-man.pl /tmp/man
+
+Some older versions of git do not support some of the variants of syntax for
+path exclusion.  One of the following commands may work for those versions::
+
+  $ scripts/kernel-doc -man \
+    $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
+    | scripts/split-man.pl /tmp/man
+
+  $ scripts/kernel-doc -man \
+    $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
+    | scripts/split-man.pl /tmp/man
-- 
Frank Rowand <frank.rowand@sony.com>

