Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967762AbeCALSP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:18:15 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39350 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967618AbeCALSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:18:12 -0500
X-Google-Smtp-Source: AG47ELuiPEjMe9+KTtjjhB5Zhvwc52R45pXFVj+4561FFVKteLs6/domlvCRaCutcAkpAB9bf4wawQ==
Date: Thu, 1 Mar 2018 12:18:01 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kconfig: remove redundant streamline_config.pl prerequisite
Message-ID: <20180301111801.gdhoam4kqrbqnasv@huvuddator>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
 <20180228051525.a2vouqs6djnd2cnf@huvuddator>
 <CAK7LNATWRmYf7nfGcFiGe2DF2PSkE9mrS51GytzWEz5DYToN0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNATWRmYf7nfGcFiGe2DF2PSkE9mrS51GytzWEz5DYToN0w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local{yes,mod}config targets currently have streamline_config.pl as
a prerequisite. This is redundant, because streamline_config.pl is a
checked-in file with no prerequisites.

Remove the prerequisite and reference streamline_config.pl directly in
the recipe of the rule instead.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 scripts/kconfig/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 1f74336d4e23..58be52cb464d 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -77,9 +77,9 @@ silentoldconfig: $(obj)/conf
 	    touch   include/generated/autoksyms.h
 	$< $(silent) --$@ $(Kconfig)
 
-localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
+localyesconfig localmodconfig: $(obj)/conf
 	$(Q)mkdir -p include/config include/generated
-	$(Q)perl $< --$@ $(srctree) $(Kconfig) > .tmp.config
+	$(Q)perl $(obj)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 					\
 			cmp -s .tmp.config .config ||			\
 			(mv -f .config .config.old.1;			\
-- 
2.14.1
