Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426707AbeBOQzu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:55:50 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40166 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423681AbeBOQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:55:13 -0500
X-Google-Smtp-Source: AH8x224Cp6GKkatoZrrJOoqqj0vUhnpzV4NPtVMcO7ERdsh2aWJBvCmLgMD3i1A0OkfvEe8eD/maEA==
From: Matthew Whitehead <tedheadster@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 2/3] x86/Kconfig : Exclude i586-class cpus lacking PAE support from HIGHMEM64G Kconfig group
Date: Thu, 15 Feb 2018 11:54:55 -0500
Message-Id: <1518713696-11360-2-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i586-class machines also lack support for Physical Address Extension (PAE),
so add them to the exclusion list

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 72d5149..89bf3fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1360,7 +1360,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486
+	depends on !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
 	select X86_PAE
 	---help---
 	  Select this if you have a 32-bit processor and more than 4
-- 
1.8.3.1
