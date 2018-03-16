Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeCPHht (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:37:49 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:20644 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeCPHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:37:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2G7bOa3029139
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 0/7] kbuild: various fix, clean-up, improvements of CONFIG_TRIM_UNUSED_KSYMS
Date: Fri, 16 Mar 2018 16:37:08 +0900
Message-Id: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro Yamada (7):
  kbuild: clear LDFLAGS in the top Makefile
  kbuild: remove wrong 'touch' in adjust_autoksyms.sh
  kbuild: move 'scripts' target below
  kbuild: restore touching autoksyms.h to the top Makefile
  kbuild: move CONFIG_TRIM_UNUSED_KSYMS code unneeded for external
    module
  kbuild: move include/config/ksym/* to include/ksym/*
  kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS

 .gitignore                  |  1 +
 Makefile                    | 64 ++++++++++++++++++++++-----------------------
 scripts/Kbuild.include      |  2 +-
 scripts/adjust_autoksyms.sh |  5 +---
 scripts/basic/fixdep.c      |  8 +++---
 scripts/kconfig/Makefile    |  2 --
 6 files changed, 39 insertions(+), 43 deletions(-)

-- 
2.7.4
