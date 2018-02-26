Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeBZLI1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:08:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbeBZLIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:08:25 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: use hvc console for dom0
Date: Mon, 26 Feb 2018 12:08:22 +0100
Message-Id: <20180226110822.13787-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the hvc console is added as a preferred console for pv domUs
only. As this requires a boot parameter for getting dom0 messages per
default add it for dom0, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c047f42552e1..d27740a80c5e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1377,7 +1377,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	if (!xen_initial_domain()) {
 		add_preferred_console("xenboot", 0, NULL);
 		add_preferred_console("tty", 0, NULL);
-		add_preferred_console("hvc", 0, NULL);
 		if (pci_xen)
 			x86_init.pci.arch_init = pci_xen_init;
 	} else {
@@ -1410,6 +1409,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 		xen_boot_params_init_edd();
 	}
+
+	add_preferred_console("hvc", 0, NULL);
+
 #ifdef CONFIG_PCI
 	/* PCI BIOS service won't work from a PV guest. */
 	pci_probe &= ~PCI_PROBE_BIOS;
-- 
2.13.6
