Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDDUOE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:14:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36790 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDDUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:14:01 -0400
X-Google-Smtp-Source: AIpwx4+kXrCROlXSfRxOl689X4gs8IBbZ3dR4Ds5scUTjBUCylgjJKlc3a1bLIWQetf/R/2PhxxMvw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/19] powerpc/powermac: Move pmac_pfunc_base_install prototype to header file
Date: Wed,  4 Apr 2018 22:13:55 +0200
Message-Id: <20180404201355.27925-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-12-malat@debian.org>
References: <20180322202007.23088-12-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
function was used there, move it to pmac_pfunc.h header to be visible in
pfunc_base.c. Fix a warning treated as error with W=1:

  arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/include/asm/pmac_pfunc.h | 1 +
 arch/powerpc/platforms/powermac/smp.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pmac_pfunc.h b/arch/powerpc/include/asm/pmac_pfunc.h
index 73bd8f28f2a8..cee4e9f5b8cf 100644
--- a/arch/powerpc/include/asm/pmac_pfunc.h
+++ b/arch/powerpc/include/asm/pmac_pfunc.h
@@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function *func);
 
 extern int pmf_call_one(struct pmf_function *func, struct pmf_args *args);
 
+int pmac_pfunc_base_install(void);
 
 /* Suspend/resume code called by via-pmu directly for now */
 extern void pmac_pfunc_base_suspend(void);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 95275e0e2efa..447da6db450a 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -65,7 +65,6 @@
 #endif
 
 extern void __secondary_start_pmac_0(void);
-extern int pmac_pfunc_base_install(void);
 
 static void (*pmac_tb_freeze)(int freeze);
 static u64 timebase;
-- 
2.11.0
