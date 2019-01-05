Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A5C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88B217F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v0HwfQUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfAEDCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:02:21 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:27337 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfAEDCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:02:21 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0531r3Z015075;
        Sat, 5 Jan 2019 12:01:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0531r3Z015075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546657314;
        bh=PZdDmW/Jyd5SDeaPKadgskF4Vos9wpzFISIsonMw6SI=;
        h=From:To:Cc:Subject:Date:From;
        b=v0HwfQUxU+LllxY0U/ChmCPLHQmb2claN9fAy4VbkdSe+zMw8fQjni0V5Oj40ODjS
         qP4+r0Ie8KsWGuY0CwtiDdqud+meK46hL9bV2EX1FIHzB7PUWFCpjo5HVpzINJYkgQ
         JBFDbwHAQon0p0qb1YhYPrzsa4fPfFTcfzskzgGfU1V6PqAIusKFwihHjdzXpdldlT
         fzPZVuATSf1U4SVQ44rsTKy3HrfzC3jC//YkY9LfJ3a8sS/5P3S2swXaP51sbCs+bd
         wm0MmZ7ilBLYo+aF+TBSbiUuTUu7G4DVTL+pMPCItUozAeYVpuISDTQ0meftVGazrn
         asrd7z4hWwr1g==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: rename generated .*conf-cfg to *conf-cfg
Date:   Sat,  5 Jan 2019 12:01:51 +0900
Message-Id: <1546657311-24661-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dot-prefixing since it is just a matter of the
.gitignore file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/.gitignore |  1 +
 scripts/kconfig/Makefile   | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 0aabc1d..b5bf92f 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -2,6 +2,7 @@
 # Generated files
 #
 *.moc
+*conf-cfg
 
 #
 # configuration programs
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 679e62e..c05ab00 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -157,53 +157,53 @@ conf-objs	:= conf.o $(common-objs)
 hostprogs-y	+= nconf
 nconf-objs	:= nconf.o nconf.gui.o $(common-objs)
 
-HOSTLDLIBS_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
-HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
-HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
+HOSTLDLIBS_nconf	= $(shell . $(obj)/nconf-cfg && echo $$libs)
+HOSTCFLAGS_nconf.o	= $(shell . $(obj)/nconf-cfg && echo $$cflags)
+HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/nconf-cfg && echo $$cflags)
 
-$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/.nconf-cfg
+$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/nconf-cfg
 
 # mconf: Used for the menuconfig target based on lxdialog
 hostprogs-y	+= mconf
 lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
 mconf-objs	:= mconf.o $(addprefix lxdialog/, $(lxdialog)) $(common-objs)
 
-HOSTLDLIBS_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
+HOSTLDLIBS_mconf = $(shell . $(obj)/mconf-cfg && echo $$libs)
 $(foreach f, mconf.o $(lxdialog), \
-  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
+  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/mconf-cfg && echo $$$$cflags)))
 
-$(obj)/mconf.o: $(obj)/.mconf-cfg
-$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/.mconf-cfg
+$(obj)/mconf.o: $(obj)/mconf-cfg
+$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/mconf-cfg
 
 # qconf: Used for the xconfig target based on Qt
 hostprogs-y	+= qconf
 qconf-cxxobjs	:= qconf.o
 qconf-objs	:= images.o $(common-objs)
 
-HOSTLDLIBS_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
-HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
+HOSTLDLIBS_qconf	= $(shell . $(obj)/qconf-cfg && echo $$libs)
+HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/qconf-cfg && echo $$cflags)
 
-$(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc
+$(obj)/qconf.o: $(obj)/qconf-cfg $(obj)/qconf.moc
 
 quiet_cmd_moc = MOC     $@
-      cmd_moc = $(shell . $(obj)/.qconf-cfg && echo $$moc) -i $< -o $@
+      cmd_moc = $(shell . $(obj)/qconf-cfg && echo $$moc) -i $< -o $@
 
-$(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
+$(obj)/%.moc: $(src)/%.h $(obj)/qconf-cfg
 	$(call cmd,moc)
 
 # gconf: Used for the gconfig target based on GTK+
 hostprogs-y	+= gconf
 gconf-objs	:= gconf.o images.o $(common-objs)
 
-HOSTLDLIBS_gconf    = $(shell . $(obj)/.gconf-cfg && echo $$libs)
-HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
+HOSTLDLIBS_gconf    = $(shell . $(obj)/gconf-cfg && echo $$libs)
+HOSTCFLAGS_gconf.o  = $(shell . $(obj)/gconf-cfg && echo $$cflags)
 
-$(obj)/gconf.o: $(obj)/.gconf-cfg
+$(obj)/gconf.o: $(obj)/gconf-cfg
 
 # check if necessary packages are available, and configure build flags
 filechk_conf_cfg = $(CONFIG_SHELL) $<
 
-$(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
+$(obj)/%conf-cfg: $(src)/%conf-cfg.sh FORCE
 	$(call filechk,conf_cfg)
 
-clean-files += .*conf-cfg
+clean-files += conf-cfg
-- 
2.7.4

