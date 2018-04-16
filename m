Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDPOtB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:01 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62202 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeDPOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:48:57 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqto017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] MIPS: boot: fix various problems in arch/mips/boot/Makefile
Date: Mon, 16 Apr 2018 23:47:40 +0900
Message-Id: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When I was trying to fix commit 0f9da844d877 in a more correct way,
I found various problems in arch/mips/boot/Makefile.

ITS is always rebuilt when you rebuild the kernel without touching
anything.  Many build rules are wrong.

If you look at the last patch in this series, you may realize
supporting ITB building in the kernel can cause nasty problems.
Personally, I do not like it, but I tried my best to fix the problems.

With this series, ITB is rebuilt only when necessary.



Masahiro Yamada (7):
  Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
  MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
  MIPS: boot: fix build rule of vmlinux.its.S
  MIPS: boot: correct prerequisite image of vmlinux.*.its
  MIPS: boot: add missing targets for vmlinux.*.its
  MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
  MIPS: boot: rebuild ITB when contained DTB is updated

 arch/mips/boot/Makefile | 69 ++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

-- 
2.7.4
