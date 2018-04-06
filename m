Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039604-2-9823427274715542038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039603; b=HQPlnVv9/Go4NCn+Ke3xsY24ASnrt/MhkuYu4vcDo6fbWsyznf
    3FojLAuFjPX0cLCtc7aVW1f7UyA2Y8+edVWTeSsuuzVQSDeATd9p4MPVVzZnFdUJ
    nLxp77UP5ri1GLAU58ycwRcrznEKHwa4UILnRVTPttkdGDSj837+jSiCDlnDn1uY
    uKKCzP0zynmQ5/VuRySRhAabuSt8HiRECAZ67dlpGFGZHwv9OZhQnOk7Sm9ju0NR
    khC4fISBjTcbjlFGs2t242yxp/OE2eiQLJnngZ47tes7vZNkQzw4Dvs5m9uMLxeD
    8XUmcVqCqxJRiv8k2zSlrAXGSj6Wkv/018+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039603; bh=
    dcHkKpiFsk/TcrFEIfqaVcs66m2Tds1BjjFIdUP97k0=; b=qKZpOyLuc+R00iTD
    p0ut9Z8PIkOhB3MHdyC2DkxMp5akQZnHIqu3D6vBEGS14n9aovSAoeCR5akXfAzz
    g9jwBGX3BkWLyxLpbTU6V74sLYui2cwR8NCl355up7E6vObt9l0ubyUTt0UumDGz
    r1CJ+Lk9B4ydouSzkClynlLyrACsAcOOwljGj6RAJbfsRppzB9KJHK3V74BqcqdB
    73ZvAp/PdxPSRqxET9yh0xji2Gspp0TUNW6UqIq5XnYdzMjYNMFgas1egf7gNboO
    eAW6L9i03yiTsMNmhoGYTYqhszWq2j5YD97pUgeN5Nho771P9Ha/hqbmGt+o0fYj
    KwX7LA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfL1WQX1935+ZiEwAZmQmdAfuvHgjy1GZm1CeXpTd7ZTA3SRySOCQdNP+r9rukiA96vf4Wv32uu76pqdwDjenTDGXtczoZbk731DjEG9AKPMvUXt6hjk1
    vH+eIaR/DsL3axcNxdkib/bVh90A8E2RkT4G9hPhHMX4XPlecC0zEGf7+GH2as7dB+2ug0OZnxvAHa5q4EhvEdsGoQLkzIUqBjr6DLhKS6ep6vu4P+0U+D1O
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=Z4Rwk6OoAAAA:8 a=zd2uoN0lAAAA:8 a=H28FcGmaHxMduE7C4VgA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeDFSdK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:33:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:26196 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeDFSac (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611438"
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
Subject: [4.15 & 4.14 stable 02/12] x86/CPU: Add a microcode loader callback
Date: Fri,  6 Apr 2018 11:30:16 -0700
Message-Id: <1523039426-3938-3-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 1008c52c09dcb23d93f8e0ea83a6246265d2cce0 upstream

Add a callback function which the microcode loader calls when microcode
has been updated to a newer revision. Do the callback only when no error
was encountered during loading.

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
Link: http://lkml.kernel.org/r/20180216112640.11554-3-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  8 ++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 44c2c4e..a5fc8f8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -969,4 +969,5 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+void microcode_check(void);
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 824aee0..84f1cd8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1749,3 +1749,13 @@ static int __init init_cpu_syscore(void)
 	return 0;
 }
 core_initcall(init_cpu_syscore);
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+void microcode_check(void)
+{
+	perf_check_microcode();
+}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7c42326..b40b56e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -509,6 +509,7 @@ static ssize_t reload_store(struct device *dev,
 			    const char *buf, size_t size)
 {
 	enum ucode_state tmp_ret = UCODE_OK;
+	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
 	int cpu;
@@ -531,10 +532,13 @@ static ssize_t reload_store(struct device *dev,
 			if (!ret)
 				ret = -EINVAL;
 		}
+
+		if (tmp_ret == UCODE_UPDATED)
+			do_callback = true;
 	}
 
-	if (!ret && tmp_ret == UCODE_UPDATED)
-		perf_check_microcode();
+	if (!ret && do_callback)
+		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
-- 
2.7.4
