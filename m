Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeB1KQC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:16:02 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:57329 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeB1KQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:16:00 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1SAEVbx029479
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
Subject: [PATCH 1/2] kbuild: remove command line interface LDFLAGS_MODULE from makefiles.txt
Date: Wed, 28 Feb 2018 19:14:23 +0900
Message-Id: <1519812864-852-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/kbuild/makefiles.txt lists variables used in Makefile
whereas Documentation/kbuild/kbuild.txt describes user assignable
parameters given via environments or the command line.

LDFLAGS_MODULE is a command line interface, so it should be dropped
from makefiles.txt.

Some lines below in this file, it is clearly explained that
KBUILD_LDFLAGS_MODULE is the right one for the internal use:

    KBUILD_LDFLAGS_MODULE   Options for $(LD) when linking modules

        $(KBUILD_LDFLAGS_MODULE) is used to add arch-specific options
        used when linking modules. This is often a linker script.
        From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).

Then, kbuild.txt explains LDFLAGS_MODULE, like follows:

    LDFLAGS_MODULE
    --------------------------------------------------
    Additional options used for $(LD) when linking modules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 667cd899..048fc39 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -837,12 +837,6 @@ When kbuild executes, the following steps are followed (roughly):
 	Note: ldflags-y can be used to further customise
 	the flags used. See chapter 3.7.
 
-    LDFLAGS_MODULE	Options for $(LD) when linking modules
-
-	LDFLAGS_MODULE is used to set specific flags for $(LD) when
-	linking the .ko files used for modules.
-	Default is "-r", for relocatable output.
-
     LDFLAGS_vmlinux	Options for $(LD) when linking vmlinux
 
 	LDFLAGS_vmlinux is used to specify additional flags to pass to
-- 
2.7.4
