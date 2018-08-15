Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD35C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11923208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MA5EZ5y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11923208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeHOUvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:51:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58347 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHOUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:51:11 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7FHvvt3020161;
        Thu, 16 Aug 2018 02:57:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7FHvvt3020161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534355878;
        bh=IWKF3o+R1CNaCp7rzIhNIc7OREDSEJv4y2V4318Jwd0=;
        h=From:Date:Subject:To:Cc:From;
        b=MA5EZ5y9cMF4nfa4yyKSgHdYtKwcyDMKZ60GKqfXewSAjO/kePnWUL1wvSskw+TfF
         0TrIOa8aIYkI3mo2CCsAiz5ipbQfPRfwoSG9crKN5f3REP2kpNXIEzrtO13pK5dzH/
         tuqz+XvUDrqFThscFdlyzJFcuNY6tV3mcEi94+6QiLG2WKN8b9tqt7V9l5+5iORa6C
         go9ga+oSOepxKgs+pMB5ZITOTeHu9iROHdnxtV7KfNZWeqSbGcWhRSTn2hFsAx6qCH
         k8tfP0feKApHSCoClpxwIlRk6Jvgn05t3Y8taixU3hQoBIpSy6qCk1sZ2yxQ69N8BB
         Dw+zwkFjRqXVA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id o11-v6so2092654uak.5;
        Wed, 15 Aug 2018 10:57:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlETU1zTw8earLCwFff1+V1OlcDOVzyc8NSeCJ0VROhn74YjAdka
        cHyj2dix9Qw0mqa7Pe5YtZpBExozgfOY2WfUM7g=
X-Google-Smtp-Source: AA+uWPzXF4NcSiVrp49uS4GMqgWQGcnkQYQ0bfYomPGVBIOAjyAQKPLXq1+N6rKinZNuxJOf5g30A3eXN+d3drXdwRs=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr17719215uai.17.1534355876503;
 Wed, 15 Aug 2018 10:57:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 10:57:16
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 02:57:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
Message-ID: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
Subject: [GIT PULL 2/3] Kconfig updates for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kconfig updates for v4.19


You will see a conflict in the top-level Makefile.

Please fix it like follows.  (it is also available in linux-next)

---------------------------------------------------------------
diff --cc Makefile
index cc4875d,f17dd99..a0650bf
--- a/Makefile
+++ b/Makefile
@@@ -224,11 -224,14 +224,14 @@@ clean-targets := %clean mrproper cleand
  no-dot-config-targets := $(clean-targets) \
                         cscope gtags TAGS tags help% %docs check% coccicheck \
                         $(version_h) headers_% archheaders archscripts \
 -                       kernelversion %src-pkg
 +                       %asm-generic kernelversion %src-pkg
+ no-sync-config-targets := $(no-dot-config-targets) install %install \
+                          kernelrelease

- config-targets := 0
- mixed-targets  := 0
- dot-config     := 1
+ config-targets  := 0
+ mixed-targets   := 0
+ dot-config      := 1
+ may-sync-config := 1

  ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
        ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
----------------------------------------------------------





The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v4.19

for you to fetch changes up to 1880861226c13ddd42c34ddd30c3b502b650fe29:

  kconfig: remove P_ENV property type (2018-08-14 09:01:47 +0900)

----------------------------------------------------------------
Kconfig updates for v4.19

- show clearer error messages where pkg-config is needed, but not
  installed

- rename SYMBOL_AUTO to SYMBOL_NO_WRITE to reflect its semantics

- create all necessary directories by Kconfig tool itself instead
  of Makefile

- update the .config unconditionally when syncconfig is invoked

- use 'include' directive instead of '-include' where
  include/config/{auto,tristate}.conf is mandatory

- do not try to update the .config when running install targets

- add .DELETE_ON_ERROR to delete partially updated files

- misc cleanups and fixes

----------------------------------------------------------------
Dirk Gouders (2):
      kconfig: rename SYMBOL_AUTO to SYMBOL_NO_WRITE
      Kbuild: Makefile.modbuiltin: include auto.conf and tristate.conf mandatory

Masahiro Yamada (15):
      kconfig: handle format string before calling conf_message_callback()
      kconfig: rename file_write_dep and move it to confdata.c
      kconfig: split out useful helpers in confdata.c
      kconfig: remove unneeded directory generation from local*config
      kconfig: create directories needed for syncconfig by itself
      kconfig: make syncconfig update .config regardless of sym_change_count
      kconfig: allow all config targets to write auto.conf if missing
      kbuild: use 'include' directive to load auto.conf from top Makefile
      kbuild: add .DELETE_ON_ERROR special target
      kbuild: do not update config when running install targets
      kbuild: do not update config for 'make kernelrelease'
      kbuild: remove auto.conf from prerequisite of phony targets
      kconfig: fix the rule of mainmenu_stmt symbol
      kconfig: remove unused sym_get_env_prop() function
      kconfig: remove P_ENV property type

Randy Dunlap (2):
      kconfig: check for pkg-config on make {menu,n,g,x}config
      kconfig: fix typos in description of "choice" in kconfig-language.txt

Rob Landley (1):
      init/Kconfig: Use short unix-style option instead of --longname

 Documentation/kbuild/kconfig-language.txt |   4 +-
 Documentation/process/changes.rst         |   8 +++
 Makefile                                  |  44 +++++++-----
 init/Kconfig                              |   4 +-
 scripts/Kbuild.include                    |   3 +
 scripts/Makefile.modbuiltin               |   4 +-
 scripts/kconfig/Makefile                  |  17 ++---
 scripts/kconfig/check-pkgconfig.sh        |   8 +++
 scripts/kconfig/conf.c                    |  39 +++++-----
 scripts/kconfig/confdata.c                | 156
++++++++++++++++++++++++++++++++--------
 scripts/kconfig/expr.h                    |   3 +-
 scripts/kconfig/gconf.c                   |   5 +-
 scripts/kconfig/lkc.h                     |   2 -
 scripts/kconfig/lkc_proto.h               |   4 +-
 scripts/kconfig/mconf.c                   |  10 ++-
 scripts/kconfig/menu.c                    |   2 +-
 scripts/kconfig/nconf.c                   |   8 +--
 scripts/kconfig/qconf.cc                  |   3 +-
 scripts/kconfig/symbol.c                  |  13 +---
 scripts/kconfig/util.c                    |  30 --------
 scripts/kconfig/zconf.y                   |   6 +-
 21 files changed, 227 insertions(+), 146 deletions(-)
 create mode 100644 scripts/kconfig/check-pkgconfig.sh


-- 
Best Regards
Masahiro Yamada
