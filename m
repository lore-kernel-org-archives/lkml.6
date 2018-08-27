Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32968208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32968208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH0UfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:35:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH0UfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:35:03 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bxuP7xaznc8h; Mon, 27 Aug 2018 18:47:22 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12F641EC02AE;
        Mon, 27 Aug 2018 18:47:22 +0200 (CEST)
Date:   Mon, 27 Aug 2018 18:45:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Takashi Iwai <tiwai@suse.de>, Tim Small <tim@buttersideup.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: Remove the i82443bxgx_edac driver
Message-ID: <20180827164535.GB22318@nazgul.tnic>
References: <20180810141520.8993-1-tiwai@suse.de>
 <20180815155752.GC28669@nazgul.tnic>
 <s5hh8jv62lk.wl-tiwai@suse.de>
 <20180815161205.GD28669@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180815161205.GD28669@nazgul.tnic>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 06:12:05PM +0200, Borislav Petkov wrote:
> Nah, I can take it - I'll just drop the CC:stable thing.

Actually, looking at this driver more - it has been depending on BROKEN
since 2007!

  28f96eeafc89 ("drivers/edac-new-i82443bxgz-mc-driver: mark as broken")

and no one has made the move to fix it. Well, here's a "fix" - let's see if
anyone moves now...

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 27 Aug 2018 18:39:28 +0200
Subject: [PATCH] EDAC: Remove the i82443bxgx_edac driver

It has been marked BROKEN since 2007:

  28f96eeafc89 ("drivers/edac-new-i82443bxgz-mc-driver: mark as broken")

and no one has made a move to fix it so let's kill it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tim Small <tim@buttersideup.com>
---
 MAINTAINERS                    |   6 -
 drivers/edac/Kconfig           |   8 -
 drivers/edac/Makefile          |   1 -
 drivers/edac/i82443bxgx_edac.c | 463 ---------------------------------
 4 files changed, 478 deletions(-)
 delete mode 100644 drivers/edac/i82443bxgx_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..657a106b0bc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5285,12 +5285,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/i7core_edac.c
 
-EDAC-I82443BXGX
-M:	Tim Small <tim@buttersideup.com>
-L:	linux-edac@vger.kernel.org
-S:	Maintained
-F:	drivers/edac/i82443bxgx_edac.c
-
 EDAC-I82975X
 M:	Ranganathan Desikan <ravi@jetztechnologies.com>
 M:	"Arvind R." <arvino55@gmail.com>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2e989f..c6ce239934f3 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -121,14 +121,6 @@ config EDAC_E752X
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.
 
-config EDAC_I82443BXGX
-	tristate "Intel 82443BX/GX (440BX/GX)"
-	depends on PCI && X86_32
-	depends on BROKEN
-	help
-	  Support for error detection and correction on the Intel
-	  82443BX/GX memory controllers (440BX/GX chipsets).
-
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
 	depends on PCI && X86_32
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 02b43a7d8c3e..409d1643b702 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
 obj-$(CONFIG_EDAC_PND2)			+= pnd2_edac.o
 obj-$(CONFIG_EDAC_E7XXX)		+= e7xxx_edac.o
 obj-$(CONFIG_EDAC_E752X)		+= e752x_edac.o
