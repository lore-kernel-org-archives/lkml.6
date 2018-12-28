Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136F320874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OzWe9dRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbeL1QAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:00:44 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:52439 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeL1QAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:00:42 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBSG0XoP030905;
        Sat, 29 Dec 2018 01:00:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBSG0XoP030905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546012833;
        bh=Hqiy1wANGhXtaKd4JinlakWGOoE2XTQLK1d9F1ENlzc=;
        h=From:Date:Subject:To:Cc:From;
        b=OzWe9dRiSolbE0W+L0qVobH7lwzVenzFSTxB6nUXHPrld0Tmi3EB07UBCuB8Dy5Gi
         kYvjPYAFuOqhQ4os8RHHEcX7MdthnmwmxY7fSZEvl3ehpPSKwH/rRpN/ouXg2akrqo
         b7Luwqcj/Au1gOaxprRGRc5+78ayyidsblvZBokfwLY7xxLd68vOPql/GOQy/d3WK7
         qm4Uhjk0d/WO7vgSiyqZLhQ8pRgLdGr+pTg09L/fxVI1lhiNi4PGqnw/9be+SkXzEc
         eh4R/vQVZPA7EPHlXbWsK1z80IThjWQQ8POUS9lPOhv0EVb+PjdyZiD40okm/M5nRj
         ENjVmNRur8IYg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id z11so6970118uaa.10;
        Fri, 28 Dec 2018 08:00:33 -0800 (PST)
X-Gm-Message-State: AJcUukfywCAkW2Z/74Q4DnRBojUsehadmpfIGuyAJCzQwKZxJbRSbQGQ
        I3H6eRnENleJPZz9WcFlBlihFHbZCxtroLuygeE=
X-Google-Smtp-Source: ALg8bN4SmQKxVRdYPRtnVn5ZuCKkVBkKRkrdzrnQEfhSeQJFa28Mcy7UPaPmWVQ3Soh0j7iicT+SJty9fqBgkxXrf3s=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr9970419uaj.42.1546012832262;
 Fri, 28 Dec 2018 08:00:32 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Dec 2018 00:59:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
Message-ID: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
Subject: [GIT PULL 2/4] Kbuild updates for v4.21 part2
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

Here are Kbuild updates for v4.21 part 2.


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.21-2

for you to fetch changes up to 5cd6239506cb97fb00c5992c1adaf6f9f788c5f2:

  kernel hacking: support building kernel with -Og optimization level
(2018-11-19 23:32:54 +0900)

----------------------------------------------------------------
Kbuild updates for v4.21 (part 2)

Debugging experience improvement by Changbin Du.

Support -Og optimization level, which offers a reasonable level of
optimization while maintaining a good debugging experience.

Introduce a new option CONFIG_NO_AUTO_INLINE as well. With this option,
only functions explicitly marked with "inline" will be inlined. This
will allow the function tracer to trace more functions.

----------------------------------------------------------------
Changbin Du (5):
      x86/mm: declare check_la57_support() as inline
      openrisc: make function cache_loop() inline
      kernel hacking: add a config option to disable compiler auto-inlining
      ARM: mm: fix build error in fix_to_virt with -Og optimization level
      kernel hacking: support building kernel with -Og optimization level

 Makefile                     | 11 +++++++++++
 arch/arm/mm/mmu.c            |  2 +-
 arch/openrisc/mm/cache.c     |  2 +-
 arch/x86/kernel/head64.c     |  2 +-
 include/linux/compiler-gcc.h |  2 ++
 init/Kconfig                 | 21 +++++++++++++++++++++
 kernel/configs/tiny.config   |  1 +
 lib/Kconfig.debug            | 17 +++++++++++++++++
 8 files changed, 55 insertions(+), 3 deletions(-)


--
Best Regards
Masahiro Yamada
