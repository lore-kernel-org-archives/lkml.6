Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CCC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBE20831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WwBmO4jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFBE20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeJ2B6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:58:00 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60589 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2B57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:57:59 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9SHCb2H015201;
        Mon, 29 Oct 2018 02:12:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9SHCb2H015201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540746758;
        bh=JjB+/Jh+xuRowYzqzM+AlhZFNYFSuoyV7mYc+dD2pJg=;
        h=From:Date:Subject:To:Cc:From;
        b=WwBmO4jt/QteXOFVUdSW89N8cAp5tWWzWqIIrO5vM+gnYunERyC/bxDjco+59zOfb
         t8JXlizyqgqanL3ATVi3ozrt4V+59UvWnJHEfFErxsbzatL+1oQPy3w59T0WXuwqR8
         q0kadQOMkCBy0JTl96MbMcuo/d1pgAnr0ht8x0wAdT7T8TZueyXwYVLNqhkbW2TuMb
         2bkODEPY8DlKEwH4aHK0mrtg2ZS4i53epVV9pbopWmKqIeK3dkDR3IWE4NEYVwfHZD
         J8cylScBU8XrpV7r9P37O7YqQcNTfia6VBklxIOSsqDIByJX1syEtZ0Nnk4Gq14KnO
         gXfzEMg/QejCA==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id d141so1475760vke.3;
        Sun, 28 Oct 2018 10:12:38 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLddTrL0dGV1Qxp0pLyTTCHogtm3Sh1Q/sx2cWpVSZcC0F9grjw
        jOwWcaIkmMO9F6S8yuy4OHg+W1T3brwrCcjQaS4=
X-Google-Smtp-Source: AJdET5eJJDDvUGbdSAI+quPsisqEMBbZtMLVjDaxP4bWkhIXSSQjzd4acE1lDE6HwiG8prf7XRk/hS9Q6qPq19lKL60=
X-Received: by 2002:a1f:1d4b:: with SMTP id d72-v6mr4735721vkd.34.1540746757197;
 Sun, 28 Oct 2018 10:12:37 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 02:12:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZO0gOaLG2kmiAMaCQe3NYNsvW4FVm4sn5ESdRK5CDNA@mail.gmail.com>
Message-ID: <CAK7LNASZO0gOaLG2kmiAMaCQe3NYNsvW4FVm4sn5ESdRK5CDNA@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v4.20
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

Please pull Kbuild updates for v4.20

Thanks!



The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.20

for you to fetch changes up to c2b1a9226fe7c1cee8f0ae42496f3eb282d73ebb:

  modpost: Create macro to avoid variable shadowing (2018-10-29 00:41:41 +0900)

----------------------------------------------------------------
Kbuild updates for v4.20

- optimize kallsyms slightly

- remove check for old CFLAGS usage

- add some compiler flags unconditionally instead of evaluating
  $(call cc-option,...)

- fix variable shadowing in host tools

- refactor scripts/mkmakefile

- refactor various makefiles

----------------------------------------------------------------
Jan Beulich (1):
      kallsyms: reduce size a little on 64-bit

Leonardo Bras (2):
      ASN.1: Remove unnecessary shadowed local variable
      modpost: Create macro to avoid variable shadowing

Masahiro Yamada (16):
      kallsyms: remove left-over Blackfin code
      kbuild: prefix Makefile.dtbinst path with $(srctree) unconditionally
      kbuild: remove old check for CFLAGS use
      kbuild: hide most of targets when running config or mixed targets
      kbuild: remove dead code in cmd_files calculation in top Makefile
      kbuild: add --include-dir flag only for out-of-tree build
      kbuild: remove VERSION and PATCHLEVEL from $(objtree)/Makefile
      kbuild: remove user ID check in scripts/mkmakefile
      kbuild: do not pass $(objtree) to scripts/mkmakefile
      kbuild: simplify command line creation in scripts/mkmakefile
      modpost: remove leftover symbol prefix handling for module device table
      kbuild: add -Wno-pointer-sign flag unconditionally
      kbuild: add -Wdeclaration-after-statement flag unconditionally
      kbuild: add -Wno-unused-but-set-variable flag unconditionally
      kbuild: remove unneeded link_multi_deps
      kbuild: use 'else ifeq' for checksrc to improve readability

 Makefile                 | 31 +++++++++++++++++--------------
 kernel/kallsyms.c        |  4 ++--
 scripts/Kbuild.include   |  2 +-
 scripts/Makefile.build   | 44 ++++++++------------------------------------
 scripts/asn1_compiler.c  |  2 +-
 scripts/kallsyms.c       |  6 ++----
 scripts/mkmakefile       | 22 ++++------------------
 scripts/mod/file2alias.c | 26 ++++++++++++++++++--------
 8 files changed, 53 insertions(+), 84 deletions(-)


-- 
Best Regards
Masahiro Yamada