-obj-$(CONFIG_EDAC_I82443BXGX)		+= i82443bxgx_edac.o
 obj-$(CONFIG_EDAC_I82875P)		+= i82875p_edac.o
 obj-$(CONFIG_EDAC_I82975X)		+= i82975x_edac.o
 obj-$(CONFIG_EDAC_I3000)		+= i3000_edac.o
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
deleted file mode 100644
index a2ca929e2168..000000000000
--- a/drivers/edac/i82443bxgx_edac.c
+++ /dev/null
@@ -1,463 +0,0 @@
-/*
- * Intel 82443BX/GX (440BX/GX chipset) Memory Controller EDAC kernel
- * module (C) 2006 Tim Small
- *
- * This file may be distributed under the terms of the GNU General
- * Public License.
- *
- * Written by Tim Small <tim@buttersideup.com>, based on work by Linux
- * Networx, Thayne Harbaugh, Dan Hollis <goemon at anime dot net> and
- * others.
- *
- * 440GX fix by Jason Uhlenkott <juhlenko@akamai.com>.
- *
- * Written with reference to 82443BX Host Bridge Datasheet:
- * http://download.intel.com/design/chipsets/datashts/29063301.pdf
- * references to this document given in [].
- *
- * This module doesn't support the 440LX, but it may be possible to
- * make it do so (the 440LX's register definitions are different, but
- * not completely so - I haven't studied them in enough detail to know
- * how easy this would be).
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-
-
-#include <linux/edac.h>
-#include "edac_module.h"
-
-#define EDAC_MOD_STR    "i82443bxgx_edac"
-
-/* The 82443BX supports SDRAM, or EDO (EDO for mobile only), "Memory
- * Size: 8 MB to 512 MB (1GB with Registered DIMMs) with eight memory
- * rows" "The 82443BX supports multiple-bit error detection and
- * single-bit error correction when ECC mode is enabled and
- * single/multi-bit error detection when correction is disabled.
- * During writes to the DRAM, the 82443BX generates ECC for the data
- * on a QWord basis. Partial QWord writes require a read-modify-write
- * cycle when ECC is enabled."
-*/
-
-/* "Additionally, the 82443BX ensures that the data is corrected in
- * main memory so that accumulation of errors is prevented. Another
- * error within the same QWord would result in a double-bit error
- * which is unrecoverable. This is known as hardware scrubbing since
- * it requires no software intervention to correct the data in memory."
- */
-
-/* [Also see page 100 (section 4.3), "DRAM Interface"]
- * [Also see page 112 (section 4.6.1.4), ECC]
- */
-
-#define I82443BXGX_NR_CSROWS 8
-#define I82443BXGX_NR_CHANS  1
-#define I82443BXGX_NR_DIMMS  4
-
-/* 82443 PCI Device 0 */
-#define I82443BXGX_NBXCFG 0x50	/* 32bit register starting at this PCI
-				 * config space offset */
-#define I82443BXGX_NBXCFG_OFFSET_NON_ECCROW 24	/* Array of bits, zero if
-						 * row is non-ECC */
-#define I82443BXGX_NBXCFG_OFFSET_DRAM_FREQ 12	/* 2 bits,00=100MHz,10=66 MHz */
-
-#define I82443BXGX_NBXCFG_OFFSET_DRAM_INTEGRITY 7	/* 2 bits:       */
-#define I82443BXGX_NBXCFG_INTEGRITY_NONE   0x0	/* 00 = Non-ECC */
-#define I82443BXGX_NBXCFG_INTEGRITY_EC     0x1	/* 01 = EC (only) */
-#define I82443BXGX_NBXCFG_INTEGRITY_ECC    0x2	/* 10 = ECC */
-#define I82443BXGX_NBXCFG_INTEGRITY_SCRUB  0x3	/* 11 = ECC + HW Scrub */
-
-#define I82443BXGX_NBXCFG_OFFSET_ECC_DIAG_ENABLE  6
-
-/* 82443 PCI Device 0 */
-#define I82443BXGX_EAP   0x80	/* 32bit register starting at this PCI
-				 * config space offset, Error Address
-				 * Pointer Register */
-#define I82443BXGX_EAP_OFFSET_EAP  12	/* High 20 bits of error address */
-#define I82443BXGX_EAP_OFFSET_MBE  BIT(1)	/* Err at EAP was multi-bit (W1TC) */
-#define I82443BXGX_EAP_OFFSET_SBE  BIT(0)	/* Err at EAP was single-bit (W1TC) */
-
-#define I82443BXGX_ERRCMD  0x90	/* 8bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_ERRCMD_OFFSET_SERR_ON_MBE BIT(1)	/* 1 = enable */
-#define I82443BXGX_ERRCMD_OFFSET_SERR_ON_SBE BIT(0)	/* 1 = enable */
-
-#define I82443BXGX_ERRSTS  0x91	/* 16bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_ERRSTS_OFFSET_MBFRE 5	/* 3 bits - first err row multibit */
-#define I82443BXGX_ERRSTS_OFFSET_MEF   BIT(4)	/* 1 = MBE occurred */
-#define I82443BXGX_ERRSTS_OFFSET_SBFRE 1	/* 3 bits - first err row singlebit */
-#define I82443BXGX_ERRSTS_OFFSET_SEF   BIT(0)	/* 1 = SBE occurred */
-
-#define I82443BXGX_DRAMC 0x57	/* 8bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_DRAMC_OFFSET_DT 3	/* 2 bits, DRAM Type */
-#define I82443BXGX_DRAMC_DRAM_IS_EDO 0	/* 00 = EDO */
-#define I82443BXGX_DRAMC_DRAM_IS_SDRAM 1	/* 01 = SDRAM */
-#define I82443BXGX_DRAMC_DRAM_IS_RSDRAM 2	/* 10 = Registered SDRAM */
-
-#define I82443BXGX_DRB 0x60	/* 8x 8bit registers starting at this PCI
-				 * config space offset. */
-
-/* FIXME - don't poll when ECC disabled? */
-
-struct i82443bxgx_edacmc_error_info {
-	u32 eap;
-};
-
-static struct edac_pci_ctl_info *i82443bxgx_pci;
-
-static struct pci_dev *mci_pdev;	/* init dev: in case that AGP code has
-					 * already registered driver
-					 */
-
-static int i82443bxgx_registered = 1;
-
-static void i82443bxgx_edacmc_get_error_info(struct mem_ctl_info *mci,
-				struct i82443bxgx_edacmc_error_info
-				*info)
-{
-	struct pci_dev *pdev;
-	pdev = to_pci_dev(mci->pdev);
-	pci_read_config_dword(pdev, I82443BXGX_EAP, &info->eap);
-	if (info->eap & I82443BXGX_EAP_OFFSET_SBE)
-		/* Clear error to allow next error to be reported [p.61] */
-		pci_write_bits32(pdev, I82443BXGX_EAP,
-				 I82443BXGX_EAP_OFFSET_SBE,
-				 I82443BXGX_EAP_OFFSET_SBE);
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_MBE)
-		/* Clear error to allow next error to be reported [p.61] */
-		pci_write_bits32(pdev, I82443BXGX_EAP,
-				 I82443BXGX_EAP_OFFSET_MBE,
-				 I82443BXGX_EAP_OFFSET_MBE);
-}
-
-static int i82443bxgx_edacmc_process_error_info(struct mem_ctl_info *mci,
-						struct
-						i82443bxgx_edacmc_error_info
-						*info, int handle_errors)
-{
-	int error_found = 0;
-	u32 eapaddr, page, pageoffset;
-
-	/* bits 30:12 hold the 4kb block in which the error occurred
-	 * [p.61] */
-	eapaddr = (info->eap & 0xfffff000);
-	page = eapaddr >> PAGE_SHIFT;
-	pageoffset = eapaddr - (page << PAGE_SHIFT);
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_SBE) {
-		error_found = 1;
-		if (handle_errors)
-			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-					     page, pageoffset, 0,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1, mci->ctl_name, "");
-	}
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_MBE) {
-		error_found = 1;
-		if (handle_errors)
-			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-					     page, pageoffset, 0,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1, mci->ctl_name, "");
-	}
-
-	return error_found;
-}
-
-static void i82443bxgx_edacmc_check(struct mem_ctl_info *mci)
-{
-	struct i82443bxgx_edacmc_error_info info;
-
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
-	i82443bxgx_edacmc_get_error_info(mci, &info);
-	i82443bxgx_edacmc_process_error_info(mci, &info, 1);
-}
-
-static void i82443bxgx_init_csrows(struct mem_ctl_info *mci,
-				struct pci_dev *pdev,
-				enum edac_type edac_mode,
-				enum mem_type mtype)
-{
-	struct csrow_info *csrow;
-	struct dimm_info *dimm;
-	int index;
-	u8 drbar, dramc;
-	u32 row_base, row_high_limit, row_high_limit_last;
-
-	pci_read_config_byte(pdev, I82443BXGX_DRAMC, &dramc);
-	row_high_limit_last = 0;
-	for (index = 0; index < mci->nr_csrows; index++) {
-		csrow = mci->csrows[index];
-		dimm = csrow->channels[0]->dimm;
-
-		pci_read_config_byte(pdev, I82443BXGX_DRB + index, &drbar);
-		edac_dbg(1, "MC%d: Row=%d DRB = %#0x\n",
-			 mci->mc_idx, index, drbar);
-		row_high_limit = ((u32) drbar << 23);
-		/* find the DRAM Chip Select Base address and mask */
-		edac_dbg(1, "MC%d: Row=%d, Boundary Address=%#0x, Last = %#0x\n",
-			 mci->mc_idx, index, row_high_limit,
-			 row_high_limit_last);
-
-		/* 440GX goes to 2GB, represented with a DRB of 0. */
-		if (row_high_limit_last && !row_high_limit)
-			row_high_limit = 1UL << 31;
-
-		/* This row is empty [p.49] */
-		if (row_high_limit == row_high_limit_last)
-			continue;
-		row_base = row_high_limit_last;
-		csrow->first_page = row_base >> PAGE_SHIFT;
-		csrow->last_page = (row_high_limit >> PAGE_SHIFT) - 1;
-		dimm->nr_pages = csrow->last_page - csrow->first_page + 1;
-		/* EAP reports in 4kilobyte granularity [61] */
-		dimm->grain = 1 << 12;
-		dimm->mtype = mtype;
-		/* I don't think 440BX can tell you device type? FIXME? */
-		dimm->dtype = DEV_UNKNOWN;
-		/* Mode is global to all rows on 440BX */
-		dimm->edac_mode = edac_mode;
-		row_high_limit_last = row_high_limit;
-	}
-}
-
-static int i82443bxgx_edacmc_probe1(struct pci_dev *pdev, int dev_idx)
-{
-	struct mem_ctl_info *mci;
-	struct edac_mc_layer layers[2];
-	u8 dramc;
-	u32 nbxcfg, ecc_mode;
-	enum mem_type mtype;
-	enum edac_type edac_mode;
-
-	edac_dbg(0, "MC:\n");
-
-	/* Something is really hosed if PCI config space reads from
-	 * the MC aren't working.
-	 */
-	if (pci_read_config_dword(pdev, I82443BXGX_NBXCFG, &nbxcfg))
-		return -EIO;
-
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = I82443BXGX_NR_CSROWS;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = I82443BXGX_NR_CHANS;
-	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
-	if (mci == NULL)
-		return -ENOMEM;
-
-	edac_dbg(0, "MC: mci = %p\n", mci);
-	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_EDO | MEM_FLAG_SDR | MEM_FLAG_RDR;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-	pci_read_config_byte(pdev, I82443BXGX_DRAMC, &dramc);
-	switch ((dramc >> I82443BXGX_DRAMC_OFFSET_DT) & (BIT(0) | BIT(1))) {
-	case I82443BXGX_DRAMC_DRAM_IS_EDO:
-		mtype = MEM_EDO;
-		break;
-	case I82443BXGX_DRAMC_DRAM_IS_SDRAM:
-		mtype = MEM_SDR;
-		break;
-	case I82443BXGX_DRAMC_DRAM_IS_RSDRAM:
-		mtype = MEM_RDR;
-		break;
-	default:
-		edac_dbg(0, "Unknown/reserved DRAM type value in DRAMC register!\n");
-		mtype = -MEM_UNKNOWN;
-	}
-
-	if ((mtype == MEM_SDR) || (mtype == MEM_RDR))
-		mci->edac_cap = mci->edac_ctl_cap;
-	else
-		mci->edac_cap = EDAC_FLAG_NONE;
-
-	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
-	pci_read_config_dword(pdev, I82443BXGX_NBXCFG, &nbxcfg);
-	ecc_mode = ((nbxcfg >> I82443BXGX_NBXCFG_OFFSET_DRAM_INTEGRITY) &
-		(BIT(0) | BIT(1)));
-
-	mci->scrub_mode = (ecc_mode == I82443BXGX_NBXCFG_INTEGRITY_SCRUB)
-		? SCRUB_HW_SRC : SCRUB_NONE;
-
-	switch (ecc_mode) {
-	case I82443BXGX_NBXCFG_INTEGRITY_NONE:
-		edac_mode = EDAC_NONE;
-		break;
-	case I82443BXGX_NBXCFG_INTEGRITY_EC:
-		edac_mode = EDAC_EC;
-		break;
-	case I82443BXGX_NBXCFG_INTEGRITY_ECC:
-	case I82443BXGX_NBXCFG_INTEGRITY_SCRUB:
-		edac_mode = EDAC_SECDED;
-		break;
-	default:
-		edac_dbg(0, "Unknown/reserved ECC state in NBXCFG register!\n");
-		edac_mode = EDAC_UNKNOWN;
-		break;
-	}
-
-	i82443bxgx_init_csrows(mci, pdev, edac_mode, mtype);
-
-	/* Many BIOSes don't clear error flags on boot, so do this
-	 * here, or we get "phantom" errors occurring at module-load
-	 * time. */
-	pci_write_bits32(pdev, I82443BXGX_EAP,
-			(I82443BXGX_EAP_OFFSET_SBE |
-				I82443BXGX_EAP_OFFSET_MBE),
-			(I82443BXGX_EAP_OFFSET_SBE |
-				I82443BXGX_EAP_OFFSET_MBE));
-
-	mci->mod_name = EDAC_MOD_STR;
-	mci->ctl_name = "I82443BXGX";
-	mci->dev_name = pci_name(pdev);
-	mci->edac_check = i82443bxgx_edacmc_check;
-	mci->ctl_page_to_phys = NULL;
-
-	if (edac_mc_add_mc(mci)) {
-		edac_dbg(3, "failed edac_mc_add_mc()\n");
-		goto fail;
-	}
-
-	/* allocating generic PCI control info */
-	i82443bxgx_pci = edac_pci_create_generic_ctl(&pdev->dev, EDAC_MOD_STR);
-	if (!i82443bxgx_pci) {
-		printk(KERN_WARNING
-			"%s(): Unable to create PCI control\n",
-			__func__);
-		printk(KERN_WARNING
-			"%s(): PCI error report via EDAC not setup\n",
-			__func__);
-	}
-
-	edac_dbg(3, "MC: success\n");
-	return 0;
-
-fail:
-	edac_mc_free(mci);
-	return -ENODEV;
-}
-
-/* returns count (>= 0), or negative on error */
-static int i82443bxgx_edacmc_init_one(struct pci_dev *pdev,
-				      const struct pci_device_id *ent)
-{
-	int rc;
-
-	edac_dbg(0, "MC:\n");
-
-	/* don't need to call pci_enable_device() */
-	rc = i82443bxgx_edacmc_probe1(pdev, ent->driver_data);
-
-	if (mci_pdev == NULL)
-		mci_pdev = pci_dev_get(pdev);
-
-	return rc;
-}
-
-static void i82443bxgx_edacmc_remove_one(struct pci_dev *pdev)
-{
-	struct mem_ctl_info *mci;
-
-	edac_dbg(0, "\n");
-
-	if (i82443bxgx_pci)
-		edac_pci_release_generic_ctl(i82443bxgx_pci);
-
-	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
-		return;
-
-	edac_mc_free(mci);
-}
-
-static const struct pci_device_id i82443bxgx_pci_tbl[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443BX_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443BX_2)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_2)},
-	{0,}			/* 0 terminated list. */
-};
-
-MODULE_DEVICE_TABLE(pci, i82443bxgx_pci_tbl);
-
-static struct pci_driver i82443bxgx_edacmc_driver = {
-	.name = EDAC_MOD_STR,
-	.probe = i82443bxgx_edacmc_init_one,
-	.remove = i82443bxgx_edacmc_remove_one,
-	.id_table = i82443bxgx_pci_tbl,
-};
-
-static int __init i82443bxgx_edacmc_init(void)
-{
-	int pci_rc;
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
-
-	pci_rc = pci_register_driver(&i82443bxgx_edacmc_driver);
-	if (pci_rc < 0)
-		goto fail0;
-
-	if (mci_pdev == NULL) {
-		const struct pci_device_id *id = &i82443bxgx_pci_tbl[0];
-		int i = 0;
-		i82443bxgx_registered = 0;
-
-		while (mci_pdev == NULL && id->vendor != 0) {
-			mci_pdev = pci_get_device(id->vendor,
-					id->device, NULL);
-			i++;
-			id = &i82443bxgx_pci_tbl[i];
-		}
-		if (!mci_pdev) {
-			edac_dbg(0, "i82443bxgx pci_get_device fail\n");
-			pci_rc = -ENODEV;
-			goto fail1;
-		}
-
-		pci_rc = i82443bxgx_edacmc_init_one(mci_pdev, i82443bxgx_pci_tbl);
-
-		if (pci_rc < 0) {
-			edac_dbg(0, "i82443bxgx init fail\n");
-			pci_rc = -ENODEV;
-			goto fail1;
-		}
-	}
-
-	return 0;
-
-fail1:
-	pci_unregister_driver(&i82443bxgx_edacmc_driver);
-
-fail0:
-	pci_dev_put(mci_pdev);
-	return pci_rc;
-}
-
-static void __exit i82443bxgx_edacmc_exit(void)
-{
-	pci_unregister_driver(&i82443bxgx_edacmc_driver);
-
-	if (!i82443bxgx_registered)
-		i82443bxgx_edacmc_remove_one(mci_pdev);
-
-	pci_dev_put(mci_pdev);
-}
-
-module_init(i82443bxgx_edacmc_init);
-module_exit(i82443bxgx_edacmc_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tim Small <tim@buttersideup.com> - WPAD");
-MODULE_DESCRIPTION("EDAC MC support for Intel 82443BX/GX memory controllers");
-
-module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
-- 
2.18.0.321.gffc6fa0e3962

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
