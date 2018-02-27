Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeB0KT2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:19:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:39035 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbeB0KT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:19:27 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] x86/xen: add tty0 and hvc0 as preferred consoles for dom0
Date: Tue, 27 Feb 2018 11:19:22 +0100
Message-Id: <20180227101922.15701-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the tty0 and hvc0 consoles are added as a preferred consoles for
pv domUs only. As this requires a boot parameter for getting dom0
messages per default, add them for dom0, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c047f42552e1..3c2c2530737e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1376,8 +1376,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	if (!xen_initial_domain()) {
 		add_preferred_console("xenboot", 0, NULL);
-		add_preferred_console("tty", 0, NULL);
-		add_preferred_console("hvc", 0, NULL);
 		if (pci_xen)
 			x86_init.pci.arch_init = pci_xen_init;
 	} else {
@@ -1410,6 +1408,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 		xen_boot_params_init_edd();
 	}
+
+	add_preferred_console("tty", 0, NULL);
+	add_preferred_console("hvc", 0, NULL);
+
 #ifdef CONFIG_PCI
 	/* PCI BIOS service won't work from a PV guest. */
 	pci_probe &= ~PCI_PROBE_BIOS;
-- 
2.13.6
