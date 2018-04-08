Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeDHTod (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 15:44:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46323 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeDHTob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 15:44:31 -0400
X-Google-Smtp-Source: AIpwx4+KjhyUgC9O/Lf2nnqlk2PXMN98XXgHG2SLAjyiuOna2zYXcRQrUiyI+sd9KyGRb8v6lb2wMA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm/radix: add missing braces for single statement block
Date: Sun,  8 Apr 2018 21:44:24 +0200
Message-Id: <20180408194424.8719-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
disable_radix") an `if` statement was added for a possible empty body
(prom_debug).

Fix the following warning, treated as error with W=1:

  arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5ae153b97d0a..f0e802495530 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -652,8 +652,9 @@ static void __init early_cmdline_parse(void)
 		} else
 			prom_radix_disable = true;
 	}
-	if (prom_radix_disable)
+	if (prom_radix_disable) {
 		prom_debug("Radix disabled from cmdline\n");
+	}
 }
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
-- 
2.11.0
