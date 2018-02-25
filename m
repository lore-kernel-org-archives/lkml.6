Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeBYRXE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34548 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeBYRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:22:55 -0500
X-Google-Smtp-Source: AH8x225OiJ3G+tx3eIJAmUfArHPKPH4CgyynqOdObsS/Mx52ayByqrKY0WUQoL1ha7zNoUjtNz5gJQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 02/21] powerpc: Move the inline keyword at the beginning of function declaration
Date: Sun, 25 Feb 2018 18:22:17 +0100
Message-Id: <20180225172236.29650-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline keyword was not at the beginning of the function declaration.
Fix the following warning (treated as error in W=1)

  CC      kernel/sys.o
arch/powerpc/lib/sstep.c:283:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
 static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
 ^~~~~~
arch/powerpc/lib/sstep.c:388:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
 static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
 ^~~~~~
  CC      arch/powerpc/kernel/setup_32.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/sstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 70274b7b4773..34d68f1b1b40 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -280,7 +280,7 @@ static nokprobe_inline int read_mem_aligned(unsigned long *dest,
  * Copy from userspace to a buffer, using the largest possible
  * aligned accesses, up to sizeof(long).
  */
-static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
+static nokprobe_inline int copy_mem_in(u8 *dest, unsigned long ea, int nb,
 				       struct pt_regs *regs)
 {
 	int err = 0;
@@ -385,7 +385,7 @@ static nokprobe_inline int write_mem_aligned(unsigned long val,
  * Copy from a buffer to userspace, using the largest possible
  * aligned accesses, up to sizeof(long).
  */
-static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
+static nokprobe_inline int copy_mem_out(u8 *dest, unsigned long ea, int nb,
 					struct pt_regs *regs)
 {
 	int err = 0;
-- 
2.11.0
