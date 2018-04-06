Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039634-2-15823829549824445537
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
    1523039633; b=mMgQqiBZDQnpTk3tBmwEVycpiRFbw7lnrXs/M6iOrAH//vP7EG
    3WTQqr+D9Qjqhdmew5V4y6Tq/Dp8i34wBWx8aN3LoLKPihcK0Qy2UuGbf73khWsu
    /saArhSzJy7jGhTzHS0W0sZjgXKONus/t4sd1njarcLlk+SiN2YmpxgXrPhNXzAR
    b2hApZKzDKsGya5+augjLMPAed83+CVen8kDfAeDjgJ2i5BjJpZORxUcjW2ONrQR
    xf15zz0yACtfNDgug0VV0pPekfcQOpoAscoijiUp0uKUWxb5FVqFhjIbfHrOQDyO
    1yzBTGwQN6gT2MHCfW9qYHmXJklKyIzi3T3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039633; bh=
    wz3kX/da48X4bd7OkDszTDd7LwD0UxyYPDLuBDcdjXg=; b=iqW70LyjNCHsf2tl
    77OjUtWxuH+9qGf/WVuPgPudWab9YsT5+WFfAK40sidSsZFphfhHntfcumzzQauv
    G0x8lUEbpG5ruP2HtsWhrhXThVSNMIp8jCWrgCFgUo5OGDLQCG5BxU4kWniEiSOv
    mYRm2tiBgBoECjB3GyjClPmQoweUp9PfDFVLCuE3Cwhl7AY7JC841NHYF2HnpQ3J
    3Xg4UZIR8UGYNKUv4/En0e900YgJB8kR/dqYOfac11ZNIMLQEbusvCz+dR33Bu/9
    Hq2CmZzP2/NbIYb3KnKt6DMUjhYBJ5AcGH4+m2SIf4fJQtRufDx4pmBFwYmR62wU
    WEdvcQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNGQP8CJs5/A8gjBxk8ZK8U/Sr/akiNzpF4U02FznY1D8qWRRvYcdGpPC/cuCNRBNNw1u4Ce0cubRipYrGcIXgAp0RRxNWO9nQqqYCQ95ccDgIux2KHd
    o+9DhOe+37+znBAZzD/zfKIovNAirFCMHqMx8/5X/J+ozNvbIOQr5hjHC22u8eiMBecbNsU0NqPw/d+en1TW2/u5MT9BDOhXvY3gWcAY3C5D/N7hRJyVF7AY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=Z4Rwk6OoAAAA:8 a=zd2uoN0lAAAA:8 a=6T5O0TFyBWI4eThTOmcA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDFSdm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:33:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:26196 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeDFSab (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611434"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [4.15 & 4.14 stable 01/12] x86/microcode: Propagate return value from updating functions
Date: Fri,  6 Apr 2018 11:30:15 -0700
Message-Id: <1523039426-3938-2-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 3f1f576a195aa266813cbd4ca70291deb61e0129 upstream

... so that callers can know when microcode was updated and act
accordingly.

Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180216112640.11554-2-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/microcode.h      |  9 +++++++--
 arch/x86/kernel/cpu/microcode/amd.c   | 10 +++++-----
 arch/x86/kernel/cpu/microcode/core.c  | 33 +++++++++++++++++----------------
 arch/x86/kernel/cpu/microcode/intel.c | 10 +++++-----
 4 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 55520cec..7fb1047 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -37,7 +37,12 @@ struct cpu_signature {
 
 struct device;
 
-enum ucode_state { UCODE_ERROR, UCODE_OK, UCODE_NFOUND };
+enum ucode_state {
+	UCODE_OK	= 0,
+	UCODE_UPDATED,
+	UCODE_NFOUND,
+	UCODE_ERROR,
+};
 
 struct microcode_ops {
 	enum ucode_state (*request_microcode_user) (int cpu,
@@ -54,7 +59,7 @@ struct microcode_ops {
 	 * are being called.
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
-	int (*apply_microcode) (int cpu);
+	enum ucode_state (*apply_microcode) (int cpu);
 	int (*collect_cpu_info) (int cpu, struct cpu_signature *csig);
 };
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 330b846..a998e1a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -498,7 +498,7 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 	return patch_size;
 }
 
-static int apply_microcode_amd(int cpu)
+static enum ucode_state apply_microcode_amd(int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_amd *mc_amd;
@@ -512,7 +512,7 @@ static int apply_microcode_amd(int cpu)
 
 	p = find_patch(cpu);
 	if (!p)
-		return 0;
+		return UCODE_NFOUND;
 
 	mc_amd  = p->data;
 	uci->mc = p->data;
@@ -523,13 +523,13 @@ static int apply_microcode_amd(int cpu)
 	if (rev >= mc_amd->hdr.patch_id) {
 		c->microcode = rev;
 		uci->cpu_sig.rev = rev;
-		return 0;
+		return UCODE_OK;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
-		return -1;
+		return UCODE_ERROR;
 	}
 	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
 		mc_amd->hdr.patch_id);
@@ -537,7 +537,7 @@ static int apply_microcode_amd(int cpu)
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
-	return 0;
+	return UCODE_UPDATED;
 }
 
 static int install_equiv_cpu_table(const u8 *buf)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index e4fc595..7c42326 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -374,7 +374,7 @@ static int collect_cpu_info(int cpu)
 }
 
 struct apply_microcode_ctx {
-	int err;
+	enum ucode_state err;
 };
 
 static void apply_microcode_local(void *arg)
@@ -489,31 +489,29 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
-static int reload_for_cpu(int cpu)
+static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	enum ucode_state ustate;
-	int err = 0;
 
 	if (!uci->valid)
-		return err;
+		return UCODE_OK;
 
 	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate == UCODE_OK)
