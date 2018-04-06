Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039532-2-1018948039042538807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039531; b=Mxda7QWTVCiW0tLFR5lcGlZNTKYCf2ox1u0bK1W4eyfpImATkO
    Pu4LP3r5lPRpSSBS1QGgXkh2Hfx0CuZdoo3NXRX7KGjIc/JZYGUKFfjYvdc9ENGf
    ALUjc0HQc0crj35Fz9FYnpMxQ8xUa+oTrlzLchUD/Y725H89pM/yZQ8e9Rgm3uqj
    1bP+DI4FZB3oh5xzPQ02286TrrrZAZlWPdHp6TRe7WdABRm6cGNj5KoKA9Z2k+xc
    RvWS8JD7P2C6vqOF+qY2RB+MYIppvoeSybLoGRrSCHBeuVPaKP1nBrVQ5yoMK2H2
    DL8by4Fj3ABA0dnn5/UwH3AdZyiUdb1b+LBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039531; bh=
    skmzQZ+EPn0wgb89sL9ujnBv7t3vxfACiHQ++F9SBfg=; b=G+Az7yWjdE+6P+J3
    mq6fa8QO+a1s1XJF0oCGBU2kQ9Kxcc58ogYjJSfhrtt1SobAKhDwilFOC9XerH7N
    Heg+EcPx2RhsBwH2d2FpfeSYyRnkRKc2apEMmpBe9L+l6pboE5EZQb9o/0EBMfrU
    ys05QgpBrgH/GK3CtC2ctGX5JhrNNk2UQYSwStCdclhJd1mBNH5Sxd2isiJK2/V1
    riiQJ3Mu9tH07sBvYPrZL+vkinfhurAf5rrN1PU5qL2OH9aYX9BU6lXRVg6/08El
    L6ajIHDN0G6qJEXIAlX/QgqAWF5pmsuVRuceJjDqLCCNeSqvMbCUUExczXKF/6Rf
    C3/i5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBgdHMwpmZugn0/eQ+TebAcqRzjIDBBJ1fMQwDVt/mx3HElouLjYv0IgmZihnjFgOyfBwANHvdhGuVFQVfUi6qK0nFg6kP1q69GEtQK1KROThpxSM3W4
    2xbk+H5+oE+3OJrijAq2HtcByRI9JE0jfDE2yQiB4JC2d2eC1l6WoN9GHnwxver7OWujeiyH7lpiMflqIZsfb34aGim1GVgvLtgwNoi/wBplNfSDEi3PgY1w
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=PznF6Tp5mt6HC0nOptgA:9
    a=rW0CPFNp2K12dI_Q:21 a=MDMtdyyDORfuzxDB:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeDFSbw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:31:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:38635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeDFSad (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611464"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 10/12] x86/microcode: Synchronize late microcode loading
Date: Fri,  6 Apr 2018 11:30:24 -0700
Message-Id: <1523039426-3938-11-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit a5321aec6412b20b5ad15db2d6b916c05349dbff upstream

Original idea by Ashok, completely rewritten by Borislav.

Before you read any further: the early loading method is still the
preferred one and you should always do that. The following patch is
improving the late loading mechanism for long running jobs and cloud use
cases.

Gather all cores and serialize the microcode update on them by doing it
one-by-one to make the late update process as reliable as possible and
avoid potential issues caused by the microcode update.

[ Borislav: Rewrite completely. ]

Co-developed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180228102846.13447-8-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 118 +++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 8adbf43..bde629e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -22,13 +22,16 @@
 #define pr_fmt(fmt) "microcode: " fmt
 
 #include <linux/platform_device.h>
+#include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/cpu.h>
+#include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 
@@ -64,6 +67,11 @@ LIST_HEAD(microcode_cache);
  */
 static DEFINE_MUTEX(microcode_mutex);
 
+/*
+ * Serialize late loading so that CPUs get updated one-by-one.
+ */
+static DEFINE_SPINLOCK(update_lock);
+
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -486,6 +494,19 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+/*
+ * Late loading dance. Why the heavy-handed stomp_machine effort?
+ *
+ * - HT siblings must be idle and not execute other code while the other sibling
+ *   is loading microcode in order to avoid any negative interactions caused by
+ *   the loading.
+ *
+ * - In addition, microcode update on the cores must be serialized until this
+ *   requirement can be relaxed in the future. Right now, this is conservative
+ *   and good.
+ */
+#define SPINUNIT 100 /* 100 nsec */
+
 static int check_online_cpus(void)
 {
 	if (num_online_cpus() == num_present_cpus())
@@ -496,23 +517,85 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static enum ucode_state reload_for_cpu(int cpu)
+static atomic_t late_cpus;
+
+/*
+ * Returns:
+ * < 0 - on error
+ *   0 - no update done
+ *   1 - microcode was updated
+ */
+static int __reload_late(void *info)
 {
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	unsigned int timeout = NSEC_PER_SEC;
+	int all_cpus = num_online_cpus();
+	int cpu = smp_processor_id();
+	enum ucode_state err;
+	int ret = 0;
 
-	if (!uci->valid)
-		return UCODE_OK;
+	atomic_dec(&late_cpus);
+
+	/*
+	 * Wait for all CPUs to arrive. A load will not be attempted unless all
+	 * CPUs show up.
+	 * */
+	while (atomic_read(&late_cpus)) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				atomic_read(&late_cpus));
+			return -1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+
+	spin_lock(&update_lock);
+	apply_microcode_local(&err);
+	spin_unlock(&update_lock);
+
+	if (err > UCODE_NFOUND) {
+		pr_warn("Error reloading microcode on CPU %d\n", cpu);
+		ret = -1;
+	} else if (err == UCODE_UPDATED) {
+		ret = 1;
+	}
 
-	return apply_microcode_on_target(cpu);
+	atomic_inc(&late_cpus);
+
+	while (atomic_read(&late_cpus) != all_cpus)
+		cpu_relax();
+
+	return ret;
+}
+
+/*
+ * Reload microcode late on all CPUs. Wait for a sec until they
+ * all gather together.
+ */
+static int microcode_reload_late(void)
+{
+	int ret;
+
+	atomic_set(&late_cpus, num_online_cpus());
+
+	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	if (ret < 0)
+		return ret;
+	else if (ret > 0)
+		microcode_check();
+
+	return ret;
 }
 
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	int cpu, bsp = boot_cpu_data.cpu_index;
 	enum ucode_state tmp_ret = UCODE_OK;
-	bool do_callback = false;
+	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
 	ssize_t ret = 0;
 
@@ -534,30 +617,13 @@ static ssize_t reload_store(struct device *dev,
 		goto put;
 
 	mutex_lock(&microcode_mutex);
-
-	for_each_online_cpu(cpu) {
-		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret > UCODE_NFOUND) {
-			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-			/* set retval for the first encountered reload error */
-			if (!ret)
-				ret = -EINVAL;
-		}
-
-		if (tmp_ret == UCODE_UPDATED)
-			do_callback = true;
-	}
-
-	if (!ret && do_callback)
-		microcode_check();
-
+	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
 
 put:
 	put_online_cpus();
 
-	if (!ret)
+	if (ret >= 0)
 		ret = size;
 
 	return ret;
-- 
2.7.4
