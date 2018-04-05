Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbeDEPRD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751616AbeDEPRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:00 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 3/9] kbuild: Do not pass arguments to link-vmlinux.sh
Date: Thu,  5 Apr 2018 17:16:39 +0200
Message-Id: <20180405151645.19130-4-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to pass LD* arguments to link-vmlinux.sh,
because they are passed as variables. The only argument
the link-vmlinux.sh supports is the 'clean' argument.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d3300e46f925..a65a3919c6ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1027,7 +1027,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
 cmd_link-vmlinux =                                                 \
-	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
+	$(CONFIG_SHELL) $< ;                                       \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
-- 
2.13.6
