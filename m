Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9EB2172D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk6dy53S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9EB2172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeHMNSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:18:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeHMNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:18:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so7485671pfi.1;
        Mon, 13 Aug 2018 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X6tnlzWmvmM7bWn29Pd8dVyTWGdFhWAbU1/++8slXrY=;
        b=Hk6dy53SrP4K8IbSDWB4XkgmnfrEqTqdQ8j1xiJuPt8eqWAGYdyma2c53V82p9CMJf
         S0zhwkl3JhoIKKJlJrJKm4Qd924dgRGnZMXNBSIcf1ak4W70l7+Ev48PRLBLcC9eB2Hy
         KwSZd4ZlRYDNmWG9sgeYoab5c9O4f6DY9/8OThGK6cBxRvmEUg7iijN7ny5MOaX1mwI0
         V76OESvLxTmBB35Wt6NrcHkFAjeHQB3yAKJ3DydPjAe7Sn1O+csSZEziTQ+qsJpQoM7Y
         AYOfgHfi0SsuI2cCNFofX65xoAsXr9enye8z73JWABzouaUInVdD07xzfJ0Cl3/WOmio
         iY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X6tnlzWmvmM7bWn29Pd8dVyTWGdFhWAbU1/++8slXrY=;
        b=TLUTbNcjqwaEYA22xfh0rXx4wrzU/qvwIQef/2LxkwiypgcHUXmOx3gVckEs8FHXs4
         xU5cdLE2qQYoQNennEHcZ6X4Ssuy4J0G6fEJAPyXAlFSRRQvyejzYYG7xwNlLUiMkLeG
         ycRL+yuAk5BpOBVcNh6u5zp10bIxTE+CH/QVqyLlarPLWInv+A5xQfFI2zWPXxKBCSvp
         Y0rCvgghg3xMG1MebXVOMRd5hTg03McYEkReZHNQN5YaJnbFJSP1+ZHfFaOlZn8UuVjc
         oG+2jNVxQiDvhIBSHT5VygtKrSh0CMBmKNeIQa2qn1yv4tQ8dDqGiaPgncbqORvGHBoe
         G1xg==
X-Gm-Message-State: AOUpUlG+U9RqPla/uup2cvv3XHSul0WkZgzcjtzyzBl8LJmhT58lyS6M
        +YwUnUikUF9rFoA2tP7zcQ6Dp1rP
X-Google-Smtp-Source: AA+uWPz1ecQhCasJFbo1fJoOYDPMlxj7opV8Myj7B+bzzj1S7I8oon3/YJRy4T4yjRck8PH2NL+GhA==
X-Received: by 2002:a63:ea0c:: with SMTP id c12-v6mr16685334pgi.158.1534156594240;
        Mon, 13 Aug 2018 03:36:34 -0700 (PDT)
Received: from localhost.localdomain ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id u2-v6sm20933686pfn.59.2018.08.13.03.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 03:36:33 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     corbet@lwn.net
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] docs: dev-tools: coccinelle: Update documentation
Date:   Mon, 13 Aug 2018 16:06:14 +0530
Message-Id: <20180813103614.7495-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix install instruction by adding `./autogen` command
  before `./configure`.
* Add link to a more detailed installation instruction.
* Add link to SmPL grammar documentation.
* Add single space after ',' to slightly improve readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 94f41c290bfc..f8305cd55186 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -30,18 +30,29 @@ of many distributions, e.g. :
  - NetBSD
  - FreeBSD
 
-You can get the latest version released from the Coccinelle homepage at
+Some distribution packages are obsolete and it is recommended
+to use the latest version released from the Coccinelle homepage at
 http://coccinelle.lip6.fr/
 
-Once you have it, run the following command::
+Or Github at:
 
-     	./configure
+https://github.com/coccinelle/coccinelle
+
+Once you have it, run the following commands::
+
+        ./autogen
+        ./configure
         make
 
 as a regular user, and install it with::
 
         sudo make install
 
+More detailed installation instruction to build from source can be
+found at:
+
+https://github.com/coccinelle/coccinelle/blob/master/install.txt
+
 Supplemental documentation
 ---------------------------
 
@@ -51,6 +62,10 @@ https://bottest.wiki.kernel.org/coccicheck
 
 The wiki documentation always refers to the linux-next version of the script.
 
+For Semantic Patch Language(SmPL) grammar documentation refer to:
+
+http://coccinelle.lip6.fr/documentation.php
+
 Using Coccinelle on the Linux kernel
 ------------------------------------
 
@@ -223,7 +238,7 @@ Since coccicheck runs through make, it naturally runs from the kernel
 proper dir, as such the second rule above would be implied for picking up a
 .cocciconfig when using ``make coccicheck``.
 
-``make coccicheck`` also supports using M= targets.If you do not supply
+``make coccicheck`` also supports using M= targets. If you do not supply
 any M= target, it is assumed you want to target the entire kernel.
 The kernel coccicheck script has::
 
-- 
2.17.1

