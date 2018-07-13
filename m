Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C63ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30198208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G/DpBuWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30198208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeGMOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:20:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50152 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeGMOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:20:52 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6DE61XV023098;
        Fri, 13 Jul 2018 23:06:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6DE61XV023098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531490762;
        bh=bX8BaoJuTqDWIyg/1ToPEnpbIhw/jTYYouw2gWL9ffo=;
        h=From:Date:Subject:To:Cc:From;
        b=G/DpBuWiX0N1EjPQUbZNHVXKw2hjnzXXq6cCHidKlPjB+wVUhkBoB9fNlzo4ALYfV
         6UpCA6s+p3b7rjdiCzq5VNmj5A3TtrF/nNW66NpUOc2HVr9+15u9m1vCaQmpGaP1jU
         5tL1ZJgo+BolveXVAyJduY4CNMvWz3z3hPAGytaZ/XPpA3OzVMMPGpJvP27UeTNj+7
         hf7qY5o1vYDOl94UBr3gqNQSq8wnZn9AjusEeMdvP8dyXea3aIcSe5FZZtrlMiy3xU
         wbGhtY+z9GNVOaeHiFT+q6kRtJ2cXLCgrG39LQRyeprShsQFZc5yiMQai6FSPojfKc
         zvX6ZcQZsDKUA==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id b78-v6so4256945vka.12;
        Fri, 13 Jul 2018 07:06:02 -0700 (PDT)
X-Gm-Message-State: AOUpUlEjraWxpaQLBMUX5rcGa3hx7qGxWJKADoMdZDRTnPawuh4+sWcr
        /OLVX4iVWJTTajq+oQHxOR8mnQLzdbneYo4bF24=
X-Google-Smtp-Source: AAOMgpci9nB2JC90e8X6/9JRkjACRXH6zM7+6w4RqKhHAbljt+QbFMivRA0izpdQjeg6qbGJ8uoKkCejhUHzLnnb7Kk=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr3846289vkf.34.1531490761216;
 Fri, 13 Jul 2018 07:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:05:20
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 13 Jul 2018 23:05:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbXpNS-pdhUnhL7ELXArJoLCVzQhASaqTAJh0+CkwFcA@mail.gmail.com>
Message-ID: <CAK7LNAQbXpNS-pdhUnhL7ELXArJoLCVzQhASaqTAJh0+CkwFcA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.18-rc5
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

Please pull a little more Kbuild fixes.



The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.18-2

for you to fetch changes up to 6d79a7b424a5630a6fcab31fd7c38af4ea9c9a0f:

  kbuild: suppress warnings from 'getconf LFS_*' (2018-07-13 00:48:18 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.18 (2nd)

 - update Kbuild and Kconfig documents

 - sanitize -I compiler option handling

 - update extract-vmlinux script to recognize LZ4 and ZSTD

 - fix tools Makefiles

 - update tags.sh to handle __ro_after_init

 - suppress warnings in case getconf does not recognize LFS_* parameters

----------------------------------------------------------------
Adam Borowski (1):
      scripts: teach extract-vmlinux about LZ4 and ZSTD

Constantine Shulyupin (1):
      scripts/tags.sh: add __ro_after_init

Laura Abbott (2):
      tools: build: Fixup host c flags
      tools: build: Use HOSTLDFLAGS with fixdep

Masahiro Yamada (3):
      kbuild: do not drop -I without parameter
      kbuild: remove duplicated comments about PHONY
      kbuild: suppress warnings from 'getconf LFS_*'

Paul Menzel (1):
      tools build: fix # escaping in .cmd files for future Make

Randy Dunlap (5):
      kbuild: update ARCH alias info for sh
      kbuild: update ARCH alias info for sparc
      kbuild: delete INSTALL_FW_PATH from kbuild documentation
      kconfig: update user kconfig tools doc.
      kbuild: document the KBUILD_KCONFIG env. variable

Ulf Magnusson (1):
      kbuild: .PHONY is not a variable, but PHONY is

 Documentation/kbuild/kbuild.txt  | 17 ++++++--------
 Documentation/kbuild/kconfig.txt | 51 +++++++++++++++++++++++++++++++++-------
 Makefile                         |  8 +++----
 scripts/Kbuild.include           |  2 +-
 scripts/Makefile.build           |  3 ---
 scripts/Makefile.clean           |  3 ---
 scripts/Makefile.modbuiltin      |  4 ----
 scripts/Makefile.modinst         |  4 ----
 scripts/Makefile.modpost         |  4 ----
 scripts/Makefile.modsign         |  3 ---
 scripts/extract-vmlinux          |  2 ++
 scripts/tags.sh                  |  2 +-
 tools/build/Build.include        |  6 ++---
 tools/build/Makefile             |  2 +-
 tools/perf/pmu-events/Build      |  2 +-
 15 files changed, 63 insertions(+), 50 deletions(-)


-- 
Best Regards
Masahiro Yamada