-		apply_microcode_on_target(cpu);
-	else
-		if (ustate == UCODE_ERROR)
-			err = -EINVAL;
-	return err;
+	if (ustate != UCODE_OK)
+		return ustate;
+
+	return apply_microcode_on_target(cpu);
 }
 
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
+	enum ucode_state tmp_ret = UCODE_OK;
 	unsigned long val;
+	ssize_t ret = 0;
 	int cpu;
-	ssize_t ret = 0, tmp_ret;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -526,15 +524,18 @@ static ssize_t reload_store(struct device *dev,
 	mutex_lock(&microcode_mutex);
 	for_each_online_cpu(cpu) {
 		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret != 0)
+		if (tmp_ret > UCODE_NFOUND) {
 			pr_warn("Error reloading microcode on CPU %d\n", cpu);
 
-		/* save retval of the first encountered reload error */
-		if (!ret)
-			ret = tmp_ret;
+			/* set retval for the first encountered reload error */
+			if (!ret)
+				ret = -EINVAL;
+		}
 	}
-	if (!ret)
+
+	if (!ret && tmp_ret == UCODE_UPDATED)
 		perf_check_microcode();
+
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a15db2b..923054a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -772,7 +772,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 	return 0;
 }
 
-static int apply_microcode_intel(int cpu)
+static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
@@ -782,7 +782,7 @@ static int apply_microcode_intel(int cpu)
 
 	/* We should bind the task to the CPU */
 	if (WARN_ON(raw_smp_processor_id() != cpu))
-		return -1;
+		return UCODE_ERROR;
 
 	uci = ucode_cpu_info + cpu;
 	mc = uci->mc;
@@ -790,7 +790,7 @@ static int apply_microcode_intel(int cpu)
 		/* Look for a newer patch in our cache: */
 		mc = find_patch(uci);
 		if (!mc)
-			return 0;
+			return UCODE_NFOUND;
 	}
 
 	/* write microcode via MSR 0x79 */
@@ -801,7 +801,7 @@ static int apply_microcode_intel(int cpu)
 	if (rev != mc->hdr.rev) {
 		pr_err("CPU%d update to revision 0x%x failed\n",
 		       cpu, mc->hdr.rev);
-		return -1;
+		return UCODE_ERROR;
 	}
 
 	if (rev != prev_rev) {
@@ -818,7 +818,7 @@ static int apply_microcode_intel(int cpu)
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-	return 0;
+	return UCODE_UPDATED;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-- 
2.7.4
