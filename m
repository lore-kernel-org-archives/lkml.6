Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994790-2-1298870390152265621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Attached: use-set_memory_block_size
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994789; b=bKDdmTpQSxBaBk7Tj1k/PrxdV5QMeC0EksgaSES8uoUXnBvwL3
    T+/sZKTMXAxQbWNG3mmqQaOwgcRmpzSwpLt+HjTverMxn4EMEgowX69spsXahhC0
    D8DKyZZWIPTi8RIDtw7gyEYjTBeVcfNvC3lry2OcD2Ne0ScmTSd4VeO7coKRZZoz
    NzEOdxCL4/Oz/YRuBqWdqedjka0+A1z56fEVR5pWkZA4sqnbsETH/KWqYKQAEDG/
    DcWVQ5rsBzMl9+7YBIN8+mNfbDJmzhyt21drboorb5PL+iS3KSW9rvjav4LkWwjd
    kd6ZOBoObIlNK0y9ip8+9JI5cMvyt2qAu+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:references:date:from:to:cc
    :subject:sender:list-id; s=fm2; t=1525994789; bh=kdPm0KQ1H0EjueB
    x2PzOwGzoMAb4BtDDDc0c7Etr+MY=; b=DN9PEFCHiwb6R+KOcEB6HSzXTAOJFYN
    3AuhskIjmcnG8XRaeqF+zl++DaBAoDdAq6ZCQh/P5TdODpNSXY9TYAkxUdHS73rW
    Fh/Qz/dtgG8rvGc9iRk3nFuKGJXUXidi+xJ8JSrUb9iJcx3ofH0ZN06eVR3tMaKT
    V7INqVGuqPTN4WiJ7iXDE8FqbDmGPdWBsX8D1E6/ShNMGi+VbVsVAxSeLZtTd5g2
    X4vzcX8iyHCkJEdjbPrYR78wg1ObRtLdcLgfrgoMInUJjbyvE4SWaizvHNXYDzhp
    u3V5GUt+per2QcwI8RoFLu+2YUUOmmebcDDgX9/lwYSMIMV/P14f/5g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN5xSBCrfNPSSHfZXxC4e4XnMNltFA8wj2Bvt5D2pXiHdB2SLPBM1pf91xjaUFHbN0CmbPLkrMJOeQiVWNN2PResLcSjECXKjh8xVzo1v6G7bOXTlpnB
    BU7nSu02Yr64D/GB6JWPN40UehARMEI+Abjcil3nbWgChhSsQF2wzdjKGTpxwd372CBU8RA8BE2XFd2unqPz/4CcHHDCI1A3SBNCiUlu9nes/Fo2cebMMstv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=MvuuwTCpAAAA:8
    a=1qZh7l4-mTh0fMg8WS8A:9 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEJX01 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:26:27 -0400
Received: from relay2.sgi.com ([192.48.180.65]:51897 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750798AbeEJX0B (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 10 May 2018 19:26:01 -0400
Message-Id: <20180510231832.321834876@stormcage.americas.sgi.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 10 May 2018 18:18:34 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] x86/platform/UV: Use new set memory block size function
Content-Disposition: inline; filename=use-set_memory_block_size
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a call to the new function to "adjust" the current fixed UV memory
block size of 2GB so it can be changed to a different physical boundary.
This accommodates changes in the Intel BIOS, and therefore UV BIOS, which
now can align boundaries different than the previous UV standard of 2GB.
It also flags any UV Mem boundaries that cause a change in the mem block
size boundary.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/reboot.h>
+#include <linux/memory.h>
 
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
@@ -392,6 +393,40 @@ extern int uv_hub_info_version(void)
 }
 EXPORT_SYMBOL(uv_hub_info_version);
 
+/* Default UV memory block size is 2GB */
+static unsigned long mem_block_size = (2UL << 30);
+
+static __init int adj_blksize(u32 lgre)
+{
+	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;
+	unsigned long size;
+
+	for (size = mem_block_size; size > MIN_MEMORY_BLOCK_SIZE; size >>= 1)
+		if (IS_ALIGNED(base, size))
+			break;
+
+	if (size >= mem_block_size)
+		return 0;
+
+	mem_block_size = size;
+	return 1;
+}
+
+static __init void set_block_size(void)
+{
+	unsigned int order = ffs(mem_block_size);
+
+	if (order) {
+		/* adjust for ffs return of 1..64 */
+		set_memory_block_size_order(order - 1);
+		pr_info("UV: mem_block_size set to 0x%lx\n", mem_block_size);
+	} else {
+		/* bad or zero value, default to 1UL << 31 (2GB) */
+		pr_err("UV: mem_block_size error with 0x%lx\n", mem_block_size);
+		set_memory_block_size_order(31);
+	}
+}
+
 /* Build GAM range lookup table: */
 static __init void build_uv_gr_table(void)
 {
@@ -1180,23 +1215,30 @@ static void __init decode_gam_rng_tbl(un
 					<< UV_GAM_RANGE_SHFT);
 		int order = 0;
 		char suffix[] = " KMGTPE";
+		int flag = ' ';
 
 		while (size > 9999 && order < sizeof(suffix)) {
 			size /= 1024;
 			order++;
 		}
 
+		/* adjust max block size to current range start */
+		if (gre->type == 1 || gre->type == 2)
+			if (adj_blksize(lgre))
+				flag = '*';
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
-			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
+			pr_info("UV:  # %20s %14s %6s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx%c %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			size, suffix[order],
+			flag, size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
+		/* update to next range start */
 		lgre = gre->limit;
 		if (sock_min > gre->sockid)
 			sock_min = gre->sockid;
@@ -1427,6 +1469,7 @@ static void __init uv_system_init_hub(vo
 
 	build_socket_tables();
 	build_uv_gr_table();
+	set_block_size();
 	uv_init_hub_info(&hub_info);
 	uv_possible_blades = num_possible_nodes();
 	if (!_node_to_pnode)

-- 
