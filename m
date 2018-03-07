Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965058AbeCGUdd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:33:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33071 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933935AbeCGUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:33:31 -0500
X-Google-Smtp-Source: AG47ELvWWZrrwjPkvg3wTqhfKBu5gB9e7oYpu+hIAc+M10G0yqZoHp0/dcYs3x8zMn+q2s7BvveUvw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 15/21] powerpc: Make function MMU_setup static
Date: Wed,  7 Mar 2018 21:32:55 +0100
Message-Id: <20180307203257.23542-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-16-malat@debian.org>
References: <20180225172236.29650-16-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function `MMU_setup` is not meant to be exported, change the
signature to `static`. Fix warning (treated as error with W=1):

  CC      kernel/sys.o
arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
 void __init MMU_setup(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..a2bf6965d04f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -99,7 +99,7 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
 /*
  * Check for command-line options that affect what MMU_init will do.
  */
-void __init MMU_setup(void)
+static void __init MMU_setup(void)
 {
 	/* Check for nobats option (used in mapin_ram). */
 	if (strstr(boot_command_line, "nobats")) {
-- 
2.11.0
