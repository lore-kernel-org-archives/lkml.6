Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEOCxo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:53:44 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:47957 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOCxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:53:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w4F2qVSt002191
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 1/3] x86/build: vdso: remove unused $(vobjs-nox32) in Makefile
Date: Tue, 15 May 2018 11:52:22 +0900
Message-Id: <1526352744-28229-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bfad381c0d1e ("x86/vdso: Improve the fake section
headers"), $(vobjs-nox32) is empty.  Therefore, $(vobjs64-for-x32)
is the same as $(vobjs-y).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index d998a48..2988506 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -100,11 +100,8 @@ VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
 			   -Wl,-z,max-page-size=4096 \
 			   -Wl,-z,common-page-size=4096
 
-# 64-bit objects to re-brand as x32
-vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
-
 # x32-rebranded versions
-vobjx32s-y := $(vobjs64-for-x32:.o=-x32.o)
+vobjx32s-y := $(vobjs-y:.o=-x32.o)
 
 # same thing, but in the output directory
 vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
-- 
2.7.4
