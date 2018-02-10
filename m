Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBJMyi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 07:54:38 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38336 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 07:54:35 -0500
Message-Id: <61813627b8aef562c425364c89fde863e77974c7.1518226173.git.christophe.leroy@c-s.fr>
In-Reply-To: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 5/5] powerpc/8xx: Increase number of slices to 64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>
Date: Sat, 10 Feb 2018 13:54:33 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 8xx, the minimum slice size is the size of the area
covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
16K pages mode.

This patch increases the number of slices from 16 to 64 on the 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: New
 
 arch/powerpc/include/asm/nohash/32/slice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
index bcb4924f7d22..3deaaea89473 100644
--- a/arch/powerpc/include/asm/nohash/32/slice.h
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_PPC_MM_SLICES
 
-#define SLICE_LOW_SHIFT		28
+#define SLICE_LOW_SHIFT		26	/* 64 slices */
 #define SLICE_LOW_TOP		(0x100000000ull)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
-- 
2.13.3
