Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750747AbeBCWq1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 17:46:27 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45861 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeBCWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 17:46:18 -0500
X-Google-Smtp-Source: AH8x2272+vcFJMDoWXKgfDEwtStJw4xuhDfYX5XScqlHzj6hqrSmdM33lES0aC5ExdSUtFAqtcu8tw==
From: Matthew Whitehead <tedheadster@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 1/3] x86/Kconfig : Add missing i586-class cpus to X86_CMPXCHG64 Kconfig group
Date: Sat,  3 Feb 2018 17:46:06 -0500
Message-Id: <1517697968-19014-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several i586-class cpus supporting this instruction are missing from
the X86_CMPXCHG64 config group.

Using a configuration with either M586TSC or M586MMX currently sets
X86_MINIMUM_CPU_FAMILY=4 instead of the correct value 5.

Booting on an i486 it will fail to generate the "This kernel
requires an i586 CPU, but only detected an i486 CPU" message and
intentional halt as expected. It will instead just silently hang
when it hits i586-specific instructions.

The M586 cpu is not in this list because at least the Cyrix 5x86
lacks this instruction, and perhaps others.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 65a9a47..ec64aa7 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -374,7 +374,7 @@ config X86_TSC
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MATOM
+	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-- 
1.8.3.1
