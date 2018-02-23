Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeBWOX3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:23:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35658 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeBWOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:22:59 -0500
X-Google-Smtp-Source: AG47ELs9FjLB/1hIgmijGNaE3WcNmNWQyLS5VD/pQmzjmEBCnREN9JRpG11EBJBmKo1h3iounI8gWA==
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] kbuild: introduce HOST_EXTRALDFLAGS
Date: Fri, 23 Feb 2018 15:22:14 +0100
Message-Id: <16dd034819f38300bf71c8866af37cade0017585.1519393674.git.robin.jarry@6wind.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519393674.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
In-Reply-To: <cover.1519393674.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new user specifiable variable to provide specific linker options
(-L, -rpath, ...) for host programs build.

Append these options to HOSTLDFLAGS.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d9cf3a40eda9..e9609319d2b8 100644
--- a/Makefile
+++ b/Makefile
@@ -365,6 +365,7 @@ HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
 HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
+HOSTLDFLAGS  += $(HOST_EXTRALDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
 # Make variables (CC, etc...)
-- 
2.11.0
