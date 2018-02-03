Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeBCWqf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 17:46:35 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41770 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeBCWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 17:46:19 -0500
X-Google-Smtp-Source: AH8x226WFOxVoXxRqXzr/HeXGPEg1O76aiuxOwB6i5W7Cc+GQVGpew1RZPZ9hf8i66HJ66Qlp0NANQ==
From: Matthew Whitehead <tedheadster@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 2/3] x86/Kconfig : Exclude i586-class cpus lacking PAE support from HIGHMEM64G Kconfig group
Date: Sat,  3 Feb 2018 17:46:07 -0500
Message-Id: <1517697968-19014-2-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517697968-19014-1-git-send-email-tedheadster@gmail.com>
References: <1517697968-19014-1-git-send-email-tedheadster@gmail.com>
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
index 423e4b6..c45fe6d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1359,7 +1359,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486
+	depends on !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
 	select X86_PAE
 	---help---
 	  Select this if you have a 32-bit processor and more than 4
-- 
1.8.3.1
