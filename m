Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeE3LJG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:09:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752730AbeE3LHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:46 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Matt Turner" <mattst88@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.120065268@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 056/153] alpha: fix reboot on Avanti platform
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 55fc633c41a08ce9244ff5f528f420b16b1e04d6 upstream.

We need to define NEED_SRM_SAVE_RESTORE on the Avanti, otherwise we get
machine check exception when attempting to reboot the machine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/alpha/kernel/pci_impl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
