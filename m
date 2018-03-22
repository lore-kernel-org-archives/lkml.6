Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCVUXo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:23:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40024 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeCVUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:53 -0400
X-Google-Smtp-Source: AG47ELvmv07KpO2AdzvBaiSUPH2Vrjv6WzTIZshtuC7BOwDqT9tdsBjnpIBPEL7nCN5buHiakMK2PA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 08/19] powerpc/tau: Make some function static
Date: Thu, 22 Mar 2018 21:19:54 +0100
Message-Id: <20180322202007.23088-9-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/kernel/tau_6xx.c:53:6: error: no previous prototype for ‘set_thresholds’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:73:6: error: no previous prototype for ‘TAUupdate’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:208:13: error: no previous prototype for ‘TAU_init_smp’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:220:12: error: no previous prototype for ‘TAU_init’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:126:6: error: no previous prototype for ‘TAUException’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/tau_6xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 8cdd852aedd1..1fc6a89a978e 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -50,7 +50,7 @@ struct timer_list tau_timer;
 #define shrink_timer	2*HZ	/* period between shrinking the window */
 #define min_window	2	/* minimum window size, degrees C */
 
-void set_thresholds(unsigned long cpu)
+static void set_thresholds(unsigned long cpu)
 {
 #ifdef CONFIG_TAU_INT
 	/*
@@ -70,7 +70,7 @@ void set_thresholds(unsigned long cpu)
 #endif
 }
 
-void TAUupdate(int cpu)
+static void TAUupdate(int cpu)
 {
 	unsigned thrm;
 
@@ -205,7 +205,7 @@ static void tau_timeout_smp(struct timer_list *unused)
 
 int tau_initialized = 0;
 
-void __init TAU_init_smp(void * info)
+static void __init TAU_init_smp(void *info)
 {
 	unsigned long cpu = smp_processor_id();
 
@@ -217,7 +217,7 @@ void __init TAU_init_smp(void * info)
 	set_thresholds(cpu);
 }
 
-int __init TAU_init(void)
+static int __init TAU_init(void)
 {
 	/* We assume in SMP that if one CPU has TAU support, they
 	 * all have it --BenH
-- 
2.11.0
