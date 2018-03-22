Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeCVUVD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39029 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeCVUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:55 -0400
X-Google-Smtp-Source: AG47ELvKrfl2AVoucU38ClRI+s0fFjabHLcYve0iz39gJjRr2wT0LaS8sb8FMXUzs8AQqNY7DduoaQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/19] powerpc/chrp/pci: Make some functions static
Date: Thu, 22 Mar 2018 21:19:55 +0100
Message-Id: <20180322202007.23088-10-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
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
 arch/powerpc/platforms/chrp/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 0f512d35f7c5..84e1fedb3796 100644
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
@@ -94,7 +94,7 @@ static struct pci_ops gg2_pci_ops =
 /*
  * Access functions for PCI config space using RTAS calls.
  */
-int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
@@ -109,7 +109,7 @@ int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
 }
 
-int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
+static int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		      int len, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-- 
2.11.0
