Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCNQox (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:44:53 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38072 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdP001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] kbuild: various fix, clean-up, improvements of CONFIG_TRIM_UNUSED_KSYMS
Date: Thu, 15 Mar 2018 01:44:14 +0900
Message-Id: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (7):
  kbuild: clear LDFLAGS in the top Makefile
  kbuild: touch autoksyms.h when it is really missing
  kbuild: move 'scripts' target below
  kbuild: restore touching autoksyms.h to the top Makefile
  kbuild: hide CONFIG_TRIM_UNUSED_KSYMS code from external module
    building
  kbuild: move include/config/ksym/* to include/ksym/*
  kbuild: link vmlinux just once for CONFIG_TRIM_UNUSED_KSYMS

 .gitignore                  |  1 +
 Makefile                    | 66 ++++++++++++++++++++++-----------------------
 scripts/Kbuild.include      |  2 +-
 scripts/adjust_autoksyms.sh |  7 +++--
 scripts/basic/fixdep.c      |  8 +++---
 scripts/kconfig/Makefile    |  2 --
 6 files changed, 41 insertions(+), 45 deletions(-)

-- 
2.7.4
