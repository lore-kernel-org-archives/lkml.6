Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeC2SB1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:01:27 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40406 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC2SBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:01:24 -0400
X-Google-Smtp-Source: AIpwx48PYkxW3aKjCuAVcCm/W5as3X94r6CXFU08C6ZLsxKxWusCXMrLg/eI3K7NkBWjqUZh/l4xJg==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [RFCv2 PATCH 3/3] x86/vdso: Add build salt to the vDSO
Date: Thu, 29 Mar 2018 11:01:12 -0700
Message-Id: <20180329180112.11055-4-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329180112.11055-1-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO is linked separately from the kernel and modules. Ensure it picks
up the comment section, if available.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Updated name
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..7c78dd39aae8 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
+#include <generated/build-salt.h>
 
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
@@ -95,6 +96,8 @@ SECTIONS
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
 
+	BUILD_ID_SALT
+
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
-- 
2.16.2
