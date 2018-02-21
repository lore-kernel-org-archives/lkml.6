Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeBUJmi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:42:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:55731 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752983AbeBUJmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:42:36 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86: make x86_init noop functions static
Date: Wed, 21 Feb 2018 10:42:32 +0100
Message-Id: <20180221094232.23462-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the noop functions in x86_init.c static in case they are used
locally only.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/x86_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 9e4e994a4836..b8cff22a8785 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -26,11 +26,11 @@
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
-int __init iommu_init_noop(void) { return 0; }
-void iommu_shutdown_noop(void) { }
-bool __init bool_x86_init_noop(void) { return false; }
-void x86_op_int_noop(int cpu) { }
-u64 u64_x86_init_noop(void) { return 0; }
+static int __init iommu_init_noop(void) { return 0; }
+static void iommu_shutdown_noop(void) { }
+static bool __init bool_x86_init_noop(void) { return false; }
+static void x86_op_int_noop(int cpu) { }
+static u64 u64_x86_init_noop(void) { return 0; }
 
 /*
  * The platform setup functions are preset with the default functions
-- 
2.13.6
