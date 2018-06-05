Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeFERGn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbeFERGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 24/61] powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef
Date: Tue,  5 Jun 2018 19:01:45 +0200
Message-Id: <20180605170119.244280138@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

The backport of the RFI flush support, done by me, has a minor bug in
that the code is inside an #ifdef CONFIG_HARDLOCKUP_DETECTOR, which is
incorrect.

This doesn't matter with common configs because we enable
HARDLOCKUP_DETECTOR, but with future patches it will break the build.
So fix it.

Fixes: c3b82ebee6e0 ("powerpc/64s: Add support for RFI flush of L1-D cache")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -679,6 +679,7 @@ static int __init disable_hardlockup_det
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+#endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
@@ -806,4 +807,3 @@ ssize_t cpu_show_meltdown(struct device
 	return sprintf(buf, "Vulnerable\n");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#endif
