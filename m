Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeC1T12 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:27:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35426 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeC1T11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:27:27 -0400
X-Google-Smtp-Source: AIpwx49o8mhAW40tRCXmwYMK4WDloYGksLUVPvi9IO+MRn8ceGpRzzbfsr093sGC9U3DF1XYuDQ7pA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] powerpc/powermac: Mark variable x as unused
Date: Wed, 28 Mar 2018 21:27:17 +0200
Message-Id: <20180328192717.656-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-2-malat@debian.org>
References: <20180322202007.23088-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the value of x is never intended to be read, declare it with gcc
attribute as unused. Fix warning treated as error with W=1:

  arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: move x variable within its local scope

 arch/powerpc/platforms/powermac/bootx_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index c3c9bbb3573a..d44e8571c1ec 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	boot_infos_t *bi = (boot_infos_t *) r4;
 	unsigned long hdr;
 	unsigned long space;
-	unsigned long ptr, x;
+	unsigned long ptr;
 	char *model;
 	unsigned long offset = reloc_offset();
 
@@ -562,6 +562,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	 * MMU switched OFF, so this should not be useful anymore.
 	 */
 	if (bi->version < 4) {
+		unsigned long x __maybe_unused;
 		bootx_printf("Touching pages...\n");
 
 		/*
-- 
2.11.0
