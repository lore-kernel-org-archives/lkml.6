Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402391-2-4308438617355765948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523402388; b=bPv993nryqXFBN+G514jgPM9UfS0nhpPOr0+VQ34CyRE+/yIVx
    FgZFk1Pb5PNqQbOE2sPN+yRduhagRT6S2uGkNaNJN+mmJjZhehXVnAf7HK2yZ5Ud
    Q9od5V3XE67RHPpw8ZujeYMSaXf+cjKJuAD4diPs6VQaimTuQ4cFAUD7hQ0lckFT
    XoX9oWRKLCWV6sXxcm++bv+iYu1mxG7rs5iLm5Wq8+vRau04ySYJBO9GsMTGiiuT
    nJMMiuwwRUA7nC0Yn6aBDUTf542ycydjbMQJ0X50PkYSebEKtluZ/dx9VUKCs1MH
    6D6FG84jS8wsEbv6emk2FYmqPHV2B+XeEplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402388; bh=H1vxZ14xBS7v4OR84eAh5g55Pqbm7+
    /JU6iy4EB0qa4=; b=U0ZYwcN2HHCr6Z34ix4AlYI1AKqwyxTF148Nfc4y76qfE9
    agK9sYWI26G1dwGOxAw2HVE7RvHRzOW3vzA86yAvPspCEZLsEGrUDge2A3lHX+IR
    Y1kliE2PCgrBMtGlI7QKbhLG+Q1H/yD7wLKOyhgSzr6aaOtyKgNxO4AjX+B5tBvD
    wxuWA+GJ5V73soCulyql/WzRDxaaleuvEi8VqGv0E/IyPzMBHtlxpb7ykeovztTP
    +e1Lq/JX2qeSR02G9WtD7LeV36hb4twkhG1fYg92cv3ufMw58yoEpDMpAIplvH+K
    DZ+6sArhLDd9Znz2DVsixqBg30ixOEPrAmZz6r6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF3VF4fTM1HXLzzDf+NmoPWBkun93cHu3S5rjMbo0B+MLeasCuW2LiYIrZl+FER/XQhammeqziRHdXC38dMUy3fIgAGnDeb/L4ajnUp8weUQ9wvsqwzG
    8nSiXeRcqHDGqnxJrFMKvsd/9EnpvZ3WKy9E3ebGfa960t0fEIdaPZ1w2dC3BX4FpJrrFGbEDmk4G/lnqJJ9TdKKze+McOoHxWD8HJ8A2p80vrEJ26rX/uCk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=tA7aZXjiAAAA:8
    a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=bwEdOZyXaQRTnyAoU_EA:9 a=QEXdDO2ut3YA:10 a=dVHiktpip_riXrfdqayU:22
    a=AjGcO6oz07-iQ99wixmX:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754724AbeDJWbF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDJWbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        David Airlie <airlied@linux.ie>, yinghai@kernel.org,
        joro@8bytes.org, kexec@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 098/168] x86/gart: Exclude GART aperture from vmcore
Date: Wed, 11 Apr 2018 00:24:00 +0200
Message-Id: <20180410212804.429856100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Bohac <jbohac@suse.cz>


[ Upstream commit 2a3e83c6f96c513f43ce5a8c9034608ea584a255 ]

On machines where the GART aperture is mapped over physical RAM
/proc/vmcore contains the remapped range and reading it may cause hangs or
reboots.

In the past, the GART region was added into the resource map, implemented
by commit 56dd669a138c ("[PATCH] Insert GART region into resource map")

However, inserting the iomem_resource from the early GART code caused
resource conflicts with some AGP drivers (bko#72201), which got avoided by
reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). This revert introduced the /proc/vmcore bug.

The vmcore ELF header is either prepared by the kernel (when using the
kexec_file_load syscall) or by the kexec userspace (when using the kexec_load
syscall). Since we no longer have the GART iomem resource, the userspace
kexec has no way of knowing which region to exclude from the ELF header.

Changes from v1 of this patch:
Instead of excluding the aperture from the ELF header, this patch
makes /proc/vmcore return zeroes in the second kernel when attempting to
read the aperture region. This is done by reusing the
gart_oldmem_pfn_is_ram infrastructure originally intended to exclude XEN
balooned memory. This works for both, the kexec_file_load and kexec_load
syscalls.

[Note that the GART region is the same in the first and second kernels:
regardless whether the first kernel fixed up the northbridge/bios setting
and mapped the aperture over physical memory, the second kernel finds the
northbridge properly configured by the first kernel and the aperture
never overlaps with e820 memory because the second kernel has a fake e820
map created from the crashkernel memory regions. Thus, the second kernel
keeps the aperture address/size as configured by the first kernel.]

register_oldmem_pfn_is_ram can only register one callback and returns an error
if the callback has been registered already. Since XEN used to be the only user
of this function, it never checks the return value. Now that we have more than
one user, I added a WARN_ON just in case agp, XEN, or any other future user of
register_oldmem_pfn_is_ram were to step on each other's toes.

Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: David Airlie <airlied@linux.ie>
Cc: yinghai@kernel.org
Cc: joro@8bytes.org
Cc: kexec@lists.infradead.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: https://lkml.kernel.org/r/20180106010013.73suskgxm7lox7g6@dwarf.suse.cz
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/aperture_64.c |   46 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/xen/mmu_hvm.c        |    2 -
 2 files changed, 46 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
 #include <asm/x86_init.h>
+#include <linux/crash_dump.h>
 
 /*
  * Using 512M as goal, in case kexec will load kernel_big
@@ -56,6 +57,33 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
+#ifdef CONFIG_PROC_VMCORE
+/*
+ * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
+ * use the same range because it will remain configured in the northbridge.
+ * Trying to dump this area via /proc/vmcore may crash the machine, so exclude
+ * it from vmcore.
+ */
+static unsigned long aperture_pfn_start, aperture_page_count;
+
+static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+{
+	return likely((pfn < aperture_pfn_start) ||
+		      (pfn >= aperture_pfn_start + aperture_page_count));
+}
+
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+	aperture_pfn_start = aper_base >> PAGE_SHIFT;
+	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+}
+#else
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+}
+#endif
+
 /* This code runs before the PCI subsystem is initialized, so just
    access the northbridge directly. */
 
@@ -435,8 +463,16 @@ int __init gart_iommu_hole_init(void)
 
 out:
 	if (!fix && !fallback_aper_force) {
-		if (last_aper_base)
+		if (last_aper_base) {
+			/*
+			 * If this is the kdump kernel, the first kernel
+			 * may have allocated the range over its e820 RAM
+			 * and fixed up the northbridge
+			 */
+			exclude_from_vmcore(last_aper_base, last_aper_order);
+
 			return 1;
+		}
 		return 0;
 	}
 
@@ -473,6 +509,14 @@ out:
 		return 0;
 	}
 
+	/*
+	 * If this is the kdump kernel _and_ the first kernel did not
+	 * configure the aperture in the northbridge, this range may
+	 * overlap with the first kernel's memory. We can't access the
+	 * range through vmcore even though it should be part of the dump.
+	 */
+	exclude_from_vmcore(aper_alloc, aper_order);
+
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
 		int bus, dev_base, dev_limit;
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -75,6 +75,6 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
+	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
 }
