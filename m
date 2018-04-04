Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeDDUPL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:15:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53358 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDDUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:15:10 -0400
X-Google-Smtp-Source: AIpwx49EFBaZmAqM2Xgi4jw+7e+nrR2J9v3zZNhz9Vf8SrEqgLZnlVJqDi+9Q1vc7W0d0jpXNWeBOQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/19] powerpc/chrp/pci: Make some functions static
Date: Wed,  4 Apr 2018 22:15:03 +0200
Message-Id: <20180404201504.28003-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-10-malat@debian.org>
References: <20180322202007.23088-10-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/pci.c:34:5: error: no previous prototype for ‘gg2_read_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:61:5: error: no previous prototype for ‘gg2_write_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:97:5: error: no previous prototype for ‘rtas_read_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:112:5: error: no previous prototype for ‘rtas_write_config’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: style: fix alignement issue (checkpatch --strict)
v2: no change
 arch/powerpc/platforms/chrp/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 0f512d35f7c5..5ddb57b82921 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -31,7 +31,7 @@ void __iomem *gg2_pci_config_base;
  * limit the bus number to 3 bits
  */
 
-int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
+static int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 			   int len, u32 *val)
 {
 	volatile void __iomem *cfg_data;
@@ -58,7 +58,7 @@ int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
+static int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
 			    int len, u32 val)
 {
 	volatile void __iomem *cfg_data;
@@ -94,8 +94,8 @@ static struct pci_ops gg2_pci_ops =
 /*
  * Access functions for PCI config space using RTAS calls.
  */
-int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		     int len, u32 *val)
+static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+			    int len, u32 *val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
@@ -109,8 +109,8 @@ int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
 }
 
-int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		      int len, u32 val)
+static int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
+			     int len, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-- 
2.11.0
