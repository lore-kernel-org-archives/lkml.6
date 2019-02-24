Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B320663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJXaIRUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfBXInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 03:43:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbfBXIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 03:43:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so5384658wmg.4;
        Sun, 24 Feb 2019 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6YWJyb2pqTzDR09+w4uI6M95MSW8vF0Z3qgpHYVq1jQ=;
        b=PJXaIRUgzJ77lw0MboYEjNoZP3MP34oR3u8Py4Y76vC1RgKXG6m71uU2AcY45+g3LN
         9issTFR0OkBLEdcxRTyONm9cbWE+YFhwIZazcmh9WQuAPHtHbxGhejk244JWHFL7UIex
         iR53RTI5+DReI0M8Mq7XNCaGFZCZ6IH0v+1WzX4jcLWADgS+K/F9MC9mrEjf0xFAayAd
         t0KrKX+h3nkwgSRsa1R6K5uOaoWNoj1DomU4td2TINHZbPZSudIbTCVqy8XrETVD/lYi
         lWDERl1sdWC/IRqJbZYxBiPX9TeNoFbAXLplk0mRcoTz9F1j5azIpkMXkCobVww4eYRC
         eaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6YWJyb2pqTzDR09+w4uI6M95MSW8vF0Z3qgpHYVq1jQ=;
        b=GazhqGqpVK08tm3wHjWpoBzF4eh+fpJ9D190kZpthTXbXeiWqmWRPw0WzzMv8lkMkt
         k1FYfwzDuKdfDuHdjzIq8plYLNB4J9CviegBnxpO8A/FdHhUDVedhafGFK5JZKrYHJ/t
         nK19FzP/CPPtAwo5fZsyLhkwh3/pwDwX/i+gVu4cIzaZM8Wfz7PXkzlzIfSP7zEskt+X
         23hZOX0KdofoxxV/1AoayVDKzL0GEggfR7yh5vQQhzwvzE1VyhBrJE1VSXdXi8G0Wt2E
         MYYu9wpzm4AtRe9WlErTvLUwEJ4UjYAJMcAdFUWKiNd/5gO7HGw4cKSxhzXYgbLvNazO
         gPrQ==
X-Gm-Message-State: AHQUAuZl4wgw0MAe0Mi5uNKIg6mL78p0Spec2YspHFtv9o6TaWwaoeRq
        ZxFVbbOivu3R3mgfmEWW5JoD124TdLOENTuxWx401t11PSc=
X-Google-Smtp-Source: AHgI3IYL/W3Z7/Q9Orv+TGbDeoNQZRvaHVW00u4sBQXXjIJBx+eBZNPE7PSK1jddYj8/bzL1UWaNZK/UiVwnpTP2nUk=
X-Received: by 2002:a1c:d183:: with SMTP id i125mr6948418wmg.30.1550997811740;
 Sun, 24 Feb 2019 00:43:31 -0800 (PST)
MIME-Version: 1.0
From:   Zenghui Yu <zenghuiyu96@gmail.com>
Date:   Sun, 24 Feb 2019 16:43:20 +0800
Message-ID: <CAKcZhuWHU+udbAyL910JW8rhZsbpomz5TXs0z2FD4m5c5Sf8hw@mail.gmail.com>
Subject: [PATCH] Documentation/process/howto: Update for 4.x -> 5.x versioning
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
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
@@ -235,16 +235,16 @@ Linux kernel development process currently
consists of a few different
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
@@ -326,10 +326,10 @@ revisions to it, and maintainers can mark
patches as under review,
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
