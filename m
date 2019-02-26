Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF88FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1F217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqd2wEn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfBZSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:23:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33000 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfBZSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:23:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so6647764pfd.0;
        Tue, 26 Feb 2019 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l8oFWUQ41dJ49oxhIQmprIfY2YfSLtyDWk2PutMXuyg=;
        b=Sqd2wEn3x4uEINFh77sfnkmC/3Pf1MbOBcYaOEH4cQLm6ZkRnS7SYrttEgUvPFg64j
         by4yPwy1R3nIioQDBndLvivsyjrPuUR3VX2ZSB7bbxnRyA23U2qwve6kf14DdwNNe8qJ
         ocZhxgSMHD7tU+2Drm0nTgbjssPhmQ+R53DGLHrOQCxbEjcLm5BFBVSU5iBXpsTFt4Bu
         BWd2kCJikkmdJRtTMyB42FGBxgJrlbc7WRiFpFZoWwwcCUvYLT+emdrfgpxu6G1iuyuD
         EZfe5j8aK0Hu57oNevBjJGzi4poGZTJxsWbMxILgdS9c6zLMEFfgWRf9eGI8Bv5KTtUX
         4IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l8oFWUQ41dJ49oxhIQmprIfY2YfSLtyDWk2PutMXuyg=;
        b=fmV+bEt5ZlVe9KnJ7+nI7O6egHKEZcCbFK7SKvFx6qAuxY6nuJpJg4j/TCNhiLOjpi
         gHi58+R7re2ZP9wg47G/w/3OH8B4BhLIqYTuPz0JAtaLf9Ac+W43ScqhzfSUTgV/hzoX
         YYM5AAjfK1awhOyEA9ZhN71pbZY1L/v+VeeA3s2ZzdnSEX7N+DIGF1IbmO3ubE6Im9Hn
         rjwFxW4g9o2fcTz/i/DtLYk/JuwY7eOx06GQWlC2/ObsRbFgC8l4t3EO0G3JNYilxmDB
         4cWdRGMMFNkEyDRJYJxCccZap4FUcSF2bEE05XCjC51Kaji8LfCLdiTG7fdwy4gxS9IM
         /5cg==
X-Gm-Message-State: AHQUAuaV7G/Q3kvOY0SOHNafoRwObJXGgv65Yw8+pmF0xS2SAV2Zwfjp
        fnKF2jP9g5JK7lT8wpZSmCE=
X-Google-Smtp-Source: AHgI3IZVhcLXBSkKDX//3L/0vP+k4d/jOckRQKFuwAczGR14EqugarRrg8LPSbl2/5OPQomuHQhsuQ==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr27532105pfm.5.1551205392467;
        Tue, 26 Feb 2019 10:23:12 -0800 (PST)
Received: from ubuntuu.lan ([112.10.94.48])
        by smtp.gmail.com with ESMTPSA id f3sm18142475pfn.100.2019.02.26.10.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 10:23:11 -0800 (PST)
From:   Zenghui Yu <zenghuiyu96@gmail.com>
To:     corbet@lwn.net
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zenghui Yu <zenghuiyu96@gmail.com>
Subject: [PATCH v3] Documentation/process/howto: Update for 4.x -> 5.x versioning
Date:   Wed, 27 Feb 2019 02:22:22 +0800
Message-Id: <1551205342-5630-1-git-send-email-zenghuiyu96@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As linux-5.0 is coming up soon, the howto.rst document can be
updated for the new kernel version. Instead of changing all 4.x
references to 5.x, this time we git rid of all explicit version
numbers and rework some kernel trees' name to keep the docs
current and real.

Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>
---
 Documentation/process/howto.rst | 47 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

 Change since v2:
 - remove explicit version numbers and rework kernel trees' name
   by Jon's suggestions

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index f16242b..ad2b6c8 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -235,22 +235,21 @@ Linux kernel development process currently consists of a few different
 main kernel "branches" and lots of different subsystem-specific kernel
 branches.  These different branches are:
 
-  - main 4.x kernel tree
-  - 4.x.y -stable kernel tree
-  - subsystem specific kernel trees and patches
-  - the 4.x -next kernel tree for integration tests
+  - Linus's mainline tree
+  - Various stable trees with multiple major numbers
+  - Subsystem-specific trees
+  - linux-next integration testing tree
 
-4.x kernel tree
-~~~~~~~~~~~~~~~
+Mainline tree
+~~~~~~~~~~~~~
 
-4.x kernels are maintained by Linus Torvalds, and can be found on
-https://kernel.org in the pub/linux/kernel/v4.x/ directory.  Its development
-process is as follows:
+Mainline tree are maintained by Linus Torvalds, and can be found at
+https://kernel.org or in the repo.  Its development process is as follows:
 
   - As soon as a new kernel is released a two weeks window is open,
     during this period of time maintainers can submit big diffs to
     Linus, usually the patches that have already been included in the
-    -next kernel for a few weeks.  The preferred way to submit big changes
+    linux-next for a few weeks.  The preferred way to submit big changes
     is using git (the kernel's source management tool, more information
     can be found at https://git-scm.com/) but plain patches are also just
     fine.
@@ -277,21 +276,19 @@ mailing list about kernel releases:
 	released according to perceived bug status, not according to a
 	preconceived timeline."*
 
-4.x.y -stable kernel tree
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Various stable trees with multiple major numbers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Kernels with 3-part versions are -stable kernels. They contain
 relatively small and critical fixes for security problems or significant
-regressions discovered in a given 4.x kernel.
+regressions discovered in a given major mainline release, with the first
+2-part of version number are the same correspondingly.
 
 This is the recommended branch for users who want the most recent stable
 kernel and are not interested in helping test development/experimental
 versions.
 
-If no 4.x.y kernel is available, then the highest numbered 4.x
-kernel is the current stable kernel.
-
-4.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
+Stable trees are maintained by the "stable" team <stable@vger.kernel.org>, and
 are released as needs dictate.  The normal release period is approximately
 two weeks, but it can be longer if there are no pressing problems.  A
 security-related problem, instead, can cause a release to happen almost
@@ -301,8 +298,8 @@ The file :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rule
 in the kernel tree documents what kinds of changes are acceptable for
 the -stable tree, and how the release process works.
 
-Subsystem Specific kernel trees and patches
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Subsystem-specific trees
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 The maintainers of the various kernel subsystems --- and also many
 kernel subsystem developers --- expose their current state of
@@ -326,19 +323,19 @@ revisions to it, and maintainers can mark patches as under review,
 accepted, or rejected.  Most of these patchwork sites are listed at
 https://patchwork.kernel.org/.
 
-4.x -next kernel tree for integration tests
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+linux-next integration testing tree
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Before updates from subsystem trees are merged into the mainline 4.x
-tree, they need to be integration-tested.  For this purpose, a special
+Before updates from subsystem trees are merged into the mainline tree,
+they need to be integration-tested.  For this purpose, a special
 testing repository exists into which virtually all subsystem trees are
 pulled on an almost daily basis:
 
 	https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
-This way, the -next kernel gives a summary outlook onto what will be
+This way, the linux-next gives a summary outlook onto what will be
 expected to go into the mainline kernel at the next merge period.
-Adventurous testers are very welcome to runtime-test the -next kernel.
+Adventurous testers are very welcome to runtime-test the linux-next.
 
 
 Bug Reporting
-- 
2.7.4

