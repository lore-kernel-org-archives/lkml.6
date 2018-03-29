Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeC2AsW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:48:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37288 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeC2AsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:48:19 -0400
X-Google-Smtp-Source: AIpwx49H+sknc9Yr3AfF1bpBfCnw2sWYNr7ynpI/4JBTnjeVFrCYzMVVCf2QBKn85Pw6GBG66OLbMA==
From: Laura Abbott <labbott@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 3/3] kbuild: Allow passing additional HOSTCFLAGS and HOSTLDFLAGS
Date: Wed, 28 Mar 2018 17:48:05 -0700
Message-Id: <20180329004805.7278-4-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329004805.7278-1-labbott@redhat.com>
References: <20180329004805.7278-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Similar to AFLAGS_KBUILD, there may be uses (e.g. hardening) for passing in
additional flags to host programs. Allow these to be passed in from the
environment.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Documentation/kbuild/kbuild.txt | 9 +++++++++
 Makefile                        | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index ac2363ea05c5..3751a4bc8596 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -24,6 +24,15 @@ KAFLAGS
 --------------------------------------------------
 Additional options to the assembler (for built-in and modules).
 
+AFLAGS_HOSTCFLAGS
+--------------------------------------------------
+Additional options passed to the compiler when building host programs.
+
+AFLAGS_HOSTLDFLAGS
+--------------------------------------------------
+Additional options passed to the linker (through the compiler) when buidling
+host programs.
+
 AFLAGS_MODULE
 --------------------------------------------------
 Additional module specific options to use for $(AS).
diff --git a/Makefile b/Makefile
index 7ba478ab8c82..2cab3f8d489c 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,9 @@ HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
+HOSTCFLAGS  += $(AFLAGS_HOSTCFLAGS)
+HOSTLDFLAGS  += $(AFLAGS_HOSTLDFLAGS)
+
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
-- 
2.16.2
