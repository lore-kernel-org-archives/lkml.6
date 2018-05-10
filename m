Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994786-2-3581869963307002723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Attached: add-set_memory_block_size_order
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994785; b=GRiglOAYjPYesfbCdGin6fLKdisoszyBW2B5K793dvBWv+6uBv
    lQEoQp2IIfhOdps+RC2I8Ju5MhXOBOV5PSoH2KCHK42OSFAHp86oB+iwNaSVq/PS
    bszqzWP+2ozbZ0pauiluGoZ+g2Br4VMdyHnPafCksLKeVFTyxb4QB2MDwE95l7G2
    JiARilQS6hb0DmFEXyZaQQ+7EqzHH0jWcdTzng2UgcJPDG/WZIsQM+q7Ol00nDRf
    wBcSycOYSgchyqYiB4LqTY4DY7MeifNWwClEF/5lDMbXcsgRXDPTHZE4FNIhaUm5
    Wfw18dDlPlCZIr6B+pTRkmZVhTa5bSfYw4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:references:date:from:to:cc
    :subject:sender:list-id; s=fm2; t=1525994785; bh=8CSbh8tEyyJXKep
    yz+CVHNodyyHyMjuYufXMhxFvuZg=; b=OWX/umAyFKd4nDAVb5vDdcrpYKnXIau
    dgoOpt5shRdaiNL0NyZNys8pMuwQtqbcY0fOaXYbZjLY4+iII7RgnpZOPl8g3MQH
    VEKlvHkGcOU7DLj1J7CoVDUefmti7lFGtbhTQoTPdOOu1ZA+wyb7eKaC6m2dYzi1
    jWg7/IKDtIFiXmZIJU7w37YvWOlxVZe+3U31eWYomySq9RT0HXA/sXnPK1LLGb2X
    mzza61fWRoQwZ8Yk8uirE4yB2Rwra8++pStTK50PuVaR3mlglGqTgUReh3CUcLVu
    C4q/pVflRn25mmX1fsEK6GkTupRD0xY6IqpShByWqSlW5B3i+///yHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJYLGVurpMYfujs3NYDVCGE0CnmGQVaANBQ2JIDuIwkwtFwmFR3l6tSPXlwDC9clrW7LSafecXVSXmF8xdJjJNUIvVbC20+lM19TZZk8FHZoFFjjnUls
    LgdE2m9tyqOw8Kd46UdL0tFkcRnzOyZ+PvnAiOUa8EF1KFyQnUQ9lUXCXgdPxlSatnI2S03b9810zLnJsK67yZNYBgR9NhWuN1NiDz4tMs0KuYcBa2HEbXu6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=MvuuwTCpAAAA:8
    a=IoUL8m2Alxbz6fW4SdcA:9 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeEJX0C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:26:02 -0400
Received: from relay2.sgi.com ([192.48.180.65]:51889 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750710AbeEJX0B (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 10 May 2018 19:26:01 -0400
Message-Id: <20180510231832.201546912@stormcage.americas.sgi.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 10 May 2018 18:18:33 -0500
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
Subject: [PATCH 1/3] x86/platform/UV: Add adjustable set memory block size function
Content-Disposition: inline; filename=add-set_memory_block_size_order
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new function to "adjust" the current fixed UV memory block size of
2GB so it can be changed to a different physical boundary.  This is out
of necessity so UV BIOS can accommodate Intel BIOS changes for NVDIMM's,
which can align these new PMEM modules at other than 2GB boundaries.

A "set order" type of function was used to insure that the memory block
size will be a power of two value without requiring a validity check on
the size value passed in.  64GB was chosen as the upper limit for memory
block size values to accommodate upcoming 4PB systems which have 6 more
bits of physical address space (46 becoming 52).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
---
 arch/x86/mm/init_64.c  |   20 ++++++++++++++++----
 include/linux/memory.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

--- linux.orig/arch/x86/mm/init_64.c
+++ linux/arch/x86/mm/init_64.c
@@ -1350,16 +1350,28 @@ int kern_addr_valid(unsigned long addr)
 /* Amount of ram needed to start using large blocks */
 #define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
 
+/* Adjustable memory block size */
+static unsigned long set_memory_block_size;
+int __init set_memory_block_size_order(unsigned int order)
+{
+	unsigned long size = 1UL << order;
+
+	if (size > MEM_SIZE_FOR_LARGE_BLOCK || size < MIN_MEMORY_BLOCK_SIZE)
+		return -EINVAL;
+
+	set_memory_block_size = size;
+	return 0;
+}
+
 static unsigned long probe_memory_block_size(void)
 {
 	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
 	unsigned long bz;
 
-	/* If this is UV system, always set 2G block size */
-	if (is_uv_system()) {
-		bz = MAX_BLOCK_SIZE;
+	/* If memory block size has been set, then use it */
+	bz = set_memory_block_size;
+	if (bz)
 		goto done;
-	}
 
 	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
 	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
--- linux.orig/include/linux/memory.h
+++ linux/include/linux/memory.h
@@ -38,6 +38,7 @@ struct memory_block {
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
+int set_memory_block_size_order(unsigned int order);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */

-- 
