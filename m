Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCUBq5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:46:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33557 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeCUBqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:46:46 -0400
X-Google-Smtp-Source: AG47ELsxBUJrxIcmJSJSMf42zmO92Z/HBrPSH01oOGHI+/RFG+V1qRYL+aMmDCS9iFFiTtWDrH9iXQ==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Subject: [RFC PATCH 3/3] x86/vdso: Add build salt to the vDSO
Date: Tue, 20 Mar 2018 18:46:35 -0700
Message-Id: <20180321014635.29113-4-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321014635.29113-1-labbott@redhat.com>
References: <20180321014635.29113-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The vDSO is linked separately from the kernel and modules. Ensure it picks
up the comment section, if available.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I only added x86 in this series because that's my primary interest.
Other arches could easily follow suit if they care.
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..ab72f3c87ebb 100644
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
 
+	ID_TAG
+
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
-- 
2.16.2
