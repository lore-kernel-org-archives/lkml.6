Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBYRYp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:24:45 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45392 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeBYRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:08 -0500
X-Google-Smtp-Source: AH8x224oYQbVB4UcVn2iuYlza5hN28d5VZ/wCORgo4ADV/w239XYRH6nDJ3r0AJneRQJSkMxHjrVOg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 13/21] powerpc: Add missing prototype for arch_dup_task_struct
Date: Sun, 25 Feb 2018 18:22:28 +0100
Message-Id: <20180225172236.29650-14-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 55ccf3fe3f9a ("fork: move the real prepare_to_copy() users to
arch_dup_task_struct()") a new arch_dup_task_struct was added without a
prototype declared in thread_info.h header. Fix the following warning
(treated as error in W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:1609:5: error: no previous prototype for ‘arch_dup_task_struct’ [-Werror=missing-prototypes]
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
     ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 4a12c00f8de3..5964145db03d 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -70,6 +70,7 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)val;
 }
 
+extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #endif /* __ASSEMBLY__ */
 
 /*
-- 
2.11.0
