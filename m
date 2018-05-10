Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757383AbeEJNyb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:54:31 -0400
Received: from ozlabs.org ([203.11.71.1]:36933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeEJNya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:54:30 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 9/8] powerpc/pkeys: Drop private VM_PKEY definitions
Date: Thu, 10 May 2018 23:54:22 +1000
Message-Id: <20180510135422.6585-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180508145948.9492-9-mpe@ellerman.id.au>
References: <20180508145948.9492-9-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've updated the generic headers to support 5 PKEY bits for
powerpc we don't need our own #defines in arch code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pkeys.h | 15 ---------------
 1 file changed, 15 deletions(-)

One additional patch to finish cleaning things up.

I've added this to my branch.

cheers

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 18ef59a9886d..5ba80cffb505 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -15,21 +15,6 @@ DECLARE_STATIC_KEY_TRUE(pkey_disabled);
 extern int pkeys_total; /* total pkeys as per device tree */
 extern u32 initial_allocation_mask; /* bits set for reserved keys */
 
-/*
- * Define these here temporarily so we're not dependent on patching linux/mm.h.
- * Once it's updated we can drop these.
- */
-#ifndef VM_PKEY_BIT0
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
-# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
-# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
-#elif !defined(VM_PKEY_BIT4)
-# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
-#endif
-
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 			    VM_PKEY_BIT3 | VM_PKEY_BIT4)
 
-- 
2.14.1
