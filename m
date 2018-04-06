Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039621-2-6933685535636402536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039620; b=aDI2LDT6lG5OUuSYld0oJ99Tb8nSf9c04UCYI2YcjS+8dK0wCI
    tcA/c+lkJTwLlqq4Q7KxJkd4W4GBbvMBOI+iFazpaLvC7+JPYAE9dfKuZbvxTos7
    L+7X/YreamtFZFJVczQoiu265jimYxCahAlPEcDo9em0FzkyFbRUI+xrG65zEC4+
    KNuozjfWOqP6k+gNdshrCJJvV5y08ZHFQXqBx0WGSOtF1x3ZZZMQpm8tDpo/GFJG
    Qp2w0VjP2axYXNAdqj+n7UrvoaS+fdOwB8lKqScYXJq5RNRCDx6/+wN09Hrl7sQW
    c4NA4FEdcopVOPYyY4JHlfCYPyMdSNWIY7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039620; bh=
    t3NBq4GFldss9WSciemJ1ZRxg8F72qiLmIqNNRVIif0=; b=ccwKoarJtqiahL8B
    WrQMpCs8qbMdOPzYMHRdjPMizeXaIWjnUy7W9ekgoD7AutTDTOqzE1hzSkIGvCXi
    QffldMNxcGAy2i3UPiE0Brdv3zwQRfdJ8mzF8fY5JoJmhglBlOdGoNO4USMpt4wI
    D66kzutp3CTiTLRBrG6EBMFtp8LKryjJLLWRKsYqWfv1YVxzEhPYTIeDLYfxmNWw
    GP6uPIgyG072Ng9e0YORDMJcdy969xLEGkpGa5VtgdVhgb0/KUxTECRRdmsg3F9t
    vSO82CgnngQCMXZL7nCPyKD4MJkHImxG0FA217bbxaIgUJVDD66DrvNeyb5v+KtE
    2CgCEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB8n//p0yB2oPFR2hI3N1d24ulcq6gWPJ+PUoGXtIbjLJ/Yu+/uzrcKYCyVZSTvqLXee4uVvXyMTxxLeO5paBBN8p3EMWEairkedakSwbE0QStWU5QZF
    6YOrZd3ZJTdpjUJ0G5zxNTpPeOPrQ8yc8IvnIZZU44aHhi/AMO3uhvmefjcBlvQXBAlWTCjb+iw6qYLxaW726+JhsUY0cktIkyXjznEvcKOyuks9cUgGtVeT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=sfOm8-O8AAAA:8
    a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=etlSxStnSOlPFdiNa60A:9
    a=TvTJqdcANYtsRzA46cdi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDFSd1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:33:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:38635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeDFSab (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611467"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 11/12] x86/microcode: Attempt late loading only when new microcode is present
Date: Fri,  6 Apr 2018 11:30:25 -0700
Message-Id: <1523039426-3938-12-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 2613f36ed965d0e5a595a1d931fd3b480e82d6fd upstream

Return UCODE_NEW from the scanning functions to denote that new microcode
was found and only then attempt the expensive synchronization dance.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180314183615.17629-1-bp@alien8.de
---
 arch/x86/include/asm/microcode.h      |  1 +
 arch/x86/kernel/cpu/microcode/amd.c   | 34 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/core.c  |  8 +++-----
 arch/x86/kernel/cpu/microcode/intel.c |  4 +++-
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7fb1047..6cf0e4c 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -39,6 +39,7 @@ struct device;
 
 enum ucode_state {
 	UCODE_OK	= 0,
+	UCODE_NEW,
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a998e1a..4817992 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -339,7 +339,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 		return -EINVAL;
 
 	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret != UCODE_OK)
+	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
 	return 0;
@@ -683,27 +683,35 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 static enum ucode_state
 load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
+	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-
-	if (ret != UCODE_OK)
+	if (ret != UCODE_OK) {
 		cleanup();
+		return ret;
+	}
 
-#ifdef CONFIG_X86_32
-	/* save BSP's matching patch for early load */
-	if (save) {
-		struct ucode_patch *p = find_patch(0);
-		if (p) {
-			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
-							       PATCH_MAX_SIZE));
-		}
+	p = find_patch(0);
+	if (!p) {
+		return ret;
+	} else {
+		if (boot_cpu_data.microcode == p->patch_id)
+			return ret;
+
+		ret = UCODE_NEW;
 	}
-#endif
+
+	/* save BSP's matching patch for early load */
+	if (!save)
+		return ret;
+
+	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
+	memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data), PATCH_MAX_SIZE));
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index bde629e..e6d5caa 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -607,7 +607,7 @@ static ssize_t reload_store(struct device *dev,
 		return size;
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_OK)
+	if (tmp_ret != UCODE_NEW)
 		return size;
 
 	get_online_cpus();
@@ -691,10 +691,8 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev,
-						     refresh_fw);
-
-	if (ustate == UCODE_OK) {
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
 	}
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 2aded9d..32b8e57 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -862,6 +862,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	unsigned int csig, cpf;
+	enum ucode_state ret = UCODE_OK;
 
 	while (leftover) {
 		struct microcode_header_intel mc_header;
@@ -903,6 +904,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 			new_mc  = mc;
 			new_mc_size = mc_size;
 			mc = NULL;	/* trigger new vmalloc */
+			ret = UCODE_NEW;
 		}
 
 		ucode_ptr += mc_size;
@@ -932,7 +934,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
 
-	return UCODE_OK;
+	return ret;
 }
 
 static int get_ucode_fw(void *to, const void *from, size_t n)
-- 
2.7.4
