Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835954-2-9097073313146882905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835953; b=jBB8NDU1gkiq67z/NNS5dDwiymex/6ZdjwWkU7aSwO2O0Tl
    +KzT1JRrgv9yJ34xaURnhSNcWIvRrV1ajcP0DoX859x3jbS0rJqxEAomqM/7MoRF
    yzy/RXwvAO0FNujmjNUjQQlLUS47yD71q+EugdJOHZTJGlcx8aY/lmoK5LqO8r5r
    +1PY+MeP0JoDD3a8RJF9UVFThq/+yBGWrUc8FsyS/SrzWGkGklHVAz6bUWr7czO8
    fCdcB1Ndbny+jnI3FGFy+PsMyIK/IHxsf1pbdFZ9+1wKrp8EWwpFdqOFOwS5VtA6
    x+GzHSBrYQd1T1R8/MOnLmOHiDi4iJGzHmzMEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835953; bh=1tyrCkoGMic6yhMCiNT
    0NmijusZMLSPHkR5WAsqbZXU=; b=shEC37GF/lr65/I5gYdWsRrSUsPv4If4ohP
    O8a6AW3W7DkuVoeiChH+jgc1d7gAytvUJ6Pn0WzC9wHZOfok9L9J6DnVqhkTp3HK
    m6uNB1jfDTnQ+LmMk5wsRr92Mfk4haBqF9OCDhMMsN8N+Mgvm02M3N4kcIy4jGsT
    40FM25J5D5k8e3rFTrSmBaF9TrGfu5nmIo884ZY9gj863JoAP5AnZRiRoFqsbDR1
    FH1pzwMI4Qi9yEcG/olEAWnCD/p7zbEWqjD4UD/Dq0UqRDQXuLgb6a7y6K/jPTKS
    qeoBV8GaABnX9l0y9HB3kyNp8E9V600pnGsfC0W8uclwpFOAbOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeB1QEK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34803 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752516AbeB1QEI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jia Zhang" <zhang.jia@linux.alibaba.com>,
        "Borislav Petkov" <bp@suse.de>, "Tony Luck" <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.974232031@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 228/254] x86/microcode/intel: Extend BDW late-loading
 further with LLC size check
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jia Zhang <zhang.jia@linux.alibaba.com>

commit 7e702d17ed138cf4ae7c00e8c00681ed464587c7 upstream.

Commit b94b73733171 ("x86/microcode/intel: Extend BDW late-loading with a
revision check") reduced the impact of erratum BDF90 for Broadwell model
79.

The impact can be reduced further by checking the size of the last level
cache portion per core.

Tony: "The erratum says the problem only occurs on the large-cache SKUs.
So we only need to avoid the update if we are on a big cache SKU that is
also running old microcode."

For more details, see erratum BDF90 in document #334165 (Intel Xeon
Processor E7-8800/4800 v4 Product Family Specification Update) from
September 2017.

Fixes: b94b73733171 ("x86/microcode/intel: Extend BDW late-loading with a revision check")
Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1516321542-31161-1-git-send-email-zhang.jia@linux.alibaba.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -87,6 +87,9 @@ MODULE_DESCRIPTION("Microcode Update Dri
 MODULE_AUTHOR("Tigran Aivazian <tigran@aivazian.fsnet.co.uk>");
 MODULE_LICENSE("GPL");
 
+/* last level cache size per core */
+static int llc_size_per_core;
+
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
@@ -273,12 +276,14 @@ static bool is_blacklisted(unsigned int
 
 	/*
 	 * Late loading on model 79 with microcode revision less than 0x0b000021
-	 * may result in a system hang. This behavior is documented in item
-	 * BDF90, #334165 (Intel Xeon Processor E7-8800/4800 v4 Product Family).
+	 * and LLC size per core bigger than 2.5MB may result in a system hang.
+	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
+	 * Processor E7-8800/4800 v4 Product Family).
 	 */
 	if (c->x86 == 6 &&
 	    c->x86_model == 0x4F &&
 	    c->x86_mask == 0x01 &&
+	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
 		pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
 		pr_err_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
@@ -345,6 +350,15 @@ static struct microcode_ops microcode_in
 	.microcode_fini_cpu               = microcode_fini_cpu,
 };
 
+static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
+{
+	u64 llc_size = c->x86_cache_size * 1024;
+
+	do_div(llc_size, c->x86_max_cores);
+
+	return (int)llc_size;
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
@@ -355,6 +369,8 @@ struct microcode_ops * __init init_intel
 		return NULL;
 	}
 
+	llc_size_per_core = calc_llc_size_per_core(c);
+
 	return &microcode_intel_ops;
 }
 
