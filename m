Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeB1KQE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:16:04 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:57349 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeB1KQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:16:00 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1SAEVc0029479
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Robin Jarry <robin.jarry@6wind.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 2/2] kbuild: remove internally used LDFLAGS_vmlinux from kbuild.txt
Date: Wed, 28 Feb 2018 19:14:24 +0900
Message-Id: <1519812864-852-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519812864-852-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519812864-852-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/kbuild/makefiles.txt lists variables used in Makefile
whereas Documentation/kbuild/kbuild.txt describes user assignable
parameters given via environments or the command line.

The top Makefile and arch/*/Makefile accumulate proper linker flags to
LDFLAGS_vmlinux.  So, users can not override it from the command line.
Generally, per-file options are not supposed to be user-assignable.
Remove the misleading entry from kbuild.txt.

If we need a way to append user-specific flags for linking the kernel,
LDFLAGS_KERNEL would be a consistent choice because we already expose
LDFLAGS_MODULE counter-part to users.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/kbuild.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index ac2363e..6c9c69e 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -50,10 +50,6 @@ LDFLAGS_MODULE
 --------------------------------------------------
 Additional options used for $(LD) when linking modules.
 
-LDFLAGS_vmlinux
---------------------------------------------------
-Additional options passed to final link of vmlinux.
-
 KBUILD_VERBOSE
 --------------------------------------------------
 Set the kbuild verbosity. Can be assigned same values as "V=...".
-- 
2.7.4
