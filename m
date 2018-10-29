Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00879C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D1E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jxKfdqCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D1E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJ3Axw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:53:52 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:61845 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJ3Axw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:53:52 -0400
X-Greylist: delayed 1342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 20:53:50 EDT
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9TG45i0028068;
        Tue, 30 Oct 2018 01:04:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9TG45i0028068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540829045;
        bh=0tY//mM+jHbaE/ok29QOqhO+tPXAkxJXjjSXgjK7fho=;
        h=From:To:Cc:Subject:Date:From;
        b=jxKfdqClVW7bKA/7MNaoLr4tQAZIWuMcFvC7WworuZpvL5buCTsVCt/oeP1cAd2ni
         /0oLLBDMbrFKFQ3LARl8ci7OkQ9gNI3vByyGHEE5FEeAsz9sPjYKCeMmCiyREE7SVq
         HLIoTodN5a4O67tYcsscJ/TgqXJRNng8uxMIn8xyVA8oisIBXJJhdOGOBJcEOfS510
         VpcACBG7Eqne8peB9JSAXJMzmDVQS9TFuDHL5CKuL/3G4tjsOOebEKcmCsg8XFIOIF
         yd/44Ena80yAZwHEOvG6YRYstU+dQjDi0+NhJng4rKPy1LBiSwe7gFwpCVEUoOZBJ9
         15TNzuzeYgFgA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: remove unused cc-fullversion variable
Date:   Tue, 30 Oct 2018 01:03:54 +0900
Message-Id: <1540829034-17725-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user of cc-fullversion was removed by commit f2910f0e6835
("powerpc: remove old GCC version checks").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt | 15 ---------------
 scripts/Kbuild.include             |  4 ----
 2 files changed, 19 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 7b6a2b2..8da26c6 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -537,21 +537,6 @@ more details, with real examples.
 	The third parameter may be a text as in this example, but it may also
 	be an expanded variable or a macro.
 
-    cc-fullversion
-	cc-fullversion is useful when the exact version of gcc is needed.
-	One typical use-case is when a specific GCC version is broken.
-	cc-fullversion points out a more specific version than cc-version does.
-
-	Example:
-		#arch/powerpc/Makefile
-		$(Q)if test "$(cc-fullversion)" = "040200" ; then \
-			echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
-			false ; \
-		fi
-
-	In this example for a specific GCC version the build will error out
-	explaining to the user why it stops.
-
     cc-cross-prefix
 	cc-cross-prefix is used to check if there exists a $(CC) in path with
 	one of the listed prefixes. The first prefix where there exist a
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ca21a35..19a63db 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -147,10 +147,6 @@ cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo
 # cc-version
 cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
-# cc-fullversion
-cc-fullversion = $(shell $(CONFIG_SHELL) \
-	$(srctree)/scripts/gcc-version.sh -p $(CC))
-
 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
 cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
-- 
2.7.4

