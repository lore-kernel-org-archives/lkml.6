Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeBAQ70 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:59:26 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38118 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBAQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:59:24 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w11GxBNN012600
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AH8x224kgwQ4i8X85uMcTu/9ab/vtU8MXU2l3N8MU6BsyKtEM+yo1aiSc+AT8LGI/o6N/G3FnbpdGeGQ7FewUZyY2+w=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 01:58:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQC+qjdcDSkmWoD7h=WV7e_yYRES-Tf+Az4CpxONPomyA@mail.gmail.com>
Message-ID: <CAK7LNAQC+qjdcDSkmWoD7h=WV7e_yYRES-Tf+Az4CpxONPomyA@mail.gmail.com>
Subject: [GIT PULL 2/3] Kbuild misc updates for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11GxZvv014554

Hi Linus,

Here are some updates of misc scripts for v4.16.  Please pull!



The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-misc-v4.16

for you to fetch changes up to 1640eea35e8dcf0cb437f03c56868a97d0666df3:

  Coccinelle: coccicheck: fix typo (2018-02-02 00:21:47 +0900)

----------------------------------------------------------------
Kbuild misc updates for v4.16

- Add snap-pkg target to create Linux kernel snap package

- Make out-of-tree creation of source packages fail correctly

- Improve and fix several semantic patches

----------------------------------------------------------------
Himanshu Jha (4):
      Coccinelle: kzalloc-simple: Add all zero allocating functions
      Coccinelle: alloc_cast: Add more memory allocating functions to the list
      Coccinelle: ifnullfree: Trim the warning reported in report mode
      Coccinelle: kzalloc-simple: Rename kzalloc-simple to zalloc-simple

Julia Lawall (2):
      Coccinelle: memdup: drop spurious line
      Coccinelle: coccicheck: fix typo

Jérémy Lefaure (1):
      Coccinelle: array_size: report even if include is missing

Masahiro Yamada (1):
      kbuild: pkg: make out-of-tree rpm/deb-pkg build immediately fail

Paolo Pisati (1):
      scripts/package: snap-pkg target

 .gitignore                                      |   5 +
 scripts/coccicheck                              |   2 +-
 scripts/coccinelle/api/alloc/alloc_cast.cocci   |  92 +++-
 .../coccinelle/api/alloc/kzalloc-simple.cocci   |  86 ----
 .../coccinelle/api/alloc/zalloc-simple.cocci    | 448 +++++++++++++++++++
 scripts/coccinelle/api/memdup.cocci             |   1 -
 scripts/coccinelle/free/ifnullfree.cocci        |   2 +-
 scripts/coccinelle/misc/array_size.cocci        |   4 +-
 scripts/package/Makefile                        |  26 +-
 scripts/package/snapcraft.template              |  14 +
 10 files changed, 565 insertions(+), 115 deletions(-)
 delete mode 100644 scripts/coccinelle/api/alloc/kzalloc-simple.cocci
 create mode 100644 scripts/coccinelle/api/alloc/zalloc-simple.cocci
 create mode 100644 scripts/package/snapcraft.template


-- 
Best Regards
Masahiro Yamada
