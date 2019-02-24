Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E766AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBEE20652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKxBlN7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfBXPpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:45:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34363 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:45:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so3304190pfn.1;
        Sun, 24 Feb 2019 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CtA84kazj2gAOPwBK1+toscY4GtDlJXc5RLYGVLYvFw=;
        b=RKxBlN7OYz+OvkczpkGUTUBnXrGyweFTyqRFWW77HA9iPyj5o9hZW4e2F50+oWyQ5F
         Q8KPIam13kkj1ZndMyhtlL6kKiuI22BJ+MWCSGJAJ8TZ8S7k/kmCotmwlQQf8yvPg4Xe
         i5E06LSvV2GTRcyy8kBZ3/jJPNb4KYisJqrSbJmbOJBDLAMCs12TyxZgRbXWiS4f69Ua
         8LiLHmMqNukmnG/ITQvkNa4i9zcjMWbU3P9RmuHKhWbyKhqD+wxE2oPx2o5zGhS3nAxD
         btGtKap/0Kpq3hR992JtRAL8RfYl6jM8L1SRwnr6Ejw+LZDf6c8kgwenMMOjvguRuqKx
         mCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CtA84kazj2gAOPwBK1+toscY4GtDlJXc5RLYGVLYvFw=;
        b=V66iQtxTau8NuO7sH55ToYNPVXrGePWPZSRjoVhPPVynlsml3hTXPLi2ut4FIJm+Lp
         LQF50MBdqxZOvgEopUBiU+p+ZmQRQNvv46Biswmjc+R2WEfbbLEw27yfYopfk39Y1woy
         bkg3gdltrStm5BzcmFpY/GAOAFrLQpMRxfanGNlg3me8NJOj1OBpnYCaAM9crlXMoo3Q
         rJlRwkps6pUKqoq68W7R5L1df7iqGP4oXPGGMUPN5mvfL8t/53gOd21xpc1qo1YnoutJ
         pe25nKJ7/91lMYqfvlidpz6Wd9oW8Kp7nFd+L/hz3rO6pDvLNp+0+SSaDGD7b+DrEvXh
         kqMQ==
X-Gm-Message-State: AHQUAubZbSHzxmR4w7azNzfXVQaJn0UEyCex+czOwEPMT2vjKXWIGSJK
        O0eZ1JT2DcW+icBRxlgOy6Q=
X-Google-Smtp-Source: AHgI3IYcLEpZ0PgAkfH4ewcStrUKmRELvnasdsRQ3RmbDsvXCcnNGPsUjlKPQfEM3tQeJdGNzvqOoQ==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr14658090pfm.63.1551023140422;
        Sun, 24 Feb 2019 07:45:40 -0800 (PST)
Received: from ubuntuu.lan ([112.10.94.48])
        by smtp.gmail.com with ESMTPSA id 33sm18326147pgs.81.2019.02.24.07.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Feb 2019 07:45:39 -0800 (PST)
From:   Zenghui Yu <zenghuiyu96@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zenghui Yu <zenghuiyu96@gmail.com>
Subject: [PATCH v2] Documentation/process/howto: Update for 4.x -> 5.x versioning
Date:   Sun, 24 Feb 2019 23:45:23 +0800
Message-Id: <1551023123-5031-1-git-send-email-zenghuiyu96@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As linux-5.0 is coming up soon, the howto.rst document can be
updated for the new kernel version. Change all 4.x references
to 5.x now.

Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>
---
 Documentation/process/howto.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index f16242b..19001e2 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -235,16 +235,16 @@ Linux kernel development process currently consists of a few different
 main kernel "branches" and lots of different subsystem-specific kernel
 branches.  These different branches are:
 
-  - main 4.x kernel tree
-  - 4.x.y -stable kernel tree
+  - main 5.x kernel tree
+  - 5.x.y -stable kernel tree
   - subsystem specific kernel trees and patches
-  - the 4.x -next kernel tree for integration tests
+  - the 5.x -next kernel tree for integration tests
 
-4.x kernel tree
+5.x kernel tree
 ~~~~~~~~~~~~~~~
 
-4.x kernels are maintained by Linus Torvalds, and can be found on
-https://kernel.org in the pub/linux/kernel/v4.x/ directory.  Its development
+5.x kernels are maintained by Linus Torvalds, and can be found on
+https://kernel.org in the pub/linux/kernel/v5.x/ directory.  Its development
 process is as follows:
 
   - As soon as a new kernel is released a two weeks window is open,
@@ -277,21 +277,21 @@ mailing list about kernel releases:
 	released according to perceived bug status, not according to a
 	preconceived timeline."*
 
-4.x.y -stable kernel tree
+5.x.y -stable kernel tree
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Kernels with 3-part versions are -stable kernels. They contain
 relatively small and critical fixes for security problems or significant
-regressions discovered in a given 4.x kernel.
+regressions discovered in a given 5.x kernel.
 
 This is the recommended branch for users who want the most recent stable
 kernel and are not interested in helping test development/experimental
 versions.
 
-If no 4.x.y kernel is available, then the highest numbered 4.x
+If no 5.x.y kernel is available, then the highest numbered 5.x
 kernel is the current stable kernel.
 
-4.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
+5.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
 are released as needs dictate.  The normal release period is approximately
 two weeks, but it can be longer if there are no pressing problems.  A
 security-related problem, instead, can cause a release to happen almost
@@ -326,10 +326,10 @@ revisions to it, and maintainers can mark patches as under review,
 accepted, or rejected.  Most of these patchwork sites are listed at
 https://patchwork.kernel.org/.
 
-4.x -next kernel tree for integration tests
+5.x -next kernel tree for integration tests
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Before updates from subsystem trees are merged into the mainline 4.x
+Before updates from subsystem trees are merged into the mainline 5.x
 tree, they need to be integration-tested.  For this purpose, a special
 testing repository exists into which virtually all subsystem trees are
 pulled on an almost daily basis:
-- 
2.7.4

