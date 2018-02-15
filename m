Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426699AbeBOQzR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:55:17 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39970 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423659AbeBOQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:55:15 -0500
X-Google-Smtp-Source: AH8x227bOW2xWmTWmqcL1PiJH567QyDN+6Q+cuZebromheabZtXcXzno0nOnmCZGxH8YwcpxAku2bQ==
From: Matthew Whitehead <tedheadster@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 3/3] x86/Kconfig : Explicitly enumerate i686-class cpus in Kconfig
Date: Thu, 15 Feb 2018 11:54:56 -0500
Message-Id: <1518713696-11360-3-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X86_P6_NOP config class leaves out many i686-class cpus. Instead,
explicitly enumerate all these cpus.

Using a configuration with M686 currently sets X86_MINIMUM_CPU_FAMILY=5
instead of the correct value 6.

Booting on an i586 it will fail to generate the "This kernel
requires an i686 CPU, but only detected an i586 CPU" message and
intentional halt as expected. It will instead just silently hang
when it hits i686-specific instructions.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index ec64aa7..8b8d229 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -385,7 +385,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && X86_P6_NOP
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
-- 
1.8.3.1
