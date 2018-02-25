Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBYR0H (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:26:07 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43540 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBYRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:04 -0500
X-Google-Smtp-Source: AH8x2259NrJqlCjNJYRGrWB9hdtHNt/Iy0r7iFsTDl6KFHaB5IoL8r0rDWxv0i0DKRB6RPCSLKRE8w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 09/21] powerpc: Make function save_all static
Date: Sun, 25 Feb 2018 18:22:24 +0100
Message-Id: <20180225172236.29650-10-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function `save_all` is not meant to be exported, change the signature
to `static`. Fix warning (treated as error with W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:559:6: error: no previous prototype for ‘save_all’ [-Werror=missing-prototypes]
 void save_all(struct task_struct *tsk)
      ^~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3ac98c0463d6..ec4f363ebb89 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -556,7 +556,7 @@ void restore_math(struct pt_regs *regs)
 	regs->msr = msr;
 }
 
-void save_all(struct task_struct *tsk)
+static void save_all(struct task_struct *tsk)
 {
 	unsigned long usermsr;
 
-- 
2.11.0
