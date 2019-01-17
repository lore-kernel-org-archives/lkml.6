Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R0LJQR+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfAQOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:48:37 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:29325 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfAQOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:48:36 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0HEmWUR025563;
        Thu, 17 Jan 2019 23:48:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0HEmWUR025563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547736513;
        bh=uvHx6wbVB0MQkkO21zFV8XbEXz0PDlJ1MDloIdQlo+c=;
        h=From:Date:Subject:To:Cc:From;
        b=R0LJQR+MkIqQ9HgJZT9Oub4MRUbQCxMEprBIDwijcmApiYriPFtdfWT/Kpea0mb9t
         Bzf1Rqf1P4/LziyitxafITx/x80siMSq5zWRDoKNIihw60jVCHu7wT9nkvBiWd0Li9
         Uefg/0RPUHgOWvZ2Mt42O+t9mdN1eReBCYw2g1StoB7DFnzj+RzJOlaakKcAsVh7pb
         f95ym9VjJFdkQY9N0q5flVDu29B9ApLNsrVgyYZuysRgrIUJsJgxU8fM8uX+ann4oD
         rGM2kzCivVVi7jwoKWKbJ+rYaEXf5HIYlOkFJhkb+EZlIqHF/6dxZcvaL60S9Va0SE
         gyIaXuml7NsWg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id n13so6375168vsk.4;
        Thu, 17 Jan 2019 06:48:33 -0800 (PST)
X-Gm-Message-State: AJcUukfSLWzTTd9H2QYp0cf6HELROhM6cCbrlinS1MGKgWjwUsnF467r
        EczaTq3KrlUpVg6kqY/LXu6SZldh1RbelvUesP0=
X-Google-Smtp-Source: ALg8bN4nD0/s1o9csMJfVS2cbL888utuMkgqaXl8/RTB1r4QSxrPYhS/S2ZMg6ifkl4MBKdWk9I8d6HNz5w6rN0evhg=
X-Received: by 2002:a67:485:: with SMTP id 127mr6085892vse.54.1547736511600;
 Thu, 17 Jan 2019 06:48:31 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 17 Jan 2019 23:47:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1ZHH6DdB5wvyBA3m2HFrnY6GRmQG+OX_Pd7t9CyJ6nQ@mail.gmail.com>
Message-ID: <CAK7LNAS1ZHH6DdB5wvyBA3m2HFrnY6GRmQG+OX_Pd7t9CyJ6nQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.0-rc3
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

Please pull some Kbuild fixes.
Thanks!

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.0

for you to fetch changes up to e00d8880481497474792d28c14479a9fb6752046:

  kbuild: mark prepare0 as PHONY to fix external module build
(2019-01-17 23:42:59 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.0

 - clean generated files in scripts/kconfig/ by 'make mrproper'

 - fix conflict between dead code elimination and ftrace for GCC <= 4.7

 - fix external module build with CONFIG_STACKPROTECTOR

 - remove unused code

----------------------------------------------------------------
Masahiro Yamada (7):
      kconfig: clean generated *conf-cfg files
      kbuild: remove unused baseprereq
      kbuild: remove unused archmrproper
      ia64: remove redundant 'export AWK'
      nds32: remove unneeded code in arch/nds32/Makefile
      openrisc: remove unneeded code in arch/openrisc/Makefile
      kbuild: mark prepare0 as PHONY to fix external module build

Paul Burton (1):
      kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <= 4.7

 Makefile                 | 8 ++++----
 arch/h8300/Makefile      | 2 --
 arch/ia64/Makefile       | 2 --
 arch/nds32/Makefile      | 8 --------
 arch/openrisc/Makefile   | 3 ---
 init/Kconfig             | 1 +
 scripts/Kbuild.include   | 4 ----
 scripts/kconfig/Makefile | 2 +-
 8 files changed, 6 insertions(+), 24 deletions(-)


-- 
Best Regards
Masahiro Yamada
