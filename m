Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeCVUVR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40980 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeCVUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:12 -0400
X-Google-Smtp-Source: AG47ELu8/bOxxWQ5OMFO8OJJfifdmYOnJymtT2b9tbL3QFsfU7bPR5oBe+BjDzYOTt2+r0OVjJeTeQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 18/19] powerpc: Add a missing include header
Date: Thu, 22 Mar 2018 21:20:04 +0100
Message-Id: <20180322202007.23088-19-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file <asm/switch_to.h> was missing from the includes. Fix the
following warning, treated as error with W=1:

  arch/powerpc/kernel/vecemu.c:260:5: error: no previous prototype for ‘emulate_altivec’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/vecemu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vecemu.c b/arch/powerpc/kernel/vecemu.c
index 8812085883fd..4acd3fb2b38e 100644
--- a/arch/powerpc/kernel/vecemu.c
+++ b/arch/powerpc/kernel/vecemu.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#include <asm/switch_to.h>
 #include <linux/uaccess.h>
 
 /* Functions in vector.S */
-- 
2.11.0
