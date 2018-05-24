Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163328-2-10279353775472091790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163325; b=hHmpiaQEC4DqU9SmpMMWTew6rTXQ8GGDsQuYfeBdUxrpOpTXNi
    c3M0jZuj8WgbFrrdUprKcDYmr4DeZWyOgGZWcezK9KlRlacVJEzNFh7nnEArdRP9
    wCjvi5PXGVjWB2XIzRxgC5KthT8CnvgMA1rkV333cPzKLz5R7lNXcAIACEI+jLBR
    455vUelsbjT/k0biaCggDYFF+MDpMMcT6mCFxZ2VDWwVCgDTbDqP+Yw0ZqWi7fnt
    uBh9KJr1Uz/yifqASFt/UkG4w4ona1o7t8AsuU3WtQ6WyXPqHkZ6SE3uiTBxIRqs
    ro286v5wCcn2+YVfllYwatCStnqngB2BQj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163325; bh=kTNDxz74pGBjn+N8fQBHQgHhkSVvVu
    zOb6LOzZ8LDAc=; b=VK+ezgkT4SxsZRzu7UoNvFpju77IeaJqkEh/2x19vadZgS
    fYo5HYirRmA56PVf+lEf8wNJVEPVc669xiVjNRjAg7AyUblFOCNMs86jsOeSbBlD
    ZLbhhgU03iwHJ4OWc5gANuhc6tIo0kSO4rvqPPYb1zSdld/ycd+Nsssz82rkBAEs
    97M+GiEjYlOM7Tb3fW5id284SBuxdtAoF2wpNrkvSi4PiQZcmW1/U5+64ypIfS2V
    Ibg9/01XHGKYe3Z9tTWTsCS6FCh9BYJZOmWJzkR3sUSpNpu6to2wFmPBZS+hX2Rp
    Bmh/LVUK06faCBRDiQDyoHLnPZ1/IAaOxjVKEDSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RTQ/l3iy x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RTQ/l3iy x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIgEjuAucAU7YaeFJeW4OuPl6jx4vwJTzp4vs1mBjj0n4tlllrs/0ySNxm9Ia8hhG8x8C3vWr/MJzedcK/B34ZTSRnW9ZkklkGddnYaiNPrvMZVNGtlC
    HOG6hS9pWW5RJU4ly2G4hmJjH4BOsyBHNnKPZ8CzuzG2MYFV4rM7/8pAt/2MR2K2uheWUn19HYeQZOj3Q8P+MDFu/7rutnkmd2DROo9f5cyvxoEOX7ZTaXU6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=PoMdBBFvNJcjPcX58mEA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966423AbeEXJoz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966695AbeEXJot (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Galbraith <mgalbraith@suse.de>
Subject: [PATCH 4.4 43/92] powerpc/powernv: Remove OPALv2 firmware define and references
Date: Thu, 24 May 2018 11:38:20 +0200
Message-Id: <20180524093203.419078826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stewart Smith <stewart@linux.vnet.ibm.com>

commit 7261aafc095763b119136a562540dea7b1ccf657 upstream.

OPALv2 only ever existed in the lab and didn't escape to the world.
All OPAL systems in the wild are OPALv3.

The probability of there being an OPALv2 system still powered on
anywhere inside IBM is approximately zero, let alone anyone
expecting to run mainline kernels.

So, start to remove references to OPALv2.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/firmware.h    |    4 +---
 arch/powerpc/platforms/powernv/opal.c  |    8 ++------
 arch/powerpc/platforms/powernv/setup.c |    4 ----
 arch/powerpc/platforms/powernv/smp.c   |    4 ++--
 4 files changed, 5 insertions(+), 15 deletions(-)

--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -47,7 +47,6 @@
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
 #define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
-#define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
 #define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
@@ -70,8 +69,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2 |
-		FW_FEATURE_OPALv3,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv3,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -100,7 +100,6 @@ int __init early_init_dt_scan_opal(unsig
 
 	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
 	} else {
@@ -349,7 +348,7 @@ int opal_put_chars(uint32_t vtermno, con
 	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
-	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
+	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
 		rc = opal_console_write_buffer_space(vtermno, &olen);
 		len = be64_to_cpu(olen);
 		if (rc || len < total_len) {
@@ -693,10 +692,7 @@ static int __init opal_init(void)
 	}
 
 	/* Register OPAL consoles if any ports */
-	if (firmware_has_feature(FW_FEATURE_OPALv2))
-		consoles = of_find_node_by_path("/ibm,opal/consoles");
-	else
-		consoles = of_node_get(opal_node);
+	consoles = of_find_node_by_path("/ibm,opal/consoles");
 	if (consoles) {
 		for_each_child_of_node(consoles, np) {
 			if (strcmp(np->name, "serial"))
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -142,10 +142,6 @@ static void pnv_show_cpuinfo(struct seq_
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
 	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		seq_printf(m, "firmware\t: OPAL v3\n");
-	else if (firmware_has_feature(FW_FEATURE_OPALv2))
-		seq_printf(m, "firmware\t: OPAL v2\n");
-	else if (firmware_has_feature(FW_FEATURE_OPAL))
-		seq_printf(m, "firmware\t: OPAL v1\n");
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -65,10 +65,10 @@ static int pnv_smp_kick_cpu(int nr)
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/*
-	 * If we already started or OPALv2 is not supported, we just
+	 * If we already started or OPALv3 is not supported, we just
 	 * kick the CPU via the PACA
 	 */
-	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv2))
+	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv3))
 		goto kick;
 
 	/*
