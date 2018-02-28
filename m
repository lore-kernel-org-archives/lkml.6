Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965063AbeB1XdA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:33:00 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43595 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964903AbeB1Xc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:32:58 -0500
X-Google-Smtp-Source: AG47ELssIUV3kmHAIXPwu/NGOMZI1cqGNSJyxjbBYyUi7ZnDkvk+ahAoLbNNBhXmg5OTJo2/SfyuDQ==
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] dtc updates for 4.17
Date: Wed, 28 Feb 2018 17:32:43 -0600
Message-Id: <20180228233249.26281-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates building dtc with flex and bison rather than using 
the _shipped files and updates dtc to the current upstream version. The 
new dtc adds some new warnings, so turn off the noisiest ones. While 
here adjusting the warnings, we can also now re-enable some that have 
gotten fixed.

Yamada-san, I figured out why you wanted the dtc update after I wrote 
the patch to remove the shipped files... :) I guess you may already have 
a similar patch. I suppose the first patch should go into 4.16, but 
nothing needs the fix yet. So it may be easier if you can just ack it 
and I'll keep it with the rest of the series.

Rob

Rob Herring (6):
  kbuild: remove remaining use of undefined YACC_PREFIX
  kbuild: add dtc as dependency on .dtb files
  scripts: re-enable some now fixed dtc warnings
  scripts/dtc: generate lexer and parser during build instead of
    shipping
  scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987
  scripts: turn off some new dtc warnings by default

 include/linux/libfdt_env.h           |    6 +-
 scripts/Makefile.lib                 |    9 +-
 scripts/dtc/Makefile                 |    6 +-
 scripts/dtc/checks.c                 |  439 ++++---
 scripts/dtc/dtc-lexer.lex.c_shipped  | 2259 ---------------------------------
 scripts/dtc/dtc-parser.tab.c_shipped | 2321 ----------------------------------
 scripts/dtc/dtc-parser.tab.h_shipped |  125 --
 scripts/dtc/dtc-parser.y             |   17 +-
 scripts/dtc/dtc.c                    |    7 +-
 scripts/dtc/dtc.h                    |   11 +-
 scripts/dtc/flattree.c               |    2 +-
 scripts/dtc/libfdt/fdt.c             |   13 +-
 scripts/dtc/libfdt/fdt.h             |    6 +-
 scripts/dtc/libfdt/fdt_overlay.c     |   51 +
 scripts/dtc/libfdt/fdt_ro.c          |  132 +-
 scripts/dtc/libfdt/fdt_rw.c          |   90 +-
 scripts/dtc/libfdt/fdt_sw.c          |   24 +-
 scripts/dtc/libfdt/fdt_wip.c         |   10 +-
 scripts/dtc/libfdt/libfdt.h          |   37 +-
 scripts/dtc/libfdt/libfdt_env.h      |   33 +-
 scripts/dtc/libfdt/libfdt_internal.h |   32 +-
 scripts/dtc/livetree.c               |   10 +-
 scripts/dtc/srcpos.c                 |    5 -
 scripts/dtc/srcpos.h                 |    6 +-
 scripts/dtc/update-dtc-source.sh     |    5 -
 scripts/dtc/util.h                   |    9 +-
 scripts/dtc/version_gen.h            |    2 +-
 27 files changed, 630 insertions(+), 5037 deletions(-)
 delete mode 100644 scripts/dtc/dtc-lexer.lex.c_shipped
 delete mode 100644 scripts/dtc/dtc-parser.tab.c_shipped
 delete mode 100644 scripts/dtc/dtc-parser.tab.h_shipped

-- 
2.14.1
